# VPS initial setup
A short checklist to perform when setting up a new VPS. Assumes that the first login is under the root user.

The guide assumes CentOS 8 to be running on the VPS.

1. **Update the system.**
    * Run `dnf distro-sync -y && sync`.
2. **Change the root password.**
    * `passwd root`
3. **Create a non-root user, grant sudo privileges.**
    * `adduser <username>`
    * `usermod -aG wheel <username>`
4. **Log out, transfer the SSH key.**
    * `ssh-copy-id -i ~/.ssh/<public-key> <username>@<host>`
5. **Log in as the newly created user.**
6. **Disable root login via SSH, disable password authentication.**
    * `sudo vim /etc/ssh/sshd_config`
    * Set `PermitRootLogin` to `no`.
    * Set `PasswordAuthentication` to `no`.
    * Restart the SSH service: `sudo service restart sshd`.
7. **Set up a firewall.**
    * Ensure `iptables` is on.
    * Install `ufw`.
    * Run the following.
    ```
    sudo ufw allow ssh  # Enable 22/tcp.
    sudo ufw allow http  # Enable 80/tcp.
    sudo ufw allow https  # Enable 443/tcp.
    ```
    * Enable the firewall: `sudo ufw enable`.
    * Check status: `sudo ufw status`.
8. **Install `fail2ban`.**
    * Create an SSH jail: `sudo vim /etc/fail2ban/jail.d/ssh.local` and input the following.
    ```
    [sshd]
    enabled = true
    banaction = ufw
    port = ssh
    filter = sshd
    logpath = %(sshd_log)s
    maxretry = 5
    ```
    This configures `fail2ban` to use the above-installed `ufw` as a ban action.
    * Enable `fail2ban` and the SSH jail.
    ```
    sudo fail2ban-client start
    sudo fail2ban-client reload
    sudo fail2ban-client add sshd
    ```
    * Check `fail2ban` status: `sudo fail2ban-client status`.
    * Check the SSH jail status: `sudo fail2ban-client status sshd`.
9. **Install `logwatch`.**
    * `vim /usr/share/logwatch/default.conf/logwatch.conf`
    * Set `MailTo` to the email address that should received the logs.
    * Set `MailFrom` to the email address that will be set as the sender. Most likely the same as the receiver.
    * Modify `Service` to the services whose logs should be analyzed. Setting `Service = All` might be too much. Instead, examine `/usr/share/logwatch/scripts/services` for the full list, and list each desired service on a separate line.
    ```
    Service = http
    Service = sendmail
    ...
    ```
    * Try it out manually: `logwatch --detail Low --mailto email@address --service http --range today`.
10. **Enable SSH 2FA.**
    * Install `libpam-google-authenticator`.
    * Make sure that the currently logged user is the one we are setting 2FA for.
    * Run `google-authenticator` (without `sudo`).
    * Make a backup of the PAM SSH config: `sudo cp --archive /etc/pam.d/sshd /etc/pam.d/sshd-COPY-$(date +"%Y%m%d%H%M%S")`.
    * Enable PAM as an authentication method for SSH by adding the following line to `/etc/pam.d/sshd`.
    ```
    auth required pam_google_authenticator.so
    ```
    In the same file, comment out the `@include common-auth` line. This tells PAM not to prompt for password.
    * Add the following lines to `/etc/ssh/sshd_config`.
    ```
    ChallengeResponseAuthentication yes
    AuthenticationMethods publickey,keyboard-interactive
    ```
    The first line makes SSH use PAM. The second line requires both the SSH key and the verification code -- by default, the SSH key would be sufficient.
    * Restart SSH: `sudo service restart sshd`.
11. **Enable automatic updates.**
    * Install: `sudo apt install unattended-upgrades`.
    * Enable periodic security updates: `sudo dpkg-reconfigure --priority=low unattended-upgrades`.
    * Check: `apt-config dump APT::Periodic::Unattended-Upgrade`.


## TODO
* Let's Encrypt HTTPS?
* Nextcloud fail2ban 
    * The configuration below is likely outdated. Check also [this link](https://help.nextcloud.com/t/fail2ban-nextclouds-log-expression-chaged/59481).
    * [This link](https://www.c-rieger.de/nextcloud-installationsanleitung/) is probably better, though auf Deutsch.
    * Create filter `sudo vim /etc/fail2ban/filter.d/nextcloud.conf`
    ```
    [Definition]
    failregex=^{"reqId":".","remoteAddr":".","app":"core","message":"Login failed: '.' (Remote IP: '')","level":2,"time":"."}$
    ^{"reqId":".","level":2,"time":".","remoteAddr":".","app":"core".","message":"Login failed: '.' (Remote IP: '')".}$
    ^.\"remoteAddr\":\"\".Trusted domain error.*$
    ```
    The first two check for login failures & flag the source IP. The third checks for trusted domain errors (bots accessing via IP, not the domain).

    Check it: `sudo fail2ban-regex /var/nextcloud/data/nextcloud.log /etc/fail2ban/filter.d/nextcloud.conf -v`
    * Create jail `sudo vim /etc/fail2ban/jail.d/nextcloud.local`
    ```
    [nextcloud]
    enabled = true
    banaction = ufw
    port = http,https
    filter = nextcloud
    logpath = /var/nextcloud/data/nextcloud.log
    maxretry = 3
    ignoreip = 192.168.1.0/24
    backend = auto
    protocol = tcp
    bantime = 36000
    findtime = 36000
    ```
    * Then
    ```
    sudo fail2ban-client add nextcloud
    sudo fail2ban-client restart
    ```
    and check status as above.
* In case ssh key transfer does not go as expected.
    * `su - <username>`
    * `mkdir ~/.ssh`
    * `chmod 700 ~/.ssh`
    * `touch ~/.ssh/authorized_keys`, paste the SSH public key inside.
    * `chmod 600 ~/.ssh/authorized_keys`

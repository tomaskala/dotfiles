# VPS initial setup
A short checklist to perform when setting up a new VPS. Assumes that the first login is under the root user.

The guide assumes CentOS 8 to be running on the VPS.

1. **Update the system.**
    * Run `dnf distro-sync -y && sync`.
2. **Change the root password.**
    * `passwd root`
3. **Create a non-root user, grant sudo privileges.**
    * `adduser <username>`
    * `passwd <username>`
    * `usermod -aG wheel <username>`
4. **Log out, transfer the SSH key.**
    * `ssh-copy-id -i ~/.ssh/<public-key> <username>@<host>`
5. **Log in as the newly created user.**
6. **Disable root login via SSH, disable password authentication.**
    * `sudo vim /etc/ssh/sshd_config`
    * Set `PermitRootLogin` to `no`.
    * Set `PasswordAuthentication` to `no`.
    * Restart the SSH service: `sudo service sshd restart`.
7. **Set up a firewall.**
    * Ensure that `iptables` is installed.
    * `sudo vim /etc/iptables.rules`
    ```
    *filter

    # Allow all loopback traffic.
    -A INPUT -i lo -j ACCEPT

    # Deny all traffic originating from 127/8 not being loopback.
    -A INPUT ! -i lo -d 127.0.0.0/8 -j REJECT

    # Allow all traffic from already established connections.
    -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

    # Allow all outgoing traffic.
    -A OUTPUT -j ACCEPT

    # Allow HTTP.
    -A INPUT -p tcp --dport 80 -j ACCEPT

    # Allow HTTPS.
    -A INPUT -p tcp --dport 443 -j ACCEPT

    # Allow SSH.
    -A INPUT -p tcp -m state --state NEW --dport 22 -j ACCEPT

    # Deny everything else.
    -A INPUT -j REJECT
    -A FORWARD -j REJECT

    COMMIT
    ```
    * Install the `iptables` service: `sudo dnf install iptables-services`.
    * Load the rules: `sudo iptables-restore < /etc/iptables.rules`.
    * Start the `iptables` service: `sudo systemctl start iptables`.
    * Enable the `iptables` service: `sudo systemctl enable iptables`.
    * Save the loaded rules into the `iptables` service: `sudo service iptables save`.
8. **Install `fail2ban`.**
    * `sudo dnf install epel-release`
    * `sudo dnf install fail2ban`
    * `sudo vim /etc/fail2ban/jail.local`
    ```
    [sshd]
    enabled = true
    ```
    * Start the `fail2ban` service: `sudo systemctl start fail2ban`.
    * Enable the `fail2ban` service: `sudo systemctl enable fail2ban`.
    * Check `fail2ban` status: `sudo fail2ban-client status`.
    * Check the SSH jail status: `sudo fail2ban-client status sshd`.
9. **Install `logwatch`.**
    * `vim /etc/logwatch/conf/logwatch.conf`
    * Set `Output` to `mail`.
    * Set `MailTo` to the email address that should received the logs.
    * Set `MailFrom` to the email address that will be set as the sender. Most likely the same as the receiver.
10. **Enable SSH 2FA.**
    * Install `google-authenticator`.
    * Make sure that the currently logged user is the one we are setting 2FA for.
    * Run `google-authenticator` (without `sudo`).
    * Make a backup of the PAM SSH config: `sudo cp --archive /etc/pam.d/sshd /etc/pam.d/sshd-COPY-$(date +"%Y%m%d%H%M%S")`.
    * Enable PAM as an authentication method for SSH by adding the following line to the top of `/etc/pam.d/sshd`.
    ```
    auth sufficient pam_google_authenticator.so
    ```
    * `sudo vim /etc/ssh/sshd_config`
    * Set `ChallengeResponseAuthentication` to `yes`.
    * Set `AuthenticationMethods` to `publickey,keyboard-interactive`.
    The first line makes SSH use PAM. The second line requires both the SSH key and the verification code -- by default, the SSH key would be sufficient.
    * Restart SSH: `sudo service sshd restart`.
11. **Enable automatic updates.**
    * `sudo dnf install dnf-automatic`
    * `sudo vim /etc/dnf/automatic.conf`
    * Set `upgrade_type` to `security`.
    * Set `apply_updates` to `yes`.
    * Set `emit_via` to `motd` to show the message upon SSH login.
    * Start the timer: `sudo systemctl enable --now dnf-automatic.timer`.


## TODO
* Let's Encrypt HTTPS?
* Nextcloud fail2ban 
    * **Nevermind, check out the nextcloud documentation, server hardening section.**
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

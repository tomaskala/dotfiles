#!/usr/bin/env lua

local function range(start, stop, step)
  local out = {}
  for i = start, stop, step do
    table.insert(out, i)
  end
  return out
end

local function weighted_choice(samples, weights)
  local weight_sum = 0.0
  for _, weight in ipairs(weights) do
    weight_sum = weight_sum + weight
  end

  local r = math.random() * weight_sum
  local cum_sum = 0.0
  local sample_idx = nil
  for i = 1, #samples do
    if cum_sum + weights[i] >= r then
      sample_idx = i
      break
    end
    cum_sum = cum_sum + weights[i]
  end
  return sample_idx
end

local function fisher_yates(t)
  for i = #t, 2, -1 do
    local j = math.random(i)
    t[i], t[j] = t[j], t[i]
  end
end

local function randomize_timesheet(timesheet, work_start, work_end, max_hours)
  local days = range(1, #timesheet, 1)
  local possible_starts = range(work_start, work_end, 0.5)
  fisher_yates(days)

  local weights = {}
  for i = 1, #days do
    table.insert(weights, 1.0 / i)
  end

  local total_hours = 0
  for _, day in ipairs(timesheet) do
    total_hours = total_hours + day["Hours"]
  end

  while total_hours > 0 do
    if #days == 0 then error("Cannot produce a solution") end
    local sample = weighted_choice(days, weights)
    local day = days[sample]
    local day_entry = timesheet[day]

    if day_entry["_state"] == nil then
      local i = math.random(#possible_starts)
      day_entry["Start"] = possible_starts[i]
      day_entry["End"] = day_entry["Start"] + 0.5
      day_entry["_state"] = true
    else
      local possible_extensions = {}
      if day_entry["Start"] >= work_start + 0.5 then
        table.insert(possible_extensions, -1)
      end
      if day_entry["End"] <= work_end - 0.5 then
        table.insert(possible_extensions, 1)
      end

      local i = math.random(#possible_extensions)
      if possible_extensions[i] == -1 then
        day_entry["Start"] = day_entry["Start"] - 0.5
      elseif possible_extensions[i] == 1 then
        day_entry["End"] = day_entry["End"] + 0.5
      end

      day_entry["Hours"] = day_entry["End"] - day_entry["Start"]
      if day_entry["Hours"] == max_hours then
        table.remove(days, sample)
        table.remove(weights, sample)
      end
    end

    total_hours = total_hours - 0.5
  end
end

local function finalize_timesheet(timesheet)
  local function date_range(start, stop)
    local curr = os.time(start)
    local max = os.time(stop)
    return function()
      while curr <= max do
        local date = os.date("*t", curr)
        curr = curr + 86400
        return {
          day = date.day,
          month = date.month,
          year = date.year,
        }
      end
    end
  end

  local function find_work_entry(date)
    for _, day_entry in ipairs(timesheet) do
      if date.day == day_entry["Date"].day
        and date.month == day_entry["Date"].month
        and date.year == day_entry["Date"].year then
        return day_entry
      end
    end
    return nil
  end

  local function format_datetime(t)
    return string.format("%02d/%02d/%d", t.day, t.month, t.year)
  end

  local full_timesheet = {}
  local date_min = timesheet[1]["Date"]
  local date_max = timesheet[#timesheet]["Date"]
  for date in date_range(date_min, date_max) do
    local work_entry = find_work_entry(date)
    if work_entry then
      table.insert(full_timesheet, {
        Date = format_datetime(date),
        Hours = work_entry["Hours"],
        Start = work_entry["Start"],
        End = work_entry["End"],
        Description = work_entry["Description"],
      })
    else
      table.insert(full_timesheet, {
        Date = format_datetime(date),
        Hours = 0,
        Start = "",
        End = "",
        Description = "",
      })
    end
  end

  return full_timesheet
end

local function read_csv(lines)
  local function parse_date(s)
    local pattern = "(%d%d)/(%d%d)/(%d%d%d%d)"
    local day, month, year = s:match(pattern)
    return {
      day = tonumber(day),
      month = tonumber(month),
      year = tonumber(year),
    }
  end

  local function from_csv(line)
    line = line .. ","
    local fields = {}
    local field_start = 1
    repeat
      if string.find(line, '^"', field_start) then
        local group
        local i = field_start
        repeat
          _, i, group = string.find(line, '"("?)', i + 1)
        until group ~= '"'
        if not i then error('unmatched "') end
        local field = string.sub(line, field_start + 1, i - 1)
        table.insert(fields, (string.gsub(field, '""', '"')))
        field_start = string.find(line, ",", i) + 1
      else
        local i = string.find(line, ",", field_start)
        table.insert(fields, string.sub(line, field_start, i - 1))
        field_start = i + 1
      end
    until field_start > string.len(line)
    return fields
  end

  local header = {"Date", "Hours", "Description"}
  local header_read = false
  local data = {}
  for line in lines do
    local fields = from_csv(line)
    if not header_read then
      if table.concat(header) ~= table.concat(fields) then
        error(string.format("Expected header '%s', got '%s'",
          table.concat(header, ", "), table.concat(fields, ", ")))
      end
      header_read = true
    else
      local entries = {
        Date = parse_date(fields[1]),
        Hours = fields[2],
        Description = fields[3],
      }
      table.insert(data, entries)
    end
  end
  return data
end

local function to_csv(t)
  local function escape_csv(s)
    if string.find(s, '[,"]') then
      s = '"' .. string.gsub(s, '"', '""') .. '"'
    end
    return s
  end

  local s = ""
  for _, p in ipairs(t) do
    s = s .. "," .. escape_csv(p)
  end
  return string.sub(s, 2)
end

local function write_csv(f, header, timesheet)
  f:write(to_csv(header) .. "\n")
  for _, day_entry in ipairs(timesheet) do
    local row = {}
    for _, field in ipairs(header) do
      table.insert(row, day_entry[field])
    end
    f:write(to_csv(row) .. "\n")
  end
end

local function parse_args()
  local help = string.format([[
Utility for the filling and randomization of a work timesheet.
Usage: %s <command> <command-arguments> [command-options]
Commands:
  add        Add an entry to a work timesheet.
  randomize  Randomize working hours of a work timesheet.
Options:
  --help  Show this message and exit
]], arg[0])

  local function die(msg, status)
    io.stderr:write(msg)
    os.exit(status)
  end

  local function parse_add(args)
    local options = {date = os.date("%d/%m/%Y"), hours = 8}
    local add_help = string.format([[
Add an entry to a work timesheet.
Usage: %s add <timesheet.csv> <description> [options]
Arguments:
  timesheet.csv         CSV file with columns 'Date', 'Hours' and 'Description'
                        If it doesn't exist or is empty, it will be created.
  description           String description of the work done on that day.
Options:
  --help                Show this message and exit.
  --date   <DD/MM/YYYY> Date of the entry being added (default: %s).
  --hours  <number>     Number of hours worked that day (default: %d).
]],
      args[0],
      options["date"],
      options["hours"]
    )

    if #args < 2 then
      if args[1] == "--help" then die(add_help, 0) end
      die(add_help, 1)
    end
    local timesheet_path = table.remove(args, 1)
    local description = table.remove(args, 1)

    for i = 1, #args, 2 do
      local option = args[i]
      if option == "--date" then
        options["date"] = args[i + 1]:match("%d%d/%d%d/%d%d%d%d") or die(add_help, 1)
      elseif option == "--hours" then
        options["hours"] = tonumber(args[i + 1]) or die(add_help, 1)
      else
        die(add_help, 1)
      end
    end

    return {timesheet_path, description}, options
  end

  local function parse_randomize(args)
    local options = {work_start = 7, work_end = 18, max_hours = 10}
    local randomize_help = string.format([[
Randomize working hours of a work timesheet.
Usage: %s randomize <timesheet.csv> [options]
Arguments:
  timesheet.csv         CSV file with columns 'Date', 'Hours' and 'Description'
                        such that 'Date' contains DD/MM/YYYY, 'Hours' contains
                        integers and 'Description' contains strings.
                        Alternatively, can be a "-" to denote stdin.
Options:
  --help                Show this message and exit.
  --start      <number> Work start on a given day (default: %d).
  --end        <number> Work end on a given day (default: %d).
  --max-hours  <number> Maximum working hours for a given day (default: %d).
]],
      args[0],
      options["work_start"],
      options["work_end"],
      options["max_hours"]
    )

    if #args == 0 then
      die(randomize_help, 1)
    elseif args[1] == "--help" then
      die(randomize_help, 0)
    end
    local timesheet_path = table.remove(args, 1)

    for i = 1, #args, 2 do
      local option = args[i]
      if option == "--start" then
        options["work_start"] = tonumber(args[i + 1]) or die(randomize_help, 1)
      elseif option == "--end" then
        options["work_end"] = tonumber(args[i + 1]) or die(randomize_help, 1)
      elseif option == "--max-hours" then
        options["max_hours"] = tonumber(args[i + 1]) or die(randomize_help, 1)
      else
        die(randomize_help, 1)
      end
    end

    return {timesheet_path}, options
  end

  if #arg == 0 then
    die(help, 1)
  elseif arg[1] == "--help" then
    die(help, 0)
  end

  local command = table.remove(arg, 1)

  if command == "add" then
    return command, parse_add(arg)
  elseif command == "randomize" then
    return command, parse_randomize(arg)
  else
    die(help, 1)
  end
end

local function main()
  local header = {"Date", "Start", "End", "Hours", "Description"}
  local command, arguments, options = parse_args()
  local timesheet_path = arguments[1]

  if command == "add" then
    local description = arguments[2]
    local date = options["date"]
    local hours = options["hours"]

    local f = assert(io.open(timesheet_path, "a"))
    if f:seek("end") == 0 then
      f:write(to_csv({"Date", "Hours", "Description"}) .. "\n")
    end
    f:write(to_csv({date, tostring(hours), description}) .. "\n")
    f:close()
  elseif command == "randomize" then
    local work_start = options["work_start"]
    local work_end = options["work_end"]
    local max_daily_hours = options["max_hours"]
    local lines = timesheet_path == "-" and io.stdin:lines() or io.lines(timesheet_path)

    local timesheet = read_csv(lines)
    randomize_timesheet(timesheet, work_start, work_end, max_daily_hours)
    timesheet = finalize_timesheet(timesheet)
    write_csv(io.stdout, header, timesheet)

    local total_hours = 0
    local min_hours = math.maxinteger
    local max_hours = math.mininteger
    for _, entry in ipairs(timesheet) do
      total_hours = total_hours + entry["Hours"]
      min_hours = math.min(min_hours, entry["Hours"])
      max_hours = math.max(max_hours, entry["Hours"])
    end
    io.stderr:write(string.format("Total hours: %d\n", total_hours))
    io.stderr:write(string.format("Min hours in a day: %0.1f\n", min_hours))
    io.stderr:write(string.format("Max hours in a day: %0.1f\n", max_hours))
  else
    error(string.format("Unrecognized command: %s", command))
  end
end

main()

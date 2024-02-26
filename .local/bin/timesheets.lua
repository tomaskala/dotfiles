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

local function is_work_day(day_entry)
  return day_entry["Hours"] ~= "" and day_entry["Description"] ~= ""
end

local function split_timesheet(timesheet)
  local work_days = {}
  local free_days = {}
  for _, day_entry in ipairs(timesheet) do
    if is_work_day(day_entry) then
      table.insert(work_days, day_entry)
    else
      table.insert(free_days, day_entry)
    end
  end
  return work_days, free_days
end

local function finalize_timesheet(work_days, free_days)
  local function parse_datetime(s)
    local pattern = "(%d%d)/(%d%d)/(%d%d%d%d)"
    local day, month, year = s:match(pattern)
    return tonumber(day), tonumber(month), tonumber(year)
  end

  local timesheet = {}
  table.move(work_days, 1, #work_days, 1, timesheet)
  table.move(free_days, 1, #free_days, #timesheet + 1, timesheet)
  table.sort(timesheet, function(entry1, entry2)
    local day1, month1, year1 = parse_datetime(entry1["Date"])
    local day2, month2, year2 = parse_datetime(entry2["Date"])
    return (day1 < day2 and month1 == month2 and year1 == year2)
      or (month1 < month2 and year1 == year2)
      or (year1 < year2)
  end)
  return timesheet
end

local function read_csv(path)
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

  local header = nil
  local data = {}
  for line in io.lines(path) do
    local fields = from_csv(line)
    if header == nil then
      header = fields
    else
      local entries = {}
      for i, field in ipairs(fields) do
        entries[header[i]] = field
      end
      table.insert(data, entries)
    end
  end
  return data
end

local function write_csv(f, header, timesheet)
  local function escape_csv(s)
    if string.find(s, '[,"]') then
      s = '"' .. string.gsub(s, '"', '""') .. '"'
    end
    return s
  end

  local function to_csv(t)
    local s = ""
    for _, p in ipairs(t) do
      s = s .. "," .. escape_csv(p)
    end
    return string.sub(s, 2)
  end

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
  local options = {work_start = 7, work_end = 18, max_hours = 10}
  local help = string.format([[
Randomize working hours of a work timesheet.
Usage: %s <timesheet.csv> [options]
Arguments:
  timesheet.csv         CSV file with columns 'Date', 'Hours' and 'Description'
                        such that 'Date' contains DD/MM/YYYY, 'Hours' contains
                        integers and 'Description' contains strings and where
                        empty 'Hours' or 'Description' imply a non-working day
Options:
  --help                Show this message and exit
  --start      <number> Work start on a given day (default: %d)
  --end        <number> Work end on a given day (default: %d)
  --max-hours  <number> Maximum working hours for a given day (default: %d)
]],
    arg[0],
    options["work_start"],
    options["work_end"],
    options["max_hours"]
  )

  local function die(status)
    io.stderr:write(help)
    os.exit(status)
  end

  if #arg == 0 then
    die(1)
  elseif arg[1] == "--help" then
    die(0)
  end
  local timesheet_path = table.remove(arg, 1)

  for i = 1, #arg, 2 do
    local option = arg[i]
    if option == "--start" then
      options["work_start"] = tonumber(arg[i + 1]) or die(1)
    elseif option == "--end" then
      options["work_end"] = tonumber(arg[i + 1]) or die(1)
    elseif option == "--max-hours" then
      options["max_hours"] = tonumber(arg[i + 1]) or die(1)
    else
      die(1)
    end
  end

  return timesheet_path, options
end

local function main()
  local header = {"Date", "Start", "End", "Hours", "Description"}
  local timesheet_path, options = parse_args()
  local work_start = options["work_start"]
  local work_end = options["work_end"]
  local max_daily_hours = options["max_hours"]

  local timesheet = read_csv(timesheet_path)
  local work_days, free_days = split_timesheet(timesheet)
  randomize_timesheet(work_days, work_start, work_end, max_daily_hours)
  timesheet = finalize_timesheet(work_days, free_days)
  write_csv(io.stdout, header, timesheet)

  local total_hours = 0
  local min_hours = math.maxinteger
  local max_hours = math.mininteger
  for _, entry in ipairs(timesheet) do
    if is_work_day(entry) then
      total_hours = total_hours + entry["Hours"]
      min_hours = math.min(min_hours, entry["Hours"])
      max_hours = math.max(max_hours, entry["Hours"])
    end
  end
  io.stderr:write(string.format("Total hours: %d\n", total_hours))
  io.stderr:write(string.format("Min hours in a day: %0.1f\n", min_hours))
  io.stderr:write(string.format("Max hours in a day: %0.1f\n", max_hours))
end

main()

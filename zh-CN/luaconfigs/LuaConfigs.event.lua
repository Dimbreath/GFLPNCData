-- params : ...
-- function num : 0 , upvalues : _ENV
local event = {
    {event_txt = 186608}, {id = 2}, {id = 3}, {event_txt = 226963, id = 4},
    {id = 5}, {id = 6}, {id = 7}, {id = 8}, {event_txt = 347756, id = 9},
    {event_txt = 386201, id = 10}, {event_txt = 326799, id = 11},
    {event_txt = 440298, id = 12}, {event_txt = 179586, id = 13},
    {event_txt = 225954, id = 14}, {event_txt = 216342, id = 15},
    {event_txt = 275934, id = 16}, {event_txt = 275934, id = 17},
    {event_txt = 284860, id = 18}, {event_txt = 455820, id = 19},
    {event_txt = 338769, id = 20}, {event_txt = 233682, id = 21},
    {event_txt = 165668, id = 22}, {event_txt = 402286, id = 23},
    {event_txt = 466000, id = 24}, {event_txt = 414186, id = 25},
    {event_txt = 466000, id = 26}, {id = 27}, {event_txt = 114670, id = 28},
    {event_txt = 114670, id = 29}, {event_txt = 114670, id = 30},
    {event_txt = 114670, id = 31}, {event_txt = 114670, id = 32},
    {event_txt = 114670, id = 33}, {event_txt = 479508, id = 34},
    {event_txt = 176230, id = 35}, {event_txt = 131762, id = 36},
    {event_txt = 131762, id = 37}, {event_txt = 239286, id = 38},
    {event_txt = 158452, id = 39}, {event_txt = 219361, id = 40},
    {event_txt = 489107, id = 41}, {event_txt = 176230, id = 42},
    {event_txt = 176230, id = 43}, {event_txt = 284860, id = 44},
    {event_txt = 186608, id = 45}, {event_txt = 186608, id = 46},
    {event_txt = 338597, id = 47}, {event_txt = 376007, id = 48}
}
local __default_values = {event_txt = 417562, id = 1, pic = ""}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(event) do setmetatable(v, base) end
local __rawdata = {__basemetatable = base}
setmetatable(event, {__index = __rawdata})
return event


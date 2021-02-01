-- params : ...
-- function num : 0 , upvalues : _ENV
TimestampToTime = function(t, isMillisecond)
  -- function num : 0_0 , upvalues : _ENV
  if isMillisecond then
    t = t // 1000
  end
  local s = (math.floor)(t % 60)
  local m = (math.floor)(t / 60 % 60)
  local h = (math.floor)(t / 3600)
  local content = ""
  if h > 0 then
    content = (string.format)("%02d:%02d:%02d", h, m, s)
  else
    content = (string.format)("%02d:%02d", m, s)
  end
  return content
end

TimestampToTimeInter = function(t, isMillisecond, calculateDay)
  -- function num : 0_1 , upvalues : _ENV
  if isMillisecond then
    t = t // 1000
  end
  local s = (math.floor)(t % 60)
  local m = (math.floor)(t / 60 % 60)
  local h = (math.floor)(t / 3600)
  local d = 0
  if calculateDay then
    d = h // 24
    h = (math.floor)(h % 24)
  end
  return d, h, m, s
end

TimestampToDate = function(t, isMillisecond)
  -- function num : 0_2 , upvalues : _ENV
  if isMillisecond then
    t = t // 1000
  end
  local dataTable = (os.date)("*t", t)
  return dataTable
end



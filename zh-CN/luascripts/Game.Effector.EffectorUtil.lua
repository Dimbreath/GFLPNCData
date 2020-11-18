-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectorUtil = {}
EffectorUtil.ConvertEffectorUid = function(uid)
  -- function num : 0_0 , upvalues : _ENV
  local functionId = uid >> 32
  local logicId = uid & CommonUtil.UInt32Max
  return functionId, logicId
end

return EffectorUtil


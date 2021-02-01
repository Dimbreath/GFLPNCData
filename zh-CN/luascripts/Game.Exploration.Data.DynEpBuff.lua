-- params : ...
-- function num : 0 , upvalues : _ENV
local DynEpBuff = class("DynEpBuff")
DynEpBuff.ctor = function(self, buff)
  -- function num : 0_0 , upvalues : _ENV
  self.dataId = buff.id
  if buff.info ~= nil then
    self.expireTm = (buff.info).expireTm
    self.cnt = (buff.info).cnt
    self.durationLayer = (buff.info).durationLayer
  else
    self.expireTm = -1
    self.cnt = -1
    self.durationLayer = -1
  end
  local buffCfg = (ConfigData.exploration_buff)[self.dataId]
  if buffCfg == nil then
    error("exploration buff cfg is null,id:" .. tostring(self.dataId))
    return 
  end
  self.epBuffCfg = buffCfg
end

DynEpBuff.IsBuffNeedShow = function(self)
  -- function num : 0_1
  return (self.epBuffCfg).is_show
end

DynEpBuff.GetEpBuffCfg = function(self)
  -- function num : 0_2
  return self.epBuffCfg
end

DynEpBuff.GetSpecificLogicPara = function(self, logic)
  -- function num : 0_3
  if (self.epBuffCfg).logic ~= logic then
    return false
  end
  return true, (self.epBuffCfg).logic_num, (self.epBuffCfg).logic_per
end

return DynEpBuff


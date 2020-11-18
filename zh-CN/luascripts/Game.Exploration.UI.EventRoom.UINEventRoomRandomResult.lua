-- params : ...
-- function num : 0 , upvalues : _ENV
local UINEventRoomRandomResult = class("UINEventRoomRandomResult", UIBaseNode)
local base = UIBaseNode
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local eResukltLogic = {addItem = 1, eventJump = 2, minItem = 3}
local eLogicFunc = {[eResukltLogic.addItem] = function(para1, para2)
  -- function num : 0_0 , upvalues : _ENV
  local temp = (string.split)(para1, "_")
  local itemNum = temp[2]
  local des = (LanguageUtil.GetLocaleText)(para2)
  des = (string.format)(des, itemNum)
  return des
end
, [eResukltLogic.eventJump] = function(para1, para2)
  -- function num : 0_1 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)(para2)
end
, [eResukltLogic.minItem] = function(para1, para2)
  -- function num : 0_2 , upvalues : _ENV
  local temp = (string.split)(para1, "_")
  local itemNum = temp[2]
  local des = (LanguageUtil.GetLocaleText)(para2)
  des = (string.format)(des, itemNum)
  return des
end
}
UINEventRoomRandomResult.OnInit = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINEventRoomRandomResult.InitRandomResult = function(self, passNum, probability, logic, para1, para2, jumpTarget)
  -- function num : 0_4 , upvalues : eLogicFunc, _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R7 in 'UnsetPending'

  ((self.ui).txt_passNum).text = passNum
  self.des = (eLogicFunc[logic])(para1, para2)
  self.jumpTarget = jumpTarget
  ;
  ((self.ui).txt_resultText):SetIndex(0, tostring(GetPreciseDecimalStr(probability * 100, 0)), self.des)
end

UINEventRoomRandomResult.GetDes = function(self)
  -- function num : 0_5
  return self.des
end

UINEventRoomRandomResult.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINEventRoomRandomResult


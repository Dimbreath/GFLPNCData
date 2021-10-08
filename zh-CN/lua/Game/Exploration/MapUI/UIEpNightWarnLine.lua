local UIEpNightWarnLine = class("UIEpNightWarnLine", UIBaseNode)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
UIEpNightWarnLine.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.fxList = {}
end

UIEpNightWarnLine.SetBossWarnLine = function(self, bool)
  -- function num : 0_1
  self.__isShowBoosWarn = bool
  ;
  ((self.ui).noticeLine):SetActive(not bool)
  ;
  ((self.ui).warnLine):SetActive(bool)
end

UIEpNightWarnLine.AdjustFx = function(self, mapData)
  -- function num : 0_2 , upvalues : _ENV
  local colNum = 4
  local rowNum = mapData.width * 2
  for col = 1, colNum do
    for row = 0, rowNum do
      local epNightWarnLineObj = ((self.ui).fX_UI_Night):Instantiate((self.ui).nightFxHolder)
      ;
      (table.insert)(self.fxList, epNightWarnLineObj)
      local x = (self.ui).fxLeftPad + (col - 1) * (self.ui).fxPad
      local y = (row % 2 == 1 and 1 or -1) * (math.ceil)(row / 2) * (self.ui).fxPad
      -- DECOMPILER ERROR at PC51: Confused about usage of register: R15 in 'UnsetPending'

      ;
      (epNightWarnLineObj.transform).localPosition = (Vector3.New)(x, y, 0)
    end
  end
end

return UIEpNightWarnLine


local UINSupportHeroAth = class("UINSupportHeroAth", UIBaseNode)
local base = UIBaseNode
local AthUtil = require("Game.Arithmetic.AthUtil")
UINSupportHeroAth.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.athItem = {obj = (self.ui).areaItem, 
ui = {}
}
  ;
  (UIUtil.LuaUIBindingTable)(((self.athItem).obj).transform, (self.athItem).ui)
end

UINSupportHeroAth.InitAth = function(self, index, space, slotDic)
  -- function num : 0_1 , upvalues : _ENV, AthUtil
  ((self.ui).img_Icon):SetIndex(index - 1)
  if #((self.athItem).ui).arry_AthSlot < space then
    space = #((self.athItem).ui).arry_AthSlot
  end
  local gridUnlockList = (ConfigData.game_config).athGridUnlockList
  local unlockGridDic = {}
  for pos,gridId in ipairs(gridUnlockList) do
    if pos <= space then
      unlockGridDic[gridId] = ((self.athItem).ui).color_unlocked
    end
  end
  if slotDic ~= nil then
    for gridId,itemId in pairs(slotDic) do
      local itemCfg = (ConfigData.item)[itemId]
      local athCfg = (ConfigData.arithmetic)[itemId]
      if itemCfg ~= nil and athCfg ~= nil then
        local gridList = (AthUtil.GetAthGridIdListBySize)(athCfg.size, gridId)
        local color = ItemQualityColor[itemCfg.quality]
        for _,eqGrid in ipairs(gridList) do
          unlockGridDic[eqGrid] = color
        end
      end
    end
  end
  do
    for i = 1, #((self.athItem).ui).arry_AthSlot do
      local gridId = (AthUtil.AthUseGridList)[i]
      local color = unlockGridDic[gridId]
      -- DECOMPILER ERROR at PC84: Confused about usage of register: R12 in 'UnsetPending'

      if color == nil or not color then
        do
          ((((self.athItem).ui).arry_AthSlot)[i]).color = ((self.athItem).ui).color_locked
          -- DECOMPILER ERROR at PC85: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC85: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

return UINSupportHeroAth


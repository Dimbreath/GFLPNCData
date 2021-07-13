-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpMonsterLevelUp = class("UIEpMonsterLevelUp", UIBaseWindow)
local base = UIBaseWindow
local UIEpMonsterLevelUpAttrItem = require("Game.Exploration.UI.MonsterLevel.UIEpMonsterLevelUpAttrItem")
UIEpMonsterLevelUp.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIEpMonsterLevelUpAttrItem
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnClickClose)
  self.attrPool = (UIItemPool.New)(UIEpMonsterLevelUpAttrItem, (self.ui).obj_attriItem)
  ;
  ((self.ui).obj_attriItem):SetActive(false)
end

UIEpMonsterLevelUp.InitEpMonsterLevelUp = function(self, curLevel, nextLevel, closeFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.closeFunc = closeFunc
  ;
  ((self.ui).uiAdapter):AdaptBgUI()
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_CurLevel).text = tostring(curLevel or 0)
  if nextLevel < (ConfigData.monster_level).monster_level_max then
    ((self.ui).tex_NextLevel):SetIndex(0, tostring(nextLevel))
  else
    ;
    ((self.ui).tex_NextLevel):SetIndex(1)
  end
  self._autoCloseTimer = (TimerManager:GetTimer(3, self.OnClickClose, self)):Start()
  self:GenLevelUpAttrItems(curLevel, nextLevel)
end

UIEpMonsterLevelUp._CleatTimer = function(self)
  -- function num : 0_2
  if self._autoCloseTimer ~= nil then
    (self._autoCloseTimer):Stop()
    self._autoCloseTimer = nil
  end
end

UIEpMonsterLevelUp.GenLevelUpAttrItems = function(self, curLevel, nextLevel)
  -- function num : 0_3 , upvalues : _ENV
  (self.attrPool):HideAll()
  local curLevelCfg = (ConfigData.monster_level)[curLevel]
  local nextLevelCfg = (ConfigData.monster_level)[nextLevel]
  do
    if curLevelCfg.hp_amplify ~= nextLevelCfg.hp_amplify then
      local item = (self.attrPool):GetOne()
      item:InitMonsterLevelPreviewRowItem(0, curLevelCfg.hp_amplify, nextLevelCfg.hp_amplify)
    end
    do
      if curLevelCfg.pow_amplify ~= nextLevelCfg.pow_amplify then
        local item = (self.attrPool):GetOne()
        item:InitMonsterLevelPreviewRowItem(1, curLevelCfg.pow_amplify, nextLevelCfg.pow_amplify)
      end
      if curLevelCfg.skill_intensity_amplify ~= nextLevelCfg.skill_intensity_amplify then
        local item = (self.attrPool):GetOne()
        item:InitMonsterLevelPreviewRowItem(2, curLevelCfg.skill_intensity_amplify, nextLevelCfg.skill_intensity_amplify)
      end
    end
  end
end

UIEpMonsterLevelUp.OnClickClose = function(self)
  -- function num : 0_4
  self:_CleatTimer()
  if self.closeFunc ~= nil then
    (self.closeFunc)()
  end
  self:Delete()
end

UIEpMonsterLevelUp.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  self:_CleatTimer()
  ;
  (base.OnDelete)(self)
end

return UIEpMonsterLevelUp


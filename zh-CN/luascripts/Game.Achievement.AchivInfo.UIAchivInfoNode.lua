-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAchivInfoNode = class("UIAchivInfoNode", UIBaseNode)
local base = UIBaseNode
UIAchivInfoNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Left, self, self.OnClickLeft)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Right, self, self.OnClickRight)
  ;
  (UIUtil.AddButtonListener)((self.ui).background, self, self.OnClickClose)
end

UIAchivInfoNode.InitAchivInfo = function(self, resLoader)
  -- function num : 0_1 , upvalues : _ENV
  self.curLevel = (PlayerDataCenter.playerLevel).level
  self.resLoader = resLoader
  self:UpdateAchivInfo(self.curLevel)
end

UIAchivInfoNode.UpdateAchivInfo = function(self, level)
  -- function num : 0_2 , upvalues : _ENV
  local levelCfg = (ConfigData.achievement_level)[level]
  if levelCfg == nil then
    error("Can\'t find achievement_level, level = " .. tostring(level))
    return 
  end
  local path = PathConsts:GetAchivLevelIconPath(levelCfg.icon)
  local icon = (self.resLoader):LoadABAsset(path)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).level_Icon).texture = icon
  ;
  ((self.ui).tex_level):SetIndex(0, tostring(level))
  ;
  ((self.ui).tex_Content):SetIndex(0, tostring(levelCfg.stamina), tostring(FormatNum(levelCfg.resource / 10)), tostring(FormatNum(levelCfg.battle_exp / 10)))
end

UIAchivInfoNode.OnClickLeft = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self.curLevel = (math.max)(1, self.curLevel - 1)
  self:UpdateAchivInfo(self.curLevel)
end

UIAchivInfoNode.OnClickRight = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local maxLevel = (ConfigData.game_config).playerMaxLevel
  self.curLevel = (math.min)(maxLevel, self.curLevel + 1)
  self:UpdateAchivInfo(self.curLevel)
end

UIAchivInfoNode.OnClickClose = function(self)
  -- function num : 0_5
  self:Hide()
end

UIAchivInfoNode.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UIAchivInfoNode


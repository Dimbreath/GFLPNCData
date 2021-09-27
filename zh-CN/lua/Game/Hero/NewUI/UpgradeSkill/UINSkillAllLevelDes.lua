local UINSkillAllLevelDes = class("UINSkillAllLevelDes", UIBaseNode)
local base = UIBaseNode
local UINSkillAllLevelDesItem = require("Game.Hero.NewUI.UpgradeSkill.UINSkillAllLevelDesItem")
local cs_Canvas = (CS.UnityEngine).Canvas
UINSkillAllLevelDes.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINSkillAllLevelDesItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_close, self, self.Hide)
  self.DesItemPool = (UIItemPool.New)(UINSkillAllLevelDesItem, (self.ui).obj_skillInfoItem)
  ;
  ((self.ui).obj_skillInfoItem):SetActive(false)
end

UINSkillAllLevelDes.InitAllDes = function(self, skillData)
  -- function num : 0_1 , upvalues : _ENV
  local maxLevel = skillData:GetMaxLevel()
  local nowLevel = 0
  if skillData:GetIsUnlock() then
    nowLevel = skillData.level
  end
  ;
  (self.DesItemPool):HideAll()
  for i = 1, maxLevel do
    local item = (self.DesItemPool):GetOne(true)
    item:InitDes(i, skillData:GetLevelDescribe(i), nowLevel)
  end
  local selectItem = ((self.DesItemPool).listItem)[nowLevel]
  if selectItem ~= nil then
    (UIUtil.ScrollRectLocation)((self.ui).scrollList, selectItem, true)
  end
end

UINSkillAllLevelDes.OnHide = function(self)
  -- function num : 0_2 , upvalues : base
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).scrollList).verticalNormalizedPosition = 1
  ;
  (base.OnHide)(self)
end

UINSkillAllLevelDes.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINSkillAllLevelDes


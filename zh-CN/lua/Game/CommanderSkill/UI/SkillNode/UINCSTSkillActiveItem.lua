local UINCSTSkillActiveItem = class("UINCSTSkillActiveItem", UIBaseNode)
local base = UIBaseNode
local CommanderSkillData = require("Game.CommanderSkill.CommanderSkillData")
UINCSTSkillActiveItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self._OnClickRoot)
  ;
  ((self.ui).obj_Select):SetActive(false)
end

UINCSTSkillActiveItem.InitCSTSkillActiveItem = function(self, cmdSkillData, resLoader, clickFunc)
  -- function num : 0_1
  self.cmdSkillData = cmdSkillData
  self.resLoader = resLoader
  self.clickFunc = clickFunc
  self:RefreshCSTSkillActiveItem()
end

UINCSTSkillActiveItem.RefreshCSTSkillActiveItem = function(self)
  -- function num : 0_2 , upvalues : _ENV, CommanderSkillData
  local cmdSkillData = self.cmdSkillData
  if cmdSkillData == nil then
    (((self.ui).img_Icon).gameObject):SetActive(false)
    ;
    ((self.ui).obj_ManualSkill):SetActive(false)
    ;
    ((self.ui).obj_Cost):SetActive(false)
    ;
    ((self.ui).obj_Lock):SetActive(false)
    ;
    ((self.ui).obj_Select):SetActive(false)
    return 
  end
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).skillName).text = (LanguageUtil.GetLocaleText)(cmdSkillData:GetName())
  ;
  (((self.ui).img_Icon).gameObject):SetActive(true)
  local islocked = not cmdSkillData:IsCmdSkillUnlock()
  ;
  ((self.ui).obj_Lock):SetActive(islocked)
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).enabled = false
  ;
  (self.resLoader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommanderSkillIcons"), function(spriteAtlas)
    -- function num : 0_2_0 , upvalues : self, cmdSkillData
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = spriteAtlas:GetSprite(cmdSkillData:GetIcon())
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).enabled = true
  end
)
  if cmdSkillData.type == (CommanderSkillData.skillType).active then
    ((self.ui).obj_ManualSkill):SetActive(cmdSkillData:CmdSkillIsManualMode())
    -- DECOMPILER ERROR at PC79: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Cost).text = tostring(cmdSkillData.mpCost)
    ;
    ((self.ui).obj_Cost):SetActive(cmdSkillData.isUnlock)
  else
    ;
    ((self.ui).obj_ManualSkill):SetActive(false)
    ;
    ((self.ui).obj_Cost):SetActive(false)
  end
end

UINCSTSkillActiveItem.SetCSTSkillItemSelect = function(self, select)
  -- function num : 0_3
  ((self.ui).obj_Select):SetActive(select)
end

UINCSTSkillActiveItem._OnClickRoot = function(self)
  -- function num : 0_4
  if self.cmdSkillData == nil then
    return 
  end
  if self.clickFunc ~= nil then
    (self.clickFunc)(self.cmdSkillData, self)
  end
end

UINCSTSkillActiveItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINCSTSkillActiveItem


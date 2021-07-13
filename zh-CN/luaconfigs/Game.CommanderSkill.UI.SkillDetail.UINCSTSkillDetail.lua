-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSTSkillDetail = class("UINCSTSkillDetail", UIBaseNode)
local base = UIBaseNode
local UINCSTSkillAdvItem = require("Game.CommanderSkill.UI.SkillDetail.UINCSTSkillAdvItem")
UINCSTSkillDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINCSTSkillAdvItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Equip, self, self._OnClickEquip)
  ;
  ((self.ui).advDetailItem):SetActive(false)
  self.advDetailPool = (UIItemPool.New)(UINCSTSkillAdvItem, (self.ui).advDetailItem)
  self.equipBtnDefaultColor = ((self.ui).img_Equip).color
end

UINCSTSkillDetail.InitCSTSkillDetail = function(self, cmdSkillCtrl, cmdSkillData, resLoader, isEquip)
  -- function num : 0_1 , upvalues : _ENV
  self.cmdSkillCtrl = cmdSkillCtrl
  self.cmdSkillData = cmdSkillData
  self.resLoader = resLoader
  self.isEquip = isEquip
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = cmdSkillData:GetName()
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R5 in 'UnsetPending'

  if cmdSkillData:IsAdvanceCmdSkill() then
    ((self.ui).tex_Desc).text = cmdSkillData:GetCmdSkillBaseDescribe()
  else
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).tex_Desc).text = cmdSkillData:GetDescribe(1)
  end
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).enabled = false
  resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommanderSkillIcons"), function(spriteAtlas)
    -- function num : 0_1_0 , upvalues : self, cmdSkillData
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
  self:RefreshCSTSkillDetail()
end

UINCSTSkillDetail.RefreshCSTSkillDetail = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if not self.active then
    return 
  end
  local cmdSkillData = self.cmdSkillData
  ;
  (((self.ui).tex_Unlock).gameObject):SetActive(not cmdSkillData.isUnlock)
  ;
  ((self.ui).tex_Unlock):SetIndex(0, tostring(cmdSkillData.unlockLevel))
  ;
  (self.advDetailPool):HideAll()
  ;
  (((self.ui).btn_Equip).gameObject):SetActive(false)
  ;
  ((self.ui).cost):SetActive(false)
  if cmdSkillData.type == (cmdSkillData.skillType).active then
    if cmdSkillData:IsCmdSkillUltimate() then
      ((self.ui).tex_Type):SetIndex(2)
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).img_TypeBg).color = (self.ui).color_ultimate
    else
      ;
      ((self.ui).tex_Type):SetIndex(0)
      -- DECOMPILER ERROR at PC63: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).img_TypeBg).color = (self.ui).color_active
    end
    if not cmdSkillData:CmdSkillIsSlotDefault() then
      (((self.ui).btn_Equip).gameObject):SetActive(cmdSkillData.isUnlock)
      ;
      ((self.ui).tex_Equip):SetIndex(self.isEquip and 1 or 0)
      -- DECOMPILER ERROR at PC95: Confused about usage of register: R2 in 'UnsetPending'

      if not self.isEquip or not Color.gray then
        ((self.ui).img_Equip).color = self.equipBtnDefaultColor
        self:_RefreshAdvDetail()
        ;
        ((self.ui).cost):SetActive(true)
        ;
        ((self.ui).tex_Cost):SetIndex(0, tostring(cmdSkillData.mpCost))
        if cmdSkillData.type == (cmdSkillData.skillType).passive then
          ((self.ui).tex_Type):SetIndex(1)
          -- DECOMPILER ERROR at PC126: Confused about usage of register: R2 in 'UnsetPending'

          ;
          ((self.ui).img_TypeBg).color = (self.ui).color_passive
        end
      end
    end
  end
end

UINCSTSkillDetail._RefreshAdvDetail = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local cmdSkillData = self.cmdSkillData
  for level = 1, cmdSkillData.maxLevel do
    local desc = cmdSkillData:GetCmdSkillAdvDescribe(level)
    if not (string.IsNullOrEmpty)(desc) then
      local iconName = (cmdSkillData.levelIconList)[level]
      local advLevel = level
      local unlockLevel = (cmdSkillData.unlockLevelList)[level]
      local unlock = not cmdSkillData.isUnlock or level <= cmdSkillData.level
      local advItem = (self.advDetailPool):GetOne()
      advItem:InitCSTSkillAdvItem(self.resLoader, iconName, advLevel, desc, unlock, unlockLevel)
    end
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINCSTSkillDetail._OnClickEquip = function(self)
  -- function num : 0_4
  if self.isEquip then
    return 
  end
  ;
  (self.cmdSkillCtrl):ChangeCSTSlotSkill((self.cmdSkillData).place, (self.cmdSkillData).dataId)
end

UINCSTSkillDetail.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (self.advDetailPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINCSTSkillDetail


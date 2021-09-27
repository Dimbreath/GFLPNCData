local UINCSTSkillDetail = class("UINCSTSkillDetail", UIBaseNode)
local base = UIBaseNode
UINCSTSkillDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Equip, self, self._OnClickEquip)
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
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Desc).text = cmdSkillData:GetDescribe()
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R5 in 'UnsetPending'

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
  ((self.ui).cost):SetActive(false)
  ;
  ((self.ui).obj_cd):SetActive(false)
  ;
  ((self.ui).tex_Type):SetIndex(cmdSkillData.type - 1)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_TypeBg).color = ((self.ui).col_type_arr)[cmdSkillData.type]
  ;
  ((self.ui).cost):SetActive(true)
  ;
  ((self.ui).tex_Cost):SetIndex(0, tostring(cmdSkillData.mpCost))
  if cmdSkillData.cdTime > 0 then
    ((self.ui).obj_cd):SetActive(true)
    ;
    ((self.ui).tex_CD):SetIndex(0, tostring(cmdSkillData.cdTime))
  end
  ;
  ((self.ui).obj_Lock):SetActive(false)
  -- DECOMPILER ERROR at PC70: Confused about usage of register: R2 in 'UnsetPending'

  if not cmdSkillData:IsCmdSkillUnlock() then
    ((self.ui).img_Equip).color = (self.ui).color_lock
    ;
    ((self.ui).tex_Equip):SetIndex(2)
    ;
    ((self.ui).obj_Lock):SetActive(true)
    -- DECOMPILER ERROR at PC85: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_lockDes).text = cmdSkillData:GetUnlockDes()
  else
    -- DECOMPILER ERROR at PC94: Confused about usage of register: R2 in 'UnsetPending'

    if self.isEquip then
      ((self.ui).img_Equip).color = Color.gray
      ;
      ((self.ui).tex_Equip):SetIndex(1)
    else
      -- DECOMPILER ERROR at PC105: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).img_Equip).color = (self.ui).color_unlock
      ;
      ((self.ui).tex_Equip):SetIndex(0)
    end
  end
end

UINCSTSkillDetail._OnClickEquip = function(self)
  -- function num : 0_3
  if self.isEquip then
    return 
  end
  if not (self.cmdSkillData):IsCmdSkillUnlock() then
    return 
  end
  ;
  (self.cmdSkillCtrl):ChangeCSTSlotSkill((self.cmdSkillData).place, (self.cmdSkillData).dataId)
end

UINCSTSkillDetail.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINCSTSkillDetail


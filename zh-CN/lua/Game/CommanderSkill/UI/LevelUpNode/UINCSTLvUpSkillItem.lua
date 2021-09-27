local UINCSTLvUpSkillItem = class("UINCSTLvUpSkillItem", UIBaseNode)
local base = UIBaseNode
UINCSTLvUpSkillItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINCSTLvUpSkillItem.InitCSTLvUpSkillItem = function(self, resLoader, cmdSkillData, treeLevel, skillLevel)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R5 in 'UnsetPending'

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
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = cmdSkillData:GetName()
  if cmdSkillData.type == (cmdSkillData.skillType).active then
    if cmdSkillData:IsCmdSkillUltimate() then
      ((self.ui).tex_Type):SetIndex(2)
      -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).img_TypeBg).color = (self.ui).color_ultimate
    else
      ;
      ((self.ui).tex_Type):SetIndex(0)
      -- DECOMPILER ERROR at PC44: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).img_TypeBg).color = (self.ui).color_active
    end
  else
    if cmdSkillData.type == (cmdSkillData.skillType).passive then
      ((self.ui).tex_Type):SetIndex(1)
      -- DECOMPILER ERROR at PC60: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).img_TypeBg).color = (self.ui).color_passive
    end
  end
  local unlockLevel = (cmdSkillData.unlockLevelList)[skillLevel]
  ;
  ((self.ui).obj_Lock):SetActive(treeLevel < unlockLevel)
  ;
  ((self.ui).tex_UnlockLevel):SetIndex(0, tostring(unlockLevel))
  local showAdv = cmdSkillData.type == (cmdSkillData.skillType).active and skillLevel > 1
  ;
  ((self.ui).obj_Level):SetActive(showAdv)
  if showAdv then
    ((self.ui).tex_Level):SetIndex(0, tostring(skillLevel))
    local iconName = (cmdSkillData.levelIconList)[skillLevel]
    do
      -- DECOMPILER ERROR at PC107: Confused about usage of register: R8 in 'UnsetPending'

      ((self.ui).img_Level).enabled = false
      resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommanderSkillIcons"), function(spriteAtlas)
    -- function num : 0_1_1 , upvalues : self, iconName
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Level).sprite = spriteAtlas:GetSprite(iconName)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Level).enabled = true
  end
)
    end
  end
  -- DECOMPILER ERROR at PC121: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Desc).text = cmdSkillData:GetDescribe(1)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UINCSTLvUpSkillItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINCSTLvUpSkillItem


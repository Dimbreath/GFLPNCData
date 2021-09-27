local UINCSTSkillPassiveItem = class("UINCSTSkillPassiveItem", UIBaseNode)
local base = UIBaseNode
UINCSTSkillPassiveItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self._OnClickRoot)
  ;
  ((self.ui).obj_Select):SetActive(false)
end

UINCSTSkillPassiveItem.InitCSTSkillPassiveItem = function(self, cmdSkillData, resLoader, clickFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.cmdSkillData = cmdSkillData
  self.resLoader = resLoader
  self.clickFunc = clickFunc
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).enabled = false
  ;
  (self.resLoader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommanderSkillIcons"), function(spriteAtlas)
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
  self:RefreshCSTSkillPassiveItem()
end

UINCSTSkillPassiveItem.RefreshCSTSkillPassiveItem = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local cmdSkillData = self.cmdSkillData
  ;
  ((self.ui).obj_Lock):SetActive(not cmdSkillData.isUnlock)
  if not cmdSkillData.isUnlock then
    ((self.ui).tex_UnlockLevel):SetIndex(0, tostring(cmdSkillData.unlockLevel))
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

  if not cmdSkillData.isUnlock or not Color.white then
    ((self.ui).img_Icon).color = Color.gray
  end
end

UINCSTSkillPassiveItem.SetCSTSkillItemSelect = function(self, select)
  -- function num : 0_3
  if ((self.ui).obj_Select).activeInHierarchy ~= select then
    ((self.ui).obj_Select):SetActive(select)
  end
end

UINCSTSkillPassiveItem._OnClickRoot = function(self)
  -- function num : 0_4
  if self.clickFunc ~= nil then
    (self.clickFunc)(self.cmdSkillData, self)
  end
  self:ShowCSTSkillItemBlueDot(false)
end

UINCSTSkillPassiveItem.ShowCSTSkillItemBlueDot = function(self, show)
  -- function num : 0_5
  if ((self.ui).blueDot).activeInHierarchy ~= show then
    ((self.ui).blueDot):SetActive(show)
  end
end

UINCSTSkillPassiveItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINCSTSkillPassiveItem


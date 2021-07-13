-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSTSkillAdvItem = class("UINCSTSkillAdvItem", UIBaseNode)
local base = UIBaseNode
UINCSTSkillAdvItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINCSTSkillAdvItem.InitCSTSkillAdvItem = function(self, resLoader, iconName, advLevel, desc, unlock, unlockLevel)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R7 in 'UnsetPending'

  ((self.ui).img_Icon).enabled = false
  resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommanderSkillIcons"), function(spriteAtlas)
    -- function num : 0_1_0 , upvalues : self, iconName
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = spriteAtlas:GetSprite(iconName)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).enabled = true
  end
)
  ;
  ((self.ui).tex_Name):SetIndex(0, tostring(advLevel))
  ;
  ((self.ui).tex_Unlock):SetIndex(0, tostring(unlockLevel))
  ;
  (((self.ui).tex_Unlock).gameObject):SetActive(not unlock)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Desc).text = desc
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R7 in 'UnsetPending'

  if not unlock or not (self.ui).color_unlock then
    ((self.ui).img_Title).color = (self.ui).color_lock
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R7 in 'UnsetPending'

    if not unlock or not (self.ui).color_unlock then
      ((self.ui).tex_Desc).color = (self.ui).color_lock
    end
  end
end

UINCSTSkillAdvItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINCSTSkillAdvItem


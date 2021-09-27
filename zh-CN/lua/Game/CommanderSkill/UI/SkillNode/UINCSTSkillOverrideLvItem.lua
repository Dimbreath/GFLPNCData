local UINCSTSkillOverrideLvItem = class("UINCSTSkillOverrideLvItem", UIBaseNode)
local base = UIBaseNode
UINCSTSkillOverrideLvItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINCSTSkillOverrideLvItem.InitCSTSkillOverrideLvItem = function(self, resLoader, iconName)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

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
end

UINCSTSkillOverrideLvItem.SetCSTSkillOverrideLvItemLock = function(self, lock, equipColor)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  if lock then
    ((self.ui).img_Bg).color = Color.black
  else
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

    if not equipColor then
      ((self.ui).img_Bg).color = Color.white
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

      if not lock or not Color.white then
        ((self.ui).img_Icon).color = Color.black
        -- DECOMPILER ERROR at PC34: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((self.ui).canvasGroup).alpha = lock and 0.4 or 1
      end
    end
  end
end

UINCSTSkillOverrideLvItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINCSTSkillOverrideLvItem


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSUpgradeSkillItem = class("UINCSUpgradeSkillItem", UIBaseNode)
local base = UIBaseNode
UINCSUpgradeSkillItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINCSUpgradeSkillItem.InitSkillItem = function(self, resloader)
  -- function num : 0_1
  self.resloader = resloader
end

UINCSUpgradeSkillItem.RefreshIcon = function(self, skillData)
  -- function num : 0_2 , upvalues : _ENV
  (self.resloader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommanderSkillIcons"), function(spriteAtlas)
    -- function num : 0_2_0 , upvalues : self, skillData
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_SkillIcon).sprite = spriteAtlas:GetSprite(skillData:GetIcon())
  end
)
end

UINCSUpgradeSkillItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINCSUpgradeSkillItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSUpgradeSkillItem = class("UINCSUpgradeSkillItem", UIBaseNode)
local base = UIBaseNode
UINCSUpgradeSkillItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINCSUpgradeSkillItem.InitSkillItem = function(self, resloader)
    -- function num : 0_1
    self.resloader = resloader
end

UINCSUpgradeSkillItem.RefreshIcon = function(self, skillData)
    -- function num : 0_2 , upvalues : _ENV
    (self.resloader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath(
                                          "CommanderSkillIcons"),
                                      function(spriteAtlas)
        -- function num : 0_2_0 , upvalues : self, skillData
        if spriteAtlas == nil then return end -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'
        
        ((self.ui).img_SkillIcon).sprite =
            spriteAtlas:GetSprite(skillData:GetIcon())
    end)
end

UINCSUpgradeSkillItem.OnDelete = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnDelete)(self)
end

return UINCSUpgradeSkillItem


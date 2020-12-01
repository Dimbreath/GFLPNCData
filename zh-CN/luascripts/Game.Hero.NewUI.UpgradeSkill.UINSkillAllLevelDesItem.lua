-- params : ...
-- function num : 0 , upvalues : _ENV
local UINSkillAllLevelDesItem = class("UINSkillAllLevelDesItem", UIBaseNode)
local base = UIBaseNode
UINSkillAllLevelDesItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINSkillAllLevelDesItem.InitDes = function(self, level, des, nowLevel)
  -- function num : 0_1 , upvalues : _ENV
  if nowLevel == level then
    ((self.ui).tex_SkillLevel):SetIndex(1, tostring(level))
    ;
    ((self.ui).tex_SkillContent):SetIndex(1, des)
  else
    ;
    ((self.ui).tex_SkillLevel):SetIndex(0, tostring(level))
    ;
    ((self.ui).tex_SkillContent):SetIndex(0, des)
  end
end

UINSkillAllLevelDesItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINSkillAllLevelDesItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINSkillAllLevelDesItem = class("UINSkillAllLevelDesItem", UIBaseNode)
local base = UIBaseNode
UINSkillAllLevelDesItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINSkillAllLevelDesItem.InitDes = function(self, level, des, nowLevel)
    -- function num : 0_1 , upvalues : _ENV
    if nowLevel == level then
        ((self.ui).tex_SkillLevel):SetIndex(1, tostring(level));
        ((self.ui).tex_SkillContent):SetIndex(1, des)
    else

        ((self.ui).tex_SkillLevel):SetIndex(0, tostring(level));
        ((self.ui).tex_SkillContent):SetIndex(0, des)
    end
end

UINSkillAllLevelDesItem.OnDelete = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnDelete)(self)
end

return UINSkillAllLevelDesItem


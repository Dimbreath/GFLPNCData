-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDungeonStoryCondition = class("UIDungeonStoryCondition", UIBaseNode)
local base = UIBaseNode
UIDungeonStoryCondition.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIDungeonStoryCondition.InitWithData = function(self, text, isMeet)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).text).text = text
  local index = 0
  if isMeet then
    index = 1
  end
  ;
  ((self.ui).img_State):SetIndex(index)
end

UIDungeonStoryCondition.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UIDungeonStoryCondition

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDungeonStoryCondition = class("UIDungeonStoryCondition", UIBaseNode)
local base = UIBaseNode
UIDungeonStoryCondition.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIDungeonStoryCondition.InitWithData = function(self, text, isMeet)
    -- function num : 0_1
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

    ((self.ui).text).text = text
    local index = 0
    if isMeet then index = 1 end
    ((self.ui).img_State):SetIndex(index)
end

UIDungeonStoryCondition.OnDelete = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnDelete)(self)
end

return UIDungeonStoryCondition


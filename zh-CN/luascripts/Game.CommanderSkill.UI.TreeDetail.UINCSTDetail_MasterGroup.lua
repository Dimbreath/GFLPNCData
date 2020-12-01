-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSTDetail_MasterGroup = class("UINCSTDetail_MasterGroup", UIBaseNode)
local base = UIBaseNode
local MasterGroupItem = require("Game.CommanderSkill.UI.TreeDetail.UINCSTDetail_MasterGroupItem")
UINCSTDetail_MasterGroup.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, MasterGroupItem
  self.totalPoint = 0
  self.usedlPoint = 0
  local levelCfg = ConfigData.commander_skill_master_level
  self.maxPoints = (levelCfg[#levelCfg]).master_point
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.MasterGroupItemPool = (UIItemPool.New)(MasterGroupItem, (self.ui).obj_skillAttriItem)
  self.__AddPoint = BindCallback(self, self.AddPoint)
  self.__MinPoint = BindCallback(self, self.MinPoint)
end

UINCSTDetail_MasterGroup.InitMasterGroup = function(self)
  -- function num : 0_1
end

UINCSTDetail_MasterGroup.RefreshMasterGroup = function(self, skillDataList, index)
  -- function num : 0_2 , upvalues : _ENV
  self.totalPoint = ((PlayerDataCenter.CommanderSkillModualData).masterSkillPoint)[index]
  self.usedlPoint = 0
  self.index = index
  ;
  ((self.ui).tex_TileName):SetIndex(0, tostring(index))
  ;
  (self.MasterGroupItemPool):HideAll()
  for index,skillData in ipairs(skillDataList) do
    local item = (self.MasterGroupItemPool):GetOne()
    item:RefreshMasterSkill(R11_PC31, self.__AddPoint, self.__MinPoint, (self.maxPoints)[index])
    self.usedlPoint = self.usedlPoint + item.curPoint
  end
  self:RefreshPoint()
end

UINCSTDetail_MasterGroup.RefreshPoint = function(self)
  -- function num : 0_3 , upvalues : _ENV
  ((self.ui).tex_Point):SetIndex(0, tostring(self.totalPoint - self.usedlPoint))
end

UINCSTDetail_MasterGroup.AddPoint = function(self)
  -- function num : 0_4
  if self.totalPoint - self.usedlPoint > 0 then
    self.usedlPoint = self.usedlPoint + 1
    self:RefreshPoint()
    return true
  else
    return false
  end
end

UINCSTDetail_MasterGroup.MinPoint = function(self)
  -- function num : 0_5
  if self.usedlPoint - 1 >= 0 then
    self.usedlPoint = self.usedlPoint - 1
  else
    self.usedlPoint = 0
  end
  self:RefreshPoint()
end

UINCSTDetail_MasterGroup.CleanAllPoint = function(self)
  -- function num : 0_6 , upvalues : _ENV
  for _,item in ipairs((self.MasterGroupItemPool).listItem) do
    item:CleanAllPoint()
  end
  self.usedlPoint = 0
  self:RefreshPoint()
end

UINCSTDetail_MasterGroup.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return UINCSTDetail_MasterGroup

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSTDetail_MasterGroup = class("UINCSTDetail_MasterGroup", UIBaseNode)
local base = UIBaseNode
local MasterGroupItem = require(
                            "Game.CommanderSkill.UI.TreeDetail.UINCSTDetail_MasterGroupItem")
UINCSTDetail_MasterGroup.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, MasterGroupItem
    self.totalPoint = 0
    self.usedlPoint = 0
    local levelCfg = ConfigData.commander_skill_master_level
    self.maxPoints = (levelCfg[#levelCfg]).master_point;
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.MasterGroupItemPool = (UIItemPool.New)(MasterGroupItem,
                                                (self.ui).obj_skillAttriItem)
    self.__AddPoint = BindCallback(self, self.AddPoint)
    self.__MinPoint = BindCallback(self, self.MinPoint)
end

UINCSTDetail_MasterGroup.InitMasterGroup =
    function(self)
        -- function num : 0_1
    end

UINCSTDetail_MasterGroup.RefreshMasterGroup =
    function(self, skillDataList, index)
        -- function num : 0_2 , upvalues : _ENV
        self.totalPoint =
            ((PlayerDataCenter.CommanderSkillModualData).masterSkillPoint)[index]
        self.usedlPoint = 0
        self.index = index;
        ((self.ui).tex_TileName):SetIndex(0, tostring(index));
        (self.MasterGroupItemPool):HideAll()
        for index, skillData in ipairs(skillDataList) do
            local item = (self.MasterGroupItemPool):GetOne()
            item:RefreshMasterSkill(R11_PC31, self.__AddPoint, self.__MinPoint,
                                    (self.maxPoints)[index])
            self.usedlPoint = self.usedlPoint + item.curPoint
        end
        self:RefreshPoint()
    end

UINCSTDetail_MasterGroup.RefreshPoint = function(self)
    -- function num : 0_3 , upvalues : _ENV
    ((self.ui).tex_Point):SetIndex(0,
                                   tostring(self.totalPoint - self.usedlPoint))
end

UINCSTDetail_MasterGroup.AddPoint = function(self)
    -- function num : 0_4
    if self.totalPoint - self.usedlPoint > 0 then
        self.usedlPoint = self.usedlPoint + 1
        self:RefreshPoint()
        return true
    else
        return false
    end
end

UINCSTDetail_MasterGroup.MinPoint = function(self)
    -- function num : 0_5
    if self.usedlPoint - 1 >= 0 then
        self.usedlPoint = self.usedlPoint - 1
    else
        self.usedlPoint = 0
    end
    self:RefreshPoint()
end

UINCSTDetail_MasterGroup.CleanAllPoint =
    function(self)
        -- function num : 0_6 , upvalues : _ENV
        for _, item in ipairs((self.MasterGroupItemPool).listItem) do
            item:CleanAllPoint()
        end
        self.usedlPoint = 0
        self:RefreshPoint()
    end

UINCSTDetail_MasterGroup.OnDelete = function(self)
    -- function num : 0_7 , upvalues : base
    (base.OnDelete)(self)
end

return UINCSTDetail_MasterGroup


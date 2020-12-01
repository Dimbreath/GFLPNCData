-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSTDetail_MasterGroupItem = class("UINCSTDetail_MasterGroupItem", UIBaseNode)
local base = UIBaseNode
UINCSTDetail_MasterGroupItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.addCallback = nil
  self.minCallback = nil
  self.curPoint = 0
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Add, self, self.AddPoint)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Reduce, self, self.MinPoint)
end

UINCSTDetail_MasterGroupItem.RefreshMasterSkill = function(self, skillData, addCallback, minCallback, maxPoint)
  -- function num : 0_1 , upvalues : _ENV
  self.skillData = skillData
  self.curPoint = skillData:GetMasterSkilllevel()
  self.addCallback = addCallback
  self.minCallback = minCallback
  self.maxPoint = maxPoint
  if skillData.isUnlock then
    ((self.ui).obj_unlock):SetActive(false)
  else
    ;
    ((self.ui).obj_unlock):SetActive(true)
    ;
    ((self.ui).tex_lock):SetIndex(0, tostring(skillData.unlockLevel))
  end
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Content).text = skillData:GetDescribe()
  self:RefreshPoint()
end

UINCSTDetail_MasterGroupItem.RefreshPoint = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self.skillData):SetMasterSkilllevel(self.curPoint)
  ;
  ((self.ui).tex_Count):SetIndex(0, tostring(self.curPoint), tostring(self.maxPoint))
  ;
  ((self.ui).tex_Ratio):SetIndex(0, (self.skillData):GetMasterSkillAddVaule())
end

UINCSTDetail_MasterGroupItem.AddPoint = function(self)
  -- function num : 0_3
  if self.addCallback ~= nil then
    local success = (self.addCallback)()
    if success then
      self.curPoint = self.curPoint + 1
      self:RefreshPoint()
    end
  end
end

UINCSTDetail_MasterGroupItem.MinPoint = function(self)
  -- function num : 0_4
  if self.curPoint > 0 and self.minCallback ~= nil then
    (self.minCallback)()
    self.curPoint = self.curPoint - 1
    self:RefreshPoint()
  end
end

UINCSTDetail_MasterGroupItem.CleanAllPoint = function(self)
  -- function num : 0_5
  self.curPoint = 0
  self:RefreshPoint()
end

UINCSTDetail_MasterGroupItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINCSTDetail_MasterGroupItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSTDetail_MasterGroupItem = class("UINCSTDetail_MasterGroupItem",
                                           UIBaseNode)
local base = UIBaseNode
UINCSTDetail_MasterGroupItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self.addCallback = nil
    self.minCallback = nil
    self.curPoint = 0;
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_Add, self, self.AddPoint);
    (UIUtil.AddButtonListener)((self.ui).btn_Reduce, self, self.MinPoint)
end

UINCSTDetail_MasterGroupItem.RefreshMasterSkill =
    function(self, skillData, addCallback, minCallback, maxPoint)
        -- function num : 0_1 , upvalues : _ENV
        self.skillData = skillData
        self.curPoint = skillData:GetMasterSkilllevel()
        self.addCallback = addCallback
        self.minCallback = minCallback
        self.maxPoint = maxPoint
        if skillData.isUnlock then
            ((self.ui).obj_unlock):SetActive(false)
        else

            ((self.ui).obj_unlock):SetActive(true);
            ((self.ui).tex_lock):SetIndex(0, tostring(skillData.unlockLevel))
        end -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'
        
        ((self.ui).tex_Content).text = skillData:GetDescribe()
        self:RefreshPoint()
    end

UINCSTDetail_MasterGroupItem.RefreshPoint =
    function(self)
        -- function num : 0_2 , upvalues : _ENV
        (self.skillData):SetMasterSkilllevel(self.curPoint);
        ((self.ui).tex_Count):SetIndex(0, tostring(self.curPoint),
                                       tostring(self.maxPoint));
        ((self.ui).tex_Ratio):SetIndex(0,
                                       (self.skillData):GetMasterSkillAddVaule())
    end

UINCSTDetail_MasterGroupItem.AddPoint = function(self)
    -- function num : 0_3
    if self.addCallback ~= nil then
        local success = (self.addCallback)()
        if success then
            self.curPoint = self.curPoint + 1
            self:RefreshPoint()
        end
    end
end

UINCSTDetail_MasterGroupItem.MinPoint = function(self)
    -- function num : 0_4
    if self.curPoint > 0 and self.minCallback ~= nil then
        (self.minCallback)()
        self.curPoint = self.curPoint - 1
        self:RefreshPoint()
    end
end

UINCSTDetail_MasterGroupItem.CleanAllPoint =
    function(self)
        -- function num : 0_5
        self.curPoint = 0
        self:RefreshPoint()
    end

UINCSTDetail_MasterGroupItem.OnDelete = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnDelete)(self)
end

return UINCSTDetail_MasterGroupItem


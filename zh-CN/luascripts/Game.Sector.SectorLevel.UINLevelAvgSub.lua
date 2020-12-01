-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLevelAvgSub = class("UINLevelAvgSub", UIBaseNode)
local base = UIBaseNode
UINLevelAvgSub.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.__OnClickRoot)
end

UINLevelAvgSub.InitLAvgSub = function(self, localPos, avgCfg, clickEvent)
  -- function num : 0_1 , upvalues : _ENV
  self.avgCfg = avgCfg
  self.clickEvent = clickEvent
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.transform).localPosition = localPos
  ;
  ((self.ui).tex_Name):SetIndex(0, tostring(avgCfg.number))
  ;
  ((self.ui).Img_PlotBg):SetIndex(0)
  self:RefreshLAvgSubPlayed()
end

UINLevelAvgSub.__OnClickRoot = function(self)
  -- function num : 0_2
  if self.clickEvent ~= nil then
    (self.clickEvent)(self)
  end
end

UINLevelAvgSub.RefreshLAvgSubPlayed = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local played = avgPlayCtrl:IsAvgPlayed((self.avgCfg).id)
  ;
  ((self.ui).Img_PlotBg):SetIndex(played and 1 or 0)
end

UINLevelAvgSub.GetLAvgSubCfg = function(self)
  -- function num : 0_4
  return self.avgCfg
end

UINLevelAvgSub.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINLevelAvgSub

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLevelAvgSub = class("UINLevelAvgSub", UIBaseNode)
local base = UIBaseNode
UINLevelAvgSub.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.__OnClickRoot)
end

UINLevelAvgSub.InitLAvgSub = function(self, localPos, avgCfg, clickEvent)
    -- function num : 0_1 , upvalues : _ENV
    self.avgCfg = avgCfg
    self.clickEvent = clickEvent -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'
    ;
    (self.transform).localPosition = localPos;
    ((self.ui).tex_Name):SetIndex(0, tostring(avgCfg.number));
    ((self.ui).Img_PlotBg):SetIndex(0)
    self:RefreshLAvgSubPlayed()
end

UINLevelAvgSub.__OnClickRoot = function(self)
    -- function num : 0_2
    if self.clickEvent ~= nil then (self.clickEvent)(self) end
end

UINLevelAvgSub.RefreshLAvgSubPlayed = function(self)
    -- function num : 0_3 , upvalues : _ENV
    local avgPlayCtrl =
        ControllerManager:GetController(ControllerTypeId.AvgPlay)
    local played = avgPlayCtrl:IsAvgPlayed((self.avgCfg).id);
    ((self.ui).Img_PlotBg):SetIndex(played and 1 or 0)
end

UINLevelAvgSub.GetLAvgSubCfg = function(self)
    -- function num : 0_4
    return self.avgCfg
end

UINLevelAvgSub.OnDelete = function(self)
    -- function num : 0_5 , upvalues : base
    (base.OnDelete)(self)
end

return UINLevelAvgSub


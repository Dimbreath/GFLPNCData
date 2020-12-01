-- params : ...
-- function num : 0 , upvalues : _ENV
local UIN3DFactoryRoomInfo = class("UIN3DFactoryRoomInfo", UIBaseNode)
local base = UIBaseNode
UIN3DFactoryRoomInfo.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.originalEnterSizeDelta = ((self.ui).img_EnterCount).sizeDelta
  self.updateRedDot = function(node)
    -- function num : 0_0_0 , upvalues : self
    if node:GetRedDotCount() <= 0 then
      ((self.ui).obj_RedDot):SetActive(self.index == nil or self.index ~= node.nodeId)
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end

end

UIN3DFactoryRoomInfo.InitRoomInfo = function(self, index)
  -- function num : 0_1 , upvalues : _ENV
  self.index = index
  self:RefreshEnergy()
  local ok, lineNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Factory, self.index)
  self.lineNode = lineNode
  ;
  ((self.ui).obj_RedDot):SetActive(not ok or lineNode:GetRedDotCount() > 0)
  RedDotController:AddListener(lineNode.nodePath, self.updateRedDot)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIN3DFactoryRoomInfo.RefreshEnergy = function(self, value, ceiling, speed)
  -- function num : 0_2 , upvalues : _ENV
  if value == nil then
    value = (self.factoryController):GetRoomEnegeyByIndex(self.index)
  end
  ;
  ((self.ui).tex_ProductCount):SetIndex(0, tostring(value), tostring(ceiling))
  ;
  ((self.ui).tex_Time):SetIndex(0, GetPreciseDecimalStr(speed * 3600, 1))
end

UIN3DFactoryRoomInfo.RefreshEnteredHeroNum = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local enterDic = (self.factoryController):GetRoomHeroList()
  local num = enterDic[self.index] and #enterDic[self.index] or 0
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_EnterCount).sizeDelta = (Vector2.New)(num * (self.originalEnterSizeDelta).x, (self.originalEnterSizeDelta).y)
end

UIN3DFactoryRoomInfo.OnDelete = function(self)
  -- function num : 0_4 , upvalues : _ENV, base
  if self.lineNode ~= nil then
    RedDotController:RemoveListener((self.lineNode).nodePath, self.updateRedDot)
    self.lineNode = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIN3DFactoryRoomInfo

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIN3DFactoryRoomInfo = class("UIN3DFactoryRoomInfo", UIBaseNode)
local base = UIBaseNode
UIN3DFactoryRoomInfo.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self.factoryController = ControllerManager:GetController(
                                 ControllerTypeId.Factory, false);
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.originalEnterSizeDelta = ((self.ui).img_EnterCount).sizeDelta
    self.updateRedDot = function(node)
        -- function num : 0_0_0 , upvalues : self
        if node:GetRedDotCount() <= 0 then
            ((self.ui).obj_RedDot):SetActive(
                self.index == nil or self.index ~= node.nodeId)
            -- DECOMPILER ERROR: 2 unprocessed JMP targets
        end
    end

end

UIN3DFactoryRoomInfo.InitRoomInfo = function(self, index)
    -- function num : 0_1 , upvalues : _ENV
    self.index = index
    self:RefreshEnergy()
    local ok, lineNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main,
                                                        RedDotStaticTypeId.Factory,
                                                        self.index)
    self.lineNode = lineNode;
    ((self.ui).obj_RedDot):SetActive(not ok or lineNode:GetRedDotCount() > 0)
    RedDotController:AddListener(lineNode.nodePath, self.updateRedDot)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIN3DFactoryRoomInfo.RefreshEnergy = function(self, value, ceiling, speed)
    -- function num : 0_2 , upvalues : _ENV
    if value == nil then
        value = (self.factoryController):GetRoomEnegeyByIndex(self.index)
    end
    ((self.ui).tex_ProductCount):SetIndex(0, tostring(value), tostring(ceiling));
    ((self.ui).tex_Time):SetIndex(0, GetPreciseDecimalStr(speed * 3600, 1))
end

UIN3DFactoryRoomInfo.RefreshEnteredHeroNum =
    function(self)
        -- function num : 0_3 , upvalues : _ENV
        local enterDic = (self.factoryController):GetRoomHeroList()
        local num = enterDic[self.index] and #enterDic[self.index] or 0 -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).img_EnterCount).sizeDelta =
            (Vector2.New)(num * (self.originalEnterSizeDelta).x,
                          (self.originalEnterSizeDelta).y)
    end

UIN3DFactoryRoomInfo.OnDelete = function(self)
    -- function num : 0_4 , upvalues : _ENV, base
    if self.lineNode ~= nil then
        RedDotController:RemoveListener((self.lineNode).nodePath,
                                        self.updateRedDot)
        self.lineNode = nil
    end
    (base.OnDelete)(self)
end

return UIN3DFactoryRoomInfo


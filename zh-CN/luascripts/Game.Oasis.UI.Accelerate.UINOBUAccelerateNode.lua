-- params : ...
-- function num : 0 , upvalues : _ENV
local UINOBUAccelerateNode = class("UINOBUAccelerateNode", UIBaseNode)
local base = UIBaseNode
local BuildingAccelerateController = require("Game.Oasis.UI.Accelerate.BuildingAccelerateController")
local cs_MessageCommon = CS.MessageCommon
local UINOBUAccelerateItem = require("Game.Oasis.UI.Accelerate.UINOBUAccelerateItem")
UINOBUAccelerateNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : BuildingAccelerateController, _ENV, UINOBUAccelerateItem
  self.BuildingAccelerateController = (BuildingAccelerateController.New)()
  ;
  (self.BuildingAccelerateController):OnInit()
  ;
  (self.BuildingAccelerateController):SetOnItemChangeCallback(BindCallback(self, self.UpdateTime))
  self.second = 0
  self.couldAcc = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.OnClickReturn)
  if (self.ui).btn_DoComplete ~= nil then
    (UIUtil.AddButtonListener)((self.ui).btn_DoComplete, self, self.OnClickConfirm)
  end
  self.accItemPool = (UIItemPool.New)(UINOBUAccelerateItem, (self.ui).materialItem)
end

UINOBUAccelerateNode.InitAccelerateNode = function(self, remainSecond, buildingId, returnFunc)
  -- function num : 0_1
  self.second = remainSecond
  self.buildingId = buildingId
  self.returnFunc = returnFunc
  self:UpdateTime(remainSecond)
end

UINOBUAccelerateNode.UpdateWithData = function(self, currentLevl, nextLevel)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).curLvlnum1).text = tostring(currentLevl // 10)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).curLvlnum2).text = tostring(currentLevl % 10)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).nxtLvlnum1).text = tostring(nextLevel // 10)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).nxtLvlnum2).text = tostring(nextLevel % 10)
end

UINOBUAccelerateNode.UpdateTime = function(self, second)
  -- function num : 0_3 , upvalues : _ENV
  if not second then
    self.second = self.second
    if self.second == nil then
      return 
    end
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_UpdateTime).text = TimestampToTime(self.second)
    local couldAcc, accItemList = (self.BuildingAccelerateController):IsCouldAcc(self.second)
    self.couldAcc = couldAcc
    self:UpdateAccItem(accItemList)
  end
end

UINOBUAccelerateNode.UpdateAccItem = function(self, accItemList)
  -- function num : 0_4 , upvalues : _ENV
  if self.UpdateAccItemCallback ~= nil then
    (self.UpdateAccItemCallback)(accItemList)
  end
  ;
  (self.accItemPool):HideAll()
  for index,data in pairs(accItemList) do
    if data.num ~= 0 then
      local item = (self.accItemPool):GetOne(true)
      item:InitItem(data.id, data.num, data.needNum)
    else
      do
        do
          local item = (self.accItemPool):GetOne(true)
          item:InitItem(data.id, 0)
          -- DECOMPILER ERROR at PC34: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC34: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC34: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

UINOBUAccelerateNode.InjectUpdateAccItemCallback = function(self, UpdateAccItemCallback)
  -- function num : 0_5
  self.UpdateAccItemCallback = UpdateAccItemCallback
end

UINOBUAccelerateNode.OnClickConfirm = function(self)
  -- function num : 0_6 , upvalues : cs_MessageCommon, _ENV
  if self.couldAcc then
    (self.BuildingAccelerateController):SendAccRequest(self.buildingId, function()
    -- function num : 0_6_0 , upvalues : self
    self.UpdateAccItemCallback = nil
    self:UpdateTime()
  end
)
  else
    ;
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.CanFitAccBuild))
    return 
  end
end

UINOBUAccelerateNode.OnClickReturn = function(self)
  -- function num : 0_7
  if self.returnFunc ~= nil then
    (self.returnFunc)()
  end
  self:Hide()
end

UINOBUAccelerateNode.OnHide = function(self)
  -- function num : 0_8
  if self.returnFunc ~= nil then
    (self.returnFunc)()
  end
end

UINOBUAccelerateNode.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  if self.accItemPool ~= nil then
    (self.accItemPool):DeleteAll()
    self.accItemPool = nil
  end
  ;
  (self.BuildingAccelerateController):Delete()
  ;
  (base.OnDelete)(self)
end

return UINOBUAccelerateNode


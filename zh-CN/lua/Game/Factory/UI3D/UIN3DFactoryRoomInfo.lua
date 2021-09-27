local UIN3DFactoryRoomInfo = class("UIN3DFactoryRoomInfo", UIBaseNode)
local base = UIBaseNode
local eRoomType = (require("Game.Factory.FactoryEnum")).eRoomType
local FactoryHelper = require("Game.Factory.FactoryHelper")
UIN3DFactoryRoomInfo.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_product, self, self.OnClickProductBtn)
end

UIN3DFactoryRoomInfo.InitRoomInfo = function(self, index, roomEntityType, unlockDes)
  -- function num : 0_1 , upvalues : eRoomType, _ENV
  self.index = index
  if roomEntityType == eRoomType.locked then
    ((self.ui).obj_name):SetActive(false)
    ;
    ((self.ui).obj_unopen):SetActive(false)
    ;
    ((self.ui).obj_lock):SetActive(true)
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_RoomLookName).text = (LanguageUtil.GetLocaleText)(((ConfigData.factory)[self.index]).name)
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_Condition).text = unlockDes
    self:SetRoomSeleced(true)
  else
    if roomEntityType == eRoomType.notOpen then
      ((self.ui).obj_name):SetActive(false)
      ;
      ((self.ui).obj_unopen):SetActive(true)
      ;
      ((self.ui).obj_lock):SetActive(false)
      self:SetRoomSeleced(true)
    else
      ;
      ((self.ui).obj_name):SetActive(true)
      ;
      ((self.ui).obj_unopen):SetActive(false)
      ;
      ((self.ui).obj_lock):SetActive(false)
      -- DECOMPILER ERROR at PC84: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tex_RoomName).text = (LanguageUtil.GetLocaleText)(((ConfigData.factory)[self.index]).name)
      self:SetRoomSeleced(false)
    end
  end
end

UIN3DFactoryRoomInfo.RefreshEnergy = function(self, value, ceiling, speed)
  -- function num : 0_2
end

UIN3DFactoryRoomInfo.RefreshEnteredHeroNum = function(self)
  -- function num : 0_3
end

UIN3DFactoryRoomInfo.RefreshProcessLine = function(self, ProcessingOrders)
  -- function num : 0_4 , upvalues : _ENV, FactoryHelper
  local processingDatas = ProcessingOrders[self.index]
  local notHaveProcessLine = processingDatas == nil or (table.count)(processingDatas) == 0
  ;
  ((self.ui).obj_product):SetActive(not notHaveProcessLine)
  if notHaveProcessLine then
    return 
  end
  for UID,processingData in pairs(processingDatas) do
    local Icon = processingData:GetOutputItemIconName()
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R10 in 'UnsetPending'

    if Icon ~= nil then
      ((self.ui).img_ItemPic).sprite = CRH:GetSprite(Icon)
    end
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R10 in 'UnsetPending'

    ;
    ((self.ui).tex_ProcessCount).text = tostring(processingData:GetOutputItemProduceNum())
    local isFinish = processingData:GetIsFinish()
    if isFinish then
      ((self.ui).tex_ProductState):SetIndex(0)
    else
      ((self.ui).tex_ProductState):SetIndex(1)
    end
    ;
    ((self.ui).obj_isComplete):SetActive(isFinish)
    ;
    ((self.ui).obj_inProduct):SetActive(not isFinish)
    if not isFinish then
      local processRate = processingData:GetProcessRate()
      -- DECOMPILER ERROR at PC73: Confused about usage of register: R12 in 'UnsetPending'

      ;
      ((self.ui).img_ProcessBar).fillAmount = processRate
      do
        do
          local leftTime = processingData:GetLeftProcessTime()
          -- DECOMPILER ERROR at PC81: Confused about usage of register: R13 in 'UnsetPending'

          ;
          ((self.ui).tex_ProcessTime).text = (FactoryHelper.ConvertTime2DisplayMode)(leftTime)
          -- DECOMPILER ERROR at PC86: Confused about usage of register: R13 in 'UnsetPending'

          ;
          ((self.ui).Img_ProductButtom).color = (self.ui).color_NotFinish
          do break end
          -- DECOMPILER ERROR at PC92: Confused about usage of register: R11 in 'UnsetPending'

          ;
          ((self.ui).Img_ProductButtom).color = (self.ui).color_Finish
          do break end
          -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

UIN3DFactoryRoomInfo.OnClickProductBtn = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local processingDatas = ((self.factoryController).ProcessingOrders)[self.index]
  for UID,processingData in pairs(processingDatas) do
    if processingData:GetIsFinish() then
      (self.factoryController):PickOrderReward(processingData)
      return 
    end
    do break end
  end
  do
    UIManager:ShowWindowAsync(UIWindowTypeID.FactoryProduceLine, function(win)
    -- function num : 0_5_0
    if win ~= nil then
      win:InitAllLines()
    end
  end
)
  end
end

UIN3DFactoryRoomInfo.SetRoomStateImage = function(self, roomEntityType)
  -- function num : 0_6 , upvalues : eRoomType
  if roomEntityType == eRoomType.locked then
    ((self.ui).img_RoomState):SetIndex(1)
  else
    if roomEntityType == eRoomType.notOpen then
      ((self.ui).img_RoomState):SetIndex(2)
    else
      ;
      ((self.ui).img_RoomState):SetIndex(0)
    end
  end
end

UIN3DFactoryRoomInfo.SetRoomSeleced = function(self, bool)
  -- function num : 0_7
  (((self.ui).img_RoomState).gameObject):SetActive(bool)
end

UIN3DFactoryRoomInfo.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV, base
  if self.lineNode ~= nil then
    RedDotController:RemoveListener((self.lineNode).nodePath, self.updateRedDot)
    self.lineNode = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIN3DFactoryRoomInfo


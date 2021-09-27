local UINHomeBannerLoopList = class("UINHomeBannerLoopList", UIBaseNode)
local base = UIBaseNode
local CS_EventTriggerListener = CS.EventTriggerListener
local UINHomeBannerPicItem = require("Game.Home.Banner.UINHomeBannerPicItem")
UINHomeBannerLoopList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHomeBannerPicItem, CS_EventTriggerListener
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.__isAutoPlay = true
  self.__LoopListNum = 0
  self.__curIndex = nil
  self.couldRoll2Next = true
  self.interval = 3
  self.picItems = {befor = (UINHomeBannerPicItem.New)(), cur = (UINHomeBannerPicItem.New)(), next = (UINHomeBannerPicItem.New)()}
  ;
  ((self.picItems).befor):Init(((self.ui).advItemArray)[1])
  ;
  ((self.picItems).cur):Init(((self.ui).advItemArray)[2])
  ;
  ((self.picItems).next):Init(((self.ui).advItemArray)[3])
  local eventTrigger = (CS_EventTriggerListener.Get)(self.gameObject)
  eventTrigger:onBeginDrag("+", BindCallback(self, self.__OnBeginDrag))
  eventTrigger:onDrag("+", BindCallback(self, self.__OnDrag))
  eventTrigger:onEndDrag("+", BindCallback(self, self.__OnEndDrag))
  ;
  (((self.ui).scrollRect).onValueChanged):AddListener(BindCallback(self, self.__OnValueChanged))
  self.m_OnLateUpdate = BindCallback(self, self.OnLateUpdate)
  UpdateManager:AddLateUpdate(self.m_OnLateUpdate)
end

UINHomeBannerLoopList.SetLoopBannerDataList = function(self, bannerDataList, initIndex, onPageIndexChange)
  -- function num : 0_1 , upvalues : _ENV
  self.bannerDataList = bannerDataList
  self.onPageIndexChange = onPageIndexChange
  self.__LoopListNum = #bannerDataList
  if #bannerDataList < initIndex then
    initIndex = 1
  end
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

  if #bannerDataList == 1 then
    ((self.ui).scrollRect).horizontal = false
    self.__isAutoPlay = false
  else
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).scrollRect).horizontal = true
    self.__isAutoPlay = true
  end
  self.__curIndex = initIndex
  local beforIndex = initIndex - 1
  if beforIndex <= 0 then
    beforIndex = self.__LoopListNum
  end
  local nextIndex = 1 % self.__LoopListNum + 1
  ;
  ((self.picItems).befor):InitHomeBannerPicItem(bannerDataList[beforIndex])
  ;
  ((self.picItems).cur):InitHomeBannerPicItem(bannerDataList[initIndex])
  ;
  ((self.picItems).next):InitHomeBannerPicItem(bannerDataList[nextIndex])
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).horizontalNormalizedPosition = 0.5
  self:Roll2Pos(0.5)
  self:__OnPageIndexChange()
  self.autoStartTime = Time.time
end

UINHomeBannerLoopList.__OnBeginDrag = function(self, go, eventData)
  -- function num : 0_2
  if self.__LoopListNum <= 1 then
    return 
  end
  self.__IsDraging = true
  self.__beginEventData = eventData
  self.__needRoll = false
  self.rollOverCallback = false
  self.couldRoll2Next = true
end

UINHomeBannerLoopList.__OnDrag = function(self, go, eventData)
  -- function num : 0_3
  self.__lastPointX = (eventData.position).x
end

UINHomeBannerLoopList.__OnEndDrag = function(self, go, eventData)
  -- function num : 0_4 , upvalues : _ENV
  if self.__LoopListNum <= 1 then
    return 
  end
  self.autoStartTime = Time.time
  self.__IsDraging = false
  if not self.__lastPointX then
    local lastPointChange = (eventData.position).x - (eventData.position).x
    self.__lastPointX = nil
    if self.__notSwitch and 0.1 / Time.deltaTime < (math.abs)(lastPointChange) then
      if lastPointChange > 0 then
        self:Roll2Before()
        -- DECOMPILER ERROR at PC39: Confused about usage of register: R4 in 'UnsetPending'

        ;
        ((self.ui).scrollRect).horizontalNormalizedPosition = ((self.ui).scrollRect).horizontalNormalizedPosition + 0.5
      else
        self:Roll2Next()
        -- DECOMPILER ERROR at PC49: Confused about usage of register: R4 in 'UnsetPending'

        ;
        ((self.ui).scrollRect).horizontalNormalizedPosition = ((self.ui).scrollRect).horizontalNormalizedPosition - 0.5
      end
      self.couldRoll2Next = false
    end
    self:Roll2Pos(0.5)
  end
end

UINHomeBannerLoopList.__OnValueChanged = function(self, pos)
  -- function num : 0_5
  if self.couldRoll2Next then
    local hnp = ((self.ui).scrollRect).horizontalNormalizedPosition
    if hnp >= 0.8 then
      self:Roll2Next()
      -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.ui).scrollRect).horizontalNormalizedPosition = hnp - 0.5
      ;
      ((self.ui).scrollRect):OnBeginDrag(self.__beginEventData)
      self.__notSwitch = false
    else
      if hnp <= 0.2 then
        self:Roll2Before()
        -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((self.ui).scrollRect).horizontalNormalizedPosition = hnp + 0.5
        ;
        ((self.ui).scrollRect):OnBeginDrag(self.__beginEventData)
        self.__notSwitch = false
      else
        self.__notSwitch = true
      end
    end
  end
end

UINHomeBannerLoopList.OnLateUpdate = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.__needRoll then
    if (math.abs)(((self.ui).scrollRect).horizontalNormalizedPosition - self.__scrollNPos) < 0.01 then
      self.__needRoll = false
      -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((self.ui).scrollRect).horizontalNormalizedPosition = self.__scrollNPos
      if self.rollOverCallback ~= nil then
        (self.rollOverCallback)()
        self.rollOverCallback = nil
      end
      return 
    end
    self.passedTime = self.passedTime + Time.deltaTime
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).scrollRect).horizontalNormalizedPosition = (Mathf.Lerp)(self.__currNPos, self.__scrollNPos, self.passedTime / self.totalCostTime)
  end
  if self.__isAutoPlay then
    self:CheckTime(Time.time)
  end
end

UINHomeBannerLoopList.Roll2Pos = function(self, pos, callback)
  -- function num : 0_7 , upvalues : _ENV
  self.rollOverCallback = callback
  self.__scrollNPos = pos
  self.__needRoll = true
  self.__currNPos = ((self.ui).scrollRect).horizontalNormalizedPosition
  self.totalCostTime = (math.abs)(self.__scrollNPos - self.__currNPos) / 3
  self.passedTime = 0
end

UINHomeBannerLoopList.Roll2Next = function(self)
  -- function num : 0_8
  local beforIndex = self.__curIndex
  local curIndex = self.__curIndex % self.__LoopListNum + 1
  local nextIndex = curIndex % self.__LoopListNum + 1
  ;
  (((self.picItems).befor).transform):SetAsLastSibling()
  ;
  ((self.picItems).befor):InitHomeBannerPicItem((self.bannerDataList)[nextIndex])
  local oldCur = (self.picItems).cur
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.picItems).cur = (self.picItems).next
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.picItems).next = (self.picItems).befor
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.picItems).befor = oldCur
  self.__curIndex = curIndex
  self:__OnPageIndexChange()
end

UINHomeBannerLoopList.Roll2Before = function(self)
  -- function num : 0_9
  local nextIndex = self.__curIndex
  local curIndex = self.__curIndex - 1
  if curIndex <= 0 then
    curIndex = self.__LoopListNum
  end
  local beforIndex = curIndex - 1
  if beforIndex <= 0 then
    beforIndex = self.__LoopListNum
  end
  ;
  (((self.picItems).next).transform):SetAsFirstSibling()
  ;
  ((self.picItems).next):InitHomeBannerPicItem((self.bannerDataList)[beforIndex])
  local oldCur = (self.picItems).cur
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.picItems).cur = (self.picItems).befor
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.picItems).befor = (self.picItems).next
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.picItems).next = oldCur
  self.__curIndex = curIndex
  self:__OnPageIndexChange()
end

UINHomeBannerLoopList.__OnPageIndexChange = function(self)
  -- function num : 0_10
  if self.onPageIndexChange ~= nil then
    (self.onPageIndexChange)(self.__curIndex)
  end
end

UINHomeBannerLoopList.SetInterval = function(self, interval)
  -- function num : 0_11
  self.interval = interval
end

UINHomeBannerLoopList.CheckTime = function(self, time)
  -- function num : 0_12
  if self.__IsDraging or not self.autoStartTime then
    return 
  end
  if self.interval <= time - self.autoStartTime then
    self:AutoPlay2Next()
    self.autoStartTime = time
  end
end

UINHomeBannerLoopList.AutoPlay2Next = function(self)
  -- function num : 0_13
  self.couldRoll2Next = false
  self:Roll2Pos(1, function()
    -- function num : 0_13_0 , upvalues : self
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    ((self.ui).scrollRect).horizontalNormalizedPosition = ((self.ui).scrollRect).horizontalNormalizedPosition - 0.5
    self:Roll2Next()
    self:Roll2Pos(0.5, function()
      -- function num : 0_13_0_0 , upvalues : self
      self.couldRoll2Next = true
    end
)
  end
)
end

UINHomeBannerLoopList.OnHide = function(self)
  -- function num : 0_14 , upvalues : CS_EventTriggerListener, _ENV
  local eventTrigger = (CS_EventTriggerListener.Get)(self.gameObject)
  eventTrigger:onBeginDrag("-", BindCallback(self, self.__OnBeginDrag))
  eventTrigger:onEndDrag("-", BindCallback(self, self.__OnEndDrag))
  UpdateManager:RemoveLateUpdate(self.m_OnLateUpdate)
end

return UINHomeBannerLoopList


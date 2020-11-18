-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpBuff = class("UIEpBuff", UIBaseWindow)
local base = UIBaseWindow
local UIEpBuffDetailItem = require("Game.Exploration.UI.EpBuff.UIEpBuffDetailItem")
local UIEpBuffItem = require("Game.Exploration.UI.EpBuff.UIEpBuffItem")
UIEpBuff.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIEpBuffItem, UIEpBuffDetailItem
  self.__fadeTween = UIManager:PlayDoFade((self.ui).canvasGroup, 0, 1, 0.5)
  ;
  ((self.ui).buffItem):SetActive(false)
  ;
  ((self.ui).buffDetailItem):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).buffNode, self, self.OnBuffNodeClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).uI_BuffDetail, self, self.OnBuffDetailPanelClicked)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Unfold, self, self.OnUnfoldClick)
  self.poolBuffItem = (UIItemPool.New)(UIEpBuffItem, (self.ui).buffItem)
  self.poolBuffDetailItem = (UIItemPool.New)(UIEpBuffDetailItem, (self.ui).buffDetailItem)
  self.__onEpBuffListChange = BindCallback(self, self.OnEpBuffListChange)
  MsgCenter:AddListener(eMsgEventId.OnEpBuffListChange, self.__onEpBuffListChange)
  self.contSizeX = ((((self.ui).buffContent).transform).sizeDelta).x
  self.contSizeY = ((((self.ui).buffContent).transform).sizeDelta).y
  self.buffItemLen = (((self.ui).buffContent).cellSize).x
end

UIEpBuff.InitEpBuffList = function(self, dynPlayer)
  -- function num : 0_1
  local buffList = dynPlayer:GetEpBuffList()
  self:OnEpBuffListChange(buffList)
end

UIEpBuff.Show = function(self)
  -- function num : 0_2 , upvalues : base, _ENV
  (base.Show)(self)
  if self.__fadeTween ~= nil then
    (self.__fadeTween):Kill()
  end
  self.__fadeTween = UIManager:PlayDoFade((self.ui).canvasGroup, 0, 1, 0.25)
end

UIEpBuff.Hide = function(self)
  -- function num : 0_3 , upvalues : _ENV, base
  if self.__fadeTween ~= nil then
    (self.__fadeTween):Kill()
  end
  self.__fadeTween = UIManager:PlayDoFade((self.ui).canvasGroup, 1, 0, 0.25, BindCallback(self, base.Hide))
end

UIEpBuff.OnEpBuffListChange = function(self, buffList)
  -- function num : 0_4 , upvalues : _ENV
  self.buffList = buffList
  self:Show()
  ;
  (self.poolBuffItem):HideAll()
  for k,epBuff in pairs(buffList) do
    local buffItem = (self.poolBuffItem):GetOne()
    buffItem:InitEpBuffItem(epBuff)
  end
  self:__PagesOfBuffContent(buffList)
end

UIEpBuff.Show = function(self)
  -- function num : 0_5 , upvalues : base
  if self.buffList == nil or #self.buffList == 0 then
    self:Hide()
    return 
  end
  ;
  (base.Show)(self)
end

UIEpBuff.OnBuffNodeClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.buffList == nil or #self.buffList == 0 then
    return 
  end
  ;
  ((self.ui).BuffDetailNode):SetActive(true)
  ;
  (self.poolBuffDetailItem):HideAll()
  for k,epBuff in pairs(self.buffList) do
    local buffDetailItem = (self.poolBuffDetailItem):GetOne()
    buffDetailItem:InitEpBuffDetail(epBuff)
  end
  self:OnUpdateSecond()
  self.__onUpdateSecondTimer = TimerManager:GetTimer(1, self.OnUpdateSecond, self, false, false, true)
  ;
  (self.__onUpdateSecondTimer):Start()
end

UIEpBuff.OnUpdateSecond = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local time = PlayerDataCenter.timestamp
  for k,buffDetailItem in pairs((self.poolBuffDetailItem).listItem) do
    buffDetailItem:RefershBuffDetailTime(time)
  end
end

UIEpBuff.OnBuffDetailPanelClicked = function(self)
  -- function num : 0_8
  ((self.ui).BuffDetailNode):SetActive(false)
  if self.__onUpdateSecondTimer ~= nil then
    (self.__onUpdateSecondTimer):Stop()
    self.__onUpdateSecondTimer = nil
  end
end

UIEpBuff.__PagesOfBuffContent = function(self, buffList)
  -- function num : 0_9
  self.page = 1
  local buffCount = #buffList
  if self.contSizeX < self.buffItemLen * buffCount then
    self.page = self.page + 1
  end
  ;
  (((self.ui).tog_Unfold).gameObject):SetActive(self.page > 1)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIEpBuff.OnUnfoldClick = function(self, value)
  -- function num : 0_10 , upvalues : _ENV
  local newSizeY = 0
  local z = 0
  if value then
    newSizeY = self.contSizeY * self.page
    z = 180
  else
    newSizeY = self.contSizeY
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (((self.ui).buffContent).transform).sizeDelta = (Vector2.New)(self.contSizeX, newSizeY)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (((self.ui).obj_togIcon).transform).rotation = (Vector3.New)(0, 0, z)
end

UIEpBuff.OnDelete = function(self)
  -- function num : 0_11 , upvalues : _ENV, base
  if self.__onUpdateSecondTimer ~= nil then
    (self.__onUpdateSecondTimer):Stop()
    self.__onUpdateSecondTimer = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.OnEpBuffListChange, self.__onEpBuffListChange)
  ;
  (base.OnDelete)(self)
end

return UIEpBuff


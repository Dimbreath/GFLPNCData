-- params : ...
-- function num : 0 , upvalues : _ENV
local UIChipDisplace = class("UIChipDisplace", UIBaseWindow)
local base = UIBaseWindow
local UINChipDisplaceItem = require("Game.Exploration.UI.ChipDisplace.UINChipDisplaceItem")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINChipDetailPanel")
local cs_tweening = (CS.DG).Tweening
UIChipDisplace.OnInit = function(self)
  -- function num : 0_0 , upvalues : UINChipDetailPanel, _ENV
  self.chipList = {}
  self.chipItemDic = {}
  self.selectIndex = 1
  self.chipDetail = (UINChipDetailPanel.New)()
  ;
  (self.chipDetail):Init((self.ui).uINChipItemDetail)
  self.__OnClickChipItem = BindCallback(self, self.OnClickChipItem)
  self.__OnClickDetail = BindCallback(self, self.OnClickDetail)
  self.resloader = ((CS.ResLoader).Create)()
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Skip, self, self.OnClickSkip)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_AllDisplace, self, self.OnClickAllDisplace)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Map, self, self.OnClickMap)
  -- DECOMPILER ERROR at PC55: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).chipList).onInstantiateItem = BindCallback(self, self.OnInstantiateItem)
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).chipList).onChangeItem = BindCallback(self, self.OnChangeItem)
end

UIChipDisplace.InitChipDisplace = function(self, remainCount, isAllDisplace, epCtr)
  -- function num : 0_1
  self.epCtr = epCtr
  self.remainCount = remainCount
  self.isAllDisplace = isAllDisplace
  ;
  (((self.ui).btn_AllDisplace).gameObject):SetActive(self.isAllDisplace)
  ;
  ((self.ui).maxRefresh):SetActive(not self.isAllDisplace)
  ;
  ((self.ui).tips):SetActive(self.isAllDisplace)
  ;
  ((self.ui).frameNode):SetActive(true)
  self:RefreshUI()
end

UIChipDisplace.RefreshUI = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.chipList = {}
  self.selectIndex = 1
  local chipDic = ((self.epCtr).dynPlayer):GetNormalChipDic()
  for k,v in pairs(chipDic) do
    (table.insert)(self.chipList, v)
  end
  self.selectIndex = 1
  ;
  ((self.ui).chipList):ClearCells()
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).chipList).totalCount = #self.chipList
  ;
  ((self.ui).chipList):RefillCells()
  ;
  ((self.ui).tex_maxRefresh):SetIndex(0, tostring(self.remainCount))
  self:RefreshDetail()
  self:RefreshBtnState()
end

UIChipDisplace.RefreshDetail = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local selectData = (self.chipList)[self.selectIndex]
  if self.isAllDisplace then
    for k,v in pairs(self.chipItemDic) do
      v:SetSelectState(true)
    end
    ;
    (self.chipDetail):OnSelectChipChanged(false)
  else
    for k,v in pairs(self.chipItemDic) do
      v:SetSelectState(v.chipData == selectData)
    end
    ;
    (self.chipDetail):OnSelectChipChanged(self.remainCount > 0)
  end
  ;
  ((self.ui).cantDisplace):SetActive(self.remainCount == 0)
  if selectData ~= nil then
    (self.chipDetail):Show()
    ;
    (self.chipDetail):InitChipDetailPanel(nil, selectData, (self.epCtr).dynPlayer, self.resloader, self.__OnClickDetail, true, eChipDetailPowerType.None, true)
  else
    (self.chipDetail):Hide()
  end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

UIChipDisplace.UpdateDiff = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self.remainCount = self.remainCount - 1
  ;
  ((self.ui).tex_maxRefresh):SetIndex(0, tostring(self.remainCount))
  if self.isAllDisplace then
    self:RefreshUI()
    local localItemList = {}
    for i,v1 in ipairs(self.chipList) do
      for k,v2 in pairs(self.chipItemDic) do
        if v2.chipData == v1 then
          (table.insert)(localItemList, v2)
        end
      end
    end
    self:PlayAllDisplaceTween(localItemList)
    return 
  end
  do
    local remData = (self.chipList)[self.selectIndex]
    local addData = nil
    local allData = ((self.epCtr).dynPlayer):GetNormalChipDic()
    for k,v1 in pairs(allData) do
      for i,v2 in ipairs(self.chipList) do
      end
      if (v1.chipCfg).id ~= (v2.chipCfg).id then
        addData = 
        break
      end
    end
    do
      -- DECOMPILER ERROR at PC73: Confused about usage of register: R4 in 'UnsetPending'

      if addData ~= nil then
        (self.chipList)[self.selectIndex] = addData
        for k,v in pairs(self.chipItemDic) do
          if v.chipData == remData then
            v:InitItem(addData, self.__OnClickChipItem)
            self:RefreshDetail()
            self:PlayAllDisplaceTween({R12_PC90})
            break
          end
        end
      end
      do
        self:RefreshBtnState()
      end
    end
  end
end

UIChipDisplace.RefreshBtnState = function(self)
  -- function num : 0_5
  local inRoom = ((self.ui).frameNode).activeInHierarchy
  ;
  ((self.ui).img_btnBg):SetIndex(inRoom and 0 or 1)
  if self.remainCount <= 0 or not (self.ui).color_normal then
    local color = (self.ui).color_gray
  end
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_AllDisplace).color = color
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).text_AllDisplace).color = color
end

UIChipDisplace.OnClickMap = function(self)
  -- function num : 0_6
  ((self.ui).frameNode):SetActive(not ((self.ui).frameNode).activeInHierarchy)
  self:RefreshBtnState()
end

UIChipDisplace.OnClickSkip = function(self)
  -- function num : 0_7
  (self.epCtr):SendExitChipReplace()
end

UIChipDisplace.OnClickAllDisplace = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.remainCount > 0 then
    local showingWindow = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    showingWindow:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(TipContent.ChipReplaceAll), function()
    -- function num : 0_8_0 , upvalues : self
    (self.epCtr):SendChipReplace(0)
  end
, nil)
  else
    do
      ;
      ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(TipContent.ChipReplaceNotCount))
    end
  end
end

UIChipDisplace.OnClickDetail = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local selectData = (self.chipList)[self.selectIndex]
  if self.remainCount > 0 then
    (self.epCtr):SendChipReplace((selectData.chipCfg).id)
  else
    ;
    ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(TipContent.ChipReplaceNotCount))
  end
end

UIChipDisplace.OnInstantiateItem = function(self, go)
  -- function num : 0_10 , upvalues : UINChipDisplaceItem
  local item = (UINChipDisplaceItem.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.chipItemDic)[go] = item
end

UIChipDisplace.OnChangeItem = function(self, go, index)
  -- function num : 0_11
  ((self.chipItemDic)[go]):InitItem((self.chipList)[index + 1], self.__OnClickChipItem)
  ;
  ((self.chipItemDic)[go]):SetSelectState(index + 1 == self.selectIndex)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIChipDisplace.OnClickChipItem = function(self, chipData)
  -- function num : 0_12
  for i = 1, #self.chipList do
    if (self.chipList)[i] == chipData then
      if self.selectIndex ~= i then
        self.selectIndex = i
        self:RefreshDetail()
      end
      return 
    end
  end
end

UIChipDisplace.PlayAllDisplaceTween = function(self, itemList)
  -- function num : 0_13 , upvalues : cs_tweening, _ENV
  local duration = 0.15
  if self.pageSequence ~= nil then
    (self.pageSequence):Kill(true)
  end
  self.pageSequence = ((cs_tweening.DOTween).Sequence)()
  for index,childData in ipairs(itemList) do
    local num = 0
    if index < 5 then
      num = num + 1
    else
      num = 1
    end
    local over = num % 5
    ;
    (self.pageSequence):Join((((((childData.ui).tran):DOLocalMoveY(20, duration)):SetLoops(2, (cs_tweening.LoopType).Yoyo)):SetRelative(true)):SetDelay(index * 0.01))
    ;
    (self.pageSequence):Join(((((childData.ui).canvasGroup):DOFade(0.4, duration)):SetLoops(2, (cs_tweening.LoopType).Yoyo)):SetDelay(over * 0.01))
  end
  ;
  (self.pageSequence):SetEase((cs_tweening.Ease).Linear)
end

UIChipDisplace.OnDelete = function(self)
  -- function num : 0_14 , upvalues : base
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  if self.pageSequence ~= nil then
    (self.pageSequence):Kill(true)
  end
  ;
  (base.OnDelete)(self)
end

return UIChipDisplace


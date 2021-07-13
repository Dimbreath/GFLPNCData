-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthRefactorSuccess = class("UIAthRefactorSuccess", UIBaseNode)
local base = UIBaseNode
local UINAthDetailItem = require("Game.Arithmetic.AthDetail.UINAthDetailItem")
local cs_MessageCommon = CS.MessageCommon
local cs_tweening = (CS.DG).Tweening
local nodeHightList = {[1] = 120, [2] = 763.4835, [3] = 197.87}
UIAthRefactorSuccess.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINAthDetailItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Save, self, self._OnClickSave)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Cancle, self, self._OnClickCancel)
  self.athDetailOld = (UINAthDetailItem.New)()
  ;
  (self.athDetailOld):Init((self.ui).athDetailOld)
  self.athDetailNew = (UINAthDetailItem.New)()
  ;
  (self.athDetailNew):Init((self.ui).athDetailNew)
  self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
end

UIAthRefactorSuccess.InitAthRefactorSuccess = function(self, athData, heroData)
  -- function num : 0_1 , upvalues : _ENV
  self:__InitTheTween()
  ;
  ((self.ui).fXP_StarUpSuccessbj):Play()
  local reconsitutionData = (PlayerDataCenter.allAthData).athReconsitutionData
  ;
  (self.athDetailOld):InitAthDetailItem(nil, athData, heroData, nil, nil, true)
  ;
  (self.athDetailNew):InitAthDetailItem(nil, athData, heroData, nil, nil, true)
  self.hasHighQuality = false
  local newAffixList = {}
  for k,affixElem in ipairs(athData.affixList) do
    if affixElem.lock then
      (table.insert)(newAffixList, affixElem)
    else
      local elem = (reconsitutionData.reco)[k - 1]
      local newAffixElem = DeepCopy(affixElem)
      newAffixElem.id = elem.id
      newAffixElem.quality = elem.quality
      newAffixElem.value = (PlayerDataCenter.allAthData):GenAthAffixValue(newAffixElem.id, newAffixElem.quality, newAffixElem.level)
      if affixElem.quality < newAffixElem.quality then
        self.hasHighQuality = true
      end
      ;
      (table.insert)(newAffixList, newAffixElem)
    end
  end
  ;
  (self.athDetailNew):RefreshAthDetailItemSubAttr(newAffixList)
end

UIAthRefactorSuccess._OnClickSave = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.__OnSaveComplete == nil then
    self.__OnSaveComplete = BindCallback(self, self._OnSaveComplete)
  end
  ;
  (self.athNetwork):CS_ATH_ReconsitutionSave(self.__OnSaveComplete)
end

UIAthRefactorSuccess._OnSaveComplete = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.AthRefactor)
  if window ~= nil then
    window:ResetAthRefactor()
  end
  self:Hide()
end

UIAthRefactorSuccess._OnClickCancel = function(self)
  -- function num : 0_4 , upvalues : _ENV, cs_MessageCommon
  if self.__OnCancelComplete == nil then
    self.__OnCancelComplete = BindCallback(self, self._OnCancelComplete)
  end
  local sendFunc = function()
    -- function num : 0_4_0 , upvalues : self
    (self.athNetwork):CS_ATH_ReconsitutionDrop(self.__OnCancelComplete)
  end

  if self.hasHighQuality then
    (cs_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(TipContent.ATH_ConfirmCancelRefactor), sendFunc, nil)
  else
    sendFunc()
  end
end

UIAthRefactorSuccess._OnCancelComplete = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.AthRefactor)
  if window ~= nil then
    window:ResetAthRefactor()
  end
  self:Hide()
end

UIAthRefactorSuccess.__InitTheTween = function(self)
  -- function num : 0_6 , upvalues : cs_tweening, _ENV, nodeHightList
  ((self.ui).obj_isNew):SetActive(false)
  if self.tweenSeq ~= nil then
    (self.tweenSeq):Kill()
  end
  self.tweenSeq = ((cs_tweening.DOTween).Sequence)()
  local count = 0
  local delay = 0
  for index,Hight in ipairs(nodeHightList) do
    count = count + 1
    delay = count == 2 and 0.35 or 0
    self:__SetNodeShowTween(index, Hight, delay)
  end
end

UIAthRefactorSuccess.__SetNodeShowTween = function(self, index, height, SetDelay)
  -- function num : 0_7 , upvalues : _ENV, cs_tweening
  local delay = SetDelay or 0
  local fade = ((self.ui).fadeList)[index]
  local layout = ((self.ui).layoutList)[index]
  layout.minHeight = 0
  ;
  (self.tweenSeq):Append((layout:DOMinSize((Vector2.New)(0, height), 0.3, true)):SetDelay(delay))
  if index == 1 then
    (self.tweenSeq):Join((fade:DOFade(0, 0.1)):SetLoops(6, (cs_tweening.LoopType).Yoyo))
  else
    if index == 2 then
      fade.alpha = 0
      ;
      (self.tweenSeq):Join(fade:DOFade(1, 0.3))
      self:_SetAthItemTween((self.ui).athDetailOld, 300)
      self:_SetAthItemTween((self.ui).athDetailNew, 300)
    else
      fade.alpha = 0
      ;
      (self.tweenSeq):Join(fade:DOFade(1, 0.3))
      self:_SetAthItemTween(((self.ui).btn_Cancle).gameObject, 100)
      self:_SetAthItemTween(((self.ui).btn_Save).gameObject, 100)
    end
  end
  ;
  (self.tweenSeq):OnComplete(function()
    -- function num : 0_7_0 , upvalues : self
    ((self.ui).obj_isNew):SetActive(true)
  end
)
end

UIAthRefactorSuccess._SetAthItemTween = function(self, itemObj, office)
  -- function num : 0_8
  local transform = itemObj.transform
  ;
  (self.tweenSeq):Join((transform:DOAnchorPosY((transform.anchoredPosition).y - office, 0.3)):From())
end

UIAthRefactorSuccess.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  (self.athDetailOld):Delete()
  ;
  (self.athDetailNew):Delete()
  if self.tweenSeq ~= nil then
    (self.tweenSeq):Kill()
    self.tweenSeq = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIAthRefactorSuccess


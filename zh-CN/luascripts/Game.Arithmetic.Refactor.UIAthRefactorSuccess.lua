-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthRefactorSuccess = class("UIAthRefactorSuccess", UIBaseNode)
local base = UIBaseNode
local UINAthDetailItem = require("Game.Arithmetic.AthDetail.UINAthDetailItem")
local cs_MessageCommon = CS.MessageCommon
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

UIAthRefactorSuccess.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (self.athDetailOld):Delete()
  ;
  (self.athDetailNew):Delete()
  ;
  (base.OnDelete)(self)
end

return UIAthRefactorSuccess


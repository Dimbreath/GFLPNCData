local UINNavSpecialUIBase = require("Game.TopStatus.Navigation.SpecialUI.UINNavSpecialUIBase")
local UINNavSpeciaOasisCollectReward = class("UINNavSpeciaOasisCollectReward", UINNavSpecialUIBase)
local base = UINNavSpecialUIBase
local UINNavSpeciaOasisCollectRewardItem = require("Game.TopStatus.Navigation.SpecialUI.UINNavSpeciaOasisCollectRewardItem")
local cs_DoTween = ((CS.DG).Tweening).DOTween
local cs_MessageCommon = CS.MessageCommon
UINNavSpeciaOasisCollectReward.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, base, UINNavSpeciaOasisCollectRewardItem
  self.alphaColor = (Color.New)(1, 1, 1, 0.3)
  self.resItemDic = {}
  self.isTweenPlay = false
  ;
  (base.OnInit)(self)
  self.resItemPool = (UIItemPool.New)(UINNavSpeciaOasisCollectRewardItem, (self.ui).resItem)
  ;
  (((self.ui).resItem).gameObject):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_resCollect, self, self.__CollectAllRewards)
  self.__B_RefreshAllRewards = BindCallback(self, self.__RefreshAllRewards)
  self._CollectAllResCompleteFunc = BindCallback(self, self._OnCollectAllResComplete)
end

UINNavSpeciaOasisCollectReward.GetSpecialUI = function(item, go, resloader)
  -- function num : 0_1 , upvalues : base, UINNavSpeciaOasisCollectReward
  local specialUI = (base.GetSpecialUI)(UINNavSpeciaOasisCollectReward, item, go)
  specialUI:__RefreshAllRewards()
  ;
  (base.__Add2TimerFuncs)(specialUI.__B_RefreshAllRewards)
end

UINNavSpeciaOasisCollectReward.__RefreshAllRewards = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.isTweenPlay then
    return 
  end
  local allDatas = {}
  for _,buildingData in pairs((PlayerDataCenter.AllBuildingData).oasisBuilt) do
    local datas = buildingData:GetResDatas()
    if datas ~= nil then
      for _,data in pairs(datas) do
        if allDatas[data.id] == nil then
          allDatas[data.id] = data
        else
          -- DECOMPILER ERROR at PC33: Confused about usage of register: R13 in 'UnsetPending'

          ;
          (allDatas[data.id]).count = (allDatas[data.id]).count + data.count
          -- DECOMPILER ERROR at PC41: Confused about usage of register: R13 in 'UnsetPending'

          ;
          (allDatas[data.id]).countMax = (allDatas[data.id]).countMax + data.countMax
        end
      end
    end
  end
  if (table.count)(allDatas) == 0 then
    self:Hide()
    return 
  end
  self:Show()
  self:__CouldCollectReward()
  ;
  (self.resItemPool):HideAll()
  for _,buildingResData in pairs(allDatas) do
    local itemId = buildingResData.id
    local rate = buildingResData.count / buildingResData.countMax
    local item = (self.resItemPool):GetOne()
    -- DECOMPILER ERROR at PC74: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.resItemDic)[itemId] = item
    item:SetNSOCRItemImage(itemId)
    item:RefreshNSOCRItemRate(rate)
  end
end

UINNavSpeciaOasisCollectReward.__CouldCollectReward = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local buildIdDict = {}
  local failCollectBuildDatas = {}
  local buildingCount = 0
  for buildId,buildData in pairs((PlayerDataCenter.AllBuildingData).oasisBuilt) do
    if buildData:IsBuildResPeriodOk() and buildData:CanGetBuildRes() then
      buildingCount = buildingCount + 1
      buildIdDict[buildId] = true
    else
      failCollectBuildDatas[buildId] = buildData
    end
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

  if buildingCount > 0 then
    ((self.ui).img_colleIcon).color = Color.white
    return true, failCollectBuildDatas, buildIdDict
  else
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_colleIcon).color = self.alphaColor
    return false, failCollectBuildDatas
  end
end

UINNavSpeciaOasisCollectReward.__CollectAllRewards = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local could, failBuildResDatas, buildIdDict = self:__CouldCollectReward()
  if could and GuideManager.collectResGuideUnComplete then
    for buildId,_ in pairs(buildIdDict) do
      if buildId == 1003 then
        GuideManager:UncompleteCollectResGuide(false)
        local topWindow = UIManager:GetWindow(UIWindowTypeID.TopStatus)
        ;
        (topWindow.resGroup):UpdateResourceGroupTopCurrencys()
        local oasisController = ControllerManager:GetController(ControllerTypeId.OasisController)
        if oasisController ~= nil then
          oasisController:CollectComplete(1003, {
{id = 1004, count = 1}
})
        end
        buildIdDict[buildId] = nil
        if (table.count)(buildIdDict) <= 0 then
          could = false
        end
        break
      end
    end
  end
  do
    if could then
      (NetworkManager:GetNetwork(NetworkTypeID.Building)):SendBuildingCollectGroup(buildIdDict, self._CollectAllResCompleteFunc)
    end
    self:_FailCollectTips(failBuildResDatas, could)
  end
end

UINNavSpeciaOasisCollectReward._FailCollectTips = function(self, failBuildResDatas, haveCouldCollect)
  -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon
  local resIds = {}
  local tipsList = {}
  local isHaveFullCapicity, isHaveCannotCollect = nil, nil
  for buildId,buildData in pairs(failBuildResDatas) do
    if buildData.state ~= proto_object_BuildingState.BuildingStateCreate and buildData.resDatas ~= nil then
      local datas = buildData:GetResDatas()
      for k,v in pairs(datas) do
        local count = v.count
        local capacity = (PlayerDataCenter.playerBonus):GetWarehouseCapcity(v.id)
        local playerResCount = PlayerDataCenter:GetItemCount(v.id)
        if capacity < playerResCount then
          isHaveFullCapicity = true
          if resIds[v.id] == nil then
            resIds[v.id] = true
            ;
            (table.insert)(tipsList, v.name .. ConfigData:GetTipContent(TipContent.ItemInWarehouseFull))
            break
          end
        else
          isHaveCannotCollect = true
        end
      end
    end
  end
  for index,tips in ipairs(tipsList) do
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(tips, true)
  end
  if not haveCouldCollect and not isHaveFullCapicity and isHaveCannotCollect then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Building_UnsatisfMinialRewardCycle), true)
  end
end

UINNavSpeciaOasisCollectReward._OnCollectAllResComplete = function(self, objList)
  -- function num : 0_6 , upvalues : _ENV, cs_MessageCommon, cs_DoTween
  if objList.Count ~= 1 then
    error("objList.Count error:" .. tostring(objList.Count))
    return 
  end
  AudioManager:PlayAudioById(1090)
  local resDic = objList[0]
  for resId,resNum in pairs(resDic) do
    local itemCfg = (ConfigData.item)[resId]
    if itemCfg ~= nil then
      local msg = ConfigData:GetTipContent(TipContent.Building_GainReward) .. (LanguageUtil.GetLocaleText)(itemCfg.name) .. " x " .. tostring(resNum)
      ;
      (cs_MessageCommon.ShowMessageTips)(msg, true)
    end
  end
  if self.resTweenSeq ~= nil then
    (self.resTweenSeq):Kill(true)
  end
  self.resTweenSeq = (cs_DoTween.Sequence)()
  for resId,resNum in pairs(resDic) do
    local item = (self.resItemDic)[resId]
    if item ~= nil and not IsNull(item) then
      (self.resTweenSeq):Join((item:GetFillAmountImage()):DOFillAmount(0, 0.5))
    end
  end
  ;
  (self.resTweenSeq):AppendCallback(function()
    -- function num : 0_6_0 , upvalues : self
    self.resTweenSeq = nil
    self.isTweenPlay = false
  end
)
  self.isTweenPlay = true
end

UINNavSpeciaOasisCollectReward.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.__RemoveFromTimerFuncs)(self.__B_RefreshAllRewards)
  for id,item in pairs(self.resItemDic) do
    item:Delete()
  end
  self.resItemDic = nil
  ;
  (self.resTweenSeq):Kill()
  self.resTweenSeq = nil
  ;
  (base.OnDelete)(self)
end

return UINNavSpeciaOasisCollectReward


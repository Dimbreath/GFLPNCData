-- params : ...
-- function num : 0 , upvalues : _ENV
local UIUserInfo = class("UIUserNameModify", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local cs_Material = (CS.UnityEngine).Material
local UINUserInfoBottomItem = require("Game.User.UINUserInfoBottomItem")
local newBottomItemTab = {
[1] = {func = function()
  -- function num : 0_0 , upvalues : _ENV
  local sectorId, stageIndex = (PlayerDataCenter.sectorStage):GetEpStageCfg4UserInfo()
  if sectorId == nil or stageIndex == nil then
    return "NO PASS"
  end
  return "STAGE " .. tostring(sectorId) .. "-" .. tostring(stageIndex)
end
}
, 
[2] = {func = function()
  -- function num : 0_1 , upvalues : _ENV
  return tostring((table.count)((PlayerDataCenter.infinityData).completed) * 10) .. "m"
end
}
, 
[3] = {func = function()
  -- function num : 0_2 , upvalues : _ENV
  local totalLevel = 0
  for key,value in pairs((PlayerDataCenter.AllBuildingData).oasisBuilt) do
    totalLevel = totalLevel + value.level
  end
  return "Lv." .. tostring(totalLevel)
end
}
}
UIUserInfo.OnInit = function(self)
  -- function num : 0_3 , upvalues : _ENV, UINUserInfoBottomItem
  self.isModifyListOpen = false
  ;
  (UIUtil.SetTopStatus)(self, self.Delete)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_toAchievement, self, self.OpenAchievement)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ExchangeHero, self, self.ExchangeBoardHero)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Modify, self, self.OpenMofiyList)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_copyUID, self, self.OnClickCopyUID)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_closePopNode, self, self.OnPopNodeClose)
  self.bottomInfoPool = (UIItemPool.New)(UINUserInfoBottomItem, (self.ui).obj_bottomInfoListItem)
  ;
  ((self.ui).obj_bottomInfoListItem):SetActive(false)
  self._RefreshBoardHero = BindCallback(self, self.RefreshBoardHero)
  self._RefreshAchievementInfo = BindCallback(self, self.RefreshAchievementInfo)
  MsgCenter:AddListener(eMsgEventId.UpdatePickedAchivTask, self._RefreshAchievementInfo)
  MsgCenter:AddListener(eMsgEventId.UpdatePlayerLevel, self._RefreshAchievementInfo)
  ;
  ((self.ui).infoPopNode):SetActive(false)
end

UIUserInfo.InitUserInfo = function(self)
  -- function num : 0_4
  self:RefreshPlayerInfo()
  self:RefreshBoardHero()
  self:RefreshHeroNum()
  self:RefreshAchievementInfo()
  self:RefreshBottomInfo()
end

UIUserInfo.RefreshPlayerInfo = function(self)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).input_userName).text = PlayerDataCenter.playerName
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_UID).text = "UID:" .. PlayerDataCenter.strPlayerId
end

UIUserInfo.RefreshBoardHero = function(self, heroData, callback)
  -- function num : 0_6 , upvalues : _ENV, cs_ResLoader
  if heroData == nil then
    if PlayerDataCenter.showGirlId == nil or PlayerDataCenter.showGirlId == 0 then
      local firtBoardHeroID = (ConfigData.game_config).firtBoardHeroID
      if (PlayerDataCenter.heroDic)[firtBoardHeroID] == nil then
        error("default board hero data is nil id " .. firtBoardHeroID)
      else
        heroData = (PlayerDataCenter.heroDic)[firtBoardHeroID]
      end
    else
      do
        heroData = (PlayerDataCenter.heroDic)[PlayerDataCenter.showGirlId]
        local resName = heroData:GetResName()
        if self.bigImgResloader ~= nil then
          (self.bigImgResloader):Put2Pool()
          self.bigImgResloader = nil
        end
        if self.softMaskMat == nil then
          self.softMaskMat = (((CS.UnityEngine).Object).Instantiate)((self.ui).mat_softMask)
          ;
          (self.softMaskMat):SetFloat("_clipSoftX", 400)
          ;
          (self.softMaskMat):SetFloat("_clipSoftY", 1)
        end
        self.bigImgResloader = (cs_ResLoader.Create)()
        ;
        (self.bigImgResloader):LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(resName), function(prefab)
    -- function num : 0_6_0 , upvalues : _ENV, self, callback
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate((self.ui).obj_heroHolder)
    local comPerspHandle = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    comPerspHandle:SetPosType("UserInfo")
    local rawImage = (self.bigImgGameObject):FindComponent(eUnityComponentID.RawImage)
    rawImage.material = self.softMaskMat
    if callback ~= nil then
      callback()
    end
  end
)
        -- DECOMPILER ERROR at PC78: Confused about usage of register: R4 in 'UnsetPending'

        ;
        ((self.ui).tex_HeroName).text = heroData:GetName()
        self.currHeroData = heroData
      end
    end
  end
end

UIUserInfo.ExchangeBoardHero = function(self)
  -- function num : 0_7 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.SelectBoardHero, function(win)
    -- function num : 0_7_0 , upvalues : self
    if win ~= nil then
      win:InitSelectBoardHero(self.currHeroData)
      win.changeBoardHeroCallback = self._RefreshBoardHero
    end
  end
)
end

UIUserInfo.RefreshHeroNum = function(self)
  -- function num : 0_8 , upvalues : _ENV
  ((self.ui).tex_CollectNum):SetIndex(0, tostring(PlayerDataCenter.heroCount), tostring((ConfigData.hero_data).totalHeroCount))
end

UIUserInfo.RefreshAchievementInfo = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement)
  ;
  ((self.ui).obj_AchievementInfo):SetActive(isUnlock)
  if not isUnlock then
    return 
  end
  local curLevel = (PlayerDataCenter.playerLevel).level
  if curLevel < 10 then
    ((self.ui).tex_CurPlayerLevel):SetIndex(0, "0", tostring(curLevel))
  else
    ;
    ((self.ui).tex_CurPlayerLevel):SetIndex(0, "", tostring(curLevel))
  end
  local cur = (PlayerDataCenter.achivLevelData):GetPickedAchNum()
  local total = (PlayerDataCenter.achivLevelData):GetTotalAchNum()
  ;
  ((self.ui).tex_CompleteNum):SetIndex(0, tostring(cur or 0), tostring(total or 0))
end

UIUserInfo.RefreshBottomInfo = function(self)
  -- function num : 0_10 , upvalues : _ENV, newBottomItemTab
  (self.bottomInfoPool):HideAll()
  for index,tab in ipairs(newBottomItemTab) do
    local item = (self.bottomInfoPool):GetOne()
    item:InitUserInfoBottomItem(index, tab.func, tab.refreshMsg)
  end
end

UIUserInfo.OpenAchievement = function(self)
  -- function num : 0_11 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.AchievementSystem, function(win)
    -- function num : 0_11_0 , upvalues : _ENV, self
    if win ~= nil then
      win:InitAchievement(nil, false, function()
      -- function num : 0_11_0_0 , upvalues : _ENV, self
      (UIUtil.PopFromBackStack)()
      self:Delete()
    end
)
    end
  end
)
end

UIUserInfo.OpenMofiyList = function(self)
  -- function num : 0_12
  self.isModifyListOpen = not self.isModifyListOpen
  ;
  ((self.ui).infoPopNode):SetActive(self.isModifyListOpen)
end

UIUserInfo.OnClickCopyUID = function(self)
  -- function num : 0_13 , upvalues : _ENV, cs_MessageCommon
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ((CS.UnityEngine).GUIUtility).systemCopyBuffer = PlayerDataCenter.strPlayerId
  self.isModifyListOpen = false
  ;
  ((self.ui).infoPopNode):SetActive(false)
  ;
  (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.UserInfo_CopyUIDDone))
end

UIUserInfo.OnPopNodeClose = function(self)
  -- function num : 0_14
  self.isModifyListOpen = false
  ;
  ((self.ui).infoPopNode):SetActive(false)
end

UIUserInfo.OnDelete = function(self)
  -- function num : 0_15 , upvalues : _ENV, base
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  if self.softMaskMat ~= nil then
    DestroyUnityObject(self.softMaskMat)
    self.softMaskMat = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.UpdatePickedAchivTask, self._RefreshAchievementInfo)
  MsgCenter:RemoveListener(eMsgEventId.UpdatePlayerLevel, self._RefreshAchievementInfo)
  local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeWin ~= nil then
    (homeWin.homeAdjutant):LoadBoardHero(self.currHeroData, function()
    -- function num : 0_15_0 , upvalues : homeWin, base, self
    homeWin:BackFromOtherWin()
    ;
    (base.OnDelete)(self)
    ;
    (self.bottomInfoPool):DeleteAll()
  end
)
  else
    ;
    (base.OnDelete)(self)
    ;
    (self.bottomInfoPool):DeleteAll()
  end
end

return UIUserInfo


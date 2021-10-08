local UILotterySelectHero = class("UILotterySelectHero", UIBaseWindow)
local base = UIBaseWindow
local UINLtrSelectHeroItem = require("Game.Lottery.UI.SelectHero.UINLtrSelectHeroItem")
local UINLtrSkillItem = require("Game.Lottery.UI.SelectHero.UINLtrSkillItem")
local HeroSkillData = require("Game.PlayerData.Skill.HeroSkillData")
local HeroInfoData = require("Game.Lottery.Data.HeroInfoData")
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local cs_EventTriggerListener = CS.EventTriggerListener
local cs_DoTween = ((CS.DG).Tweening).DOTween
local LotteryRtUtil = require("Game.Lottery.UI.LotteryRtUtil")
UILotterySelectHero.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINLtrSelectHeroItem, cs_ResLoader, LotteryRtUtil
  (UIUtil.AddButtonListener)((self.ui).btn_HeroInfo, self, self.__OnClickHeroInfo)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ShowCharacter, self, self.__OnClickShowCharacter)
  ;
  ((self.ui).heroItem):SetActive(false)
  self.heroItemPool = (UIItemPool.New)(UINLtrSelectHeroItem, (self.ui).heroItem)
  self._OnSelectHeroFunc = BindCallback(self, self._OnSelectHero)
  self.resloader = (cs_ResLoader.Create)()
  self.texture = (LotteryRtUtil.GetARGBHalfRtTemporary)(256, 256, 24)
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).cameraImage).texture = self.texture
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).camera).targetTexture = self.texture
  ;
  (((self.ui).camera).gameObject):SetActive(true)
  ;
  (((self.ui).cameraImage).gameObject):SetActive(true)
  self.resLoader = (cs_ResLoader.Create)()
  ;
  (((self.ui).img_star).gameObject):SetActive(false)
  self.StarList = {}
  self.heroHoderDefaultPosition = (((self.ui).heroHolder).transform).localPosition
end

UILotterySelectHero.InitLotterySelectHero = function(self, ltrPoolData)
  -- function num : 0_1
  self.ltrPoolData = ltrPoolData
  local heroIdList, heroId2ItemIdMapDic = ltrPoolData:GetLtrFreeChoiceHeroIdList()
  self.heroId2ItemIdMapDic = heroId2ItemIdMapDic
  self:_InitHeroList(heroIdList)
end

UILotterySelectHero.InitPageChangeDrag = function(self, startDragFunc, endDragFunc)
  -- function num : 0_2 , upvalues : cs_EventTriggerListener
  local pageChangeEventTrigger = (cs_EventTriggerListener.Get)((self.ui).dragPageChange)
  pageChangeEventTrigger:onBeginDrag("+", startDragFunc)
  pageChangeEventTrigger:onEndDrag("+", endDragFunc)
end

UILotterySelectHero._InitHeroList = function(self, heroIdList)
  -- function num : 0_3 , upvalues : _ENV
  self.heroIdList = heroIdList
  ;
  (self.heroItemPool):HideAll()
  for k,heroId in ipairs(heroIdList) do
    local heroItem = (self.heroItemPool):GetOne()
    heroItem:InitLtrSelectHeroItem(heroId, self._OnSelectHeroFunc, self.resloader)
    if k > 4 or not (self.ui).upperList then
      do
        (heroItem.transform):SetParent((self.ui).downList)
        -- DECOMPILER ERROR at PC27: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC27: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  local defalutId = (((self.heroItemPool).listItem)[1]).heroId
  self:_OnSelectHero(defalutId)
end

UILotterySelectHero.__OnClickHeroInfo = function(self)
  -- function num : 0_4 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroInfoState, function(win)
    -- function num : 0_4_0 , upvalues : self
    if win == nil then
      return 
    end
    win:InitHeroInfoState(self.selectHeroId)
  end
)
end

UILotterySelectHero.__OnClickShowCharacter = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local currentPoolId = 0
  local heroId = self.selectHeroId
  local lottrryCtrl = ControllerManager:GetController(ControllerTypeId.Lottery, true)
  if lottrryCtrl ~= nil then
    currentPoolId = lottrryCtrl.curPoolId
  end
  local ltrWin = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
  if ltrWin ~= nil then
    ltrWin:CloseLottery(true)
  end
  ;
  (ControllerManager:GetController(ControllerTypeId.ShowCharacter, true)):EnterShowCharacterScene(heroId, currentPoolId)
end

UILotterySelectHero._OnSelectHero = function(self, heroId)
  -- function num : 0_6 , upvalues : _ENV, HeroInfoData
  if self.isChangeing or self.selectHeroId == heroId then
    return 
  end
  if heroId == nil then
    error("heroId is Empty")
    return 
  end
  local isFirstSet = self.selectHeroId == nil
  self.selectHeroId = heroId
  if isFirstSet then
    self:LoadPic(false)
    self:ChangeHeroShow()
  else
    self:LoadPic(true)
    self:_AniHeroChange()
  end
  self.selectHeroData = HeroInfoData:New()
  ;
  (self.selectHeroData):InitData(self.selectHeroId)
  self:__refreshPreviewPic()
  for i,item in ipairs((self.heroItemPool).listItem) do
    item:SetLtrSelectHeroItemIsOn(self.selectHeroId)
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UILotterySelectHero.__refreshPreviewPic = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self.selectHeroId then
    local lottery_preview = (ConfigData.lottery_preview)[self.selectHeroId]
    if lottery_preview ~= nil then
      local fullPath = PathConsts:GetImagePath(lottery_preview.previewPic)
      local image = (self.resLoader):LoadABAsset(fullPath)
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R4 in 'UnsetPending'

      if image ~= nil then
        ((self.ui).img_PreviewCharacter).texture = image
      end
    end
  end
end

UILotterySelectHero.__refreshModel = function(self)
  -- function num : 0_8 , upvalues : _ENV, cs_ResLoader
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
    self.resLoader = nil
  end
  local modelPath = PathConsts:GetCharacterModelPrefabPath(((self.selectHeroData).heroData):GetResModelName())
  if self.modelPath == modelPath then
    return 
  end
  if not IsNull(self.heroGo) then
    (self.heroGo):SetActive(false)
  end
  self.resLoader = (cs_ResLoader.Create)()
  ;
  (self.resLoader):LoadABAssetAsync(modelPath, function(prefab)
    -- function num : 0_8_0 , upvalues : _ENV, self, modelPath
    DestroyUnityObject(self.heroGo)
    self.modelPath = modelPath
    self.heroGo = prefab:Instantiate(((self.ui).modelHoder).transform)
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.heroGo).transform).localEulerAngles = (Vector3.New)(0, 180, 0)
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.heroGo).transform).localPosition = (Vector3.New)(0, -0.5, 0)
  end
)
end

UILotterySelectHero.ChangeHeroShow = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local heroCfg = (ConfigData.hero_data)[self.selectHeroId]
  if heroCfg == nil then
    error("hero cfg is null,id:" .. tostring(self.selectHeroId))
    return 
  end
  self.curHeroCfg = heroCfg
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(heroCfg.name)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_ENName).text = heroCfg.name_en
  local careerCfg = (ConfigData.career)[heroCfg.career]
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_Carrer).sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
  self:_UpdateStarNum(heroCfg.rank)
end

UILotterySelectHero._AniHeroChange = function(self)
  -- function num : 0_10 , upvalues : cs_DoTween, _ENV
  self.isChangeing = true
  self.isChangeingFirstState = true
  if self.heroChangeTween ~= nil then
    (self.heroChangeTween):Restart()
    ;
    (self.heroChangeTween):PlayForward()
    return 
  end
  self.heroChangeTween = (cs_DoTween.Sequence)()
  ;
  (self.heroChangeTween):SetAutoKill(false)
  local tempTime = 0.2
  local newWorldPos = (((self.ui).heroInfo).transform):TransformPoint(self.heroHoderDefaultPosition + (Vector3.New)(50, 0, 0))
  ;
  (self.heroChangeTween):Append(((self.ui).heroInfo):DOFade(0, tempTime))
  ;
  (self.heroChangeTween):Join((((self.ui).heroHolder).transform):DOMove(newWorldPos, tempTime))
  ;
  (self.heroChangeTween):OnComplete(function()
    -- function num : 0_10_0 , upvalues : self
    self.isChangeingFirstState = false
    self:TryContinueTween()
  end
)
  ;
  (self.heroChangeTween):PlayForward()
end

UILotterySelectHero.LoadPic = function(self, isPreLoader)
  -- function num : 0_11 , upvalues : _ENV, cs_ResLoader
  local loadFunc = function(loader, finishAct)
    -- function num : 0_11_0 , upvalues : _ENV, self
    local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
    local resCfg = skinCtr:GetResModel(self.selectHeroId, 0)
    local resPath = PathConsts:GetCharacterBigImgPrefabPath(resCfg.res_Name)
    loader:LoadABAssetAsync(resPath, function(prefab)
      -- function num : 0_11_0_0 , upvalues : _ENV, self, finishAct
      if IsNull(prefab) then
        return 
      end
      local objField = prefab:Instantiate(((self.ui).heroHolder).transform)
      local commonPicCtrl = objField:FindComponent(eUnityComponentID.CommonPicController)
      commonPicCtrl:SetPosType("HeroList")
      if finishAct ~= nil then
        finishAct(objField)
      end
      AudioManager:PlayAudioById(1062)
    end
)
  end

  if isPreLoader then
    if self.nextResLoader ~= nil then
      (self.nextResLoader):Put2Pool()
      self.nextResLoader = nil
    end
    if not IsNull(self.nextBigImgGameObject) then
      DestroyUnityObject(self.nextBigImgGameObject)
    end
    self.nextResLoader = (cs_ResLoader.Create)()
    loadFunc(self.nextResLoader, function(fileObj)
    -- function num : 0_11_1 , upvalues : self
    self.nextBigImgGameObject = fileObj
    self:TryContinueTween()
  end
)
  else
    if self.bigImgResloader ~= nil then
      (self.bigImgResloader):Put2Pool()
    end
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgResloader = (cs_ResLoader.Create)()
    loadFunc(self.bigImgResloader, function(fileObj)
    -- function num : 0_11_2 , upvalues : self
    self.bigImgGameObject = fileObj
  end
)
  end
end

UILotterySelectHero.TryContinueTween = function(self)
  -- function num : 0_12 , upvalues : _ENV, cs_DoTween
  -- DECOMPILER ERROR at PC17: Unhandled construct in 'MakeBoolean' P1

  if (not self.isChangeing or self.isChangeingFirstState or IsNull(self.nextBigImgGameObject)) and self.nextBigImgGameObject ~= nil then
    (self.nextBigImgGameObject):SetActive(false)
  end
  do return  end
  DestroyUnityObject(self.bigImgGameObject)
  self.bigImgGameObject = self.nextBigImgGameObject
  self.nextBigImgGameObject = nil
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
  end
  self.bigImgResloader = self.nextResLoader
  self.nextResLoader = nil
  ;
  (self.bigImgGameObject):SetActive(true)
  self:ChangeHeroShow()
  if self.heroChangeTweenBack ~= nil then
    (self.heroChangeTweenBack):Restart()
    ;
    (self.heroChangeTweenBack):PlayForward()
    return 
  end
  self.heroChangeTweenBack = (cs_DoTween.Sequence)()
  ;
  (self.heroChangeTweenBack):SetAutoKill(false)
  local tempTime = 0.2
  local oriWorldPos = (((self.ui).heroInfo).transform):TransformPoint(self.heroHoderDefaultPosition)
  ;
  (self.heroChangeTweenBack):Append(((self.ui).heroInfo):DOFade(1, tempTime))
  ;
  (self.heroChangeTweenBack):Join((((self.ui).heroHolder).transform):DOMove(oriWorldPos, tempTime))
  ;
  (self.heroChangeTweenBack):OnComplete(function()
    -- function num : 0_12_0 , upvalues : self
    self.isChangeing = false
  end
)
  ;
  (self.heroChangeTweenBack):PlayForward()
end

UILotterySelectHero._UpdateStarNum = function(self, rank)
  -- function num : 0_13 , upvalues : _ENV
  local rankCfg = (ConfigData.hero_rank)[rank]
  if rankCfg == nil then
    error("Can\'t find rankCfg, id = " .. tostring(rank))
    return 
  end
  local num = rankCfg.star
  local count = (math.ceil)(num / 2)
  local isHalf = num % 2 == 1
  for _,starGameObject in ipairs(self.StarList) do
    (starGameObject.gameObject):SetActive(false)
  end
  for i = 1, count do
    if (self.StarList)[i] ~= nil then
      (((self.StarList)[i]).gameObject):SetActive(true)
      ;
      ((self.StarList)[i]):SetIndex(0)
    else
      local imgItemInfo = ((((self.ui).img_star).gameObject):Instantiate()):GetComponent(typeof(CS.UiImageItemInfo))
      ;
      (table.insert)(self.StarList, imgItemInfo)
      ;
      (imgItemInfo.gameObject):SetActive(true)
    end
  end
  if isHalf then
    ((self.StarList)[count]):SetIndex(1)
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

UILotterySelectHero.GetLtrSelectHeroItemId = function(self)
  -- function num : 0_14
  local itemId = (self.heroId2ItemIdMapDic)[self.selectHeroId]
  return itemId, self.selectHeroId
end

UILotterySelectHero.ConfimFreeSelectHero = function(self, ltrCtrl)
  -- function num : 0_15 , upvalues : _ENV
  local itemId = (self.heroId2ItemIdMapDic)[self.selectHeroId]
  UIManager:ShowWindowAsync(UIWindowTypeID.LotteryExchange, function(window)
    -- function num : 0_15_0 , upvalues : itemId, self, ltrCtrl
    if window ~= nil then
      window:ShowLtrSHNode(itemId, self.curHeroCfg, (self.ltrPoolData).ltrCfg, ltrCtrl)
    end
  end
)
end

UILotterySelectHero.OnHide = function(self)
  -- function num : 0_16 , upvalues : base
  (base.OnHide)(self)
end

UILotterySelectHero.ClearLotterySelect = function(self)
  -- function num : 0_17 , upvalues : _ENV
  if self.heroChangeTween ~= nil then
    (self.heroChangeTween):Kill()
    self.heroChangeTween = nil
  end
  if self.heroChangeTweenBack ~= nil then
    (self.heroChangeTweenBack):Kill()
    self.heroChangeTweenBack = nil
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self.ui).heroHolder).transform).localPosition = self.heroHoderDefaultPosition
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).heroInfo).alpha = 1
  self.selectHeroId = nil
  self.isChangeing = false
  self.isChangeingFirstState = false
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = ""
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_ENName).text = ""
  if self.nextResLoader ~= nil then
    (self.nextResLoader):Put2Pool()
    self.nextResLoader = nil
  end
  if not IsNull(self.nextBigImgGameObject) then
    DestroyUnityObject(self.nextBigImgGameObject)
  end
end

UILotterySelectHero.OnDelete = function(self)
  -- function num : 0_18 , upvalues : LotteryRtUtil, base
  self:ClearLotterySelect()
  ;
  (self.heroItemPool):DeleteAll()
  ;
  (self.bigImgResloader):Put2Pool()
  self.bigImgResloader = nil
  ;
  (self.resloader):Put2Pool()
  self.resloader = nil
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
  end
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  if self.texture ~= nil then
    ((self.ui).camera).targetTexture = nil
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).cameraImage).texture = nil
    ;
    (LotteryRtUtil.ReleaseTemporaryAndDestory)(self.texture)
    self.texture = nil
    ;
    (((self.ui).camera).gameObject):SetActive(false)
    ;
    (((self.ui).cameraImage).gameObject):SetActive(false)
  end
  ;
  (base.OnDelete)(self)
end

return UILotterySelectHero


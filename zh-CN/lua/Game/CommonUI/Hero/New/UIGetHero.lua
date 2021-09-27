local UIGetHero = class("UIGetHero", UIBaseWindow)
local base = UIBaseWindow
local UINHeroCardConvert = require("Game.CommonUI.Hero.New.UINHeroCardConvert")
local cs_ResLoader = CS.ResLoader
local cs_ParticleSystem = (CS.UnityEngine).ParticleSystem
local cs_MovieManager = (CS.MovieManager).Instance
local cs_DoTween = ((CS.DG).Tweening).DOTween
local cs_PlayState = ((CS.UnityEngine).Playables).PlayState
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroLookTargetController = require("Game.Hero.Live2D.HeroLookTargetController")
local util = require("XLua.Common.xlua_util")
local eSkipMode = {None = 1, SkipOldHero = 2, NotNewStar3 = 3}
local heroNameEffColor = {[3] = (Color.New)(1, 0.671, 0.476, 1), [2] = (Color.New)(0.798, 0.561, 1, 1), [1] = (Color.New)(0.524, 0.746, 1, 1)}
local m_moviePlayer = nil
local HeroIdTo4Hex = function(id)
  -- function num : 0_0 , upvalues : _ENV
  local out = (string.format)("%X", id)
  local len = (string.len)(out)
  if len < 4 then
    for i = 1, 4 - len do
      out = "0" .. out
    end
  else
    do
      if len > 4 then
        out = (string.sub)(out, len - 3)
      end
      return "#" .. out
    end
  end
end

UIGetHero.OnInit = function(self)
  -- function num : 0_1 , upvalues : cs_ResLoader, _ENV, UINHeroCardConvert, eSkipMode
  self.resloader = (cs_ResLoader.Create)()
  self.TagList = {}
  ;
  (table.insert)(self.TagList, (self.ui).tagItem)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnClickClose)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Skip, self, self.OnClickSkip)
  local codeActionBinding = ((self.ui).ui_timeline):FindComponent(eUnityComponentID.CodeActionBinding)
  codeActionBinding:RegisterAction("ZoomOut", BindCallback(self, self._OnCamZoomOut))
  codeActionBinding:RegisterAction("StarVoice1", BindCallback(self, self._OnStarVoice, 1))
  codeActionBinding:RegisterAction("StarVoice2", BindCallback(self, self._OnStarVoice, 2))
  codeActionBinding:RegisterAction("StarVoice3", BindCallback(self, self._OnStarVoice, 3))
  codeActionBinding:RegisterAction("StarVoice4", BindCallback(self, self._OnStarVoice, 4))
  codeActionBinding:RegisterAction("StarVoice5", BindCallback(self, self._OnStarVoice, 5))
  codeActionBinding:RegisterAction("ConvertTween", BindCallback(self, self._OnConvertTween))
  self.auBack_StarDic = {}
  ;
  ((self.ui).heroConvertItem):SetActive(false)
  self.cardConvertItemPool = (UIItemPool.New)(UINHeroCardConvert, (self.ui).heroConvertItem)
  self.skipMode = eSkipMode.None
  -- DECOMPILER ERROR at PC103: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (UIManager.UICamera).fieldOfView = 90
end

UIGetHero.SetCustomVoiceType = function(self, type)
  -- function num : 0_2
  self.__customVoiceType = type
end

UIGetHero.InitGetHeroList = function(self, heroIdList, useHeroData, withGetHeroSound, newHeroIndexDic, closeFunc, skipOldHero, newSkinIdDic)
  -- function num : 0_3 , upvalues : eSkipMode, _ENV
  if #heroIdList < 1 then
    return 
  end
  ;
  (((self.ui).btn_Skip).gameObject):SetActive(not useHeroData)
  self.withGetHeroSound = withGetHeroSound
  self.haveNext = true
  self.heroIdList = heroIdList
  self.useHeroData = useHeroData
  self.newHeroIndexDic = newHeroIndexDic
  self.newSkinIdDic = newSkinIdDic
  self.showIndex = 1
  if skipOldHero then
    self.skipMode = eSkipMode.SkipOldHero
  end
  self.allTweens = (self.transform):GetComponentsInChildren(typeof(((CS.DG).Tweening).DOTweenAnimation))
  self:SetCloseFunction(closeFunc)
  self:_TryShowNext()
end

UIGetHero._TryShowNext = function(self)
  -- function num : 0_4
  self.__tempPlayAllTween = nil
  self:_StopCampAudio()
  self:_ReturnMovie()
  self:_StopAllAudio()
  if self.haveNext then
    self:ShowNext()
  else
    self:_OnComplete()
  end
end

UIGetHero.ShowNext = function(self)
  -- function num : 0_5 , upvalues : _ENV, eSkipMode
  self:_StopHeroVoice()
  ;
  ((self.ui).ui_timeline):Stop()
  self.isNew = self.newHeroIndexDic ~= nil and (self.newHeroIndexDic)[self.showIndex] or false
  local heroId = (self.heroIdList)[self.showIndex]
  local heroCfg = (ConfigData.hero_data)[heroId]
  if heroCfg == nil then
    error("hero cfg is null,id:" .. tostring(heroId))
    return 
  end
  local rankCfg = (ConfigData.hero_rank)[heroCfg.rank]
  if rankCfg == nil then
    error("Can\'t find rankCfg, id = " .. tostring(heroCfg.rank))
    return 
  end
  local heroStar = rankCfg.star
  ;
  (((self.ui).btn_Skip).gameObject):SetActive((not self.useHeroData and not self.isNew))
  local skip = false
  if self.skipMode == eSkipMode.SkipOldHero then
    skip = not self.isNew
  elseif self.isNew and heroStar >= 6 then
    skip = self.skipMode ~= eSkipMode.NotNewStar3
    do
      if not skip then
        local newSkinId = nil
        if self.newSkinIdDic ~= nil then
          newSkinId = (self.newSkinIdDic)[heroId]
        end
        self:_InitGetHero(heroId, self.isNew, newSkinId)
        self.isSkipAllTween = false
      end
      self.showIndex = self.showIndex + 1
      if #self.heroIdList < self.showIndex then
        self.haveNext = false
      end
      if skip then
        self:_TryShowNext()
      end
      -- DECOMPILER ERROR: 9 unprocessed JMP targets
    end
  end
end

UIGetHero._InitGetHero = function(self, heroId, isNew, newSkinId)
  -- function num : 0_6 , upvalues : _ENV, m_moviePlayer, cs_MovieManager, HeroIdTo4Hex, HeroCubismInteration, heroNameEffColor
  self.curHeroId = heroId
  local heroData, heroCfg = nil, nil
  if self.useHeroData then
    heroData = PlayerDataCenter:GetHeroData(heroId)
    heroCfg = heroData.heroCfg
  else
    heroCfg = (ConfigData.hero_data)[heroId]
  end
  ;
  (self.cardConvertItemPool):HideAll()
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R6 in 'UnsetPending'

  if isNew then
    ((self.ui).img_movie_bg).color = (Color.New)(0, 0, 0, 1)
    self.__tempPlayAllTween = self.PlayAllTween
    self.movieCB = BindCallback(self, function(table)
    -- function num : 0_6_0
    if table.__tempPlayAllTween ~= nil then
      (table.__tempPlayAllTween)(table)
      table.__tempPlayAllTween = nil
    end
  end
)
    local camCfg = (ConfigData.camp)[heroCfg.camp]
    if camCfg == nil then
      error("camp cfg is null,id:" .. tostring(heroCfg.camp))
      return 
    end
    if (string.IsNullOrEmpty)(camCfg.camp_video_path) then
      error("camp gethero_path is null,id:" .. tostring(heroCfg.camp))
    end
    local videoname = PathConsts:GetHeroVideoPath(camCfg.camp_video_path)
    m_moviePlayer = cs_MovieManager:GetMoviePlayer(false, true)
    m_moviePlayer:SetVideoRender((self.ui).img_movie)
    m_moviePlayer:PlayVideo(videoname)
    m_moviePlayer:SetVideoFadeInoutPercent(0.4, self.movieCB)
    self.auBack_camp = AudioManager:PlayAudioById(camCfg.camp_audio, function()
    -- function num : 0_6_1 , upvalues : self
    self.auBack_camp = nil
  end
)
  else
    do
      if not self.useHeroData then
        local rankCfg = (ConfigData.hero_rank)[heroCfg.rank]
        if rankCfg == nil then
          error("Can\'t find rankCfg, id = " .. tostring(heroCfg.rank))
        else
          for k,itemId in ipairs(rankCfg.repeat_extra_trans_id) do
            local itemNum = (rankCfg.repeat_extra_trans_num)[k]
            local convertItem = (self.cardConvertItemPool):GetOne(false)
            convertItem:InitHeroCardConvert(itemId, itemNum)
          end
        end
      end
      do
        self:PlayAllTween()
        for index,com in ipairs((self.ui).isNews) do
          com.enabled = isNew
        end
        -- DECOMPILER ERROR at PC143: Confused about usage of register: R6 in 'UnsetPending'

        ;
        ((self.ui).tex_HeroID_Big).text = HeroIdTo4Hex(heroId)
        -- DECOMPILER ERROR at PC149: Confused about usage of register: R6 in 'UnsetPending'

        ;
        ((self.ui).tex_HeroID_Small).text = HeroIdTo4Hex(heroId)
        local campCfg = (ConfigData.camp)[heroCfg.camp]
        local campIcon = (LanguageUtil.GetLocaleText)(campCfg.icon)
        ;
        (self.resloader):LoadABAssetAsync(PathConsts:GetCampPicPath(campIcon), function(texture)
    -- function num : 0_6_2 , upvalues : _ENV, self
    if IsNull(self.transform) then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Camp).texture = texture
  end
)
        if newSkinId ~= nil then
          local skinCfg = (ConfigData.skin)[newSkinId]
          local resModelCfg = (ControllerManager:GetController(ControllerTypeId.Skin, true)):GetResModel(heroId, skinCfg ~= nil and skinCfg.id or nil)
          local resPath = PathConsts:GetCharacterLive2DPath(resModelCfg.src_id_pic)
          local haveLive2D = ((CS.ResManager).Instance):ContainsAsset(resPath)
          local isLocked = (skinCfg ~= nil and (HeroCubismInteration.JudgeL2DLocked)(skinCfg.id))
          if haveLive2D and not isLocked then
            self:__LoadLive2D(resPath, skinCfg)
          else
            self:__LoadPic(PathConsts:GetCharacterBigImgPrefabPath(resModelCfg.src_id_pic))
          end
        else
          local resCfg = (ConfigData.resource_model)[heroCfg.src_id]
          if resCfg == nil then
            error("resource model Cfg is null,id:" .. tostring(heroCfg.src_id))
          end
          self:__LoadPic(PathConsts:GetCharacterBigImgPrefabPath(resCfg.res_Name))
        end
        ;
        ((self.ui).img_Carrer):SetIndex(heroCfg.career - 1)
        -- DECOMPILER ERROR at PC251: Confused about usage of register: R8 in 'UnsetPending'

        ;
        ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(heroCfg.name)
        local enName = (LanguageUtil.GetLocaleText)(heroCfg.name_en)
        -- DECOMPILER ERROR at PC258: Confused about usage of register: R9 in 'UnsetPending'

        ;
        ((self.ui).tex_NameEN_Big).text = enName
        -- DECOMPILER ERROR at PC261: Confused about usage of register: R9 in 'UnsetPending'

        ;
        ((self.ui).tex_NameEN_small).text = enName
        self:ShowTags(heroCfg.tag)
        local heroStar, heroRare = nil, nil
        if self.useHeroData then
          heroStar = heroData.star
          heroRare = heroData.rare
        else
          local rankCfg = (ConfigData.hero_rank)[heroCfg.rank]
          if rankCfg == nil then
            error("Can\'t find rankCfg, id = " .. tostring(heroCfg.rank))
            return 
          end
          heroStar = rankCfg.star
          heroRare = rankCfg.rare
        end
        self:ShowStars(heroStar)
        local qualityColor = HeroRareColor[heroRare]
        local nameEffColor = heroNameEffColor[heroRare]
        -- DECOMPILER ERROR at PC296: Confused about usage of register: R13 in 'UnsetPending'

        ;
        ((self.ui).img_Quality).color = qualityColor
        self:SetPlayEffectColor(qualityColor, nameEffColor)
        self:ShowTimeAndTimeZone()
        -- DECOMPILER ERROR at PC307: Confused about usage of register: R13 in 'UnsetPending'

        ;
        ((self.ui).tex_Signet).text = PlayerDataCenter.playerName
        -- DECOMPILER ERROR: 9 unprocessed JMP targets
      end
    end
  end
end

UIGetHero.__LoadLive2D = function(self, path, skinCfg)
  -- function num : 0_7 , upvalues : _ENV, HeroCubismInteration, HeroLookTargetController
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  if self.Live2DResloader ~= nil then
    (self.Live2DResloader):Put2Pool()
    self.Live2DResloader = nil
  end
  if self.heroCubismInteration ~= nil then
    (self.heroCubismInteration):Delete()
    self.heroCubismInteration = nil
  end
  self.Live2DResloader = ((CS.ResLoader).Create)()
  DestroyUnityObject(self.l2dModelIns)
  ;
  (self.Live2DResloader):LoadABAssetAsync(path, function(l2dModelAsset)
    -- function num : 0_7_0 , upvalues : _ENV, self, HeroCubismInteration, skinCfg, HeroLookTargetController
    DestroyUnityObject(self.l2dModelIns)
    self.l2dModelIns = l2dModelAsset:Instantiate(((self.ui).heroHolder).transform)
    ;
    ((self.l2dModelIns).transform):SetLayer(LayerMask.UI)
    local cs_CubismInterationController = ((self.l2dModelIns).gameObject):GetComponent(typeof((((((CS.Live2D).Cubism).Samples).OriginalWorkflow).Demo).CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = (HeroCubismInteration.New)()
      local skinId = skinCfg ~= nil and skinCfg.id or 0
      ;
      (self.heroCubismInteration):InitHeroCubism(cs_CubismInterationController, self.curHeroId, skinId, UIManager:GetUICamera(), false)
    end
    do
      self.l2dBinding = {}
      ;
      (UIUtil.LuaUIBindingTable)(self.l2dModelIns, self.l2dBinding)
      local cubismLookController = ((self.l2dModelIns).gameObject):GetComponent(typeof(((((CS.Live2D).Cubism).Framework).LookAt).CubismLookController))
      ;
      (HeroLookTargetController.OpenLookTarget)(cubismLookController, ((self.l2dBinding).lookTarget).gameObject, UIManager:GetUICamera())
      -- DECOMPILER ERROR at PC80: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.l2dBinding).renderController).SortingLayer = "UIOverHigh"
      -- DECOMPILER ERROR at PC83: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.l2dBinding).renderController).SortingOrder = 1
      -- DECOMPILER ERROR at PC88: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.l2dBinding).renderController).uiCanvasGroup = (self.ui).heroHolder
      ;
      ((self.l2dBinding).commonPerpectiveHandle):SetL2DPosType("GetHero", false)
    end
  end
)
end

UIGetHero.__LoadPic = function(self, path)
  -- function num : 0_8 , upvalues : _ENV
  if self.Live2DResloader ~= nil then
    (self.Live2DResloader):Put2Pool()
    self.Live2DResloader = nil
  end
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  if self.heroCubismInteration ~= nil then
    (self.heroCubismInteration):Delete()
    self.heroCubismInteration = nil
  end
  self.bigImgResloader = ((CS.ResLoader).Create)()
  DestroyUnityObject(self.bigImgGameObject)
  ;
  (self.bigImgResloader):LoadABAssetAsync(path, function(prefab)
    -- function num : 0_8_0 , upvalues : _ENV, self
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate(((self.ui).heroHolder).transform)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("GetHero")
  end
)
end

UIGetHero.SetPlayEffectColor = function(self, qualityColor, nameEffColor)
  -- function num : 0_9 , upvalues : _ENV, cs_ParticleSystem
  for index,effect in ipairs((self.ui).Eff_QualityList) do
    if effect.isPlaying then
      effect:Stop()
      ;
      (effect.gameObject):SetActive(false)
    end
    local minMaxGradient = cs_ParticleSystem:MinMaxGradient()
    if index == 4 then
      minMaxGradient.color = nameEffColor
    else
      minMaxGradient.color = qualityColor
    end
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (effect.main).startColor = minMaxGradient
    ;
    (effect.gameObject):SetActive(true)
    effect:Play()
  end
end

UIGetHero.ShowTimeAndTimeZone = function(self)
  -- function num : 0_10 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).tex_Time).text = (os.date)("%m/%d %H:%M", (os.time)())
end

UIGetHero.PlayAllTween = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if IsNull(self.gameObject) then
    return 
  end
  local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
  if cvCtr:HasCv(self.curHeroId) then
    ((self.ui).dialogue):SetActive(true)
    local voiceId = nil
    if self.__customVoiceType ~= nil then
      voiceId = self.__customVoiceType
    else
      if self.useHeroData then
        voiceId = eVoiceType.RANKUP
      else
        voiceId = eVoiceType.GAIN
      end
    end
    local cvText = cvCtr:GetCvText(self.curHeroId, voiceId)
    ;
    ((self.ui).tex_Dialogue):DOKill(true)
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_Dialogue).text = ""
    ;
    (((self.ui).tex_Dialogue):DOText(cvText, 1.5)):SetLink(((self.ui).tex_Dialogue).gameObject)
    self.auBack_Voice = cvCtr:PlayCv(self.curHeroId, voiceId, function()
    -- function num : 0_11_0 , upvalues : self
    self.auBack_Voice = nil
  end
)
  else
    do
      ;
      ((self.ui).dialogue):SetActive(false)
      -- DECOMPILER ERROR at PC73: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).ui_timeline).time = 0
      ;
      ((self.ui).ui_timeline):Play()
      self:_ReturnMovie()
      for i = 0, (self.allTweens).Length - 1 do
        local tween = (self.allTweens)[i]
        tween:DOPause()
        tween:DORewind()
        tween:DOPlay()
      end
    end
  end
end

UIGetHero.CheckIsTweening = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if not IsNull(self.allTweens) then
    for i = 0, (self.allTweens).Length - 1 do
      local tween = ((self.allTweens)[i]).tween
      local loopNum = tween:Loops()
      if loopNum ~= -1 then
        local isPlaying = tween:IsPlaying()
        if isPlaying then
          return true
        end
      end
    end
  end
  do
    return false
  end
end

UIGetHero.GotoTweenAnimation = function(self, rate, keepPlay)
  -- function num : 0_13 , upvalues : _ENV
  self:_StopAllAudio()
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  if ((self.ui).ui_timeline).time < 2.5 then
    ((self.ui).ui_timeline).time = 2.5
  end
  if not IsNull(self.allTweens) then
    for i = 0, (self.allTweens).Length - 1 do
      local tween = ((self.allTweens)[i]).tween
      local loopNum = tween:Loops()
      if loopNum ~= -1 then
        local duration = tween:Duration()
        local elapsed = tween:Elapsed()
        if elapsed < duration * rate then
          tween:SetDelay(0)
          tween:Goto(duration * rate, keepPlay)
        end
      end
    end
  end
end

UIGetHero.ShowStars = function(self, num)
  -- function num : 0_14 , upvalues : _ENV
  for _,starGo in ipairs((self.ui).ui_starList) do
    (starGo.gameObject):SetActive(false)
  end
  local count = (math.ceil)(num / 2)
  local isHalf = num % 2 == 1
  for i = 1, count do
    local item = ((self.ui).ui_starList)[i]
    if item ~= nil then
      (item.gameObject):SetActive(true)
      item:SetIndex(0)
    end
  end
  if isHalf then
    (((self.ui).ui_starList)[count]):SetIndex(1)
  end
  self.starCount = count
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UIGetHero.ShowTags = function(self, tagList)
  -- function num : 0_15 , upvalues : _ENV
  for _,starGo in ipairs(self.TagList) do
    starGo:SetActive(false)
  end
  for index,tagId in ipairs(tagList) do
    if (self.TagList)[index] ~= nil then
      ((self.TagList)[index]):SetActive(true)
      local textItemInfo = ((self.TagList)[index]):GetComponentInChildren(typeof(CS.UiTextItemInfo))
      textItemInfo:SetIndex(tagId)
      local imgItem = ((self.TagList)[index]):GetComponentsInChildren(typeof(((CS.UnityEngine).UI).Image))
      local spriteName = eHeroShowTag[tagId]
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R10 in 'UnsetPending'

      ;
      (imgItem[1]).sprite = CRH:GetSprite(spriteName)
    else
      do
        local item = ((self.ui).tagItem):Instantiate()
        local textItemInfo = item:GetComponentInChildren(typeof(CS.UiTextItemInfo))
        local imgItem = item:GetComponentsInChildren(typeof(((CS.UnityEngine).UI).Image))
        ;
        (table.insert)(self.TagList, item)
        textItemInfo:SetIndex(tagId)
        do
          local spriteName = eHeroShowTag[tagId]
          -- DECOMPILER ERROR at PC85: Confused about usage of register: R11 in 'UnsetPending'

          ;
          (imgItem[1]).sprite = CRH:GetSprite(spriteName)
          -- DECOMPILER ERROR at PC86: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC86: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC86: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

UIGetHero._OnCamZoomOut = function(self)
  -- function num : 0_16 , upvalues : _ENV
  if self.withGetHeroSound then
    local audioId = nil
    if self.starCount == 1 then
      audioId = 1020
    else
      if self.starCount == 2 then
        audioId = 1021
      else
        if self.starCount == 3 then
          audioId = 1022
        end
      end
    end
    self.auBack_ShowHero = AudioManager:PlayAudioById(audioId, function()
    -- function num : 0_16_0 , upvalues : self
    self.auBack_ShowHero = nil
  end
)
  end
end

UIGetHero._OnConvertTween = function(self)
  -- function num : 0_17 , upvalues : cs_DoTween, _ENV
  if #(self.cardConvertItemPool).listItem == 0 then
    return 
  end
  if self.convertSeq ~= nil then
    (self.convertSeq):Rewind(true)
    ;
    (self.convertSeq):Kill(true)
    self.convertSeq = nil
  end
  local sequence = (cs_DoTween.Sequence)()
  local deplay = 0
  for index,item in ipairs((self.cardConvertItemPool).listItem) do
    do
      deplay = (index - 1) * 0.15
      item:Show()
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((item.transform).anchoredPosition).x = 0
      sequence:Insert(0, ((((item.ui).tran_tween):DOAnchorPosX(((item.transform).anchoredPosition).x + 510, 0.45)):From()):SetDelay(deplay))
      sequence:Insert(0, ((((item.ui).fade_tween):DOFade(0, 0.45)):From()):SetDelay(deplay))
      sequence:AppendCallback(function()
    -- function num : 0_17_0 , upvalues : item, _ENV
    if (item.ui).FxArr ~= nil then
      for _,go in ipairs((item.ui).FxArr) do
        go:SetActive(true)
      end
    end
  end
)
    end
  end
  self.convertSeq = sequence
end

UIGetHero._OnStarVoice = function(self, starNum)
  -- function num : 0_18 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  if starNum <= self.starCount then
    (self.auBack_StarDic)[starNum] = AudioManager:PlayAudioById(1110, function()
    -- function num : 0_18_0 , upvalues : self, starNum
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    (self.auBack_StarDic)[starNum] = nil
  end
)
  end
end

UIGetHero._StopAllAudio = function(self)
  -- function num : 0_19 , upvalues : _ENV
  for k,auBack in pairs(self.auBack_StarDic) do
    AudioManager:StopAudioByBack(auBack)
  end
  self.auBack_StarDic = {}
  if self.auBack_ShowHero ~= nil then
    AudioManager:StopAudioByBack(self.auBack_ShowHero)
    self.auBack_ShowHero = nil
  end
end

UIGetHero._StopHeroVoice = function(self)
  -- function num : 0_20 , upvalues : _ENV
  if self.auBack_Voice ~= nil then
    AudioManager:StopAudioByBack(self.auBack_Voice)
    self.auBack_Voice = nil
  end
end

UIGetHero._StopCampAudio = function(self)
  -- function num : 0_21 , upvalues : _ENV
  if self.auBack_camp ~= nil then
    AudioManager:StopAudioByBack(self.auBack_camp)
    self.auBack_camp = nil
  end
end

UIGetHero.OnClickClose = function(self)
  -- function num : 0_22 , upvalues : m_moviePlayer, cs_PlayState
  if m_moviePlayer ~= nil then
    return 
  end
  if not self.isNew then
    if not self.isSkipAllTween and not self:CheckIsTweening() then
      self:GotoTweenAnimation(0.4, true)
      self.isSkipAllTween = true
      return 
    else
      self.isSkipAllTween = false
    end
  else
    if self:CheckIsTweening() or ((self.ui).ui_timeline).state == cs_PlayState.Playing then
      return 
    end
  end
  self:_TryShowNext()
end

UIGetHero.OnClickSkip = function(self)
  -- function num : 0_23 , upvalues : eSkipMode
  if self.skipMode ~= eSkipMode.SkipOldHero or self.skipMode == eSkipMode.None then
    self.skipMode = eSkipMode.SkipOldHero
    self:_TryShowNext()
  end
end

UIGetHero._OnComplete = function(self)
  -- function num : 0_24
  if self.closeFunc ~= nil then
    local func = self.closeFunc
    self.closeFunc = nil
    func()
  else
    do
      self:Delete()
    end
  end
end

UIGetHero._ReturnMovie = function(self)
  -- function num : 0_25 , upvalues : _ENV, m_moviePlayer, cs_MovieManager
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).img_movie_bg).color = (Color.New)(0, 0, 0, 0)
  if m_moviePlayer ~= nil then
    cs_MovieManager:ReturnMoviePlayer(m_moviePlayer)
    m_moviePlayer = nil
  end
end

UIGetHero.SetCloseFunction = function(self, closeFunc)
  -- function num : 0_26
  self.closeFunc = closeFunc
end

UIGetHero.OnDelete = function(self)
  -- function num : 0_27 , upvalues : _ENV, base
  self:_ReturnMovie()
  self:_StopAllAudio()
  self:_StopCampAudio()
  self:_StopHeroVoice()
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  if self.__initCoroutine ~= nil then
    (GR.StopCoroutine)(self.__initCoroutine)
  end
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (UIManager.UICamera).fieldOfView = 30
  if self.convertSeq ~= nil then
    (self.convertSeq):Rewind()
    ;
    (self.convertSeq):Kill()
    self.convertSeq = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIGetHero


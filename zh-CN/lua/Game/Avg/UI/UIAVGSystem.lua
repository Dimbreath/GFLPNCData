local UIAVGSystem = class("UIAVGSystem", UIBaseWindow)
local base = UIBaseWindow
local UINAvgDialog = require("Game.Avg.UI.UINAvgDialog")
local UINAvgChapter = require("Game.Avg.UI.UINAvgChapter")
local UINAvgChoose = require("Game.Avg.UI.UINAvgChoose")
local UINAvgRecord = require("Game.Avg.UI.UINAvgRecord")
local UINAvgImgItem = require("Game.Avg.UI.UINAvgImgItem")
local UINAvgHeroPic = require("Game.Avg.UI.UINAvgHeroPic")
local UINAvgVideoNode = require("Game.Avg.UI.UINAvgVideoNode")
local UINAvgEffectNode = require("Game.Avg.UI.Effect.UINAvgEffectNode")
local UINAvgHeroCommItem = require("Game.Avg.UI.UINAvgHeroCommItem")
local AvgPostProcess = require("Game.Avg.AvgPostProcess")
local eAvgImgType = require("Game.Avg.Enum.eAvgImgType")
local eAvgImgPosType = require("Game.Avg.Enum.eAvgImgPosType")
local eAvgDialogPosX = require("Game.Avg.Enum.eAvgDialogPosX")
local eAvgContentType = require("Game.Avg.Enum.eAvgContentType")
local CS_MessageCommon = CS.MessageCommon
local CS_Object = (CS.UnityEngine).Object
local CS_DoTween = ((CS.DG).Tweening).DOTween
local CS_Material = (CS.UnityEngine).Material
local defaultScreenRatio = 1.7777777777778
local imgMaxCount = 10
local eBgColor = {[1] = Color.clear, [2] = Color.black, [3] = Color.white}
local LongPressSpeed = {TwoSpeed = 0, FourSpeed = 0, EightSpeed = 0, SixteenSpeed = 0}
local SliderInterval = 43
UIAVGSystem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINAvgImgItem
  (UIUtil.AddButtonListener)((self.ui).btn_ShwoLogList, self, self.OnClickShwoLogList)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Skip, self, self.OnClickSkip)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_AutoPlay, self, self.OnClickAutoPlay)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_HideUI, self, self.OnClickHideUI)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ReShowUI, self, self.OnClickReShowUI)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_bg, self, self._OnClickBackground)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_AvgNoun, self, self.OnClickAvgNoun)
  self:InitAvgLongPressAndDrag()
  ;
  (((self.ui).btn_ReShowUI).gameObject):SetActive(false)
  ;
  ((self.ui).imgItem):SetActive(false)
  ;
  ((self.ui).heroItem):SetActive(false)
  ;
  ((self.ui).communication):SetActive(false)
  -- DECOMPILER ERROR at PC76: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_bg).color = Color.clear
  self.imgItemPool = (UIItemPool.New)(UINAvgImgItem, (self.ui).imgItem)
  self.distantViewImgDic = {}
  self.bgImgDic = {}
  self.foregroundImgDic = {}
  self.heroPicDic = {}
  self.audioBackDic = {}
  self.imgCount = 0
  self.__onAvgImgTweenComplete = BindCallback(self, self.OnAvgImgTweenComplete)
  self._OnAvgNounClose = BindCallback(self, self.OnAvgNounClose)
  self.isend = false
end

UIAVGSystem.InitAvgLongPressAndDrag = function(self)
  -- function num : 0_1 , upvalues : _ENV, LongPressSpeed
  (((self.ui).btn_bg).onPress):AddListener(BindCallback(self, self.OnLongPressBackground))
  ;
  (((self.ui).btn_bg).OnFirstExcute):AddListener(BindCallback(self, self.OnFirstExcute))
  ;
  (((self.ui).btn_bg).OnDragEvent):AddListener(BindCallback(self, self.OnDragEvent))
  ;
  (((self.ui).btn_bg).onPressUp):AddListener(BindCallback(self, self.OnPressUpEvent))
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).btn_bg).responseOnceByPress = false
  self.LastIndex = 0
  self.CurIndex = 0
  self.CurChildIndex = 0
  LongPressSpeed.TwoSpeed = ((self.ui).btn_bg).pressRepeatInterval
  LongPressSpeed.FourSpeed = LongPressSpeed.TwoSpeed / 2
  LongPressSpeed.EightSpeed = LongPressSpeed.FourSpeed / 2
  LongPressSpeed.SixteenSpeed = LongPressSpeed.EightSpeed / 2
end

UIAVGSystem.InitAvgSystem = function(self, avgCtrl)
  -- function num : 0_2 , upvalues : _ENV, UINAvgChapter, UINAvgDialog, UINAvgChoose, UINAvgEffectNode, UINAvgRecord, UINAvgVideoNode, AvgPostProcess
  local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeWin ~= nil and (ControllerManager:GetController(ControllerTypeId.HomeController)):IsNormalState() then
    self._needChangeHomeState = true
    homeWin:OpenOtherCoverWin()
  end
  self.avgCtrl = avgCtrl
  local autoPlay, delayRatio = (self.avgCtrl):GetAvgAutoPlayMode()
  self:RefreshAutoPlay(autoPlay, delayRatio)
  self.chapterNode = (UINAvgChapter.New)(self)
  ;
  (self.chapterNode):Init((self.ui).chapter)
  self.dialogNode = (UINAvgDialog.New)(self)
  ;
  (self.dialogNode):Init((self.ui).dialog)
  self.chooseNode = (UINAvgChoose.New)(self)
  ;
  (self.chooseNode):Init((self.ui).chooseNode)
  ;
  (self.chooseNode):Hide()
  self.effectNode = (UINAvgEffectNode.New)()
  ;
  (self.effectNode):Init((self.ui).effectNode)
  self.recordNode = (UINAvgRecord.New)(self)
  ;
  (self.recordNode):Init((self.ui).recordNode)
  self.videoNode = (UINAvgVideoNode.New)(self)
  ;
  (self.videoNode):Init((self.ui).videoNode)
  ;
  (self.videoNode):Hide()
  self.avgPP = (AvgPostProcess.New)(self)
  ;
  (self.avgPP):InitAvgPP((self.ui).ppProfile)
  self:__UpdateBlackEdge()
  self._uiCamHdr = (UIManager.UICamera).allowHDR
  -- DECOMPILER ERROR at PC103: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (UIManager.UICamera).allowHDR = true
end

UIAVGSystem.__UpdateBlackEdge = function(self)
  -- function num : 0_3 , upvalues : _ENV, defaultScreenRatio
  local curRatio = (UIManager.UICamera).aspect
  local needEdge = curRatio < defaultScreenRatio
  ;
  ((self.ui).blackEdge):SetActive(needEdge)
  if not needEdge then
    return 
  end
  local height = (UIManager.BackgroundStretchSize).x / defaultScreenRatio
  local extraHeight = ((UIManager.BackgroundStretchSize).y - height) / 2
  local sizeDelta = ((self.ui).blackEdge_Top).sizeDelta
  sizeDelta.y = extraHeight
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).blackEdge_Top).sizeDelta = sizeDelta
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).blackEdge_Bottom).sizeDelta = sizeDelta
  ;
  (self.dialogNode):SetAvgDialogBottom(extraHeight)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIAVGSystem.PlayAvgAct = function(self, actCfg)
  -- function num : 0_4 , upvalues : _ENV
  if actCfg == nil then
    (self.avgCtrl):AvgLogError("Cant get actCfg")
    return 
  end
  self.actCfg = actCfg
  ;
  (self.chapterNode):Hide()
  ;
  (self.dialogNode):Hide()
  ;
  (self.chooseNode):HideAvgChoose()
  self.jumpAct = nil
  self.jumpChapter = nil
  self.skipTween = false
  self:_ChangeBgColor()
  self:PlayAvgAudio()
  self:RefreshAvgImg(actCfg.images)
  self:RefreshHeroFace(actCfg.heroFace)
  self.hasImgTween = actCfg.imgTween ~= nil and (table.count)(actCfg.imgTween) > 0
  self.hasContent = actCfg.content ~= nil
  self.hasBranch = actCfg.branch ~= nil and (table.count)(actCfg.branch) > 0
  self.hasVideo = actCfg.vedioPath ~= nil
  self.hasPPVTween = actCfg.ppv ~= nil
  ;
  (self.avgPP):ChangeAvgPP(actCfg.ppv)
  ;
  (self.effectNode):PlayAvgEffect(actCfg.effect)
  self:DoCustomCode()
  self.contentLenth = 0
  self:PlayAvgOrder()
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

UIAVGSystem._ChangeBgColor = function(self)
  -- function num : 0_5 , upvalues : eBgColor, _ENV
  local actCfg = self.actCfg
  if actCfg.bgColor ~= nil then
    local color = eBgColor[actCfg.bgColor]
    if color == nil then
      (self.avgCtrl):AvgLogError("[Avg] bgColor error, bgColor = " .. tostring(actCfg.bgColor))
      return 
    end
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_bg).color = color
  end
end

UIAVGSystem.PlayAvgOrder = function(self)
  -- function num : 0_6
  if self.hasPPVTween then
    self:PlayAvgVideoLoopBg()
    return 
  end
  if self.hasImgTween then
    self:RefreshAvgImgTween((self.actCfg).imgTween)
    return 
  end
  if self.hasContent then
    self:ShowAvgContent()
    return 
  end
  if self.hasBranch then
    (self.chooseNode):ShowAvgChoose((self.actCfg).branch)
    return 
  end
  if self.hasVideo then
    self:PlayAvgVideo()
    return 
  end
  if self:CheckActComplete() then
    return 
  end
  if (self.actCfg).autoContinue and not (self.avgCtrl):GetAvgAutoPlayMode() then
    (self.avgCtrl):ClickContinueAvg()
  end
end

UIAVGSystem.CheckActComplete = function(self)
  -- function num : 0_7
  if self.hasContent or self.voiceIsPlaying or self.hasVideo or self.hasBranch or self.hasPPVTween or self.hasImgTween then
    return false
  end
  return (self.avgCtrl):OnAvgActComplete(self.selectBranchIndex, self.jumpAct, self.jumpChapter, self.contentLenth)
end

UIAVGSystem.GetAvgSpeakerName = function(self, heroId)
  -- function num : 0_8 , upvalues : _ENV
  if heroId == -1 then
    return heroId
  end
  local heroCfg = (ConfigData.avg_character)[heroId]
  if heroCfg == nil then
    warn("Can\'t find avg_character cfg, speakerHeroId = " .. tostring(heroId))
    return 
  end
  return (LanguageUtil.GetLocaleText)(heroCfg.name)
end

UIAVGSystem.ShowAvgContent = function(self)
  -- function num : 0_9 , upvalues : eAvgContentType, eAvgImgPosType, _ENV, eAvgDialogPosX, CS_MessageCommon
  local actCfg = self.actCfg
  local content = (self.avgCtrl):GetAvgLanguage(actCfg.content)
  if actCfg.contentType == eAvgContentType.Chapter then
    (self.chapterNode):ShowAvgChapter(content, actCfg.contentShake, self.skipTween, actCfg.scrambleTypeWriter)
  else
    if actCfg.contentType == eAvgContentType.Narratage then
      (self.dialogNode):ShowAvgDialog(content, actCfg.contentShake, self.skipTween, actCfg.scrambleTypeWriter, nil, true)
    else
      if actCfg.contentType == eAvgContentType.NarratageWithSpeaker then
        local speakerName = (self.avgCtrl):GetAvgLanguage(actCfg.speakerName)
        ;
        (self.dialogNode):ShowAvgDialog(content, actCfg.contentShake, self.skipTween, actCfg.scrambleTypeWriter, speakerName, true)
      else
        do
          if not actCfg.speakerHeroPosId then
            local posId = actCfg.contentType ~= eAvgContentType.HeroDialog or 2
          end
          if eAvgImgPosType[posId] == nil then
            posId = 2
            ;
            (self.avgCtrl):AvgLogError("speakerHeroPosId error, id = " .. tostring(actCfg.speakerHeroPosId))
            return 
          end
          do
            local posX = eAvgDialogPosX[posId]
            ;
            (self.dialogNode):ShowAvgDialog(content, actCfg.contentShake, self.skipTween, actCfg.scrambleTypeWriter, self:GetAvgSpeakerName(actCfg.speakerHeroId), false, posX)
            if not actCfg.tipsShowDuration then
              (CS_MessageCommon.ShowMessageTips)(content, true, actCfg.contentType ~= eAvgContentType.Tips or 0, actCfg.tipsTypeWriter)
              self:ShowTextComplete()
              ;
              (self.avgCtrl):AvgLogError((string.format)("Avg contentType error, contentType:%s", actCfg.contentType))
              do return  end
              self:PlayAvgVoice()
            end
          end
        end
      end
    end
  end
end

UIAVGSystem.ShowTextComplete = function(self, contentLenth)
  -- function num : 0_10
  self.hasContent = false
  self.contentLenth = contentLenth or 0
  self:PlayAvgOrder()
end

UIAVGSystem.DoCustomCode = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if (string.IsNullOrEmpty)((self.actCfg).customCode) then
    return 
  end
  local code = load((self.actCfg).customCode)
  if code == nil then
    return 
  end
  local status, current = xpcall(code, debug.traceback)
  if not status then
    error(current)
  end
end

UIAVGSystem.PlayAvgVideo = function(self)
  -- function num : 0_12
  (self.videoNode):PlayAvgVideo((self.actCfg).vedioPath, (self.actCfg).vedioAudio)
end

UIAVGSystem.PlayAvgVideoComplete = function(self)
  -- function num : 0_13
  self.hasVideo = false
  self:PlayAvgOrder()
end

UIAVGSystem.PlayAvgVideoLoopBg = function(self)
  -- function num : 0_14
  if (self.actCfg).vedioLoopPath ~= nil then
    (self.videoNode):PlayAvgVideoLoop((self.actCfg).vedioLoopPath, (self.actCfg).vedioLoopFrame)
  else
    if (self.actCfg).vedioLoopFrame ~= nil then
      (self.videoNode):SetAvgVideoLoop((self.actCfg).vedioLoopFrame)
    end
  end
  if (self.actCfg).vedioLoopStop then
    (self.videoNode):StopAvgVideoLoop()
  end
end

UIAVGSystem.PlayAvgAudio = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if (self.actCfg).audio == nil then
    return 
  end
  local audioCfg = (self.actCfg).audio
  if audioCfg.bgm ~= nil then
    if (audioCfg.bgm).stop then
      AudioManager:StopSource(eAudioSourceType.BgmSource)
    else
      local fadeInTime, fadeOutTime = nil, nil
      if (audioCfg.bgm).fadeIn ~= nil then
        fadeInTime = (audioCfg.bgm).fadeIn * 1000
      end
      if (audioCfg.bgm).fadeOut ~= nil then
        fadeOutTime = (audioCfg.bgm).fadeOut * 1000
      end
      AudioManager:SetBgmSourceFadeInAndOutTime(fadeInTime, fadeOutTime)
      AudioManager:PlayAudio((audioCfg.bgm).cue, (audioCfg.bgm).sheet, eAudioSourceType.BgmSource)
    end
  end
  do
    do
      if audioCfg.sfx ~= nil then
        local auBack = AudioManager:PlayAudio((audioCfg.sfx).cue, (audioCfg.sfx).sheet, eAudioSourceType.SfxSource)
        ;
        (self.avgCtrl):RecordAvgAudioSheet((audioCfg.sfx).sheet)
        -- DECOMPILER ERROR at PC73: Confused about usage of register: R3 in 'UnsetPending'

        if (audioCfg.sfx).audioId ~= nil then
          (self.audioBackDic)[(audioCfg.sfx).audioId] = auBack
        end
      end
      if audioCfg.stopAudioId ~= nil then
        for k,id in ipairs(audioCfg.stopAudioId) do
          local auBack = (self.audioBackDic)[id]
          if auBack == nil then
            warn("[avg] stopAudioId is invalid, id : " .. tostring(id))
          else
            AudioManager:StopAudioByBack(auBack)
            -- DECOMPILER ERROR at PC98: Confused about usage of register: R8 in 'UnsetPending'

            ;
            (self.audioBackDic)[id] = nil
          end
        end
      end
    end
  end
end

UIAVGSystem.PlayAvgVoice = function(self)
  -- function num : 0_16 , upvalues : _ENV
  if (self.actCfg).audio == nil then
    return 
  end
  local audioCfg = (self.actCfg).audio
  self.voiceIsPlaying = false
  if audioCfg.voice ~= nil then
    self.voiceIsPlaying = true
    if self.__onAudioPlayComplete == nil then
      self.__onAudioPlayComplete = BindCallback(self, self.AudioPlayComplete)
    end
    local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
    cvCtr:PlayCv((audioCfg.voice).heroId, (audioCfg.voice).voiceId, self.__onAudioPlayComplete)
  end
end

UIAVGSystem.AudioPlayComplete = function(self)
  -- function num : 0_17
  self.voiceIsPlaying = false
  self:CheckActComplete()
end

UIAVGSystem.StopAvgVoice = function(self)
  -- function num : 0_18 , upvalues : _ENV
  if self.voiceIsPlaying then
    AudioManager:StopSource(eAudioSourceType.VoiceSource)
    self.voiceIsPlaying = false
  end
end

UIAVGSystem.BranchChooseComplete = function(self, index, jumpAct, jumpChapter)
  -- function num : 0_19
  self.selectBranchIndex = index
  self.jumpAct = jumpAct
  self.jumpChapter = jumpChapter
  self.hasBranch = false
  self:StopAvgVoice()
  self:PlayAvgOrder()
end

UIAVGSystem.RefreshAvgImg = function(self, imgCfgList)
  -- function num : 0_20 , upvalues : _ENV
  if imgCfgList == nil then
    return 
  end
  for k,v in ipairs(imgCfgList) do
    if v.delete then
      self:RecycleImgItem(v.imgId)
    end
  end
  self.imgNeedSort = {}
  for k,v in ipairs(imgCfgList) do
    if not v.delete then
      self:NewImgItem(v)
    end
  end
  self:SortAvtImgItem()
  ;
  (((self.ui).heroesNode).gameObject):SetActive((table.count)(self.heroPicDic) > 0)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIAVGSystem.NewImgItem = function(self, imgCfg)
  -- function num : 0_21 , upvalues : eAvgImgType, UINAvgHeroPic, _ENV, imgMaxCount
  local imgId = imgCfg.imgId
  local imgType = imgCfg.imgType
  local imgItem = nil
  if imgType == eAvgImgType.Background then
    imgItem = (self.bgImgDic)[imgId]
    if imgItem == nil then
      imgItem = (self.imgItemPool):GetOne()
      -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self.bgImgDic)[imgId] = imgItem
    end
    imgItem:InitAvgImgItem(imgCfg, (self.ui).background, self.__onAvgImgTweenComplete)
  else
    if imgType == eAvgImgType.Character then
      imgItem = (self.heroPicDic)[imgId]
      if imgItem == nil then
        imgItem = (UINAvgHeroPic.New)()
        -- DECOMPILER ERROR at PC34: Confused about usage of register: R5 in 'UnsetPending'

        ;
        (self.heroPicDic)[imgId] = imgItem
      end
      imgItem:InitAvgHeroPic(imgCfg, (self.ui).heroItem, self.__onAvgImgTweenComplete)
    else
      if imgType == eAvgImgType.Foreground then
        imgItem = (self.foregroundImgDic)[imgId]
        if imgItem == nil then
          imgItem = (self.imgItemPool):GetOne()
          -- DECOMPILER ERROR at PC54: Confused about usage of register: R5 in 'UnsetPending'

          ;
          (self.foregroundImgDic)[imgId] = imgItem
        end
        imgItem:InitAvgImgItem(imgCfg, (self.ui).foreground, self.__onAvgImgTweenComplete)
      else
        if imgType == eAvgImgType.DistantView or imgType == eAvgImgType.Movie then
          imgItem = (self.distantViewImgDic)[imgId]
          if imgItem == nil then
            imgItem = (self.imgItemPool):GetOne()
            -- DECOMPILER ERROR at PC77: Confused about usage of register: R5 in 'UnsetPending'

            ;
            (self.distantViewImgDic)[imgId] = imgItem
          end
          imgItem:InitAvgImgItem(imgCfg, (self.ui).distantView, self.__onAvgImgTweenComplete)
        else
          local imgItem = self:GetImgItem(imgId, true)
          if imgItem == nil then
            local actId = (self.avgCtrl):GetCurActId()
            local chapterName = (self.avgCtrl):GetCurChapterName()
            warn((string.format)("Unsupported avg imgType, imgType = %s, imgId = %s, actId = %s, chapterName = %s", imgType, imgId, actId, chapterName))
            return 
          else
            do
              do
                if imgCfg.order ~= nil then
                  imgType = imgItem:GetAvgImgType()
                  imgItem:ChangeAvgImgOrder(imgCfg.order)
                  -- DECOMPILER ERROR at PC119: Confused about usage of register: R6 in 'UnsetPending'

                  ;
                  (self.imgNeedSort)[imgType] = true
                  return 
                end
                -- DECOMPILER ERROR at PC122: Confused about usage of register: R5 in 'UnsetPending'

                ;
                (self.imgNeedSort)[imgType] = true
                self.imgCount = self.imgCount + 1
                if imgMaxCount < self.imgCount then
                  warn("Avg image count is beyond limit, imgCount = " .. tostring(self.imgCount))
                end
              end
            end
          end
        end
      end
    end
  end
end

UIAVGSystem.RecycleImgItem = function(self, imgId)
  -- function num : 0_22 , upvalues : _ENV
  local imgItem = nil
  if (self.bgImgDic)[imgId] ~= nil then
    imgItem = (self.bgImgDic)[imgId]
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.bgImgDic)[imgId] = nil
    ;
    (self.imgItemPool):HideOne(imgItem)
  else
    if (self.heroPicDic)[imgId] ~= nil then
      imgItem = (self.heroPicDic)[imgId]
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self.heroPicDic)[imgId] = nil
      imgItem:Delete()
    else
      if (self.foregroundImgDic)[imgId] ~= nil then
        imgItem = (self.foregroundImgDic)[imgId]
        -- DECOMPILER ERROR at PC32: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (self.foregroundImgDic)[imgId] = nil
        ;
        (self.imgItemPool):HideOne(imgItem)
      else
        if (self.distantViewImgDic)[imgId] ~= nil then
          imgItem = (self.distantViewImgDic)[imgId]
          -- DECOMPILER ERROR at PC45: Confused about usage of register: R3 in 'UnsetPending'

          ;
          (self.distantViewImgDic)[imgId] = nil
          ;
          (self.imgItemPool):HideOne(imgItem)
        else
          warn("Can\'t find avg img to delete, imgId = " .. tostring(imgId))
          return 
        end
      end
    end
  end
  self.imgCount = self.imgCount - 1
end

UIAVGSystem.GetImgItem = function(self, imgId, withoutWarn)
  -- function num : 0_23 , upvalues : _ENV
  local imgItem = nil
  if (self.bgImgDic)[imgId] ~= nil then
    imgItem = (self.bgImgDic)[imgId]
  else
    if (self.heroPicDic)[imgId] ~= nil then
      imgItem = (self.heroPicDic)[imgId]
    else
      if (self.foregroundImgDic)[imgId] ~= nil then
        imgItem = (self.foregroundImgDic)[imgId]
      else
        if (self.distantViewImgDic)[imgId] ~= nil then
          imgItem = (self.distantViewImgDic)[imgId]
        else
          if not withoutWarn then
            warn("Can\'t find avg img item, imgId = " .. tostring(imgId))
            return 
          end
        end
      end
    end
  end
  return imgItem
end

UIAVGSystem.SortAvtImgItem = function(self)
  -- function num : 0_24 , upvalues : _ENV, eAvgImgType
  for imgType,v in pairs(self.imgNeedSort) do
    local targetDic = nil
    if imgType == eAvgImgType.Background then
      targetDic = self.bgImgDic
    else
      if imgType == eAvgImgType.Character then
        targetDic = self.heroPicDic
      else
        if imgType == eAvgImgType.Foreground then
          targetDic = self.foregroundImgDic
        else
          if imgType == eAvgImgType.DistantView or imgType == eAvgImgType.Movie then
            targetDic = self.distantViewImgDic
          end
        end
      end
    end
    if targetDic ~= nil then
      local imgItemList = {}
      for k,v in pairs(targetDic) do
        (table.insert)(imgItemList, v)
      end
      ;
      (table.sort)(imgItemList, function(a, b)
    -- function num : 0_24_0
    do return a:GetAvgImgOrder() < b:GetAvgImgOrder() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
      for k,v in ipairs(imgItemList) do
        (v.transform):SetAsLastSibling()
      end
    end
  end
end

UIAVGSystem.RefreshAvgImgTween = function(self, tweenCfgList)
  -- function num : 0_25 , upvalues : _ENV
  if tweenCfgList == nil then
    return 
  end
  self.tweenImgItemDic = {}
  for k,tweenCfg in ipairs(tweenCfgList) do
    local imgId = tweenCfg.imgId
    local imgItem = self:GetImgItem(imgId)
    if imgItem ~= nil then
      imgItem:AddAvgImgTween(tweenCfg)
      -- DECOMPILER ERROR at PC19: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.tweenImgItemDic)[imgId] = imgItem
    end
  end
  for k,v in pairs(self.tweenImgItemDic) do
    v:PlayAvgImgTween()
  end
end

UIAVGSystem.OnAvgImgTweenComplete = function(self, imgId)
  -- function num : 0_26 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.tweenImgItemDic)[imgId] = nil
  if (table.count)(self.tweenImgItemDic) == 0 then
    self.hasImgTween = false
    self:PlayAvgOrder()
  end
end

UIAVGSystem.OnAvgPPVTweenComplete = function(self)
  -- function num : 0_27
  if self.hasPPVTween then
    self.hasPPVTween = false
    self:PlayAvgOrder()
  end
end

UIAVGSystem.SetTopControlActive = function(self, active)
  -- function num : 0_28
  ((self.ui).topNode):SetActive(active)
end

UIAVGSystem.RefreshHeroFace = function(self, faceCfg)
  -- function num : 0_29 , upvalues : _ENV
  if faceCfg == nil then
    return 
  end
  for k,cfg in ipairs(faceCfg) do
    local imgItem = (self.heroPicDic)[cfg.imgId]
    if imgItem == nil then
      (self.avgCtrl):AvgLogError("Cant get heroPicItem, imgId = " .. tostring(cfg.imgId))
    else
      imgItem:AvgHeroChangeFace(cfg.faceId)
    end
  end
end

UIAVGSystem.OnClickShwoLogList = function(self)
  -- function num : 0_30
  self.__lastAutoPlay = (self.avgCtrl):GetAvgAutoPlayMode()
  if self.__lastAutoPlay then
    (self.avgCtrl):SetAvgAutoPlayMode(false)
  end
  ;
  (self.recordNode):ShowAcgRecord((self.avgCtrl):GetAvgRecordData())
end

UIAVGSystem.OnAvgRecordClose = function(self)
  -- function num : 0_31
  if self.__lastAutoPlay then
    (self.avgCtrl):SetAvgAutoPlayMode(true, self.__lastDelayRatio)
  end
end

UIAVGSystem.OnClickAutoPlay = function(self)
  -- function num : 0_32
  local autoPlay, delayRatio = (self.avgCtrl):SwitchAvgAutoPlay()
  self:RefreshAutoPlay(autoPlay, delayRatio)
end

UIAVGSystem.OnClickHideUI = function(self)
  -- function num : 0_33
  (((self.ui).btn_ReShowUI).gameObject):SetActive(true)
  local autoPlay, delayRatio = (self.avgCtrl):CloseAvgAutoPlayMode()
  self:RefreshAutoPlay(autoPlay, delayRatio)
  ;
  (self.dialogNode):ShowAvgUI(false)
  ;
  (self.chooseNode):ShowAvgUI(false)
  self:SetTopControlActive(false)
end

UIAVGSystem.OnClickReShowUI = function(self)
  -- function num : 0_34
  (self.dialogNode):ShowAvgUI(true)
  ;
  (self.chooseNode):ShowAvgUI(true)
  self:SetTopControlActive(true)
  ;
  (((self.ui).btn_ReShowUI).gameObject):SetActive(false)
end

UIAVGSystem.RefreshAutoPlay = function(self, autoPlay, delayRatio)
  -- function num : 0_35 , upvalues : CS_DoTween
  if self.firstAutoPlay == nil then
    self.autoIconPos = (((self.ui).img_AutoIcon).transform).position
    self.autoIconColor = ((self.ui).img_AutoIcon).color
    self.firstAutoPlay = false
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).img_AutoIcon).transform).position = self.autoIconPos
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.autoIconColor).a = 1
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_AutoIcon).color = self.autoIconColor
  local twSequence = nil
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

  if autoPlay then
    ((self.ui).fade_AutoPlay).alpha = 1
    if self.twSequence ~= nil then
      (self.twSequence):Kill()
      self.twSequence = nil
    end
    twSequence = (CS_DoTween.Sequence)()
    twSequence:Append((((self.ui).img_AutoIcon).transform):DOLocalMoveX(160, 1.2))
    twSequence:Join(((self.ui).img_AutoIcon):DOFade(0, 1.2))
    twSequence:SetLoops(-1)
    twSequence:SetUpdate(true)
    self.twSequence = twSequence
    ;
    ((self.ui).img_AutoPlayIcon):SetIndex(delayRatio == 1 and 0 or 1)
  else
    -- DECOMPILER ERROR at PC77: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).fade_AutoPlay).alpha = 0.6
    ;
    ((self.ui).img_AutoPlayIcon):SetIndex(0)
    if self.twSequence ~= nil then
      (self.twSequence):Kill()
      self.twSequence = nil
    end
  end
end

UIAVGSystem.OnClickSkip = function(self)
  -- function num : 0_36 , upvalues : _ENV, CS_MessageCommon
  local SkipTextId = (((self.avgCtrl).avgCfg)[1]).SkipScenario
  if SkipTextId ~= nil then
    UIManager:ShowWindowAsync(UIWindowTypeID.AvgSkip, function(window)
    -- function num : 0_36_0 , upvalues : SkipTextId
    if window == nil then
      return 
    end
    window:InitTextInfo(SkipTextId)
  end
)
  else
    ;
    (CS_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(TipContent.Avg_SkipAllAvg), function()
    -- function num : 0_36_1 , upvalues : self
    (self.avgCtrl):SkipAvg()
  end
, nil)
  end
end

UIAVGSystem._OnClickBackground = function(self, withoutSound)
  -- function num : 0_37 , upvalues : _ENV, eAvgContentType
  if not withoutSound then
    AudioManager:PlayAudioById(1134)
  end
  if self.hasContent or self.hasImgTween or self.hasBranch or self.hasVideo or self.hasPPVTween then
    self.skipTween = true
    if self.hasPPVTween then
      (self.avgPP):SkipAvgPPV()
    else
      if self.hasImgTween then
        local list = {}
        for k,v in pairs(self.tweenImgItemDic) do
          list[k] = v
        end
        for k,v in pairs(list) do
          v:AvgImgTweenDoComplete()
        end
      else
        do
          if self.hasContent then
            if (self.actCfg).contentType == eAvgContentType.Chapter then
              (self.chapterNode):SkipAvgContent()
            else
              ;
              (self.dialogNode):SkipAvgContent()
            end
          end
          do return  end
          ;
          (self.avgCtrl):ClickContinueAvg()
        end
      end
    end
  end
end

UIAVGSystem.OnFirstExcute = function(self)
  -- function num : 0_38 , upvalues : _ENV, LongPressSpeed
  local btnSpeed = (self.ui).btn_bg
  local mousepos = btnSpeed:GetMouseDir()
  local imgprogress = (self.ui).img_ProgressBar
  local calctime = btnSpeed:GetCalcTime()
  local totaltime = btnSpeed.pressDurationTime - btnSpeed.ProgressAppearTime
  if calctime / totaltime <= 1 or not 1 then
    local progress = calctime / totaltime
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R7 in 'UnsetPending'

  if mousepos == 0 then
    (((self.ui).obj_SpeedUp).transform).localPosition = (Vector3.New)(741.2, 0, 0)
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (((self.ui).obj_timescale).transform).localPosition = (Vector3.New)(739, -11.6, 0)
  else
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R7 in 'UnsetPending'

    if mousepos == 1 then
      (((self.ui).obj_SpeedUp).transform).localPosition = (Vector3.New)(-856.2, 0, 0)
      -- DECOMPILER ERROR at PC62: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (((self.ui).obj_timescale).transform).localPosition = (Vector3.New)(-856.2, -11.6, 0)
    end
  end
  ;
  ((self.ui).obj_SpeedUp):SetActive(true)
  imgprogress.fillAmount = progress
  if progress == 1 then
    ((self.ui).obj_SpeedUp):SetActive(false)
    ;
    ((self.ui).obj_timescale):SetActive(true)
    -- DECOMPILER ERROR at PC83: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).Canvas_Dialog).blocksRaycasts = false
    local playspeed = (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):GetAvgplayspeed()
    if playspeed == 0 or playspeed == nil then
      btnSpeed.pressRepeatInterval = LongPressSpeed.TwoSpeed
      self.CurIndex = self:GetChildIndex(LongPressSpeed.TwoSpeed)
      self.CurChildIndex = self:GetChildIndex(LongPressSpeed.TwoSpeed)
      self:SetTImeScale()
    else
      btnSpeed.pressRepeatInterval = playspeed
      self.CurIndex = self:GetChildIndex(playspeed)
      self.CurChildIndex = self:GetChildIndex(playspeed)
      self:SetTImeScale()
    end
  end
end

UIAVGSystem.OnLongPressBackground = function(self)
  -- function num : 0_39
  self:_OnClickBackground(true)
end

UIAVGSystem.OnClickAvgNoun = function(self)
  -- function num : 0_40 , upvalues : _ENV
  self.__lastAutoPlay = (self.avgCtrl):GetAvgAutoPlayMode()
  if self.__lastAutoPlay then
    (self.avgCtrl):SetAvgAutoPlayMode(false)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.AvgNounDes, function(window)
    -- function num : 0_40_0 , upvalues : self
    if window == nil then
      return 
    end
    window:InitAvgNounDes(nil, nil, self._OnAvgNounClose)
  end
)
end

UIAVGSystem.OnAvgNounClose = function(self)
  -- function num : 0_41
  if self.__lastAutoPlay then
    (self.avgCtrl):SetAvgAutoPlayMode(true, self.__lastDelayRatio)
  end
end

UIAVGSystem.OnDragEvent = function(self, SlideDis)
  -- function num : 0_42 , upvalues : _ENV
  local tempdis = ((self.ui).btn_bg).Sliderdis
  if tempdis > 0 then
    self.LastIndex = self.CurIndex
    local index = (math.floor)(tempdis / ((self.ui).btn_bg).SliderInterval)
    self.CurIndex = index
    if self.LastIndex ~= self.CurIndex then
      if self.CurChildIndex - 1 >= 0 or not 0 then
        do
          self.CurChildIndex = self.CurChildIndex - 1
          self:SetTImeScale()
          if tempdis < 0 then
            tempdis = tempdis * -1
            self.LastIndex = self.CurIndex
            local index = (math.floor)(tempdis / ((self.ui).btn_bg).SliderInterval)
            self.CurIndex = index
            if self.LastIndex ~= self.CurIndex then
              if self.CurChildIndex + 1 <= 3 or not 3 then
                self.CurChildIndex = self.CurChildIndex + 1
                self:SetTImeScale()
              end
            end
          end
        end
      end
    end
  end
end

UIAVGSystem.OnPressUpEvent = function(self)
  -- function num : 0_43
  ((self.ui).obj_SpeedUp):SetActive(false)
  ;
  ((self.ui).obj_timescale):SetActive(false)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).Canvas_Dialog).blocksRaycasts = true
  self.isend = false
end

UIAVGSystem.GetChildIndex = function(self, TimeSpeed)
  -- function num : 0_44 , upvalues : LongPressSpeed, _ENV
  if TimeSpeed == LongPressSpeed.SixteenSpeed then
    return 0
  else
    if TimeSpeed == LongPressSpeed.EightSpeed then
      return 1
    else
      if TimeSpeed == LongPressSpeed.FourSpeed then
        return 2
      else
        if TimeSpeed == LongPressSpeed.TwoSpeed then
          return 3
        else
          print("TimeSpeed Error")
        end
      end
    end
  end
end

UIAVGSystem.SetTImeScale = function(self)
  -- function num : 0_45 , upvalues : LongPressSpeed, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  if self.CurChildIndex == 0 then
    ((self.ui).btn_bg).pressRepeatInterval = LongPressSpeed.SixteenSpeed
    ;
    (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):Saveavgspeed(LongPressSpeed.SixteenSpeed)
  else
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

    if self.CurChildIndex == 1 then
      ((self.ui).btn_bg).pressRepeatInterval = LongPressSpeed.EightSpeed
      ;
      (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):Saveavgspeed(LongPressSpeed.EightSpeed)
    else
      -- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

      if self.CurChildIndex == 2 then
        ((self.ui).btn_bg).pressRepeatInterval = LongPressSpeed.FourSpeed
        ;
        (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):Saveavgspeed(LongPressSpeed.FourSpeed)
      else
        -- DECOMPILER ERROR at PC57: Confused about usage of register: R1 in 'UnsetPending'

        if self.CurChildIndex == 3 then
          ((self.ui).btn_bg).pressRepeatInterval = LongPressSpeed.TwoSpeed
          ;
          (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):Saveavgspeed(LongPressSpeed.TwoSpeed)
        else
          print("curToggleIndex Error")
        end
      end
    end
  end
  local child = (((self.ui).obj_timescale).transform):GetChild(self.CurChildIndex)
  ;
  ((self.ui).trans_select):SetParent(child)
  -- DECOMPILER ERROR at PC89: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).trans_select).offsetMax = (Vector2.New)(0, 0)
  -- DECOMPILER ERROR at PC97: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).trans_select).offsetMin = (Vector2.New)(0, 0)
end

UIAVGSystem.GetHeroCommItem = function(self)
  -- function num : 0_46 , upvalues : _ENV, UINAvgHeroCommItem, CS_Material
  if self.heroCommItemPool == nil then
    self.heroCommItemPool = (UIItemPool.New)(UINAvgHeroCommItem, (self.ui).communication)
  end
  if IsNull(self.commMat) then
    self.commMat = CS_Material((self.ui).commHeroMat)
  end
  return (self.heroCommItemPool):GetOne(), self.commMat
end

UIAVGSystem.ReturnHeroCommItem = function(self, item)
  -- function num : 0_47
  (item.transform):SetParent((((self.ui).communication).transform).parent)
  ;
  (self.heroCommItemPool):HideOne(item)
end

UIAVGSystem.OnClickAvgTextLink = function(self, herfStr, linkStr)
  -- function num : 0_48 , upvalues : _ENV
  local arg = (string.split)(herfStr, ":")
  if arg[1] == "Des" then
    local desId = tonumber(arg[2])
    do
      (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):SaveAvgNoun(desId)
      PersistentManager:SaveModelData((PersistentConfig.ePackage).UserData)
      UIManager:ShowWindowAsync(UIWindowTypeID.AvgNounDes, function(win)
    -- function num : 0_48_0 , upvalues : desId
    win:InitAvgNounDes(true, desId)
  end
)
    end
  end
end

UIAVGSystem.GetOnClickAvgTextLinkCallback = function(self)
  -- function num : 0_49 , upvalues : _ENV
  if self.__OnClickAvgTextLink == nil then
    self.__OnClickAvgTextLink = BindCallback(self, self.OnClickAvgTextLink)
  end
  return self.__OnClickAvgTextLink
end

UIAVGSystem.GetAvgHeroDissolveMat = function(self)
  -- function num : 0_50 , upvalues : _ENV, CS_Material
  if IsNull(self.heroDissolveMat) then
    self.heroDissolveMat = CS_Material((self.ui).dissolveHeroMat)
  end
  return self.heroDissolveMat
end

UIAVGSystem.AvgIgnoreTimeScale = function(self)
  -- function num : 0_51
  return (self.avgCtrl):AvgIgnoreTimeScale()
end

UIAVGSystem.CloseUIAVGSystem = function(self)
  -- function num : 0_52 , upvalues : _ENV
  local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeWin ~= nil and self._needChangeHomeState then
    self._needChangeHomeState = false
    homeWin:BackFromOtherCoverWin()
  end
  self:Delete()
end

UIAVGSystem.OnDelete = function(self)
  -- function num : 0_53 , upvalues : _ENV, base
  (UIManager.csUIManager):DisableUIPPVolume()
  if self.chapterNode ~= nil then
    (self.chapterNode):Delete()
  end
  if self.dialogNode ~= nil then
    ((((self.dialogNode).ui).text_Dialog).GetInfoDic):Clear()
    ;
    (self.dialogNode):Delete()
  end
  if self.chooseNode ~= nil then
    (self.chooseNode):Delete()
  end
  if self.recordNode ~= nil then
    (self.recordNode):Delete()
  end
  if self.avgPP ~= nil then
    (self.avgPP):Delete()
  end
  if self.effectNode ~= nil then
    (self.effectNode):Delete()
  end
  if self.videoNode ~= nil then
    (self.videoNode):Delete()
  end
  local acgnounwindow = UIManager:GetWindow(UIWindowTypeID.AvgNounDes)
  if acgnounwindow ~= nil then
    acgnounwindow:Delete()
  end
  ;
  (self.imgItemPool):DeleteAll()
  for k,v in pairs(self.heroPicDic) do
    v:Delete()
  end
  self:StopAvgVoice()
  DestroyUnityObject(self.heroDissolveMat)
  self.heroDissolveMat = nil
  DestroyUnityObject(self.commMat)
  self.commMat = nil
  if self.twSequence ~= nil then
    (self.twSequence):Kill()
    self.twSequence = nil
  end
  -- DECOMPILER ERROR at PC92: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (UIManager.UICamera).allowHDR = self._uiCamHdr
  UIManager:DeleteWindow(UIWindowTypeID.AvgSkip, true)
  ;
  (base.OnDelete)(self)
end

return UIAVGSystem


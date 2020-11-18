-- params : ...
-- function num : 0 , upvalues : _ENV
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
local AvgPostProcess = require("Game.Avg.AvgPostProcess")
local eAvgImgType = require("Game.Avg.Enum.eAvgImgType")
local eAvgImgPosType = require("Game.Avg.Enum.eAvgImgPosType")
local eAvgDialogPosX = require("Game.Avg.Enum.eAvgDialogPosX")
local eAvgContentType = require("Game.Avg.Enum.eAvgContentType")
local CS_MessageCommon = CS.MessageCommon
local CS_Object = (CS.UnityEngine).Object
local CS_DoTween = ((CS.DG).Tweening).DOTween
local CS_Screen = (CS.UnityEngine).Screen
local defaultScreenRatio = 1.7777777777778
local imgMaxCount = 10
UIAVGSystem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINAvgImgItem
  (UIUtil.AddButtonListener)((self.ui).btn_ShwoLogList, self, self.OnClickShwoLogList)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SpeedUp, self, self.OnClickSpeedUp)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Skip, self, self.OnClickSkip)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_AutoPlay, self, self.OnClickAutoPlay)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_bg, self, self.OnClickBackground)
  ;
  ((self.ui).imgItem):SetActive(false)
  ;
  ((self.ui).heroItem):SetActive(false)
  self.imgItemPool = (UIItemPool.New)(UINAvgImgItem, (self.ui).imgItem)
  self.distantViewImgDic = {}
  self.bgImgDic = {}
  self.foregroundImgDic = {}
  self.heroPicDic = {}
  self.imgCount = 0
  self.__onAvgImgTweenComplete = BindCallback(self, self.OnAvgImgTweenComplete)
end

UIAVGSystem.InitAvgSystem = function(self, avgCtrl)
  -- function num : 0_1 , upvalues : UINAvgChapter, UINAvgDialog, UINAvgChoose, UINAvgEffectNode, UINAvgRecord, UINAvgVideoNode, AvgPostProcess
  self.avgCtrl = avgCtrl
  local autoPlay = (self.avgCtrl):GetAvgAutoPlayMode()
  self:RefreshAutoPlay(autoPlay)
  local speedup = (self.avgCtrl):GetAvgSpeedupMode()
  self:RefreshSpeedup(speedup)
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
end

UIAVGSystem.__UpdateBlackEdge = function(self)
  -- function num : 0_2 , upvalues : CS_Screen, defaultScreenRatio, _ENV
  local sWidth = CS_Screen.width
  local sHeight = CS_Screen.height
  local curRatio = sWidth / sHeight
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
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).blackEdge_Top).sizeDelta = sizeDelta
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).blackEdge_Bottom).sizeDelta = sizeDelta
  ;
  (self.dialogNode):SetAvgDialogBottom(extraHeight)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIAVGSystem.PlayAvgAct = function(self, actCfg)
  -- function num : 0_3 , upvalues : _ENV
  if actCfg == nil then
    error("Cant get actCfg, id = " .. tostring())
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
  self:PlayAvgAudio()
  self:RefreshAvgImg(actCfg.images)
  self.hasImgTween = actCfg.imgTween ~= nil and (table.count)(actCfg.imgTween) > 0
  self.hasContent = actCfg.content ~= nil
  self.hasBranch = actCfg.branch ~= nil and (table.count)(actCfg.branch) > 0
  self.hasVideo = actCfg.vedioPath ~= nil
  self:PlayAvgVideoLoopBg()
  ;
  (self.avgPP):ChangeAvgPP(actCfg.ppv)
  ;
  (self.effectNode):PlayAvgEffect(actCfg.effect)
  self:DoCustomCode()
  self:PlayAvgOrder()
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

UIAVGSystem.PlayAvgOrder = function(self)
  -- function num : 0_4
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
  self:CheckActComplete()
  if (self.actCfg).autoContinue then
    (self.avgCtrl):ClickContinueAvg()
  end
end

UIAVGSystem.CheckActComplete = function(self)
  -- function num : 0_5
  if self.hasContent or self.voiceIsPlaying or self.hasVideo or self.hasBranch or self.hasImgTween then
    return 
  end
  ;
  (self.avgCtrl):OnAvgActComplete(self.jumpAct, self.jumpChapter)
end

UIAVGSystem.GetAvgSpeakerName = function(self, heroId)
  -- function num : 0_6 , upvalues : _ENV
  if heroId == -1 then
    return heroId
  end
  local heroCfg = (ConfigData.hero_data)[heroId]
  if heroCfg == nil then
    warn("Can\'t find heroCfg, speakerHeroId = " .. tostring(heroId))
    return 
  end
  return (LanguageUtil.GetLocaleText)(heroCfg.name)
end

UIAVGSystem.ShowAvgContent = function(self)
  -- function num : 0_7 , upvalues : eAvgContentType, eAvgImgPosType, _ENV, eAvgDialogPosX, CS_MessageCommon
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
            error("speakerHeroPosId error, id = " .. actCfg.speakerHeroPosId)
          end
          do
            local posX = eAvgDialogPosX[posId]
            ;
            (self.dialogNode):ShowAvgDialog(content, actCfg.contentShake, self.skipTween, actCfg.scrambleTypeWriter, self:GetAvgSpeakerName(actCfg.speakerHeroId), false, posX)
            if not actCfg.tipsShowDuration then
              (CS_MessageCommon.ShowMessageTips)(content, true, actCfg.contentType ~= eAvgContentType.Tips or 0, actCfg.tipsTypeWriter)
              self:ShowTextComplete()
              self:PlayAvgVoice()
            end
          end
        end
      end
    end
  end
end

UIAVGSystem.ShowTextComplete = function(self)
  -- function num : 0_8
  self.hasContent = false
  self:PlayAvgOrder()
end

UIAVGSystem.DoCustomCode = function(self)
  -- function num : 0_9 , upvalues : _ENV
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
  -- function num : 0_10
  (self.videoNode):PlayAvgVideo((self.actCfg).vedioPath)
end

UIAVGSystem.PlayAvgVideoComplete = function(self)
  -- function num : 0_11
  self.hasVideo = false
  self:PlayAvgOrder()
end

UIAVGSystem.PlayAvgVideoLoopBg = function(self)
  -- function num : 0_12
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
  -- function num : 0_13 , upvalues : _ENV
  if (self.actCfg).audio == nil then
    return 
  end
  local audioCfg = (self.actCfg).audio
  if audioCfg.bgm ~= nil then
    if (audioCfg.bgm).stop then
      AudioManager:StopSource(eAudioSourceType.BgmSource)
    else
      AudioManager:PlayAudio((audioCfg.bgm).cue, (audioCfg.bgm).sheet, eAudioSourceType.BgmSource)
    end
  end
  if audioCfg.sfx ~= nil then
    AudioManager:PlayAudio((audioCfg.sfx).cue, (audioCfg.sfx).sheet, eAudioSourceType.SfxSource)
  end
end

UIAVGSystem.PlayAvgVoice = function(self)
  -- function num : 0_14 , upvalues : _ENV
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
    AudioManager:PlayAudio((audioCfg.voice).cue, (audioCfg.voice).sheet, eAudioSourceType.VoiceSource, self.__onAudioPlayComplete)
  end
end

UIAVGSystem.AudioPlayComplete = function(self)
  -- function num : 0_15
  self.voiceIsPlaying = false
  self:CheckActComplete()
end

UIAVGSystem.StopAvgVoice = function(self)
  -- function num : 0_16 , upvalues : _ENV
  if self.voiceIsPlaying then
    AudioManager:StopSource(eAudioSourceType.VoiceSource)
    self.voiceIsPlaying = false
  end
end

UIAVGSystem.BranchChooseComplete = function(self, jumpAct, jumpChapter)
  -- function num : 0_17
  self.jumpAct = jumpAct
  self.jumpChapter = jumpChapter
  self.hasBranch = false
  self:StopAvgVoice()
  self:PlayAvgOrder()
end

UIAVGSystem.RefreshAvgImg = function(self, imgCfgList)
  -- function num : 0_18 , upvalues : _ENV
  if imgCfgList == nil then
    return 
  end
  self.imgNeedSort = {}
  for k,v in ipairs(imgCfgList) do
    if v.delete then
      self:RecycleImgItem(v.imgId)
    else
      self:NewImgItem(v)
    end
  end
  self:SortAvtImgItem()
  ;
  (((self.ui).heroesNode).gameObject):SetActive((table.count)(self.heroPicDic) > 0)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIAVGSystem.NewImgItem = function(self, imgCfg)
  -- function num : 0_19 , upvalues : eAvgImgType, UINAvgHeroPic, _ENV, imgMaxCount
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
        if imgType == eAvgImgType.DistantView then
          imgItem = (self.distantViewImgDic)[imgId]
          if imgItem == nil then
            imgItem = (self.imgItemPool):GetOne()
            -- DECOMPILER ERROR at PC74: Confused about usage of register: R5 in 'UnsetPending'

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
                  -- DECOMPILER ERROR at PC116: Confused about usage of register: R6 in 'UnsetPending'

                  ;
                  (self.imgNeedSort)[imgType] = true
                  return 
                end
                -- DECOMPILER ERROR at PC119: Confused about usage of register: R5 in 'UnsetPending'

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
  -- function num : 0_20 , upvalues : _ENV
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
  -- function num : 0_21 , upvalues : _ENV
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
  -- function num : 0_22 , upvalues : _ENV, eAvgImgType
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
          if imgType == eAvgImgType.DistantView then
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
    -- function num : 0_22_0
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
  -- function num : 0_23 , upvalues : _ENV
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
  -- function num : 0_24 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.tweenImgItemDic)[imgId] = nil
  if (table.count)(self.tweenImgItemDic) == 0 then
    self.hasImgTween = false
    self:PlayAvgOrder()
  end
end

UIAVGSystem.SetTopControlActive = function(self, active)
  -- function num : 0_25
  ((self.ui).topNode):SetActive(active)
end

UIAVGSystem.OnClickShwoLogList = function(self)
  -- function num : 0_26
  self.__lastAutoPlay = (self.avgCtrl):GetAvgAutoPlayMode()
  if self.__lastAutoPlay then
    (self.avgCtrl):SwitchAvgAutoPlay()
  end
  ;
  (self.recordNode):ShowAcgRecord((self.avgCtrl):GetAvgRecordData())
end

UIAVGSystem.OnAvgRecordClose = function(self)
  -- function num : 0_27
  if self.__lastAutoPlay then
    (self.avgCtrl):SwitchAvgAutoPlay()
  end
end

UIAVGSystem.OnClickSpeedUp = function(self)
  -- function num : 0_28
  local speedup = (self.avgCtrl):SwitchAvgSpeedup()
  self:RefreshSpeedup(speedup)
end

UIAVGSystem.RefreshSpeedup = function(self, speedup)
  -- function num : 0_29
  ;
  ((self.ui).img_SpeedUpIcon):SetIndex(speedup and 1 or 0)
end

UIAVGSystem.OnClickAutoPlay = function(self)
  -- function num : 0_30
  local autoPlay = (self.avgCtrl):SwitchAvgAutoPlay()
  self:RefreshAutoPlay(autoPlay)
end

UIAVGSystem.RefreshAutoPlay = function(self, autoPlay)
  -- function num : 0_31 , upvalues : CS_DoTween
  if self.firstAutoPlay == nil then
    self.autoIconPos = (((self.ui).img_AutoIcon).transform).position
    self.autoIconColor = ((self.ui).img_AutoIcon).color
    self.firstAutoPlay = false
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).img_AutoIcon).transform).position = self.autoIconPos
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.autoIconColor).a = 1
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_AutoIcon).color = self.autoIconColor
  local twSequence = nil
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R3 in 'UnsetPending'

  if autoPlay then
    ((self.ui).fade_AutoPlay).alpha = 1
    twSequence = (CS_DoTween.Sequence)()
    twSequence:Append((((self.ui).img_AutoIcon).transform):DOLocalMoveX(160, 1.2))
    twSequence:Join(((self.ui).img_AutoIcon):DOFade(0, 1.2))
    twSequence:SetLoops(-1)
    twSequence:SetUpdate(true)
    self.twSequence = twSequence
  else
    -- DECOMPILER ERROR at PC60: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).fade_AutoPlay).alpha = 0.6
    if self.twSequence ~= nil then
      (self.twSequence):Kill()
      self.twSequence = nil
    end
  end
end

UIAVGSystem.OnClickSkip = function(self)
  -- function num : 0_32 , upvalues : CS_MessageCommon, _ENV
  (CS_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(TipContent.Avg_SkipAllAvg), function()
    -- function num : 0_32_0 , upvalues : self
    (self.avgCtrl):CompleteAllAvg()
  end
, nil)
end

UIAVGSystem.OnClickBackground = function(self)
  -- function num : 0_33 , upvalues : _ENV, eAvgContentType
  if self.hasContent or self.hasImgTween or self.hasBranch then
    self.skipTween = true
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

UIAVGSystem.AvgIgnoreTimeScale = function(self)
  -- function num : 0_34
  return (self.avgCtrl):AvgIgnoreTimeScale()
end

UIAVGSystem.OnDelete = function(self)
  -- function num : 0_35 , upvalues : _ENV, base
  (UIManager.csUIManager):DisableUIPPVolume()
  ;
  (self.chapterNode):Delete()
  ;
  (self.dialogNode):Delete()
  ;
  (self.chooseNode):Delete()
  ;
  (self.recordNode):Delete()
  ;
  (self.avgPP):Delete()
  ;
  (self.effectNode):Delete()
  ;
  (self.videoNode):Delete()
  ;
  (self.imgItemPool):DeleteAll()
  for k,v in pairs(self.heroPicDic) do
    v:Delete()
  end
  self:StopAvgVoice()
  if self.twSequence ~= nil then
    (self.twSequence):Kill()
    self.twSequence = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIAVGSystem


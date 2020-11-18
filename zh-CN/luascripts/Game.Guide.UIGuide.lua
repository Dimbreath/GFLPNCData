-- params : ...
-- function num : 0 , upvalues : _ENV
local UIGuide = class("UIGuide", UIBaseWindow)
local base = UIBaseWindow
local GuideEnum = require("Game.Guide.GuideEnum")
UIGuide.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.__permanent = true
  self.smallDialogSize = ((self.ui).smallDialogNode).sizeDelta
  self.talkDialogNode = ((self.ui).talkDialogNode).sizeDelta
  self.talkContentNodeSize = ((self.ui).talkContentNode).sizeDelta
  self.resloader = ((CS.ResLoader).Create)()
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Continue, self, self.OnBtnContinueClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SkipGuide, self, self.OnSkipClicked)
end

UIGuide.SetWaitMaskActive = function(self, active)
  -- function num : 0_1
  ((self.ui).waitMask):SetActive(active)
end

UIGuide.PlayGuide = function(self, rectTransform, camera)
  -- function num : 0_2
  return ((self.ui).maskOperate):Play(rectTransform, camera)
end

UIGuide.PlayGuideBox = function(self, boxCollider, camera)
  -- function num : 0_3
  return ((self.ui).maskOperate):PlayBox(boxCollider, camera)
end

UIGuide.PlayGuideCustome = function(self, screenPoint, screenSize)
  -- function num : 0_4
  return ((self.ui).maskOperate):PlayCustome(screenPoint, screenSize)
end

UIGuide.ShowGuideAniInfo = function(self, info, info_type, info_pos, isFirst, step_type)
  -- function num : 0_5 , upvalues : _ENV, GuideEnum
  local position = (((self.ui).maskOperate).targetArea).localPosition
  local sizeDelta = (((self.ui).maskOperate).targetArea).sizeDelta
  local sizeDeltaMax = (sizeDelta.x + sizeDelta.y) / 1.8
  local fitSize = (math.clamp)(sizeDeltaMax, (self.ui).arrowNodeMin, (self.ui).arrowNodeMax)
  local fitSizeDelta = (Vector2.New)(fitSize, fitSize)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R11 in 'UnsetPending'

  if step_type == (GuideEnum.StepType).Operate then
    (((self.ui).arrowNode).transform).localPosition = position
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (((self.ui).arrowNode).transform).sizeDelta = fitSizeDelta
    if isFirst then
      (((self.ui).arrowNode).gameObject):SetActive(true)
      ;
      (((self.ui).ani_TargetArea).gameObject):SetActive(true)
      -- DECOMPILER ERROR at PC58: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (((self.ui).ani_TargetArea).transform).sizeDelta = fitSizeDelta - ((self.ui).ani_TargetArea).endValueV2
      ;
      ((self.ui).ani_TargetArea):DORestart(true)
    end
  else
    if isFirst then
      (((self.ui).arrowNode).gameObject):SetActive(false)
    end
  end
  if (string.IsNullOrEmpty)(info) then
    return 
  end
  local offsetRatio = nil
  if position.x <= 0 and position.y >= 0 then
    offsetRatio = (Vector2.New)(1, -1)
  else
    if position.x <= 0 and position.y <= 0 then
      offsetRatio = (Vector2.New)(1, 1)
    else
      if position.x >= 0 and position.y <= 0 then
        offsetRatio = (Vector2.New)(-1, 1)
      else
        offsetRatio = (Vector2.New)(-1, -1)
      end
    end
  end
  local arrowOffset = sizeDelta / 2 * offsetRatio
  if info_type > 0 then
    self:ShowHeroSmallTalk(info, info_type, info_pos, position, arrowOffset, offsetRatio)
  else
    self:ShowSmallDialogNode(info, position, arrowOffset, offsetRatio)
  end
end

UIGuide.ShowSmallDialogNode = function(self, info, position, arrowOffset, offsetRatio)
  -- function num : 0_6 , upvalues : _ENV
  if (string.IsNullOrEmpty)(info) then
    return 
  end
  local dialogOffset = arrowOffset + (Vector2.New)(((self.smallDialogSize).x / 2 + ((self.ui).arrowDialogOffset).x) * offsetRatio.x, ((self.ui).arrowDialogOffset).y * offsetRatio.y)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).smallDialogNode).localPosition = position + (Vector3.New)(dialogOffset.x, dialogOffset.y, 0)
  ;
  (((self.ui).smallDialogNode).gameObject):SetActive(true)
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_SmallDialog).text = info
end

UIGuide.HideSmallDialogNode = function(self)
  -- function num : 0_7
  (((self.ui).smallDialogNode).gameObject):SetActive(false)
end

UIGuide.ShowHeroSmallTalk = function(self, info, info_type, info_pos, position, arrowOffset, offsetRatio)
  -- function num : 0_8 , upvalues : _ENV
  if (string.IsNullOrEmpty)(info) then
    return 
  end
  local heroCfg = (ConfigData.hero_data)[info_type]
  if heroCfg ~= nil then
    local resCfg = heroCfg:GetHeroResCfg()
    if resCfg ~= nil then
      self.__talkHeroId = info_type
      local picPath = PathConsts:GetCharacterPicPath(resCfg.res_Name)
      ;
      (self.resloader):LoadABAssetAsync(picPath, function(texture)
    -- function num : 0_8_0 , upvalues : self, info_type
    if self.__talkHeroId ~= info_type then
      return 
    end
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_TalkHeroPic).texture = texture
  end
)
    end
  end
  do
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.ui).tex_TalkDialog).text = tostring(info)
    if not (string.IsNullOrEmpty)(info_pos) then
      local childNode = ((self.ui).talkDialogPosGroup):Find(info_pos)
      -- DECOMPILER ERROR at PC51: Confused about usage of register: R9 in 'UnsetPending'

      if not IsNull(childNode) then
        ((self.ui).talkDialogNode).localPosition = childNode.localPosition
      end
    else
      do
        local xOffset = 0
        if offsetRatio.x < 0 then
          xOffset = (self.talkDialogNode).x / 2 + (self.talkContentNodeSize).x
        else
          xOffset = (self.talkDialogNode).x / 2
        end
        do
          local dialogOffset = arrowOffset + (Vector2.New)((xOffset + ((self.ui).arrowDialogOffset).x) * offsetRatio.x, ((self.ui).arrowDialogOffset).y * offsetRatio.y)
          -- DECOMPILER ERROR at PC91: Confused about usage of register: R10 in 'UnsetPending'

          ;
          ((self.ui).talkDialogNode).localPosition = position + (Vector3.New)(dialogOffset.x, dialogOffset.y, 0)
          ;
          (((self.ui).talkDialogNode).gameObject):SetActive(true)
        end
      end
    end
  end
end

UIGuide.HideHeroTalkDialog = function(self)
  -- function num : 0_9
  (((self.ui).talkDialogNode).gameObject):SetActive(false)
end

UIGuide.ShowGuideLargeDialog = function(self, info, info_type, info_pos, nextAction)
  -- function num : 0_10 , upvalues : _ENV, GuideEnum
  ((self.ui).panelDialog):SetActive(true)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_LargeDialog).text = nil
  if (string.IsNullOrEmpty)(info) then
    info = ""
  end
  self:__ShowBigHeroPic(info_type, info_pos)
  ;
  (((self.ui).tween_txt_LargeDialog).tween):ChangeEndValue(info, true)
  ;
  ((self.ui).tween_txt_LargeDialog):DORestart()
  self.nextAction = nextAction
  self.step_type = (GuideEnum.StepType).LargeDialog
  ;
  (((self.ui).btn_Continue).gameObject):SetActive(true)
end

UIGuide.ShowGuideHeroSmallTalk = function(self, info, info_type, info_pos, nextAction)
  -- function num : 0_11 , upvalues : _ENV, GuideEnum
  if (string.IsNullOrEmpty)(info) then
    info = ""
  end
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_TalkDialog).text = tostring(info)
  local heroCfg = (ConfigData.hero_data)[info_type]
  if heroCfg ~= nil then
    local resCfg = heroCfg:GetHeroResCfg()
    if resCfg ~= nil then
      self.__talkHeroId = info_type
      local picPath = PathConsts:GetCharacterPicPath(resCfg.res_Name)
      ;
      (self.resloader):LoadABAssetAsync(picPath, function(texture)
    -- function num : 0_11_0 , upvalues : self, info_type
    if self.__talkHeroId ~= info_type then
      return 
    end
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_TalkHeroPic).texture = texture
  end
)
    end
  end
  do
    do
      if not (string.IsNullOrEmpty)(info_pos) then
        local childNode = ((self.ui).talkDialogPosGroup):Find(info_pos)
        -- DECOMPILER ERROR at PC51: Confused about usage of register: R7 in 'UnsetPending'

        if not IsNull(childNode) then
          ((self.ui).talkDialogNode).localPosition = childNode.localPosition
        end
      end
      ;
      (((self.ui).talkDialogNode).gameObject):SetActive(true)
      self.nextAction = nextAction
      self.step_type = (GuideEnum.StepType).HeroSmallTalk
      ;
      (((self.ui).btn_Continue).gameObject):SetActive(true)
    end
  end
end

UIGuide.__ShowBigHeroPic = function(self, info_type, info_pos)
  -- function num : 0_12 , upvalues : _ENV
  if not info_type then
    info_type = 0
  end
  if info_type > 0 then
    if self.__lastBigImgHeroId == info_type then
      do
        if not IsNull(self.__lastBigImgHeroId) then
          local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
          commonPicCtrl:SetPosType(info_pos)
        end
        do return  end
        self.__lastBigImgHeroId = info_type
        local heroCfg = (ConfigData.hero_data)[info_type]
        do
          if heroCfg ~= nil then
            local resCfg = heroCfg:GetHeroResCfg()
            if resCfg ~= nil then
              if self.bigImgResloader ~= nil then
                (self.bigImgResloader):Put2Pool()
              end
              self.bigImgResloader = ((CS.ResLoader).Create)()
              DestroyUnityObject(self.bigImgGameObject)
              ;
              (self.bigImgResloader):LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(resCfg.res_Name), function(prefab)
    -- function num : 0_12_0 , upvalues : self, info_type, _ENV, info_pos
    if self.__lastBigImgHeroId ~= info_type then
      return 
    end
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate((self.ui).herolPicNode)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType(info_pos)
  end
)
            end
          end
          if self.bigImgResloader ~= nil then
            (self.bigImgResloader):Put2Pool()
            self.bigImgResloader = nil
          end
          DestroyUnityObject(self.bigImgGameObject)
          self.__lastBigImgHeroId = nil
        end
      end
    end
  end
end

UIGuide.BindContinueBtnEvent = function(self, nextAction, step_type)
  -- function num : 0_13
  self.nextAction = nextAction
  self.step_type = step_type
  ;
  (((self.ui).btn_Continue).gameObject):SetActive(true)
end

UIGuide.OnBtnContinueClicked = function(self)
  -- function num : 0_14 , upvalues : GuideEnum
  if self.step_type == (GuideEnum.StepType).LargeDialog then
    local isPlaying = (((self.ui).tween_txt_LargeDialog).tween):IsPlaying()
    if isPlaying then
      ((self.ui).tween_txt_LargeDialog):DOComplete()
    else
      if self.nextAction ~= nil then
        (self.nextAction)()
      end
    end
  else
    do
      -- DECOMPILER ERROR at PC32: Unhandled construct in 'MakeBoolean' P1

      if self.step_type == (GuideEnum.StepType).HeroSmallTalk and self.nextAction ~= nil then
        (self.nextAction)()
      end
      if self.step_type == (GuideEnum.StepType).Highlight and self.nextAction ~= nil then
        (self.nextAction)()
      end
    end
  end
end

UIGuide.BindGuideSkipEvent = function(self, skipEvent)
  -- function num : 0_15
  self.__skipEvent = skipEvent
end

UIGuide.OnSkipClicked = function(self)
  -- function num : 0_16
  if self.__skipEvent ~= nil then
    (self.__skipEvent)()
  end
end

UIGuide.SetSkipButtonActive = function(self, bool)
  -- function num : 0_17
  (((self.ui).btn_SkipGuide).gameObject):SetActive(bool)
end

UIGuide.CloseGuide = function(self, step_type)
  -- function num : 0_18 , upvalues : GuideEnum
  if step_type == (GuideEnum.StepType).LargeDialog then
    ((self.ui).panelDialog):SetActive(false)
  else
    if step_type == (GuideEnum.StepType).Operate or step_type == (GuideEnum.StepType).Highlight then
      ((self.ui).maskOperate):Close()
      self:HideSmallDialogNode()
      self:HideHeroTalkDialog()
    else
      if step_type == (GuideEnum.StepType).HeroSmallTalk then
        (((self.ui).talkDialogNode).gameObject):SetActive(false)
      end
    end
  end
  ;
  (((self.ui).btn_Continue).gameObject):SetActive(false)
  self.nextAction = nil
  self.step_type = nil
end

UIGuide.PlaySlideGuide = function(self, startUIPos, endUIPos)
  -- function num : 0_19 , upvalues : _ENV
  local lineSizeDelta = (((self.ui).img_SlideLine).transform).sizeDelta
  lineSizeDelta.x = (Vector3.Distance)(startUIPos, endUIPos)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (((self.ui).img_SlideLine).transform).sizeDelta = lineSizeDelta
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (((self.ui).img_SlideLine).transform).localPosition = startUIPos
  local angle = (((CS.UnityEngine).Mathf).Atan2)(endUIPos.y - startUIPos.y, endUIPos.x - startUIPos.x) * ((CS.UnityEngine).Mathf).Rad2Deg
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.ui).img_SlideLine).transform).localEulerAngles = (Vector3.New)(0, 0, angle)
  local offsetY = ((((self.ui).img_SlideArrows).transform).sizeDelta).y / 4
  startUIPos.y = startUIPos.y - offsetY
  endUIPos.y = endUIPos.y - offsetY
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (((self.ui).img_SlideArrows).transform).localPosition = startUIPos
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_SlideArrows).endValueV3 = endUIPos
  ;
  ((self.ui).slideNode):SetActive(true)
end

UIGuide.EndSlideGuide = function(self)
  -- function num : 0_20
  ((self.ui).slideNode):SetActive(false)
end

UIGuide.PlayHandClickGuide = function(self, startUIPos)
  -- function num : 0_21 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  (((self.ui).handClick).transform).localPosition = (Vector3.New)(startUIPos.x, startUIPos.y, 0)
  ;
  ((self.ui).handClick):SetActive(true)
end

UIGuide.EndHandClickGuide = function(self)
  -- function num : 0_22
  ((self.ui).handClick):SetActive(false)
end

UIGuide.OnDelete = function(self)
  -- function num : 0_23 , upvalues : base
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIGuide


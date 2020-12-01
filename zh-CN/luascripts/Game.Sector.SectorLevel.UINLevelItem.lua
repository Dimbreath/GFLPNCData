-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLevelItem = class("UINLevelItem", UIBaseNode)
local base = UIBaseNode
local CS_DoTween = ((CS.DG).Tweening).DOTween
local verticalAnchor = (Vector2.New)(0.5, 1)
local horizontalAnchor = (Vector2.New)(0, 0.5)
local bottomTweenSizeDelta = (Vector2.New)(295.25, 128.27)
local aniSelectTweenSizeDelta = (Vector2.New)(-10, -10)
UINLevelItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).rootBtn, self, self.OnClickLevelItem)
  self.bottomTweenSizeDeltaDefault = (((self.ui).buttom).transform).sizeDelta
  self.aniSelectTweenSizeDeltaDefault = (((self.ui).ani_Select).transform).sizeDelta
end

UINLevelItem.InitSectorLevelItem = function(self, stageData, arrangeCfg, clickEvent, resLoader)
  -- function num : 0_1 , upvalues : _ENV, verticalAnchor, horizontalAnchor
  self.clickEvent = clickEvent
  self.stageData = stageData
  ;
  ((self.ui).tex_SubTile):SetIndex(0, tostring(stageData.sector), tostring(stageData.num))
  ;
  ((self.ui).tex_Tile):SetIndex(0, (LanguageUtil.GetLocaleText)(stageData.name))
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_LevlelPic).enabled = false
  resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorLevelIcon"), function(spriteAtlas)
    -- function num : 0_1_0 , upvalues : self, stageData
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_LevlelPic).sprite = spriteAtlas:GetSprite(stageData.pic)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_LevlelPic).enabled = true
  end
)
  self:RefreshLevelState()
  self:LevelItemShowContinue(false)
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'

  if arrangeCfg.vertical then
    (self.transform).anchorMin = verticalAnchor
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self.transform).anchorMax = verticalAnchor
  else
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self.transform).anchorMin = horizontalAnchor
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self.transform).anchorMax = horizontalAnchor
  end
  -- DECOMPILER ERROR at PC61: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.transform).anchoredPosition = (Vector2.New)((arrangeCfg.pos)[1], (arrangeCfg.pos)[2])
  self:SeletedLevelItem(false, false)
end

UINLevelItem.OnClickLevelItem = function(self)
  -- function num : 0_2
  if self.clickEvent ~= nil then
    (self.clickEvent)(self)
  end
end

UINLevelItem.DisableSelectLevelItem = function(self, disable)
  -- function num : 0_3
  if not self.isUnlock then
    return 
  end
  self.isDisable = disable
  self:RefreshNoEntry()
end

UINLevelItem.RefreshNoEntry = function(self)
  -- function num : 0_4
  if not self.isUnlock or self.isDisable then
    ((self.ui).noEntry):SetActive(true)
    if self.isDisable then
      ((self.ui).img_NoEntry):SetIndex(0)
    else
      ;
      ((self.ui).img_NoEntry):SetIndex(1)
    end
  else
    ;
    ((self.ui).noEntry):SetActive(false)
  end
end

UINLevelItem.LevelItemShowContinue = function(self, show)
  -- function num : 0_5
  ((self.ui)["continue"]):SetActive(show)
end

UINLevelItem.SeletedLevelItem = function(self, select, withTween)
  -- function num : 0_6 , upvalues : CS_DoTween, bottomTweenSizeDelta, aniSelectTweenSizeDelta
  self:__ClearSelectedSequence()
  local seq = nil
  if withTween then
    seq = (CS_DoTween.Sequence)()
  end
  if select then
    (((self.ui).img_Pic).gameObject):SetActive(false)
    ;
    (((self.ui).img_LevlelPic).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

    if withTween then
      (((self.ui).ani_Select).transform).sizeDelta = self.aniSelectTweenSizeDeltaDefault
      local color = ((self.ui).img_LevlelPic).color
      color.a = 0
      -- DECOMPILER ERROR at PC35: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).img_LevlelPic).color = color
      color = ((self.ui).ani_Select).color
      color.a = 1
      -- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).ani_Select).color = color
      seq:Join((((self.ui).buttom).transform):DOSizeDelta(bottomTweenSizeDelta, 0.25))
      seq:Join(((self.ui).img_LevlelPic):DOFade(1, 0.25))
      seq:AppendCallback(function()
    -- function num : 0_6_0 , upvalues : self
    (((self.ui).ani_Select).gameObject):SetActive(true)
  end
)
    else
      do
        -- DECOMPILER ERROR at PC68: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (((self.ui).buttom).transform).sizeDelta = bottomTweenSizeDelta
        do
          local color = ((self.ui).img_LevlelPic).color
          color.a = 1
          -- DECOMPILER ERROR at PC75: Confused about usage of register: R5 in 'UnsetPending'

          ;
          ((self.ui).img_LevlelPic).color = color
          ;
          (((self.ui).ani_Select).gameObject):SetActive(true)
          self.__selectSizeTween = ((((self.ui).ani_Select).transform):DOSizeDelta(aniSelectTweenSizeDelta, 1)):SetLoops(-1)
          self.__selectFadeTween = ((((self.ui).ani_Select):DOFade(0, 1)):SetLoops(-1)):SetDelay(0.3)
          ;
          (((self.ui).ani_Select).gameObject):SetActive(false)
          if withTween then
            seq:Join((((self.ui).buttom).transform):DOSizeDelta(self.bottomTweenSizeDeltaDefault, 0.25))
            seq:AppendCallback(function()
    -- function num : 0_6_1 , upvalues : self
    (((self.ui).img_Pic).gameObject):SetActive(true)
    ;
    (((self.ui).img_LevlelPic).gameObject):SetActive(false)
  end
)
          else
            -- DECOMPILER ERROR at PC132: Confused about usage of register: R4 in 'UnsetPending'

            ;
            (((self.ui).buttom).transform).sizeDelta = self.bottomTweenSizeDeltaDefault
            ;
            (((self.ui).img_Pic).gameObject):SetActive(true)
            ;
            (((self.ui).img_LevlelPic).gameObject):SetActive(false)
          end
          self.__sequence = seq
        end
      end
    end
  end
end

UINLevelItem.ShowBlueDotLevelItem = function(self, show)
  -- function num : 0_7
  ((self.ui).blueDot):SetActive(show)
end

UINLevelItem.RefreshLevelState = function(self)
  -- function num : 0_8 , upvalues : _ENV
  ((self.ui).clearLevel):SetActive((PlayerDataCenter.sectorStage):IsStageComplete((self.stageData).id))
  self.isUnlock = (PlayerDataCenter.sectorStage):IsStageUnlock((self.stageData).id)
  self:RefreshNoEntry()
end

UINLevelItem.IsLevelUnlock = function(self)
  -- function num : 0_9
  return self.isUnlock
end

UINLevelItem.GetLevelStageData = function(self)
  -- function num : 0_10
  return self.stageData
end

UINLevelItem.__ClearSelectedSequence = function(self)
  -- function num : 0_11
  if self.__sequence ~= nil then
    (self.__sequence):Kill()
    self.__sequence = nil
  end
  if self.__selectSizeTween ~= nil then
    (self.__selectSizeTween):Rewind()
    ;
    (self.__selectSizeTween):Kill()
    self.__selectSizeTween = nil
    ;
    (self.__selectFadeTween):Rewind()
    ;
    (self.__selectFadeTween):Kill()
    self.__selectFadeTween = nil
  end
end

UINLevelItem.OnReturnLevelItem = function(self)
  -- function num : 0_12
  self:__ClearSelectedSequence()
end

UINLevelItem.OnDelete = function(self)
  -- function num : 0_13 , upvalues : base
  self:__ClearSelectedSequence()
  ;
  (base.OnDelete)(self)
end

return UINLevelItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLevelItem = class("UINLevelItem", UIBaseNode)
local base = UIBaseNode
local CS_DoTween = ((CS.DG).Tweening).DOTween
local verticalAnchor = (Vector2.New)(0.5, 1)
local horizontalAnchor = (Vector2.New)(0, 0.5)
local bottomTweenSizeDelta = (Vector2.New)(295.25, 128.27)
local aniSelectTweenSizeDelta = (Vector2.New)(-10, -10)
UINLevelItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).rootBtn, self, self.OnClickLevelItem)
    self.bottomTweenSizeDeltaDefault = (((self.ui).buttom).transform).sizeDelta
    self.aniSelectTweenSizeDeltaDefault =
        (((self.ui).ani_Select).transform).sizeDelta
end

UINLevelItem.InitSectorLevelItem = function(self, stageData, arrangeCfg,
                                            clickEvent, resLoader)
    -- function num : 0_1 , upvalues : _ENV, verticalAnchor, horizontalAnchor
    self.clickEvent = clickEvent
    self.stageData = stageData;
    ((self.ui).tex_SubTile):SetIndex(0, tostring(stageData.sector),
                                     tostring(stageData.num));
    ((self.ui).tex_Tile):SetIndex(0,
                                  (LanguageUtil.GetLocaleText)(stageData.name)) -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.ui).img_LevlelPic).enabled = false
    resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorLevelIcon"),
                               function(spriteAtlas)
        -- function num : 0_1_0 , upvalues : self, stageData
        if spriteAtlas == nil then return end -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'
        
        ((self.ui).img_LevlelPic).sprite = spriteAtlas:GetSprite(stageData.pic) -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'
        ;
        ((self.ui).img_LevlelPic).enabled = true
    end)
    self:RefreshLevelState()
    self:LevelItemShowContinue(false)
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'

    if arrangeCfg.vertical then
        (self.transform).anchorMin = verticalAnchor -- DECOMPILER ERROR at PC45: Confused about usage of register: R5 in 'UnsetPending'
        ;
        (self.transform).anchorMax = verticalAnchor
    else
        -- DECOMPILER ERROR at PC49: Confused about usage of register: R5 in 'UnsetPending'


        (self.transform).anchorMin = horizontalAnchor -- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'
        ;
        (self.transform).anchorMax = horizontalAnchor
    end -- DECOMPILER ERROR at PC61: Confused about usage of register: R5 in 'UnsetPending'
    
    (self.transform).anchoredPosition = (Vector2.New)((arrangeCfg.pos)[1],
                                                      (arrangeCfg.pos)[2])
    self:SeletedLevelItem(false, false)
end

UINLevelItem.OnClickLevelItem = function(self)
    -- function num : 0_2
    if self.clickEvent ~= nil then (self.clickEvent)(self) end
end

UINLevelItem.DisableSelectLevelItem = function(self, disable)
    -- function num : 0_3
    if not self.isUnlock then return end
    self.isDisable = disable
    self:RefreshNoEntry()
end

UINLevelItem.RefreshNoEntry = function(self)
    -- function num : 0_4
    if not self.isUnlock or self.isDisable then
        ((self.ui).noEntry):SetActive(true)
        if self.isDisable then
            ((self.ui).img_NoEntry):SetIndex(0)
        else

            ((self.ui).img_NoEntry):SetIndex(1)
        end
    else

        ((self.ui).noEntry):SetActive(false)
    end
end

UINLevelItem.LevelItemShowContinue = function(self, show)
    -- function num : 0_5
    ((self.ui)["continue"]):SetActive(show)
end

UINLevelItem.SeletedLevelItem = function(self, select, withTween)
    -- function num : 0_6 , upvalues : CS_DoTween, bottomTweenSizeDelta, aniSelectTweenSizeDelta
    self:__ClearSelectedSequence()
    local seq = nil
    if withTween then seq = (CS_DoTween.Sequence)() end
    if select then
        (((self.ui).img_Pic).gameObject):SetActive(false);
        (((self.ui).img_LevlelPic).gameObject):SetActive(true)
        -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

        if withTween then
            (((self.ui).ani_Select).transform).sizeDelta =
                self.aniSelectTweenSizeDeltaDefault
            local color = ((self.ui).img_LevlelPic).color
            color.a = 0 -- DECOMPILER ERROR at PC35: Confused about usage of register: R5 in 'UnsetPending'
            ;
            ((self.ui).img_LevlelPic).color = color
            color = ((self.ui).ani_Select).color
            color.a = 1 -- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'
            ;
            ((self.ui).ani_Select).color = color
            seq:Join((((self.ui).buttom).transform):DOSizeDelta(
                         bottomTweenSizeDelta, 0.25))
            seq:Join(((self.ui).img_LevlelPic):DOFade(1, 0.25))
            seq:AppendCallback(function()
                -- function num : 0_6_0 , upvalues : self
                (((self.ui).ani_Select).gameObject):SetActive(true)
            end)
        else
            do
                -- DECOMPILER ERROR at PC68: Confused about usage of register: R4 in 'UnsetPending'


                (((self.ui).buttom).transform).sizeDelta = bottomTweenSizeDelta
                do
                    local color = ((self.ui).img_LevlelPic).color
                    color.a = 1 -- DECOMPILER ERROR at PC75: Confused about usage of register: R5 in 'UnsetPending'
                    ;
                    ((self.ui).img_LevlelPic).color = color;
                    (((self.ui).ani_Select).gameObject):SetActive(true)
                    self.__selectSizeTween =
                        ((((self.ui).ani_Select).transform):DOSizeDelta(
                            aniSelectTweenSizeDelta, 1)):SetLoops(-1)
                    self.__selectFadeTween =
                        ((((self.ui).ani_Select):DOFade(0, 1)):SetLoops(-1)):SetDelay(
                            0.3);
                    (((self.ui).ani_Select).gameObject):SetActive(false)
                    if withTween then
                        seq:Join((((self.ui).buttom).transform):DOSizeDelta(
                                     self.bottomTweenSizeDeltaDefault, 0.25))
                        seq:AppendCallback(
                            function()
                                -- function num : 0_6_1 , upvalues : self
                                (((self.ui).img_Pic).gameObject):SetActive(true);
                                (((self.ui).img_LevlelPic).gameObject):SetActive(
                                    false)
                            end)
                    else
                        -- DECOMPILER ERROR at PC132: Confused about usage of register: R4 in 'UnsetPending'


                        (((self.ui).buttom).transform).sizeDelta =
                            self.bottomTweenSizeDeltaDefault;
                        (((self.ui).img_Pic).gameObject):SetActive(true);
                        (((self.ui).img_LevlelPic).gameObject):SetActive(false)
                    end
                    self.__sequence = seq
                end
            end
        end
    end
end

UINLevelItem.ShowBlueDotLevelItem = function(self, show)
    -- function num : 0_7
    ((self.ui).blueDot):SetActive(show)
end

UINLevelItem.RefreshLevelState = function(self)
    -- function num : 0_8 , upvalues : _ENV
    ((self.ui).clearLevel):SetActive(
        (PlayerDataCenter.sectorStage):IsStageComplete((self.stageData).id))
    self.isUnlock = (PlayerDataCenter.sectorStage):IsStageUnlock(
                        (self.stageData).id)
    self:RefreshNoEntry()
end

UINLevelItem.IsLevelUnlock = function(self)
    -- function num : 0_9
    return self.isUnlock
end

UINLevelItem.GetLevelStageData = function(self)
    -- function num : 0_10
    return self.stageData
end

UINLevelItem.__ClearSelectedSequence = function(self)
    -- function num : 0_11
    if self.__sequence ~= nil then
        (self.__sequence):Kill()
        self.__sequence = nil
    end
    if self.__selectSizeTween ~= nil then
        (self.__selectSizeTween):Rewind();
        (self.__selectSizeTween):Kill()
        self.__selectSizeTween = nil;
        (self.__selectFadeTween):Rewind();
        (self.__selectFadeTween):Kill()
        self.__selectFadeTween = nil
    end
end

UINLevelItem.OnReturnLevelItem = function(self)
    -- function num : 0_12
    self:__ClearSelectedSequence()
end

UINLevelItem.OnDelete = function(self)
    -- function num : 0_13 , upvalues : base
    self:__ClearSelectedSequence();
    (base.OnDelete)(self)
end

return UINLevelItem


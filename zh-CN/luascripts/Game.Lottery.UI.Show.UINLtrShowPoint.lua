-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLtrShowPoint = class("UINLtrShowPoint", UIBaseNode)
local base = UIBaseNode
UINLtrShowPoint.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINLtrShowPoint.InitLtrShowPoint = function(self, pos, fromPos, rare, from)
  -- function num : 0_1 , upvalues : _ENV
  local color = ((self.ui).imgRing1).color
  color.a = 0
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).imgRing1).color = color
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).imgRing2).color = color
  self:__ClearLineTween()
  self:__ClearPointTween()
  ;
  ((self.ui).flare):SetActive(false)
  self.bingoItem = nil
  self.rare = rare
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.transform).anchoredPosition = pos
  if from ~= nil and from.entered == true then
    from.entered = false
    ;
    ((from.ui).anim):Rewind()
    ;
    ((from.ui).anim):Play("UI_LSPoint_Exit")
  end
  if rare == nil then
    self.pointFadeTween = ((self.ui).img_Point):DOFade(0, 0.5)
    ;
    (((self.ui).line).gameObject):SetActive(false)
  else
    ;
    ((self.ui).anim):Play("UI_LSPoint_Enter")
    self.entered = true
    ;
    (((self.ui).line).gameObject):SetActive(true)
    local localFromPos = fromPos - pos
    -- DECOMPILER ERROR at PC70: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (((self.ui).line).transform).anchoredPosition = localFromPos
    local cross = (Vector3.Cross)((Vector3.New)(localFromPos.x, localFromPos.y, 0), Vector3.right)
    local angle = (Vector2.Angle)(localFromPos, Vector2.right)
    if cross.z > 0 then
      angle = angle * -1
    end
    angle = angle + 180
    -- DECOMPILER ERROR at PC102: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (((self.ui).line).transform).localEulerAngles = (Vector3.New)(0, 0, angle)
    local sizeDelta = (((self.ui).line).transform).sizeDelta
    sizeDelta.x = 0
    -- DECOMPILER ERROR at PC111: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (((self.ui).line).transform).sizeDelta = sizeDelta
    sizeDelta.x = (Vector2.Distance)(localFromPos, Vector2.zero)
    self._lineTween = ((((self.ui).line).transform):DOSizeDelta(sizeDelta, 0.3)):SetDelay(0.5)
  end
end

UINLtrShowPoint.SetLtrPointBingo = function(self, bingoItem)
  -- function num : 0_2
  self.bingoItem = bingoItem
end

UINLtrShowPoint.GetLtrPointBingo = function(self)
  -- function num : 0_3
  return self.bingoItem
end

UINLtrShowPoint.ShowLtrSPointFlare = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.entered == false then
    return 
  end
  ;
  ((self.ui).flare):SetActive(true)
  local color = ((self.ui).rareColor)[self.rare]
  local main1 = ((self.ui).flareParticle1).main
  local startColor = main1.startColor
  startColor.color = color
  main1.startColor = startColor
  local main2 = ((self.ui).flareParticle2).main
  main2.startColor = startColor
  if self.rare == eHeroCardRareType.R then
    AudioManager:PlayAudioById(1048)
  else
    if self.rare == eHeroCardRareType.SR then
      AudioManager:PlayAudioById(1049)
    else
      if self.rare == eHeroCardRareType.SSR then
        AudioManager:PlayAudioById(1050)
      end
    end
  end
end

UINLtrShowPoint.__ClearLineTween = function(self)
  -- function num : 0_5
  if self._lineTween ~= nil then
    (self._lineTween):Kill()
    self._lineTween = nil
  end
end

UINLtrShowPoint.__ClearPointTween = function(self)
  -- function num : 0_6
  if self.pointFadeTween ~= nil then
    (self.pointFadeTween):Kill()
    self.pointFadeTween = nil
  end
end

UINLtrShowPoint.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  self:__ClearLineTween()
  self:__ClearPointTween()
  ;
  (base.OnDelete)(self)
end

return UINLtrShowPoint

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLtrShowPoint = class("UINLtrShowPoint", UIBaseNode)
local base = UIBaseNode
UINLtrShowPoint.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINLtrShowPoint.InitLtrShowPoint = function(self, pos, fromPos, rare, from)
    -- function num : 0_1 , upvalues : _ENV
    local color = ((self.ui).imgRing1).color
    color.a = 0 -- DECOMPILER ERROR at PC6: Confused about usage of register: R6 in 'UnsetPending'
    ;
    ((self.ui).imgRing1).color = color -- DECOMPILER ERROR at PC9: Confused about usage of register: R6 in 'UnsetPending'
    ;
    ((self.ui).imgRing2).color = color
    self:__ClearLineTween()
    self:__ClearPointTween();
    ((self.ui).flare):SetActive(false)
    self.bingoItem = nil
    self.rare = rare -- DECOMPILER ERROR at PC22: Confused about usage of register: R6 in 'UnsetPending'
    ;
    (self.transform).anchoredPosition = pos
    if from ~= nil and from.entered == true then
        from.entered = false;
        ((from.ui).anim):Rewind();
        ((from.ui).anim):Play("UI_LSPoint_Exit")
    end
    if rare == nil then
        self.pointFadeTween = ((self.ui).img_Point):DOFade(0, 0.5);
        (((self.ui).line).gameObject):SetActive(false)
    else

        ((self.ui).anim):Play("UI_LSPoint_Enter")
        self.entered = true;
        (((self.ui).line).gameObject):SetActive(true)
        local localFromPos = fromPos - pos -- DECOMPILER ERROR at PC70: Confused about usage of register: R7 in 'UnsetPending'
        ;
        (((self.ui).line).transform).anchoredPosition = localFromPos
        local cross = (Vector3.Cross)((Vector3.New)(localFromPos.x,
                                                    localFromPos.y, 0),
                                      Vector3.right)
        local angle = (Vector2.Angle)(localFromPos, Vector2.right)
        if cross.z > 0 then angle = angle * -1 end
        angle = angle + 180 -- DECOMPILER ERROR at PC102: Confused about usage of register: R9 in 'UnsetPending'
        ;
        (((self.ui).line).transform).localEulerAngles =
            (Vector3.New)(0, 0, angle)
        local sizeDelta = (((self.ui).line).transform).sizeDelta
        sizeDelta.x = 0 -- DECOMPILER ERROR at PC111: Confused about usage of register: R10 in 'UnsetPending'
        ;
        (((self.ui).line).transform).sizeDelta = sizeDelta
        sizeDelta.x = (Vector2.Distance)(localFromPos, Vector2.zero)
        self._lineTween = ((((self.ui).line).transform):DOSizeDelta(sizeDelta,
                                                                    0.3)):SetDelay(
                              0.5)
    end
end

UINLtrShowPoint.SetLtrPointBingo = function(self, bingoItem)
    -- function num : 0_2
    self.bingoItem = bingoItem
end

UINLtrShowPoint.GetLtrPointBingo = function(self)
    -- function num : 0_3
    return self.bingoItem
end

UINLtrShowPoint.ShowLtrSPointFlare = function(self)
    -- function num : 0_4 , upvalues : _ENV
    if self.entered == false then return end
    ((self.ui).flare):SetActive(true)
    local color = ((self.ui).rareColor)[self.rare]
    local main1 = ((self.ui).flareParticle1).main
    local startColor = main1.startColor
    startColor.color = color
    main1.startColor = startColor
    local main2 = ((self.ui).flareParticle2).main
    main2.startColor = startColor
    if self.rare == eHeroCardRareType.R then
        AudioManager:PlayAudioById(1048)
    else
        if self.rare == eHeroCardRareType.SR then
            AudioManager:PlayAudioById(1049)
        else
            if self.rare == eHeroCardRareType.SSR then
                AudioManager:PlayAudioById(1050)
            end
        end
    end
end

UINLtrShowPoint.__ClearLineTween = function(self)
    -- function num : 0_5
    if self._lineTween ~= nil then
        (self._lineTween):Kill()
        self._lineTween = nil
    end
end

UINLtrShowPoint.__ClearPointTween = function(self)
    -- function num : 0_6
    if self.pointFadeTween ~= nil then
        (self.pointFadeTween):Kill()
        self.pointFadeTween = nil
    end
end

UINLtrShowPoint.OnDelete = function(self)
    -- function num : 0_7 , upvalues : base
    self:__ClearLineTween()
    self:__ClearPointTween();
    (base.OnDelete)(self)
end

return UINLtrShowPoint


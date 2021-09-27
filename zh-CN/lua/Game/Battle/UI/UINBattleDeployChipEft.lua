local UINBattleDeployChipEft = class("UINBattleDeployChipEft", UIBaseNode)
local base = UIBaseNode
local CS_DOTween = ((CS.DG).Tweening).DOTween
UINBattleDeployChipEft.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINBattleDeployChipEft.StartEft = function(self, skills, startPos, targetObj, resloader)
  -- function num : 0_1 , upvalues : _ENV, CS_DOTween
  self._eftRuning = true
  self.resloader = resloader
  self.skills = skills
  startPos.z = 0
  self.targetTr = targetObj.transform
  self.oriTargetWorldPos = (self.targetTr).position
  self.timerId = TimerManager:StartTimer(0.1, self.CheckTargetMove, self)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).lineRenderNor).enabled = true
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).lineRenderHigh).enabled = true
  local matLineNor = ((self.ui).lineRenderNor):GetMaterial()
  local matLineHigh = ((self.ui).lineRenderHigh):GetMaterial()
  matLineNor:SetFloat("_BFAlpha", 0)
  matLineHigh:SetFloat("_BFAlpha", 0)
  matLineHigh:SetFloat("_BFPanner01", 0)
  ;
  (((self.ui).eftUnitChipEft).gameObject):SetActive(false)
  ;
  (((self.ui).eftUnitChipEftShow).gameObject):SetActive(false)
  ;
  (((self.ui).eftUnitChipEft).transform):SetParent(self.targetTr)
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (((self.ui).eftUnitChipEft).transform).localPosition = Vector3.zero
  -- DECOMPILER ERROR at PC71: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (((self.ui).eftUnitChipEft).transform).localScale = Vector3.one
  ;
  (((self.ui).eftUnitChipEftShow).transform):SetParent(self.targetTr)
  -- DECOMPILER ERROR at PC83: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (((self.ui).eftUnitChipEftShow).transform).localPosition = Vector3.zero
  -- DECOMPILER ERROR at PC89: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (((self.ui).eftUnitChipEftShow).transform).localScale = Vector3.one
  if self.eftTween ~= nil then
    (self.eftTween):Kill()
    self.eftTween = nil
  end
  local sequence1 = (CS_DOTween.Sequence)()
  sequence1:AppendInterval((self.ui).lineAppearDelayTime)
  sequence1:Append(matLineNor:DOFloat(1, "_BFAlpha", (self.ui).lineAppearTime))
  sequence1:Join(matLineHigh:DOFloat(1, "_BFAlpha", (self.ui).lineAppearTime))
  local sequence2 = (CS_DOTween.Sequence)()
  sequence2:AppendInterval((self.ui).lineLightDelayTime)
  sequence2:Append(matLineHigh:DOFloat(1, "_BFPanner01", (self.ui).lineLightTime))
  local sequence3 = (CS_DOTween.Sequence)()
  sequence3:AppendInterval((self.ui).lineMissDelayTime)
  sequence3:Append(matLineNor:DOFloat(0, "_BFAlpha", (self.ui).lineMissTime))
  sequence3:Join(matLineHigh:DOFloat(0, "_BFAlpha", (self.ui).lineMissTime))
  local sequence4 = (CS_DOTween.Sequence)()
  sequence4:AppendInterval((self.ui).buttonEftDelayTime)
  sequence4:AppendCallback(function()
    -- function num : 0_1_0 , upvalues : self
    (((self.ui).eftUnitChipEft).gameObject):SetActive(true)
  end
)
  self.eftTween = (CS_DOTween.Sequence)()
  ;
  (self.eftTween):AppendInterval((self.ui).eftStarDelayTime)
  ;
  (self.eftTween):AppendCallback(function()
    -- function num : 0_1_1 , upvalues : _ENV, self, startPos
    local x, y = UIManager:World2UIPositionOut(self.targetTr, (self.ui).chipEft, UIManager:GetUICamera(), UIManager:GetMainCamera())
    local endPos = (Vector3.New)(x, y, 0)
    ;
    ((self.ui).lineRenderNor):SetPosition(0, startPos)
    ;
    ((self.ui).lineRenderNor):SetPosition(1, (Vector3.New)(startPos.x, endPos.y, 0))
    ;
    ((self.ui).lineRenderNor):SetPosition(2, endPos)
    ;
    ((self.ui).lineRenderHigh):SetPosition(0, startPos)
    ;
    ((self.ui).lineRenderHigh):SetPosition(1, (Vector3.New)(startPos.x, endPos.y, 0))
    ;
    ((self.ui).lineRenderHigh):SetPosition(2, endPos)
  end
)
  ;
  (self.eftTween):Append(sequence1)
  ;
  (self.eftTween):Join(sequence2)
  ;
  (self.eftTween):Join(sequence3)
  ;
  (self.eftTween):Join(sequence4)
  ;
  (self.eftTween):SetAutoKill(false)
  self:PlayHeroChipShow()
end

UINBattleDeployChipEft.PlayHeroChipShow = function(self)
  -- function num : 0_2 , upvalues : _ENV, CS_DOTween
  local maxEftCount = #(self.ui).arr_chipEft
  ;
  (((self.ui).eftUnitChipEftShow).gameObject):SetActive(true)
  ;
  ((self.ui).eftUnitChipEftShow):SetCountAllActive(false)
  if self.customMats == nil then
    self.customMats = {}
    for i = 1, maxEftCount do
      local newMat = (((CS.UnityEngine).Object).Instantiate)((((self.ui).arr_chipEft)[i]):GetMaterial())
      -- DECOMPILER ERROR at PC34: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (self.customMats)[i] = newMat
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (((self.ui).arr_chipEft)[i]).material = newMat
    end
  end
  do
    local singleUnitTime = (self.ui).EftTime / (math.ceil)(#self.skills / (self.ui).maxShowOnceTime)
    do
      if singleUnitTime <= 1 or not singleUnitTime then
        singleUnitTime = 1
      end
      for _,parSys in ipairs((self.ui).arr_allShowEft) do
        -- DECOMPILER ERROR at PC66: Confused about usage of register: R8 in 'UnsetPending'

        (parSys.main).duration = singleUnitTime - singleUnitTime / (self.ui).maxShowOnceTime
      end
      if self.eftChipShowTween ~= nil then
        (self.eftChipShowTween):Kill()
        self.eftChipShowTween = nil
      end
      local sequence = (CS_DOTween.Sequence)()
      sequence:AppendInterval((self.ui).chipEftDelayTime + (self.ui).eftStarDelayTime)
      sequence:AppendCallback(function()
    -- function num : 0_2_0 , upvalues : self, maxEftCount, _ENV
    self.eftObjIdOrders = {}
    local oriTable = nil
    for i = 1, #self.skills do
      if i % (self.ui).maxShowOnceTime == 1 then
        oriTable = {}
        for i = 1, maxEftCount do
          if (self.eftObjIdOrders)[#self.eftObjIdOrders] ~= i then
            (table.insert)(oriTable, i)
          end
        end
      end
      do
        do
          local index = (math.random)(#oriTable)
          ;
          (table.insert)(self.eftObjIdOrders, oriTable[index])
          ;
          (table.remove)(oriTable, index)
          -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  end
)
      for i = 1, #self.skills do
        sequence:AppendCallback(function()
    -- function num : 0_2_1 , upvalues : self, i, _ENV
    local skillData = (self.skills)[i]
    local index = (self.eftObjIdOrders)[i]
    ;
    ((self.ui).eftUnitChipEftShow):SetCountActive(index - 1, false)
    ;
    ((self.ui).eftUnitChipEftShow):SetCountActive(index - 1, true)
    local mat = (self.customMats)[index]
    local itemCfg = (ConfigData.item)[skillData.itemId]
    if itemCfg ~= nil then
      local sprite = CRH:GetSpriteByItemConfig(itemCfg)
      local newTexture = sprite.texture
      local size = (Vector2.New)((sprite.rect).width / newTexture.width, (sprite.rect).height / newTexture.height)
      local diffWidth = ((sprite.rect).width - (sprite.textureRect).width) / 2
      local diffHeight = ((sprite.rect).height - (sprite.textureRect).height) / 2
      local offset = (Vector2.New)((((sprite.textureRect).position).x - diffWidth) / newTexture.width, (((sprite.textureRect).position).y - diffHeight) / newTexture.height)
      mat:SetTexture("_Maintex", newTexture)
      mat:SetTextureOffset("_Maintex", offset)
      mat:SetTextureScale("_Maintex", size)
      local color = (ChipDetailColor[eChipLevelToQaulity[skillData.level]]).light
      mat:SetColor("_LevelColor", color)
    end
  end
)
        if i % (self.ui).maxShowOnceTime == 0 or i == #self.skills then
          sequence:AppendInterval(singleUnitTime)
        else
          sequence:AppendInterval(singleUnitTime / (self.ui).maxShowOnceTime)
        end
      end
      sequence:SetLoops(-1)
      self.eftChipShowTween = sequence
      ;
      (self.eftChipShowTween):SetAutoKill(false)
    end
  end
end

UINBattleDeployChipEft.EndEft = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if not self._eftRuning then
    return 
  end
  self._eftRuning = false
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  if self.eftTween ~= nil then
    (self.eftTween):Kill()
    self.eftTween = nil
  end
  if self.eftChipShowTween ~= nil then
    (self.eftChipShowTween):Kill()
    self.eftChipShowTween = nil
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).lineRenderNor).enabled = false
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).lineRenderHigh).enabled = false
  ;
  (((self.ui).eftUnitChipEft).transform):SetParent(self.transform)
  ;
  (((self.ui).eftUnitChipEftShow).transform):SetParent(self.transform)
  ;
  (((self.ui).eftUnitChipEft).gameObject):SetActive(false)
  ;
  (((self.ui).eftUnitChipEftShow).gameObject):SetActive(false)
end

UINBattleDeployChipEft.CheckTargetMove = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if not IsNull(self.targetTr) and self.oriTargetWorldPos == (self.targetTr).position then
    return 
  end
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  if self.eftTween ~= nil then
    (self.eftTween):Kill()
    self.eftTween = nil
  end
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).lineRenderNor).enabled = false
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).lineRenderHigh).enabled = false
  ;
  (((self.ui).eftUnitChipEft).gameObject):SetActive(false)
end

UINBattleDeployChipEft.OnHide = function(self)
  -- function num : 0_5 , upvalues : base
  self:EndEft()
  ;
  (base.OnHide)(self)
end

UINBattleDeployChipEft.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.OnDelete)(self)
  if self.customMats ~= nil then
    for _,mat in ipairs(self.customMats) do
      DestroyUnityObject(mat)
    end
    self.customMats = nil
  end
end

return UINBattleDeployChipEft


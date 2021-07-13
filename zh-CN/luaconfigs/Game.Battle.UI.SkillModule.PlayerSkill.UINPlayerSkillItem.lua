-- params : ...
-- function num : 0 , upvalues : _ENV
local UINPlayerSkillItem = class("UINPlayerSkillItem", UIBaseNode)
local base = UIBaseNode
UINPlayerSkillItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_CD).enabled = false
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tran_Line).localScale = Vector3.zero
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self.ui).ani_mpMax).transform).localScale = Vector3.zero
  ;
  (((self.ui).Ani_Item).onComplete):AddListener(function()
    -- function num : 0_0_0 , upvalues : self, _ENV
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

    ((self.ui).tran_Line).localScale = Vector3.zero
  end
)
  ;
  (((self.ui).Ani_Item).onPlay):AddListener(function()
    -- function num : 0_0_1 , upvalues : self, _ENV
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

    ((self.ui).tran_Line).localScale = Vector3.one
  end
)
  self._defaultPressDurationTime = ((self.ui).btnPlus_Root).pressDurationTime
  self._defaultPressRepeatInterval = ((self.ui).btnPlus_Root).pressRepeatInterval
end

UINPlayerSkillItem.InitPlayerSkillItem = function(self, battleSkill, reslaoder, clickFunc, longPressFunc, pressUpFunc, pressDownFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.battleSkill = battleSkill
  self.skillId = battleSkill.dataId
  self.clickFunc = clickFunc
  self.longPressFunc = longPressFunc
  self.pressUpFunc = pressUpFunc
  self.pressDownFunc = pressDownFunc
  self.isSkillNoCD = battleSkill.totalCDTime == 0
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Cost).text = tostring((battleSkill.skillCfg).PlayerMpCost)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).enabled = false
  ;
  ((self.ui).cantUse):SetActive(false)
  ;
  ((self.ui).img_ManualSkill):SetActive(battleSkill.isManualMode)
  if not (string.IsNullOrEmpty)((battleSkill.skillCfg).Icon) then
    reslaoder:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommanderSkillIcons"), function(spriteAtlas)
    -- function num : 0_1_0 , upvalues : self, battleSkill
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = spriteAtlas:GetSprite((battleSkill.skillCfg).Icon)
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).enabled = true
  end
)
  end
  if not (self.battleSkill).isManualMode then
    (((self.ui).btnPlus_Root).onClick):AddListener(BindCallback(self, self.__OnSkillClicked))
  else
    (((self.ui).btnPlus_Root).onPressDown):AddListener(BindCallback(self, self.__OnSkillPointDown))
  end
  -- DECOMPILER ERROR at PC78: Confused about usage of register: R7 in 'UnsetPending'

  if self.isSkillNoCD and not battleSkill.isManualMode then
    ((self.ui).btnPlus_Root).responseOnceByPress = false
    -- DECOMPILER ERROR at PC84: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).btnPlus_Root).pressDurationTime = (ConfigData.game_config).noCdCommanderSkillInterval
    -- DECOMPILER ERROR at PC90: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).btnPlus_Root).pressRepeatInterval = (ConfigData.game_config).noCdCommanderSkillInterval
  else
    -- DECOMPILER ERROR at PC94: Confused about usage of register: R7 in 'UnsetPending'

    ((self.ui).btnPlus_Root).responseOnceByPress = true
    -- DECOMPILER ERROR at PC98: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).btnPlus_Root).pressDurationTime = self._defaultPressDurationTime
    -- DECOMPILER ERROR at PC102: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).btnPlus_Root).pressRepeatInterval = self._defaultPressRepeatInterval
  end
  ;
  (((self.ui).btnPlus_Root).onPress):AddListener(BindCallback(self, self.__OnSkillLongPress))
  ;
  (((self.ui).btnPlus_Root).onPressUp):AddListener(BindCallback(self, self.__OnSkillPressUp))
  self.isSkillDown = false
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

UINPlayerSkillItem.RefreshPlayerSkillItemMp = function(self, curMp, isMax)
  -- function num : 0_2 , upvalues : _ENV
  if type(curMp) == "number" then
    self.curMp = curMp
  else
    self.curMp = curMp.RawValue
  end
  local decoloration = 0.5
  decoloration = self.curMp == nil or (((self.battleSkill).skillCfg).PlayerMpCost <= self.curMp and 1) or 0.5
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).Fade).alpha = decoloration
  self:__SetPlayerSkillMPMaxUI(isMax)
end

UINPlayerSkillItem.OnUpdateLogic_PlayerSkillItem = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if not self.isSkillNoCD then
    local skill = self.battleSkill
    if skill:IsReadyToTake() then
      if ((self.ui).img_CD).enabled then
        self:RefreshPlayerSkillItemMp(self.curMp)
      end
      -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).img_CD).enabled = false
    else
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).img_CD).enabled = true
      self.curCDRatio = (skill.totalCDTime - skill.UICdTime) / skill.totalCDTime
      self.nextCDRatio = (skill.totalCDTime - skill.NextUICdTime) / skill.totalCDTime
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).img_CD).fillAmount = self.curCDRatio
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).Fade).alpha = 0.5
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (((self.ui).ani_mpMax).transform).localScale = Vector3.zero
    end
  end
end

UINPlayerSkillItem.OnUpdateRender_PlayerSkillItem = function(self, deltaTime, interpolation)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  if not self.isSkillNoCD and ((self.ui).img_CD).enabled then
    ((self.ui).img_CD).fillAmount = (Mathf.Lerp)(self.curCDRatio, self.nextCDRatio, interpolation)
  end
end

UINPlayerSkillItem.__OnSkillClicked = function(self)
  -- function num : 0_5
  if ((self.ui).cantUse).activeSelf then
    return 
  end
  if not (self.battleSkill).isManualMode then
    if ((self.ui).Fade).alpha == 1 then
      ((self.ui).Ani_Item):DORestart()
    end
    if self.clickFunc ~= nil then
      (self.clickFunc)(self.battleSkill)
    end
  end
end

UINPlayerSkillItem.__OnSkillPointDown = function(self)
  -- function num : 0_6
  if (self.battleSkill).isManualMode and not self.isSkillDown and self.pressDownFunc ~= nil then
    (self.pressDownFunc)(self.battleSkill)
  end
end

UINPlayerSkillItem.__OnSkillLongPress = function(self)
  -- function num : 0_7
  if self.longPressFunc ~= nil then
    (self.longPressFunc)(self, self.battleSkill)
  end
end

UINPlayerSkillItem.__OnSkillPressUp = function(self)
  -- function num : 0_8
  if self.pressUpFunc ~= nil then
    (self.pressUpFunc)()
  end
  if self.isSkillDown then
    self.isSkillDown = false
  end
end

UINPlayerSkillItem.__SetPlayerSkillMPMaxUI = function(self, isMax)
  -- function num : 0_9
  if ((self.battleSkill).skillCfg).PlayerMpCost <= self.curMp and isMax then
    (((self.ui).ani_mpMax).transform):SetLocalScale(1, 1, 1)
  else
    ;
    (((self.ui).ani_mpMax).transform):SetLocalScale(0, 0, 0)
  end
  if isMax then
    ((self.ui).ani_mpMax):DORestart()
  else
    ;
    ((self.ui).ani_mpMax):DOPause()
  end
end

UINPlayerSkillItem.SetSkillItemLock = function(self, isLock)
  -- function num : 0_10
  ((self.ui).cantUse):SetActive(isLock)
end

UINPlayerSkillItem.OnDelete = function(self)
  -- function num : 0_11 , upvalues : base
  self.isSkillDown = false
  ;
  ((self.ui).ani_mpMax):DOKill()
  ;
  (base.OnDelete)(self)
end

return UINPlayerSkillItem


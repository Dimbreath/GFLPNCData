local UINPlayerConsumeSkillItem = class("UINPlayerConsumeSkillItem", UIBaseNode)
local base = UIBaseNode
UINPlayerConsumeSkillItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_CD).enabled = false
  ;
  (((self.ui).btnPlus_Root).onClick):AddListener(BindCallback(self, self.__OnSkillClicked))
  ;
  (((self.ui).btnPlus_Root).onPress):AddListener(BindCallback(self, self.__OnSkillLongPress))
  ;
  (((self.ui).btnPlus_Root).onPressUp):AddListener(BindCallback(self, self.__OnSkillPressUp))
end

UINPlayerConsumeSkillItem.InitPlayerConsumeSkillItem = function(self, battleSkill, clickFunc, longPressFunc, pressUpFunc, pressDownFunc)
  -- function num : 0_1
  self.battleSkill = battleSkill
  self.skillId = battleSkill.dataId
  self.clickFunc = clickFunc
  self.longPressFunc = longPressFunc
  self.pressUpFunc = pressUpFunc
  self.pressDownFunc = pressDownFunc
  self.isSkillNoCD = battleSkill.totalCDTime == 0
  local battleSkillCfg = (self.battleSkill).skillCfg
  self:RefreshData(battleSkillCfg)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINPlayerConsumeSkillItem.InitPlayerConsumeSkillJustShow = function(self, battleSkillCfg)
  -- function num : 0_2
  self.skillId = battleSkillCfg.Id
  self:RefreshData(battleSkillCfg)
end

UINPlayerConsumeSkillItem.RefreshData = function(self, battleSkillCfg)
  -- function num : 0_3 , upvalues : _ENV
  local spriteIcon = CRH:GetSprite(battleSkillCfg.Icon, CommonAtlasType.SkillIcon)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_SkillIcon).sprite = spriteIcon
  local skillTag = battleSkillCfg.SkillTag
  ;
  ((self.ui).img_SkillTypeLine):SetIndex(skillTag)
  ;
  ((self.ui).img_SkillType):SetIndex(skillTag)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (((self.ui).img_SkillType).image).color = eBattleSkillTypeColor[battleSkillCfg.TypeColor]
end

UINPlayerConsumeSkillItem.OnUpdateLogic_PlayerConsumeSkillItem = function(self)
  -- function num : 0_4
  local skill = self.battleSkill
  local canUseTime = skill.useLimitTime - skill.curUseTime
  if self.canUseTime ~= canUseTime then
    self.canUseTime = canUseTime
    if self.canUseTime <= 0 then
      self:Hide()
    else
      self:Show()
    end
  end
  if not self.isSkillNoCD then
    local skill = self.battleSkill
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R4 in 'UnsetPending'

    if skill:IsReadyToTake() then
      ((self.ui).img_CD).enabled = false
    else
      -- DECOMPILER ERROR at PC30: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).img_CD).enabled = true
      self.curCDRatio = (skill.totalCDTime - skill.UICdTime) / skill.totalCDTime
      self.nextCDRatio = (skill.totalCDTime - skill.NextUICdTime) / skill.totalCDTime
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).img_CD).fillAmount = self.curCDRatio
    end
  end
end

UINPlayerConsumeSkillItem.OnUpdateRender_PlayerConsumeSkillItem = function(self, deltaTime, interpolation)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  if not self.isSkillNoCD and ((self.ui).img_CD).enabled then
    ((self.ui).img_CD).fillAmount = (Mathf.Lerp)(self.curCDRatio, self.nextCDRatio, interpolation)
  end
end

UINPlayerConsumeSkillItem.__OnSkillClicked = function(self)
  -- function num : 0_6
  if self.clickFunc ~= nil then
    (self.clickFunc)(self.battleSkill)
  end
end

UINPlayerConsumeSkillItem.__OnSkillLongPress = function(self)
  -- function num : 0_7
  if self.longPressFunc ~= nil then
    (self.longPressFunc)(self, self.battleSkill)
  end
end

UINPlayerConsumeSkillItem.__OnSkillPressUp = function(self)
  -- function num : 0_8
  if self.pressUpFunc ~= nil then
    (self.pressUpFunc)()
  end
end

UINPlayerConsumeSkillItem.SetSkillBtnEnabled = function(self, enabled)
  -- function num : 0_9
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).btnPlus_Root).enabled = enabled
end

UINPlayerConsumeSkillItem.OnDelete = function(self)
  -- function num : 0_10 , upvalues : base
  (base.OnDelete)(self)
end

return UINPlayerConsumeSkillItem


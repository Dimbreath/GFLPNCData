local UINBaseChipDetail = class("UINBaseChipDetail", UIBaseNode)
local base = UIBaseNode
local UINChipLevel = require("Game.CommonUI.Chip.UINChipLevel")
local UINChipDetailSuitItem = require("Game.CommonUI.Chip.UINChipDetailSuitItem")
local UINChipDetailSuitInfo = require("Game.CommonUI.Chip.UINChipDetailSuitInfo")
local cs_Edge = ((CS.UnityEngine).RectTransform).Edge
UINBaseChipDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipDetailSuitItem, UINChipDetailSuitInfo
  if (self.ui).rootTransform ~= nil or not self.transform then
    local transform = (self.ui).rootTransform
  end
  ;
  (UIUtil.LuaUIBindingTable)(transform, self.ui)
  ;
  ((self.ui).obj_Level):SetActive(false)
  local suitItem = (UINChipDetailSuitItem.New)()
  suitItem:Init((self.ui).obj_SuitItem)
  self.suitItem = suitItem
  self.suitInfoNode = (UINChipDetailSuitInfo.New)()
  ;
  (self.suitInfoNode):Init((self.ui).chipSuitDetail)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_RichIntro, self, self._ShowRichIntro)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_suitInfo, self, self._OnClickSuitInfo)
  self._onDescribeChange = BindCallback(self, self._OnDescribeChange)
  MsgCenter:AddListener(eMsgEventId.DescribeSettingChange, self._onDescribeChange)
end

UINBaseChipDetail.InitBaseChipDetail = function(self, index, chipData, dynPlayer, resloader, isHideNxtLvlInfo, isOwnData)
  -- function num : 0_1
  self.index = index
  self._chipData = chipData
  self._resloader = resloader
  self._isOwnData = isOwnData
  self._dynPlayer = dynPlayer
  self._isHideNxtLvlInfo = isHideNxtLvlInfo
  ;
  (self.suitInfoNode):Hide()
  ;
  ((self.ui).chipInfoNode):SetActive(true)
  self:_InitChipLevel(chipData, dynPlayer, isHideNxtLvlInfo, isOwnData)
  self:_InitChipPlane(chipData, dynPlayer, isOwnData)
  self:_InitChipDescription(chipData, dynPlayer, isHideNxtLvlInfo)
end

UINBaseChipDetail._InitChipPlane = function(self, chipData, dynPlayer, isOwnData)
  -- function num : 0_2 , upvalues : _ENV
  local quality = chipData:GetQuality()
  local colData = ChipDetailColor[quality]
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_QualityCol).color = colData.normal
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_QualityLightCol).color = colData.light
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_CornerIcon).sprite = CRH:GetSprite(chipData:GetChipMarkIcon(), CommonAtlasType.ExplorationIcon)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = chipData:GetName()
  local isConsumeChip = chipData:IsConsumeSkillChip()
  ;
  (((self.ui).img_Icon).gameObject):SetActive(not isConsumeChip)
  ;
  ((self.ui).skillIconNode):SetActive(isConsumeChip)
  if isConsumeChip then
    local color = chipData:GetColor()
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.ui).img_SkillIcon).sprite = CRH:GetSprite(chipData:GetIcon(), CommonAtlasType.SkillIcon)
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.ui).img_SkillQuality).color = color
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.ui).img_SkillMark).color = color
  else
    do
      do
        local iconSprite = CRH:GetSprite(chipData:GetIcon())
        -- DECOMPILER ERROR at PC68: Confused about usage of register: R8 in 'UnsetPending'

        ;
        ((self.ui).img_Icon).sprite = iconSprite
        -- DECOMPILER ERROR at PC71: Confused about usage of register: R8 in 'UnsetPending'

        ;
        ((self.ui).img_IconSD).sprite = iconSprite
        local unlockChipSuit = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TagSuit)
        local chipCfg = chipData:GetChipCfg()
        local tagId = chipCfg.fun_tag
        ;
        ((self.ui).fx_AddSuit):SetActive(false)
        ;
        ((self.ui).fx_NewSuitEffect):SetActive(false)
        if unlockChipSuit and tagId ~= 0 and not isConsumeChip then
          ((self.ui).suitList):SetActive(true)
          local isFirstGet = false
          do
            if dynPlayer ~= nil then
              local playerChipDic = dynPlayer:GetNormalChipDic()
              isFirstGet = playerChipDic[chipData.dataId] == nil
            end
            local suitItem = self.suitItem
            if dynPlayer ~= nil then
              local haveCount, maxCount = dynPlayer:GetChipTagIdCount(tagId)
              suitItem:InitChipDetailSuitAndCount(tagId, haveCount, maxCount, dynPlayer, isOwnData, isFirstGet)
              if isFirstGet then
                ((self.ui).fx_AddSuit):SetActive(true)
                local tagSuitCfg = ((ConfigData.chip_tag).tag_suits)[tagId]
                for _,tag_suit in pairs(tagSuitCfg) do
                  local active = false
                  if tag_suit.number <= haveCount + 1 then
                    active = true
                  end
                  if active and haveCount < tag_suit.number then
                    ((self.ui).fx_NewSuitEffect):SetActive(true)
                    break
                  end
                end
              end
            else
              suitItem:InitChipDetailSuit(tagId)
            end
            do
              local chipTagCfg = (ConfigData.chip_tag)[tagId]
              if chipTagCfg == nil then
                error("chip tag cfg is null,id:" .. tostring(tagId))
                return 
              end
              -- DECOMPILER ERROR at PC183: Confused about usage of register: R13 in 'UnsetPending'

              ;
              ((self.ui).tex_SuitName).text = (LanguageUtil.GetLocaleText)(chipTagCfg.tag_name)
              ;
              ((self.ui).suitList):SetActive(false)
              ;
              ((self.ui).obj_time):SetActive(false)
              if isConsumeChip then
                return 
              end
              if #chipCfg.attribute_id > 0 then
                return 
              end
              local hasCD, CD = chipData:TryGetSkillCD((self.level):GetCurrLevel(), 2)
              ;
              ((self.ui).obj_time):SetActive(hasCD)
              if hasCD then
                ((self.ui).tex_Time):SetIndex(0, CD)
              end
              -- DECOMPILER ERROR: 12 unprocessed JMP targets
            end
          end
        end
      end
    end
  end
end

UINBaseChipDetail._InitChipLevel = function(self, chipData, dynPlayer, isHideNxtLvlInfo, isOwnData)
  -- function num : 0_3 , upvalues : UINChipLevel
  if self.level == nil then
    self.level = (UINChipLevel.New)()
    ;
    (self.level):Init((self.ui).obj_Level)
    ;
    (self.level):Show()
  end
  ;
  (self.level):InitChipLevel(chipData, dynPlayer, isHideNxtLvlInfo, isOwnData)
end

UINBaseChipDetail._InitChipDescription = function(self, chipData, dynPlayer, _isHideNxtLvlInfo)
  -- function num : 0_4 , upvalues : _ENV
  local haveNum = 0
  do
    if dynPlayer ~= nil then
      local playerChipDic = dynPlayer:GetNormalChipDic()
      if playerChipDic[chipData.dataId] ~= nil then
        haveNum = (playerChipDic[chipData.dataId]):GetCount()
      end
    end
    local nextLevel = (self.level):GetNextLevel()
    self.uiIntroData = nil
    ;
    (((self.ui).btn_RichIntro).gameObject):SetActive(false)
    local isShowDetail = (CommonUtil.GetDetailDescribeSetting)(eGameSetDescType.chip)
    local chipCfg = chipData:GetChipCfg()
    if #chipCfg.attribute_id > 0 then
      local attrId = (chipCfg.attribute_id)[1]
      local initValue = (chipCfg.attribute_initial)[1]
      local fluenceIntro = ConfigData:GetChipinfluenceIntro(chipCfg.id)
      local increaseVal = (chipCfg.level_increase)[1]
      local attrInfo = nil
      if not _isHideNxtLvlInfo then
        if haveNum > 0 and haveNum < nextLevel then
          attrInfo = (BattleUtil.GetChipAttrUpgradeInfo)(attrId, initValue, increaseVal, haveNum, nextLevel)
        else
          attrInfo = (BattleUtil.GetChipAttrInfo)(attrId, initValue, increaseVal, chipData:GetCount(), chipData:GetChipMaxLevel())
        end
      else
        attrInfo = (BattleUtil.GetChipAttrInfo)(attrId, initValue, increaseVal, chipData:GetCount())
      end
      -- DECOMPILER ERROR at PC88: Confused about usage of register: R13 in 'UnsetPending'

      ;
      ((self.ui).tex_Description).text = fluenceIntro .. attrInfo
    else
      do
        if chipData:GetSkillCfg() ~= nil then
          local skillCfg = chipData:GetSkillCfg()
          -- DECOMPILER ERROR at PC120: Confused about usage of register: R9 in 'UnsetPending'

          if not _isHideNxtLvlInfo then
            if haveNum > 0 and haveNum < nextLevel then
              ((self.ui).tex_Description).text = skillCfg:GetLevelUpDescribe(haveNum, nextLevel, (ConfigData.buildinConfig).ChipLevelUpSign, ConfigData:GetChipQualityColor(haveNum), ConfigData:GetChipQualityColor(nextLevel), isShowDetail)
            else
              -- DECOMPILER ERROR at PC137: Confused about usage of register: R9 in 'UnsetPending'

              ;
              ((self.ui).tex_Description).text = skillCfg:GetChipSkillTotalLevelDesc(chipData:GetCount(), chipData:GetChipMaxLevel(), (ConfigData.buildinConfig).ChipLevelDarkColor, (ConfigData.buildinConfig).ChipLevelLightColor, isShowDetail)
            end
          else
            -- DECOMPILER ERROR at PC147: Confused about usage of register: R9 in 'UnsetPending'

            ;
            ((self.ui).tex_Description).text = skillCfg:GetLevelDescribe(chipData:GetCount(), false, isShowDetail)
          end
        else
          do
            -- DECOMPILER ERROR at PC151: Confused about usage of register: R8 in 'UnsetPending'

            ;
            ((self.ui).tex_Description).text = ""
            local skillId = chipData:GetSkillID()
            if skillId == nil then
              return 
            end
            local tab = {}
            local btnActive = false
            local skillLabeIdList = nil
            local labelDic = ((ConfigData.battle_skill).skill_label_Dic)[skillId]
            if labelDic ~= nil then
              for id,unlockLevel in pairs(labelDic) do
                if unlockLevel <= haveNum + 1 then
                  btnActive = true
                  ;
                  (table.insert)(tab, id)
                end
              end
            end
            do
              if btnActive then
                self.uiIntroData = {}
                -- DECOMPILER ERROR at PC186: Confused about usage of register: R13 in 'UnsetPending'

                ;
                (self.uiIntroData).skillLabeIdList = tab
                ;
                (((self.ui).btn_RichIntro).gameObject):SetActive(btnActive)
              end
            end
          end
        end
      end
    end
  end
end

UINBaseChipDetail.GetChipQuality = function(self)
  -- function num : 0_5
  return (self._chipData):GetQuality()
end

UINBaseChipDetail.SetUIModifier = function(self, modifier)
  -- function num : 0_6
  self._modifier = modifier
end

UINBaseChipDetail._ShowRichIntro = function(self)
  -- function num : 0_7 , upvalues : _ENV, cs_Edge
  if self.uiIntroData == nil then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.RichIntro, function(win)
    -- function num : 0_7_0 , upvalues : self, cs_Edge, _ENV
    if win ~= nil then
      local parent = (self.ui).tran_RichIntroHolder
      win:SetRichIntroList(parent, self.uiIntroData)
      win:SetIntroListPosition(cs_Edge.Left, cs_Edge.Top)
      win:SetIntroListModifier(self._modifier, false)
      AudioManager:PlayAudioById(1055)
    end
  end
)
end

UINBaseChipDetail._OnClickSuitInfo = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local rot = ((self.ui).img_Arrow).localEulerAngles
  if self.suitCloseCallback == nil then
    self.suitCloseCallback = BindCallback(self, self._SuitCloseCallback, rot)
  end
  if (self.suitInfoNode).active then
    (self.suitInfoNode):Hide()
    ;
    (self.suitCloseCallback)()
  else
    local chipCfg = (self._chipData):GetChipCfg()
    local tagId = chipCfg.fun_tag
    ;
    (self.suitInfoNode):InitChipDetailSuitInfo(tagId, self._chipData, self.suitCloseCallback)
    ;
    (self.suitInfoNode):Show()
    ;
    ((self.ui).chipInfoNode):SetActive(false)
    rot.z = 225
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_Arrow).localEulerAngles = rot
    AudioManager:PlayAudioById(1072)
  end
end

UINBaseChipDetail._SuitCloseCallback = function(self, rot)
  -- function num : 0_9
  ((self.ui).chipInfoNode):SetActive(true)
  rot.z = 45
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_Arrow).localEulerAngles = rot
end

UINBaseChipDetail._OnDescribeChange = function(self, eTypeId)
  -- function num : 0_10 , upvalues : _ENV
  if eTypeId ~= eGameSetDescType.chip then
    return 
  end
  if self._chipData == nil then
    return 
  end
  self:_InitChipDescription(self._chipData, self._dynPlayer, self._isHideNxtLvlInfo)
end

UINBaseChipDetail.SetBaseBackground = function(self, parent)
  -- function num : 0_11 , upvalues : _ENV
  ((self.ui).background):SetParent(parent)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).background).localPosition = Vector3.zero
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).background).sizeDelta = Vector2.zero
  ;
  ((self.ui).background):SetAsFirstSibling()
end

UINBaseChipDetail.OnDelete = function(self)
  -- function num : 0_12 , upvalues : _ENV, base
  (self.suitInfoNode):Delete()
  ;
  (self.suitItem):Delete()
  MsgCenter:RemoveListener(eMsgEventId.DescribeSettingChange, self._onDescribeChange)
  ;
  (base.OnDelete)(self)
end

return UINBaseChipDetail


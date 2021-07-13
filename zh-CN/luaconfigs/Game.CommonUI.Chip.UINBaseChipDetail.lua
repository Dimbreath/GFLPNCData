-- params : ...
-- function num : 0 , upvalues : _ENV
local UINBaseChipDetail = class("UINBaseChipDetail", UIBaseNode)
local base = UIBaseNode
local UINChipLevel = require("Game.CommonUI.Chip.UINChipLevel")
local UINChipDetailSuitItem = require("Game.CommonUI.Chip.UINChipDetailSuitItem")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local cs_Edge = ((CS.UnityEngine).RectTransform).Edge
local cs_DoTweenLoopType = ((CS.DG).Tweening).LoopType
UINBaseChipDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipDetailSuitItem
  if (self.ui).rootTransform ~= nil or not self.transform then
    local transform = (self.ui).rootTransform
  end
  ;
  (UIUtil.LuaUIBindingTable)(transform, self.ui)
  ;
  ((self.ui).obj_Level):SetActive(false)
  ;
  ((self.ui).obj_SuitItem):SetActive(false)
  self:SetObjNewTagActive(false)
  self.suitPool = (UIItemPool.New)(UINChipDetailSuitItem, (self.ui).obj_SuitItem)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_RichIntro, self, self._ShowRichIntro)
end

UINBaseChipDetail.InitBaseChipDetail = function(self, index, chipData, dynPlayer, resloader, isHideNxtLvlInfo, isOwnData)
  -- function num : 0_1
  self.index = index
  self._chipData = chipData
  self._resloader = resloader
  self._isOwnData = isOwnData
  self:_InitChipPlane(chipData, dynPlayer, isOwnData)
  self:_InitChipLevel(chipData, dynPlayer, isHideNxtLvlInfo, isOwnData)
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
  local iconSprite = CRH:GetSprite(chipData:GetIcon())
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = iconSprite
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_IconSD).sprite = iconSprite
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_CornerIcon).sprite = CRH:GetSprite(eChipCornerSprite[chipData:GetMarkIconIndex()], CommonAtlasType.ExplorationIcon)
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = chipData:GetName()
  local unlockChipSuit = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TagSuit)
  if unlockChipSuit then
    local isFirstGet = false
    do
      if dynPlayer ~= nil then
        local playerChipDic = dynPlayer:GetNormalChipDic()
        isFirstGet = playerChipDic[chipData.dataId] == nil
      end
      local chipCfg = chipData:GetChipCfg()
      ;
      (self.suitPool):HideAll()
      for k,tagId in pairs(chipCfg.fun_tag) do
        local suitItem = (self.suitPool):GetOne(true)
        if dynPlayer ~= nil then
          local haveCount, maxCount = dynPlayer:GetChipTagIdCount(tagId)
          suitItem:InitChipDetailSuitAndCount(tagId, haveCount, maxCount, dynPlayer, isOwnData, isFirstGet)
        else
          suitItem:InitChipDetailSuit(tagId)
        end
      end
      -- DECOMPILER ERROR: 5 unprocessed JMP targets
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

UINBaseChipDetail._InitChipDescription = function(self, chipData, dynPlayer, isHideNxtLvlInfo)
  -- function num : 0_4 , upvalues : _ENV
  local chipCfg = chipData:GetChipCfg()
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
    if #chipCfg.skill_list > 0 then
      local skillId = (chipCfg.skill_list)[1]
      local skillCfg = (((CS.GameData).instance).listBattleSkillDatas):GetDataById(skillId)
      if skillCfg == nil then
        error("Can\'t find skillCfg, id = " .. tostring(skillId))
      else
        -- DECOMPILER ERROR at PC72: Confused about usage of register: R9 in 'UnsetPending'

        if not isHideNxtLvlInfo then
          if haveNum > 0 and haveNum < nextLevel then
            ((self.ui).tex_Description).text = skillCfg:GetLevelUpDescribe(haveNum, nextLevel, (ConfigData.buildinConfig).ChipLevelUpSign, ConfigData:GetChipQualityColor(haveNum), ConfigData:GetChipQualityColor(nextLevel))
          else
            -- DECOMPILER ERROR at PC88: Confused about usage of register: R9 in 'UnsetPending'

            ;
            ((self.ui).tex_Description).text = skillCfg:GetChipSkillTotalLevelDesc(chipData:GetCount(), chipData:GetChipMaxLevel(), (ConfigData.buildinConfig).ChipLevelDarkColor, (ConfigData.buildinConfig).ChipLevelLightColor)
          end
        else
          -- DECOMPILER ERROR at PC96: Confused about usage of register: R9 in 'UnsetPending'

          ;
          ((self.ui).tex_Description).text = skillCfg:GetLevelDescribe(chipData:GetCount())
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
          do
            if btnActive then
              self.uiIntroData = {}
              -- DECOMPILER ERROR at PC126: Confused about usage of register: R13 in 'UnsetPending'

              ;
              (self.uiIntroData).skillLabeIdList = tab
              ;
              (((self.ui).btn_RichIntro).gameObject):SetActive(btnActive)
            end
            if #chipCfg.attribute_id > 0 then
              local attrId = (chipCfg.attribute_id)[1]
              local initValue = (chipCfg.attribute_initial)[1]
              local fluenceIntro = ConfigData:GetChipinfluenceIntro(chipCfg.id)
              local increaseVal = (chipCfg.level_increase)[1]
              local attrInfo = nil
              if not isHideNxtLvlInfo then
                if haveNum > 0 and haveNum < nextLevel then
                  attrInfo = (BattleUtil.GetChipAttrUpgradeInfo)(attrId, initValue, increaseVal, haveNum, nextLevel)
                else
                  attrInfo = (BattleUtil.GetChipAttrInfo)(attrId, initValue, increaseVal, chipData:GetCount(), chipData:GetChipMaxLevel())
                end
              else
                attrInfo = (BattleUtil.GetChipAttrInfo)(attrId, initValue, increaseVal, chipData:GetCount())
              end
              -- DECOMPILER ERROR at PC191: Confused about usage of register: R12 in 'UnsetPending'

              ;
              ((self.ui).tex_Description).text = fluenceIntro .. attrInfo
            else
              do
                -- DECOMPILER ERROR at PC195: Confused about usage of register: R7 in 'UnsetPending'

                ;
                ((self.ui).tex_Description).text = ""
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

UINBaseChipDetail.SetObjNewTagActive = function(self, active, chipShowState)
  -- function num : 0_6 , upvalues : ChipEnum, cs_DoTweenLoopType
  if active then
    if chipShowState == (ChipEnum.eChipShowState).NewState then
      (((self.ui).img_New).gameObject):SetActive(true)
      ;
      ((self.ui).img_New):SetIndex(0)
    else
      if chipShowState == (ChipEnum.eChipShowState).UpState then
        (((self.ui).img_New).gameObject):SetActive(true)
        ;
        ((self.ui).img_New):SetIndex(1)
      else
        ;
        (((self.ui).img_New).gameObject):SetActive(false)
      end
    end
  else
    ;
    (((self.ui).img_New).gameObject):SetActive(false)
  end
  if (((self.ui).img_New).gameObject).activeInHierarchy then
    if self.__fadeTween == nil then
      self.__fadeTween = ((((((self.ui).img_New).image):DOFade(0, 0.7)):From()):SetLoops(-1, cs_DoTweenLoopType.Yoyo)):SetLink(((self.ui).img_New).gameObject)
    else
      ;
      (self.__fadeTween):Restart()
    end
  end
end

UINBaseChipDetail.SetUIModifier = function(self, modifier)
  -- function num : 0_7
  self._modifier = modifier
end

UINBaseChipDetail.SetBtnToParentHolder = function(self, childTrans)
  -- function num : 0_8
  childTrans:SetParent((self.ui).tran_BtnHolder)
end

UINBaseChipDetail._ShowRichIntro = function(self)
  -- function num : 0_9 , upvalues : _ENV, cs_Edge
  if self.uiIntroData == nil then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.RichIntro, function(win)
    -- function num : 0_9_0 , upvalues : self, cs_Edge
    if win ~= nil then
      local parent = (self.ui).tran_RichIntroHolder
      win:SetRichIntroList(parent, self.uiIntroData)
      win:SetIntroListPosition(cs_Edge.Left, cs_Edge.Top)
      win:SetIntroListModifier(self._modifier, false)
    end
  end
)
end

UINBaseChipDetail.OnDelete = function(self)
  -- function num : 0_10 , upvalues : base
  (self.suitPool):DeleteAll()
  if self.__fadeTween ~= nil then
    (self.__fadeTween):Kill()
    self.__fadeTween = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINBaseChipDetail


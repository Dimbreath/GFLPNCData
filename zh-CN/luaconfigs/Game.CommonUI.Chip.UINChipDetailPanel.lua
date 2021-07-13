-- params : ...
-- function num : 0 , upvalues : _ENV
local UINChipDetailPanel = class("UINChipDetailPanel", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
local UINChipTagItem = require("Game.CommonUI.Chip.UINChipTagItem")
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local UINSelectChipAttrItem = require("Game.Exploration.UI.SelectChip.UINSelectChipAttrItem")
local cs_Edge = ((CS.UnityEngine).RectTransform).Edge
local cs_DoTween = ((CS.DG).Tweening).DOTween
UINChipDetailPanel.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipTagItem, UINSelectChipAttrItem, UINHeroHeadItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).img_OnSelect):SetActive(false)
  self:SetChipEffectHeroNodeActive(false)
  self:SetTacticNodeActive(false)
  ;
  ((self.ui).tagItem):SetActive(false)
  ;
  ((self.ui).heroHeadItem):SetActive(false)
  ;
  ((self.ui).attriItem):SetActive(false)
  self:SetObjNewTagActive(false)
  self:SetSelectAnima(false)
  self.tagPool = (UIItemPool.New)(UINChipTagItem, (self.ui).tagItem)
  self.attrItemPool = (UIItemPool.New)(UINSelectChipAttrItem, (self.ui).attriItem)
  self.heroHeadPool = (UIItemPool.New)(UINHeroHeadItem, (self.ui).heroHeadItem)
  self.__onRichIntroWindowsOpen = BindCallback(self, self.RichIntroWindowsOpen)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Select, self, self.OnChipPanelClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ShowIntro, self, self.__ShowSkillIntro)
  if not IsNull((self.ui).root) then
    self._defaultRootPos = ((self.ui).root).localPosition
    self._refreshRootPos = (Vector3.New)((self._defaultRootPos).x, (self._defaultRootPos).y + 60, (self._defaultRootPos).z)
  end
end

UINChipDetailPanel.InitChipDetailPanel = function(self, index, chipData, dynPlayer, resloader, clickEvent, isHideNxtLvlInfo, powerType, isOwnData, showBuyPrice)
  -- function num : 0_1
  self.index = index
  self.__chipData = chipData
  self.__clickEvent = clickEvent
  self.__resloader = resloader
  self.__isOwnData = isOwnData
  self:__InitChipHeadInfo(chipData, dynPlayer, isOwnData)
  self:__InitChipEffectInfo(chipData, dynPlayer, isHideNxtLvlInfo, powerType, isOwnData, showBuyPrice)
end

UINChipDetailPanel.__InitChipHeadInfo = function(self, chipData, dynPlayer, isOwnData)
  -- function num : 0_2 , upvalues : _ENV, UINChipItem
  local chipCfg = chipData:GetChipCfg()
  local chipColor = chipData:GetColor()
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_QualityColor).color = chipColor
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (((self.ui).img_QualityIcon).image).color = chipColor
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_QualityLine).color = chipColor
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (((self.ui).tex_Decorate).text).color = (Color.New)(chipColor.r, chipColor.g, chipColor.b, 0.5)
  ;
  ((self.ui).img_QualityIcon):SetIndex(chipData:GetQuality())
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_Mark).sprite = CRH:GetSprite(eChipCornerSprite[chipData:GetMarkIconIndex()], CommonAtlasType.ExplorationIcon)
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_ChipName).text = chipData:GetName()
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_ChipIntro).text = chipData:GetChipInfo()
  local chipItem = (UINChipItem.New)()
  chipItem:Init((self.ui).chipItem)
  chipItem:InitChipItem(chipData)
  self.chipItem = chipItem
  ;
  (self.tagPool):HideAll()
  for k,tagId in pairs(chipCfg.fun_tag) do
    local tagItem = (self.tagPool):GetOne(true)
    if dynPlayer ~= nil then
      local haveCount, maxCount = dynPlayer:GetChipTagIdCount(tagId)
      tagItem:InitChipTagAndSuit(tagId, haveCount, maxCount, isOwnData)
    else
      do
        do
          tagItem:InitChipTag(tagId)
          tagItem:SetChipTagColor(chipData:GetColor())
          -- DECOMPILER ERROR at PC93: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC93: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC93: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

UINChipDetailPanel.GetChipQuality = function(self)
  -- function num : 0_3
  return (self.__chipData):GetQuality()
end

UINChipDetailPanel.__InitChipEffectInfo = function(self, chipData, dynPlayer, isHideNxtLvlInfo, powerType, isOwnData, showBuyPrice)
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
    if not isOwnData or not haveNum + 1 then
      local nextLevel = (math.min)(haveNum + chipData:GetCount(), chipData:GetChipMaxLevel())
      if haveNum > 0 and haveNum < nextLevel and not isHideNxtLvlInfo then
        ((self.ui).tex_ChipLevel):SetIndex(1, tostring(haveNum), tostring(nextLevel))
      else
        if haveNum > 0 and isHideNxtLvlInfo then
          ((self.ui).tex_ChipLevel):SetIndex(0, tostring(chipData:GetCount()))
        else
          ;
          ((self.ui).tex_ChipLevel):SetIndex(0, tostring(chipData:GetCount()))
        end
      end
      self.uiIntroData = nil
      ;
      (((self.ui).btn_ShowIntro).gameObject):SetActive(false)
      if #chipCfg.skill_list > 0 then
        local skillId = (chipCfg.skill_list)[1]
        local skillCfg = (((CS.GameData).instance).listBattleSkillDatas):GetDataById(skillId)
        if skillCfg == nil then
          error("Can\'t find skillCfg, id = " .. tostring(skillId))
        else
          -- DECOMPILER ERROR at PC123: Confused about usage of register: R12 in 'UnsetPending'

          if not isHideNxtLvlInfo then
            if haveNum > 0 and haveNum < nextLevel then
              ((self.ui).tex_Description).text = skillCfg:GetLevelUpDescribe(haveNum, nextLevel, (ConfigData.buildinConfig).ChipLevelUpSign, ConfigData:GetChipQualityColor(haveNum), ConfigData:GetChipQualityColor(nextLevel))
            else
              -- DECOMPILER ERROR at PC139: Confused about usage of register: R12 in 'UnsetPending'

              ;
              ((self.ui).tex_Description).text = skillCfg:GetChipSkillTotalLevelDesc(chipData:GetCount(), chipData:GetChipMaxLevel(), (ConfigData.buildinConfig).ChipLevelDarkColor, (ConfigData.buildinConfig).ChipLevelLightColor)
            end
          else
            -- DECOMPILER ERROR at PC147: Confused about usage of register: R12 in 'UnsetPending'

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
                -- DECOMPILER ERROR at PC177: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (self.uiIntroData).skillLabeIdList = tab
                ;
                (((self.ui).btn_ShowIntro).gameObject):SetActive(btnActive)
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
                -- DECOMPILER ERROR at PC242: Confused about usage of register: R15 in 'UnsetPending'

                ;
                ((self.ui).tex_Description).text = fluenceIntro .. attrInfo
              else
                do
                  -- DECOMPILER ERROR at PC246: Confused about usage of register: R10 in 'UnsetPending'

                  ;
                  ((self.ui).tex_Description).text = ""
                  ;
                  (self.attrItemPool):HideAll()
                  for k,atrId in ipairs(chipCfg.attribute_id) do
                    local initValue = (chipCfg.attribute_initial)[k]
                    local attrItem = (self.attrItemPool):GetOne()
                    attrItem:InitChipAttrItem(atrId, initValue)
                    attrItem:Show()
                  end
                  if (self.ui).obj_ReCC ~= nil then
                    ((self.ui).obj_ReCC):SetActive(false)
                  end
                  self.fightPower = 0
                  ;
                  (self.heroHeadPool):HideAll()
                  if dynPlayer ~= nil then
                    local validCharacters = chipData:GetValidRoleList(dynPlayer.heroList, eBattleRoleBelong.player)
                    local isAllHero = #dynPlayer.heroList <= #validCharacters
                    ;
                    ((self.ui).heroHeadList):SetActive(not isAllHero)
                    ;
                    ((self.ui).allHero):SetActive(isAllHero)
                    if not isAllHero then
                      for _,dynHero in pairs(validCharacters) do
                        local go = ((self.ui).heroHeadItem):Instantiate()
                        local heroHeadItem = (self.heroHeadPool):GetOne()
                        heroHeadItem:InitHeroHeadItem(dynHero.heroData, self.__resloader)
                        heroHeadItem:Show()
                      end
                    end
                    if powerType == eChipDetailPowerType.Add or powerType == nil then
                      ((self.ui).obj_Power):SetActive(true)
                      self.fightPower = dynPlayer:GetChipCombatEffect(chipData, isOwnData) * 100
                      ;
                      ((self.ui).tex_Power):SetIndex(0, GetPreciseDecimalStr(self.fightPower, 1))
                    elseif powerType == eChipDetailPowerType.Subtract then
                      ((self.ui).obj_Power):SetActive(true)
                      self.fightPower = dynPlayer:GetChipOriginFightPower(chipData) * 100
                      ;
                      ((self.ui).tex_Power):SetIndex(1, GetPreciseDecimalStr(self.fightPower, 1))
                    else
                      ((self.ui).obj_Power):SetActive(false)
                    end
                    if not isOwnData then
                      local returnMoney = dynPlayer:GetChipReturnMoney(chipData.dataId, chipData:GetCount())
                      if returnMoney > 0 and (self.ui).obj_ReCC ~= nil then
                        ((self.ui).obj_ReCC):SetActive(true)
                        -- DECOMPILER ERROR at PC404: Confused about usage of register: R13 in 'UnsetPending'

                        ;
                        ((self.ui).tex_ReCC).text = tostring(returnMoney)
                      end
                    end
                  else
                    ((self.ui).obj_Power):SetActive(false)
                  end
                  if showBuyPrice and not IsNull((self.ui).obj_ReCC) then
                    ((self.ui).obj_ReCC):SetActive(true)
                    ;
                    ((self.ui).tex_CCName):SetIndex(1)
                    -- DECOMPILER ERROR at PC438: Confused about usage of register: R10 in 'UnsetPending'

                    ;
                    ((self.ui).tex_ReCC).text = tostring(chipData:GetChipBuyPrice(ExplorationManager:GetEpModuleId()))
                  end
                  -- DECOMPILER ERROR: 10 unprocessed JMP targets
                end
              end
            end
          end
        end
      end
    end
  end
end

UINChipDetailPanel.GetInPlayFightPower = function(self, dynPlayer, isSubtract)
  -- function num : 0_5
  if isSubtract then
    return dynPlayer:GetChipOriginFightPower(self.__chipData, true) * 100
  else
    return dynPlayer:GetChipCombatEffect(self.__chipData, self.__isOwnData, true) * 100
  end
end

UINChipDetailPanel.OnChipPanelClicked = function(self)
  -- function num : 0_6
  if self.__clickEvent ~= nil then
    (self.__clickEvent)(self)
  end
end

UINChipDetailPanel.OnSelectChipChanged = function(self, select)
  -- function num : 0_7
  if select then
    ((self.ui).ani_Select):DORestartById("SelectSize")
    self:UnSelectAlpha(not select)
  else
    ;
    ((self.ui).ani_Select):DOPlayBackwardsById("SelectSize")
  end
  ;
  ((self.ui).img_OnSelect):SetActive(select)
  self:SetSelectAnima(select)
  self:ShowHeroHeadOrTacticActive(select)
end

UINChipDetailPanel.ShowChipPanelRefreshTween = function(self, updItemFunc, index, onlyMoveDown)
  -- function num : 0_8 , upvalues : cs_DoTween
  self:_ClearRefreshSequece()
  self:EnableChipDetailPanelClick(false)
  local sequece = (cs_DoTween.Sequence)()
  local deplay = 0
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R6 in 'UnsetPending'

  if not onlyMoveDown then
    ((self.ui).canvasGroup).alpha = 1
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).root).localPosition = self._defaultRootPos
    deplay = 0.04 * index
    sequece:Insert(deplay, ((self.ui).root):DOLocalMoveY((self._refreshRootPos).y, 0.2))
    sequece:Insert(deplay, ((self.ui).canvasGroup):DOFade(0, 0.2))
  end
  sequece:InsertCallback(deplay, updItemFunc)
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R6 in 'UnsetPending'

  if onlyMoveDown then
    ((self.ui).canvasGroup).alpha = 0
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).root).localPosition = self._refreshRootPos
    deplay = 0.04 * index
  end
  deplay = deplay + 0.2
  sequece:Insert(deplay, ((self.ui).root):DOLocalMoveY((self._defaultRootPos).y, 0.2))
  sequece:Insert(deplay, ((self.ui).canvasGroup):DOFade(1, 0.2))
  sequece:OnComplete(function()
    -- function num : 0_8_0 , upvalues : self
    self:EnableChipDetailPanelClick(true)
  end
)
  self._refreshSequece = sequece
end

UINChipDetailPanel._ClearRefreshSequece = function(self)
  -- function num : 0_9
  if self._refreshSequece ~= nil then
    (self._refreshSequece):Kill()
    self._refreshSequece = nil
  end
end

UINChipDetailPanel.ShowHeroHeadOrTacticActive = function(self, active)
  -- function num : 0_10
  self:SetTacticNodeActive(false)
  self:SetChipEffectHeroNodeActive(false)
  if self.__chipData ~= nil and (self.__chipData):IsValidDynPlayer() then
    self:SetTacticNodeActive(active)
    return 
  end
  self:SetChipEffectHeroNodeActive(active)
end

UINChipDetailPanel.SetTacticNodeActive = function(self, active)
  -- function num : 0_11
  if (self.ui).tacticNode ~= nil then
    ((self.ui).tacticNode):SetActive(active)
  end
end

UINChipDetailPanel.SetChipEffectHeroNodeActive = function(self, active)
  -- function num : 0_12
  ((self.ui).heroHeadNode):SetActive(active)
end

UINChipDetailPanel.SetUnSelectAlpha = function(self)
  -- function num : 0_13
  self:UnSelectAlpha(true)
  self:SetSelectAnima(false)
end

UINChipDetailPanel.UnSelectAlpha = function(self, boolean)
  -- function num : 0_14 , upvalues : _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if not boolean or not Vector3.one then
    ((self.ui).tran_Mask).localScale = Vector3.zero
  end
end

UINChipDetailPanel.SetSelectAnima = function(self, active)
  -- function num : 0_15
  ((self.ui).obj_SelectLine):SetActive(active)
  ;
  ((self.ui).obj_SelectImg):SetActive(active)
end

UINChipDetailPanel.GetChipDetailPanelData = function(self)
  -- function num : 0_16
  return self.__chipData
end

UINChipDetailPanel.GetChipItem = function(self)
  -- function num : 0_17
  return self.chipItem
end

UINChipDetailPanel.GetAutoTipsHolder = function(self)
  -- function num : 0_18
  return (self.ui).autoTipsHolder
end

UINChipDetailPanel.SetObjNewTagActive = function(self, active)
  -- function num : 0_19
  if (self.ui).img_isNew ~= nil then
    ((self.ui).img_isNew):SetActive(active)
  end
end

UINChipDetailPanel.EnableChipDetailPanelClick = function(self, enable)
  -- function num : 0_20
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).canvasGroup).interactable = enable
end

UINChipDetailPanel.SetUIModifier = function(self, modifier)
  -- function num : 0_21
  self.modifier = modifier
end

UINChipDetailPanel.__ShowSkillIntro = function(self)
  -- function num : 0_22 , upvalues : _ENV
  if self.uiIntroData == nil then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.RichIntro, function(win)
    -- function num : 0_22_0 , upvalues : self
    if win ~= nil then
      (self.__onRichIntroWindowsOpen)(win)
    end
  end
)
end

UINChipDetailPanel.RichIntroWindowsOpen = function(self, win)
  -- function num : 0_23 , upvalues : cs_Edge
  local parent = (self.ui).introLeftHolder
  local is3D = (parent.gameObject).layer ~= 12 and false
  win:SetRichIntroList(parent, self.uiIntroData)
  win:SetIntroListPosition(cs_Edge.Left, cs_Edge.Top)
  win:SetIntroListModifier(self.modifier, is3D)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINChipDetailPanel.OnDelete = function(self)
  -- function num : 0_24 , upvalues : base
  self:_ClearRefreshSequece()
  ;
  (base.OnDelete)(self)
end

return UINChipDetailPanel


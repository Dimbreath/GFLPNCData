-- params : ...
-- function num : 0 , upvalues : _ENV
local UINChipDetailPanel = class("UINChipDetailPanel", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
local UINChipTagItem = require("Game.CommonUI.Chip.UINChipTagItem")
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local UINSelectChipAttrItem = require("Game.Exploration.UI.SelectChip.UINSelectChipAttrItem")
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
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Select, self, self.OnChipPanelClicked)
end

UINChipDetailPanel.InitChipDetailPanel = function(self, index, chipData, dynPlayer, resloader, clickEvent, isHideNxtLvlInfo, powerType, isOwnData)
  -- function num : 0_1
  self.index = index
  self.__chipData = chipData
  self.__clickEvent = clickEvent
  self.__resloader = resloader
  self.__isOwnData = isOwnData
  self:__InitChipHeadInfo(chipData)
  self:__InitChipEffectInfo(chipData, dynPlayer, isHideNxtLvlInfo, powerType, isOwnData)
end

UINChipDetailPanel.__InitChipHeadInfo = function(self, chipData)
  -- function num : 0_2 , upvalues : _ENV, UINChipItem
  local chipCfg = chipData:GetChipCfg()
  local chipColor = chipData:GetColor()
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_QualityColor).color = chipColor
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (((self.ui).img_QualityIcon).image).color = chipColor
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_QualityLine).color = chipColor
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (((self.ui).tex_Decorate).text).color = (Color.New)(chipColor.r, chipColor.g, chipColor.b, 0.5)
  ;
  ((self.ui).img_QualityIcon):SetIndex(chipData:GetQuality())
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Mark).sprite = CRH:GetSprite(eChipCornerSprite[chipData:GetMarkIconIndex()], CommonAtlasType.ExplorationIcon)
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_ChipName).text = chipData:GetName()
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R4 in 'UnsetPending'

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
    tagItem:InitChipTag(tagId)
    tagItem:SetChipTagColor(chipData:GetColor())
  end
end

UINChipDetailPanel.GetChipQuality = function(self)
  -- function num : 0_3
  return (self.__chipData):GetQuality()
end

UINChipDetailPanel.__InitChipEffectInfo = function(self, chipData, dynPlayer, isHideNxtLvlInfo, powerType, isOwnData)
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
    if haveNum > 0 and not isHideNxtLvlInfo then
      if not isOwnData or not haveNum + 1 then
        local nextLevel = haveNum + chipData:GetCount()
      end
      ;
      ((self.ui).tex_ChipLevel):SetIndex(1, tostring(haveNum), tostring(nextLevel))
    else
      do
        if haveNum > 0 and isHideNxtLvlInfo then
          ((self.ui).tex_ChipLevel):SetIndex(0, tostring(chipData:GetCount()))
        else
          if haveNum <= 0 then
            ((self.ui).tex_ChipLevel):SetIndex(0, tostring(chipData:GetCount()))
          end
        end
        if #chipCfg.skill_list > 0 then
          local skillId = (chipCfg.skill_list)[1]
          local skillCfg = (((CS.GameData).instance).listBattleSkillDatas):GetDataById(skillId)
          if skillCfg == nil then
            error("Can\'t find skillCfg, id = " .. tostring(skillId))
          else
            if haveNum > 0 and not isHideNxtLvlInfo then
              if not isOwnData or not haveNum + 1 then
                local nextLevel = haveNum + chipData:GetCount()
              end
              -- DECOMPILER ERROR at PC112: Confused about usage of register: R11 in 'UnsetPending'

              ;
              ((self.ui).tex_Description).text = skillCfg:GetLevelUpDescribe(haveNum, nextLevel, (ConfigData.buildinConfig).ChipLevelUpSign, (ConfigData.buildinConfig).ChipLevelUpColor)
            else
              do
                do
                  -- DECOMPILER ERROR at PC124: Confused about usage of register: R10 in 'UnsetPending'

                  if haveNum > 0 and isHideNxtLvlInfo then
                    ((self.ui).tex_Description).text = skillCfg:GetLevelDescribe(chipData:GetCount())
                  else
                    -- DECOMPILER ERROR at PC134: Confused about usage of register: R10 in 'UnsetPending'

                    if haveNum <= 0 then
                      ((self.ui).tex_Description).text = skillCfg:GetLevelDescribe(chipData:GetCount())
                    end
                  end
                  if #chipCfg.attribute_id > 0 then
                    local attrId = (chipCfg.attribute_id)[1]
                    local initValue = (chipCfg.attribute_initial)[1]
                    local fluenceIntro = ConfigData:GetChipinfluenceIntro(chipCfg.id)
                    local increaseVal = (chipCfg.level_increase)[1]
                    local attrInfo = nil
                    if haveNum > 0 and not isHideNxtLvlInfo then
                      if not isOwnData or not haveNum + 1 then
                        local nextLevel = haveNum + chipData:GetCount()
                      end
                      attrInfo = (BattleUtil.GetChipAttrInfo)(attrId, initValue, increaseVal, haveNum, nextLevel)
                    else
                      do
                        do
                          if haveNum > 0 and isHideNxtLvlInfo then
                            attrInfo = (BattleUtil.GetChipAttrInfo)(attrId, initValue, increaseVal, chipData:GetCount())
                          else
                            if haveNum <= 0 then
                              attrInfo = (BattleUtil.GetChipAttrInfo)(attrId, initValue, increaseVal, chipData:GetCount())
                            end
                          end
                          -- DECOMPILER ERROR at PC203: Confused about usage of register: R13 in 'UnsetPending'

                          ;
                          ((self.ui).tex_Description).text = fluenceIntro .. attrInfo
                          -- DECOMPILER ERROR at PC207: Confused about usage of register: R8 in 'UnsetPending'

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
                          else
                            ((self.ui).obj_Power):SetActive(false)
                          end
                          -- DECOMPILER ERROR: 8 unprocessed JMP targets
                        end
                      end
                    end
                  end
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

UINChipDetailPanel.ShowHeroHeadOrTacticActive = function(self, active)
  -- function num : 0_8
  self:SetTacticNodeActive(false)
  self:SetChipEffectHeroNodeActive(false)
  if self.__chipData ~= nil and (self.__chipData):IsValidDynPlayer() then
    self:SetTacticNodeActive(active)
    return 
  end
  self:SetChipEffectHeroNodeActive(active)
end

UINChipDetailPanel.SetTacticNodeActive = function(self, active)
  -- function num : 0_9
  if (self.ui).tacticNode ~= nil then
    ((self.ui).tacticNode):SetActive(active)
  end
end

UINChipDetailPanel.SetChipEffectHeroNodeActive = function(self, active)
  -- function num : 0_10
  ((self.ui).heroHeadNode):SetActive(active)
end

UINChipDetailPanel.SetUnSelectAlpha = function(self)
  -- function num : 0_11
  self:UnSelectAlpha(true)
  self:SetSelectAnima(false)
end

UINChipDetailPanel.UnSelectAlpha = function(self, boolean)
  -- function num : 0_12 , upvalues : _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if not boolean or not Vector3.one then
    ((self.ui).tran_Mask).localScale = Vector3.zero
  end
end

UINChipDetailPanel.SetSelectAnima = function(self, active)
  -- function num : 0_13
  ((self.ui).obj_SelectLine):SetActive(active)
  ;
  ((self.ui).obj_SelectImg):SetActive(active)
end

UINChipDetailPanel.GetChipDetailPanelData = function(self)
  -- function num : 0_14
  return self.__chipData
end

UINChipDetailPanel.GetChipItem = function(self)
  -- function num : 0_15
  return self.chipItem
end

UINChipDetailPanel.GetAutoTipsHolder = function(self)
  -- function num : 0_16
  return (self.ui).autoTipsHolder
end

UINChipDetailPanel.SetObjNewTagActive = function(self, active)
  -- function num : 0_17
  if (self.ui).img_isNew ~= nil then
    ((self.ui).img_isNew):SetActive(active)
  end
end

UINChipDetailPanel.OnDelete = function(self)
  -- function num : 0_18 , upvalues : base
  (base.OnDelete)(self)
end

return UINChipDetailPanel


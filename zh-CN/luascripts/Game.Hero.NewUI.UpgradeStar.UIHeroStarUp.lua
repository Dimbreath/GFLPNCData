-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHeroStarUp = class("UIHeroStarUp", UIBaseWindow)
local base = UIBaseWindow
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local UINStarUpStarList = require("Game.Hero.NewUI.UpgradeStar.UINStarUpStarList")
local UINStarUpPromoteItem = require("Game.Hero.NewUI.UpgradeStar.UINStarUpPromoteItem")
local UINBaseSkillItem = require("Game.CommonUI.Item.UINBaseSkillItem")
local UINStarUpAttrItem = require("Game.Hero.NewUI.UpgradeStar.UINStarUpAttrItem")
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local promoteType = {athSpace = 1, skillLevelLimit = 2, uSkillLevelLimit = 3, special = 4}
UIHeroStarUp.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINResourceGroup, UINBaseItem, UINStarUpStarList, UINBaseSkillItem, UINStarUpPromoteItem, UINStarUpAttrItem
  self.isClosing = false
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Hero)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_StarUp, self, self.OnClickStarUp)
  ;
  (UIUtil.CreateTopBtnGroup)((self.ui).obj_topButtonGroup, self, self.OnClickBack, true)
  self.resourceGroup = (UINResourceGroup.New)()
  ;
  (self.resourceGroup):Init((self.ui).obj_gameResourceGroup)
  self.fragBaseItem = (UINBaseItem.New)()
  ;
  (self.fragBaseItem):Init((self.ui).obj_FragUINBaseItem)
  self.extrBaseItem = (UINBaseItem.New)()
  ;
  (self.extrBaseItem):Init((self.ui).obj_ExtrUINBaseItem)
  self.currentStarList = (UINStarUpStarList.New)()
  ;
  (self.currentStarList):Init((self.ui).starListGroup)
  self.nextStarList = (UINStarUpStarList.New)()
  ;
  (self.nextStarList):Init(((self.ui).starListGroup):Instantiate())
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_LeftArrow, self, self.__OnClickLeftArrow)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_RightArrow, self, self.__OnClickRightArrow)
  self.skillItem = (UINBaseSkillItem.New)()
  ;
  (self.skillItem):Init((self.ui).skillItem)
  self.promoteItemPool = (UIItemPool.New)(UINStarUpPromoteItem, (self.ui).promoteItem)
  ;
  ((self.ui).promoteItem):SetActive(false)
  self.attrItemPool = (UIItemPool.New)(UINStarUpAttrItem, (self.ui).attriItem)
  ;
  ((self.ui).attriItem):SetActive(false)
  self.__RefreshRank = BindCallback(self, self.RefreshRank)
  MsgCenter:AddListener(eMsgEventId.OnHeroRankChange, self.__RefreshRank)
  self.__RefreshItem = BindCallback(self, self.RefreshItem)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__RefreshItem)
  self:InitAllTween()
end

UIHeroStarUp.InitAllTween = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self.allTweens = (self.transform):GetComponentsInChildren(typeof(((CS.DG).Tweening).DOTweenAnimation))
  for i = 0, (self.allTweens).Length - 1 do
    local tween = (self.allTweens)[i]
  end
end

UIHeroStarUp.InitHeroStarUp = function(self, heroData, resloader, hideCallBack, switchHeroFunc)
  -- function num : 0_2 , upvalues : _ENV
  (UIUtil.Push2BackStack)(self, self.OnClickBack)
  self.heroData = heroData
  self.resloader = resloader
  self.hideCallBack = hideCallBack
  self.switchHeroFunc = switchHeroFunc
  self.isClosing = false
  self:RefreshAll()
  self:PlayAllDOTween()
end

UIHeroStarUp.SwitchHero = function(self, heroData, reUseBigImgResloader)
  -- function num : 0_3
  self.heroData = heroData
  self:RefreshAll(nil, reUseBigImgResloader)
  self:PlayAllDOTween()
end

UIHeroStarUp.RefreshItem = function(self)
  -- function num : 0_4
  self.isItemUpdate = true
  if self.isRankUpdate then
    self:RefreshAll()
  end
end

UIHeroStarUp.RefreshRank = function(self)
  -- function num : 0_5
  self.isRankUpdate = true
  self.isItemUpdate = false
end

UIHeroStarUp.RefreshAll = function(self, heroId, reUseBigImgResloader)
  -- function num : 0_6
  self.isItemUpdate = false
  self.isRankUpdate = false
  local ableUp, fitFrag, fitCurrency, fitExtr = (self.heroData):AbleUpgradeStar()
  if heroId ~= nil and heroId ~= (self.heroData).dataId then
    return 
  end
  if (self.heroData):IsFullRank() then
    self:RefreshFrag(true)
    self:RefreshCurrency(true)
    self:RefreshExtrItem(true)
    self:RefreshHeroStaticInfo(reUseBigImgResloader)
    self:RefreshStarUpInfo(true)
    ;
    (self.nextStarList):Hide()
    ;
    (((self.ui).btn_StarUp).gameObject):SetActive(false)
    return 
  else
    ;
    (self.nextStarList):Show()
    ;
    (((self.ui).btn_StarUp).gameObject):SetActive(true)
  end
  self.needfragNum = (self.heroData):StarNeedFrag()
  self.currencyId = (self.heroData):StarNeedCurrencyNum()
  self.extrItemId = (self.heroData):StarNeedItemNum()
  self:RefreshFrag()
  self:RefreshCurrency(false, fitCurrency)
  self:RefreshExtrItem()
  self:RefreshHeroStaticInfo(reUseBigImgResloader)
  self:RefreshStarUpInfo()
  self:SetStarUpGray(ableUp)
end

UIHeroStarUp.RefreshFrag = function(self, isFullLevel)
  -- function num : 0_7 , upvalues : _ENV
  if isFullLevel or self.needfragNum == 0 then
    ((self.ui).obj_heroFragItem):SetActive(false)
    return 
  else
    ;
    ((self.ui).obj_heroFragItem):SetActive(true)
  end
  local totalFragNum = (self.heroData):GetHeroFragCount()
  local itemCfg = (ConfigData.item)[(self.heroData).fragId]
  if itemCfg == nil then
    error("frag itemCfg error id=" .. (self.heroData).fragId)
  else
    ;
    (self.fragBaseItem):InitBaseItem(itemCfg)
  end
  if self.needfragNum <= totalFragNum then
    ((self.ui).tex_FragCount):SetIndex(0, tostring(self.needfragNum), tostring(totalFragNum))
  else
    ;
    ((self.ui).tex_FragCount):SetIndex(2, tostring(self.needfragNum), tostring(totalFragNum))
  end
end

UIHeroStarUp.RefreshCurrency = function(self, isFullLevel, fitCurrency)
  -- function num : 0_8 , upvalues : _ENV
  if isFullLevel then
    (self.resourceGroup):Hide()
    ;
    ((self.ui).obj_CurrencyCost):SetActive(false)
    return 
  else
    ;
    (self.resourceGroup):Show()
    ;
    ((self.ui).obj_CurrencyCost):SetActive(true)
  end
  if self.currencyId ~= nil then
    (self.resourceGroup):SetResourceIds({self.currencyId})
    ;
    ((self.ui).obj_CurrencyCost):SetActive(true)
    local itemCfg = (ConfigData.item)[self.currencyId]
    if itemCfg == nil then
      error("itemCfg read error id=" .. self.currencyId)
    else
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).img_CurrencyItem).sprite = CRH:GetSprite(itemCfg.small_icon)
    end
    if fitCurrency then
      ((self.ui).tex_CurrencyCost):SetIndex(1, tostring(self.needCurrencyNum))
    else
      ;
      ((self.ui).tex_CurrencyCost):SetIndex(0, tostring(self.needCurrencyNum))
    end
  else
    do
      ;
      (self.resourceGroup):Hide()
      ;
      ((self.ui).obj_CurrencyCost):SetActive(false)
    end
  end
end

UIHeroStarUp.RefreshExtrItem = function(self, isFullLevel)
  -- function num : 0_9 , upvalues : _ENV
  if isFullLevel then
    ((self.ui).obj_ExtrItem):SetActive(false)
    return 
  else
    ;
    ((self.ui).obj_ExtrItem):SetActive(true)
  end
  if self.extrItemId ~= nil then
    local totalExtrItemNum = PlayerDataCenter:GetItemCount(self.extrItemId)
    ;
    ((self.ui).obj_ExtrItem):SetActive(true)
    local itemCfg = (ConfigData.item)[self.extrItemId]
    if itemCfg == nil then
      error("extr itemCfg error id=" .. self.extrItemId)
    else
      ;
      (self.extrBaseItem):InitBaseItem(itemCfg)
    end
    if self.needExtrItemNum <= totalExtrItemNum then
      ((self.ui).tex_ExtrCount):SetIndex(0, tostring(self.needExtrItemNum), tostring(totalExtrItemNum))
    else
      ;
      ((self.ui).tex_ExtrCount):SetIndex(2, tostring(self.needExtrItemNum), tostring(totalExtrItemNum))
    end
  else
    do
      ;
      ((self.ui).obj_ExtrItem):SetActive(false)
    end
  end
end

UIHeroStarUp.RefreshHeroStaticInfo = function(self, reUseBigImgResloader)
  -- function num : 0_10 , upvalues : _ENV, cs_ResLoader
  local campIcon = (LanguageUtil.GetLocaleText)(((self.heroData):GetCampCfg()).icon)
  ;
  (self.resloader):LoadABAssetAsync(PathConsts:GetCampPicPath(campIcon), function(texture)
    -- function num : 0_10_0 , upvalues : _ENV, self
    if IsNull(self.transform) then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Camp).texture = texture
  end
)
  if reUseBigImgResloader ~= nil then
    (self.bigImgGameObject):SetActive(false)
    reUseBigImgResloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath((self.heroData):GetResName()), function(prefab)
    -- function num : 0_10_1 , upvalues : _ENV, self
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
  end
)
  else
    if self.bigImgResloader ~= nil then
      (self.bigImgResloader):Put2Pool()
    end
    self.bigImgResloader = (cs_ResLoader.Create)()
    ;
    (self.bigImgResloader):LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath((self.heroData):GetResName()), function(prefab)
    -- function num : 0_10_2 , upvalues : _ENV, self
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
  end
)
  end
end

UIHeroStarUp.RefreshStarUpInfo = function(self, isFullLevel)
  -- function num : 0_11 , upvalues : _ENV, promoteType
  local rankCfg, nextRankCfg = nil, nil
  rankCfg = (ConfigData.hero_rank)[(self.heroData).rank]
  if rankCfg == nil then
    error("Can\'t find rankCfg, id = " .. tostring((self.heroData).rank))
  end
  if not isFullLevel then
    nextRankCfg = (ConfigData.hero_rank)[(self.heroData).rank + 1]
    if nextRankCfg == nil then
      error("Can\'t find rankCfg, id = " .. tostring((self.heroData).rank + 1))
    end
  end
  local currentStar = rankCfg.star
  ;
  (self.currentStarList):InitStarList(nil, currentStar)
  do
    if not isFullLevel then
      local nextStar = nextRankCfg.star
      ;
      (self.nextStarList):InitStarList(nil, nextStar)
    end
    if not isFullLevel then
      (self.attrItemPool):HideAll()
      local changeList = (self.heroData):GetDifferAttrWhenRankUp((self.heroData).rank + 1, nil)
      if #changeList >= 10 then
        for index,data in ipairs(changeList) do
          if index <= 10 then
            do
              local item = (self.attrItemPool):GetOne()
              item:InitAttrItem(data.oldAttr, data.newAttr, data.attrId)
              -- DECOMPILER ERROR at PC78: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC78: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      else
        if #changeList < 10 then
          local showedIds = {}
          local num = #changeList
          for index,data in ipairs(changeList) do
            (table.insert)(showedIds, data.attrId)
          end
          for _,attrId in ipairs((ConfigData.attribute).baseAttrIds) do
            -- DECOMPILER ERROR at PC118: Unhandled construct in 'MakeBoolean' P1

            if ((ConfigData.attribute)[attrId]).merge_attribute == 0 and num < 10 then
              do
                if not (table.contain)(showedIds, attrId) then
                  num = num + 1
                  ;
                  (table.insert)(changeList, {attrId = attrId, property = ((ConfigData.attribute)[attrId]).attribute_priority, oldAttr = (self.heroData):GetAttr(attrId, nil, true), newAttr = nil})
                end
                -- DECOMPILER ERROR at PC138: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC138: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
          ;
          (table.sort)(changeList, function(a, b)
    -- function num : 0_11_0
    if a.attrId >= b.attrId then
      do return a.property ~= b.property end
      do return a.property < b.property end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
          for index,data in ipairs(changeList) do
            local item = (self.attrItemPool):GetOne()
            item:InitAttrItem(data.oldAttr, data.newAttr, data.attrId)
          end
        end
      end
    else
      do
        ;
        (self.attrItemPool):HideAll()
        do
          local num = 0
          for _,attrId in ipairs((ConfigData.attribute).baseAttrIds) do
            -- DECOMPILER ERROR at PC178: Unhandled construct in 'MakeBoolean' P1

            if ((ConfigData.attribute)[attrId]).merge_attribute == 0 and num < 10 then
              num = num + 1
              do
                local item = (self.attrItemPool):GetOne()
                item:InitAttrItem(((self.heroData):GetAttr(R16_PC188, nil, true)), nil, R16_PC188)
                -- DECOMPILER ERROR at PC192: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC192: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
          ;
          (self.promoteItemPool):HideAll()
          if not isFullLevel then
            local heroStarCfg = (ConfigData.hero_star)[(self.heroData).dataId]
            if heroStarCfg == nil then
              error("Can\'t find heroStarCfg, id = " .. tostring((self.heroData).dataId))
            end
            local currentHeroStarCfg = heroStarCfg[rankCfg.rank]
            local nextHeroStarCfg = heroStarCfg[nextRankCfg.rank]
            do
              if (currentHeroStarCfg.algorithm_space)[1] ~= (nextHeroStarCfg.algorithm_space)[1] then
                local item = (self.promoteItemPool):GetOne()
                item:InitPromoteItem(promoteType.athSpace, (nextHeroStarCfg.algorithm_space)[1], (currentHeroStarCfg.algorithm_space)[1])
              end
              do
                if rankCfg.skill_level_max ~= nextRankCfg.skill_level_max then
                  local item = (self.promoteItemPool):GetOne()
                  item:InitPromoteItem(promoteType.skillLevelLimit, nextRankCfg.skill_level_max, rankCfg.skill_level_max)
                end
                if nextHeroStarCfg.rank_text ~= nil then
                  local str = (LanguageUtil.GetLocaleText)(nextHeroStarCfg.rank_text)
                  if not (string.IsNullOrEmpty)(str) then
                    local item = (self.promoteItemPool):GetOne()
                    item:InitPromoteItem(promoteType.special, str)
                  end
                end
                do
                  -- DECOMPILER ERROR at PC273: Confused about usage of register: R5 in 'UnsetPending'

                  if #(self.promoteItemPool).listItem > 0 then
                    ((self.ui).Fade_Promote).alpha = 1
                    ;
                    ((self.ui).Promotelist):SetActive(true)
                  else
                    -- DECOMPILER ERROR at PC282: Confused about usage of register: R5 in 'UnsetPending'

                    ;
                    ((self.ui).Fade_Promote).alpha = 0.4
                    ;
                    ((self.ui).Promotelist):SetActive(false)
                  end
                  ;
                  ((self.ui).unlockSkillItem):SetActive(false)
                  -- DECOMPILER ERROR at PC295: Confused about usage of register: R5 in 'UnsetPending'

                  ;
                  ((self.ui).Fade_Skill).alpha = 0.4
                  if not isFullLevel then
                    local nextRank = (self.heroData).rank + 1
                    local newUSkill = ((ConfigData.hero_rank)[nextRank]).ultimateskill_level
                    local overSkillData = nil
                    local hasOpenSkill = false
                    for _,skillData in ipairs((self.heroData).skillList) do
                      if skillData:IsUniqueSkill() and (self.heroData):GetUltimateSkillLevel() < newUSkill then
                        overSkillData = skillData
                        -- DECOMPILER ERROR at PC325: Overwrote pending register: R16 in 'AssignReg'

                        ;
                        ((self.ui).Tex_unlockSkillTip):SetIndex(R16_PC188)
                        break
                      end
                      if (skillData.skillCfg).open_star == nextRank and not hasOpenSkill then
                        overSkillData = skillData
                        -- DECOMPILER ERROR at PC338: Overwrote pending register: R16 in 'AssignReg'

                        ;
                        ((self.ui).Tex_unlockSkillTip):SetIndex(R16_PC188)
                        hasOpenSkill = true
                      end
                    end
                    do
                      if overSkillData ~= nil then
                        ((self.ui).unlockSkillItem):SetActive(true)
                        ;
                        (self.skillItem):InitBaseSkillItem(overSkillData, self.resloader)
                        ;
                        (self.skillItem):__SetUnlockUI(true)
                        -- DECOMPILER ERROR at PC361: Confused about usage of register: R9 in 'UnsetPending'

                        ;
                        ((self.ui).Fade_Skill).alpha = 1
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

UIHeroStarUp.SetStarUpGray = function(self, ableUp)
  -- function num : 0_12
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if ableUp then
    ((self.ui).img_btn_StarUp).color = (self.ui).color_orange
  else
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_btn_StarUp).color = (self.ui).color_gray
  end
end

UIHeroStarUp.OnClickStarUp = function(self)
  -- function num : 0_13 , upvalues : cs_MessageCommon, _ENV
  local ableUp, fitFrag, fitCurrency, fitExtr = (self.heroData):AbleUpgradeStar()
  if ableUp then
    (self.networkCtrl):SendHeroAddStar((self.heroData).dataId)
  else
    if not fitFrag or not fitCurrency or not fitExtr then
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.hero_CantUpgrade))
    end
  end
end

UIHeroStarUp.OnClickBack = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if not self.isClosing then
    self.isClosing = true
  else
    return 
  end
  if self.hideCallBack ~= nil then
    (self.hideCallBack)()
  end
  UIManager:ShowWindow(UIWindowTypeID.HeroState)
  self:Hide()
end

UIHeroStarUp.PlayAllDOTween = function(self)
  -- function num : 0_15
  for i = 0, (self.allTweens).Length - 1 do
    local tween = (self.allTweens)[i]
    tween:DORestart(false)
  end
end

UIHeroStarUp.BackwardsAllDOTween = function(self, callback)
  -- function num : 0_16 , upvalues : _ENV
  local longestDuration = 0
  for i = 0, (self.allTweens).Length - 1 do
    local tween = (self.allTweens)[i]
    if longestDuration < tween.duration then
      longestDuration = tween.duration
    end
    tween:DOPlayBackwards()
  end
  if callback ~= nil then
    (TimerManager:GetTimer(longestDuration, callback, nil, true)):Start()
  end
end

UIHeroStarUp.__OnClickLeftArrow = function(self)
  -- function num : 0_17
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = (self.switchHeroFunc)(-1)
    self:SwitchHero(newHeroData, reUseBigImgResloader)
  end
end

UIHeroStarUp.__OnClickRightArrow = function(self)
  -- function num : 0_18
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = (self.switchHeroFunc)(1)
    self:SwitchHero(newHeroData, reUseBigImgResloader)
  end
end

UIHeroStarUp.OnDelete = function(self)
  -- function num : 0_19 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnHeroRankChange, self.__RefreshRank)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__RefreshItem)
  ;
  (self.resourceGroup):Delete()
  ;
  (base.OnDelete)(self)
end

return UIHeroStarUp


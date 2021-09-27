local UINDungeonInfoChipDetail = class("UINDungeonInfoChipDetail", UIBaseNode)
local base = UIBaseNode
local UINChipDetailSuitItem = require("Game.CommonUI.Chip.UINChipDetailSuitItem")
local UINChipLevel = require("Game.CommonUI.Chip.UINChipLevel")
local DynChipSuit = require("Game.Exploration.Data.ChipSuit.DynChipSuit")
local UINEpChipSuitDescItem = require("Game.Exploration.UI.ChipSuit.UINEpChipSuitDescItem")
local UINPlayerConsumeSkillItem = require("Game.Battle.UI.SkillModule.PlayerSkill.UINPlayerConsumeSkillItem")
local cs_Edge = ((CS.UnityEngine).RectTransform).Edge
local cs_MessageCommon = CS.MessageCommon
UINDungeonInfoChipDetail.ctor = function(self, dungeonInfoDetailRoot)
  -- function num : 0_0
  self.dungeonInfoDetailRoot = dungeonInfoDetailRoot
end

UINDungeonInfoChipDetail.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, UINChipDetailSuitItem, UINChipLevel, UINEpChipSuitDescItem, UINPlayerConsumeSkillItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ShowIntro, self, self.__ShowSkillIntro)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SellOut, self, self.__OnClickSellOut)
  self.nowChipIndex = 1
  self.chipDataList = {}
  self.epNetWork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  self._OnSellCompleteFunc = BindCallback(self, self._OnSellComplete)
  self.suitItemPool = (UIItemPool.New)(UINChipDetailSuitItem, (self.ui).suitItem)
  ;
  ((self.ui).suitItem):SetActive(false)
  self.chipLevelNode = (UINChipLevel.New)()
  ;
  (self.chipLevelNode):Init((self.ui).level)
  self.suitDescItemPool = (UIItemPool.New)(UINEpChipSuitDescItem, (self.ui).suitDescItem)
  ;
  ((self.ui).suitDescItem):SetActive(false)
  ;
  ((self.ui).suitNode):SetActive(false)
  self.consumeSkillItem = (UINPlayerConsumeSkillItem.New)()
  ;
  (self.consumeSkillItem):Init((self.ui).uIBattleSkillItem)
  ;
  (self.consumeSkillItem):Hide()
end

UINDungeonInfoChipDetail.OnShow = function(self)
  -- function num : 0_2 , upvalues : _ENV
  AudioManager:PlayAudioById(1066)
end

UINDungeonInfoChipDetail.InitChipInfo = function(self, chipDataList, index)
  -- function num : 0_3
  self.chipDataList = chipDataList
  self:RefreshData(index)
end

UINDungeonInfoChipDetail.RefreshData = function(self, index)
  -- function num : 0_4 , upvalues : _ENV, DynChipSuit
  self.nowChipIndex = index
  local chipData = (self.chipDataList)[index]
  local chipCfg = chipData.chipCfg
  local chipDetailColor = ChipDetailColor[chipData:GetQuality()]
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_QualityColor).color = chipDetailColor.normal
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Light).color = chipDetailColor.light
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Corner).sprite = CRH:GetSprite(chipData:GetChipMarkIcon(), CommonAtlasType.ExplorationIcon)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_ChipName).text = chipData:GetName()
  ;
  (self.chipLevelNode):InitChipLevel(chipData, nil, true, true)
  local isConsumeChip = chipData:IsConsumeSkillChip()
  ;
  (((self.ui).img_Icon).gameObject):SetActive(not isConsumeChip)
  if isConsumeChip then
    (self.consumeSkillItem):Show()
    ;
    (self.consumeSkillItem):InitPlayerConsumeSkillJustShow(chipData:GetSkillCfg())
  else
    ;
    (self.consumeSkillItem):Hide()
    local iconSprite = CRH:GetSprite(chipData:GetIcon())
    -- DECOMPILER ERROR at PC67: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = iconSprite
    -- DECOMPILER ERROR at PC70: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).img_IconSD).sprite = iconSprite
  end
  do
    ;
    ((self.ui).tempSkillType):SetActive(isConsumeChip)
    local unlockChipSuit = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TagSuit)
    local tagId = chipData:GetChipFuncTag()
    if unlockChipSuit and tagId ~= 0 and not isConsumeChip then
      (self.suitItemPool):HideAll()
      local dynPlayer = (BattleUtil.GetCurDynPlayer)()
      local showFuncCount = dynPlayer ~= nil and dynPlayer:GetChipTagIdCount(tagId) or 0
      local item = (self.suitItemPool):GetOne()
      if dynPlayer == nil then
        item:InitChipDetailSuit(tagId)
      else
        local haveCount, maxCount = dynPlayer:GetChipTagIdCount(tagId)
        item:InitChipDetailSuitAndCount(tagId, haveCount, maxCount, dynPlayer, true, false)
      end
      do
        local isShowDetail = (CommonUtil.GetDetailDescribeSetting)(eGameSetDescType.chip)
        ;
        ((self.ui).suitNode):SetActive(true)
        local chipSuit = (DynChipSuit.New)(tagId, showFuncCount)
        -- DECOMPILER ERROR at PC141: Confused about usage of register: R13 in 'UnsetPending'

        ;
        ((self.ui).img_suitIcon).sprite = chipSuit:GetChipSuitIconSprite()
        -- DECOMPILER ERROR at PC146: Confused about usage of register: R13 in 'UnsetPending'

        ;
        ((self.ui).tex_SuitName).text = chipSuit:GetChipSuitName()
        ;
        (self.suitDescItemPool):HideAll()
        for _,tag_suit in ipairs(chipSuit.tagSuitCfg) do
          local item = (self.suitDescItemPool):GetOne()
          item:InitSuitDescItem(tag_suit.number, tag_suit.number <= showFuncCount, ConfigData:GetChipDescriptionById(tag_suit.chip_id, 1, isShowDetail), (self.ui).color_suitActive, (self.ui).color_suitlock)
        end
        ;
        (self.suitItemPool):HideAll()
        ;
        ((self.ui).suitNode):SetActive(false)
        ;
        (((self.ui).btn_ShowIntro).gameObject):SetActive(false)
        local isShowDetail = (CommonUtil.GetDetailDescribeSetting)(eGameSetDescType.chip)
        -- DECOMPILER ERROR at PC202: Confused about usage of register: R9 in 'UnsetPending'

        ;
        ((self.ui).tex_Description).text = chipData:GetChipDescription(isShowDetail)
        if #chipCfg.skill_list > 0 then
          local num = chipData:GetCount()
          local skillId = (chipCfg.skill_list)[1]
          local tab = {}
          local btnActive = false
          local skillLabeIdList = nil
          local labelDic = ((ConfigData.battle_skill).skill_label_Dic)[skillId]
          if labelDic ~= nil then
            for id,unlockLevel in pairs(labelDic) do
              if unlockLevel <= num then
                btnActive = true
                ;
                (table.insert)(tab, id)
              end
            end
          end
          if btnActive then
            self.uiIntroData = {}
            -- DECOMPILER ERROR at PC239: Confused about usage of register: R15 in 'UnsetPending'

            ;
            (self.uiIntroData).skillLabeIdList = tab
            ;
            (((self.ui).btn_ShowIntro).gameObject):SetActive(btnActive)
          end
        end
        local showSellBtn = false
        if ExplorationManager.epCtrl ~= nil then
          if ((ExplorationManager.epCtrl).residentStoreCtrl):HasEpResidentStore() then
            showSellBtn = not ((ExplorationManager.epCtrl).sceneCtrl):InBattleScene()
          end
          if showSellBtn then
            local epTypeCfg = ExplorationManager:GetEpTypeCfg()
            local buyPrice = chipData:GetChipBuyPrice(ExplorationManager:GetEpModuleId())
            local sellPrice = ConfigData:CalculateEpChipSalePrice(epTypeCfg.store_pool, chipData:GetCount(), buyPrice, ExplorationManager:GetDynPlayer())
            -- DECOMPILER ERROR at PC289: Confused about usage of register: R13 in 'UnsetPending'

            ;
            ((self.ui).tex_SellOut).text = tostring(sellPrice)
          end
        end
        ;
        (((self.ui).btn_SellOut).gameObject):SetActive(showSellBtn)
        -- DECOMPILER ERROR: 9 unprocessed JMP targets
      end
    end
  end
end

UINDungeonInfoChipDetail.SwitchChip = function(self, bool)
  -- function num : 0_5
  local nextIndex = self.nowChipIndex
  local listCount = #self.chipDataList
  if bool then
    if listCount < nextIndex + 1 then
      nextIndex = 1
    else
      nextIndex = nextIndex + 1
    end
  else
    if nextIndex - 1 <= 0 then
      nextIndex = listCount
    else
      nextIndex = nextIndex - 1
    end
  end
  self:RefreshData(nextIndex)
  return nextIndex
end

UINDungeonInfoChipDetail.__ShowSkillIntro = function(self)
  -- function num : 0_6 , upvalues : _ENV, cs_Edge
  if self.uiIntroData == nil then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.RichIntro, function(win)
    -- function num : 0_6_0 , upvalues : _ENV, self, cs_Edge
    if win ~= nil then
      local modifier = nil
      local infowin = UIManager:GetWindow(UIWindowTypeID.DungeonInfoDetail)
      if infowin ~= nil then
        modifier = (infowin.ui).modifier
      end
      win:SetRichIntroList((self.ui).introHolder, self.uiIntroData, modifier)
      win:SetIntroListPosition(cs_Edge.Left)
    end
  end
)
end

UINDungeonInfoChipDetail.__OnClickSellOut = function(self)
  -- function num : 0_7 , upvalues : _ENV, cs_MessageCommon
  local chipData = (self.chipDataList)[self.nowChipIndex]
  self._sellChipName = chipData:GetName()
  local epTypeCfg = ExplorationManager:GetEpTypeCfg()
  local buyPrice = chipData:GetChipBuyPrice(ExplorationManager:GetEpModuleId())
  local sellPrice = ConfigData:CalculateEpChipSalePrice(epTypeCfg.store_pool, chipData:GetCount(), buyPrice, ExplorationManager:GetDynPlayer())
  local msg = (string.format)(ConfigData:GetTipContent(288), self._sellChipName, tostring(sellPrice))
  ;
  (cs_MessageCommon.ShowMessageBox)(msg, function()
    -- function num : 0_7_0 , upvalues : self, chipData
    (self.epNetWork):CS_EXPLORATION_Alg_Sold(chipData.dataId, self._OnSellCompleteFunc)
  end
, nil)
end

UINDungeonInfoChipDetail._OnSellComplete = function(self)
  -- function num : 0_8 , upvalues : cs_MessageCommon, _ENV
  (cs_MessageCommon.ShowMessageTips)(self._sellChipName .. ConfigData:GetTipContent(TipContent.exploration_Store_SellSuc))
  self._sellChipName = nil
  ;
  (self.dungeonInfoDetailRoot):OnClickRetreat()
end

UINDungeonInfoChipDetail.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  (self.suitItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINDungeonInfoChipDetail


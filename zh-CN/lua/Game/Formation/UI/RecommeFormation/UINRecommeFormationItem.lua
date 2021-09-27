local UINRecommeFormationItem = class("UINRecommeFormationItem", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadWithStarItem = require("Game.CommonUI.Hero.UINHeroHeadWithStarItem")
local UINCommanderSkill = require("Game.Formation.UI.UINCommanderSkill")
local CS_MessageCommon = CS.MessageCommon
UINRecommeFormationItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINCommanderSkill, UINHeroHeadWithStarItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).obj_HeroHead):SetActive(false)
  ;
  ((self.ui).obj_EmptyHero):SetActive(false)
  ;
  ((self.ui).skillItem):SetActive(false)
  self.skillIconPool = (UIItemPool.New)(UINCommanderSkill, (self.ui).skillItem)
  self.heroHeadPool = (UIItemPool.New)(UINHeroHeadWithStarItem, (self.ui).obj_HeroHead)
  self.emptyIconList = {}
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Use, self, self.OnClickCopy)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ViewChip, self, self.OnClickLookChip)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_OpenUserInfo, self, self.OnClickOpenUserInfo)
end

UINRecommeFormationItem.InitItem = function(self, recommeCtr, data, isOpenCopy, resloader)
  -- function num : 0_1 , upvalues : _ENV
  self.recommeCtr = recommeCtr
  self.data = data
  self.resloader = resloader
  ;
  (((self.ui).btn_Use).gameObject):SetActive(isOpenCopy)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_UserName).text = (self.data).playerName
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_MainTeamPower).text = tostring((self.data).firstPower)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_BenchTeamPower).text = tostring((self.data).benchPower)
  local isAllow = data:IsAllowCopy()
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R6 in 'UnsetPending'

  if not isAllow or not (self.ui).colorNorImg then
    ((self.ui).img_Use).color = (self.ui).colorGrayImg
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R6 in 'UnsetPending'

    if not isAllow or not (self.ui).colorNorText then
      ((self.ui).text_Use).color = (self.ui).colorGrayText
      -- DECOMPILER ERROR at PC60: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).tex_ComSkillName).text = (LanguageUtil.GetLocaleText)(((self.data).treeCfg).name)
      ;
      (self.skillIconPool):HideAll()
      for i = 1, #(self.data).slotSkillList do
        local skillId = ((self.data).slotSkillList)[i]
        if skillId ~= nil and skillId > 0 then
          local item = (self.skillIconPool):GetOne()
          item:InitCommanderSkill(skillId, self.resloader)
        end
      end
      local stageCount = (ConfigData.game_config).max_stage_hero
      local allCount = stageCount + (ConfigData.game_config).max_bench_hero
      ;
      (self.heroHeadPool):HideAll()
      for i = 1, #self.emptyIconList do
        ((self.emptyIconList)[i]):SetActive(false)
      end
      local emptyIndex = self:__RefreshHeroIcon(1, (self.ui).mainTeam, 1, stageCount)
      self:__RefreshHeroIcon(emptyIndex, (self.ui).benchTeam, stageCount + 1, allCount)
      local isEmptyChip = (self.data).chipList == nil or #(self.data).chipList <= 0
      -- DECOMPILER ERROR at PC140: Confused about usage of register: R10 in 'UnsetPending'

      ;
      ((self.ui).canvasGroup_ViewChip).alpha = isEmptyChip and (self.ui).float_chipEmptyAlpha or 1
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
end

UINRecommeFormationItem.__RefreshHeroIcon = function(self, emptyIndex, parentTr, startIndex, endIndex)
  -- function num : 0_2 , upvalues : _ENV
  for i = startIndex, endIndex do
    local recommanHeroInfo = ((self.data).recommanHeroDic)[i]
    if recommanHeroInfo ~= nil then
      local item = (self.heroHeadPool):GetOne()
      local isHas = (PlayerDataCenter.heroDic)[(recommanHeroInfo.basic).dataId] ~= nil
      local isMvp = (recommanHeroInfo.basic).dataId == (self.data).mvpHeroId
      item:InitHead(recommanHeroInfo.basic, isHas, isMvp)
      ;
      ((item.gameObject).transform):SetParent(parentTr)
      ;
      ((item.gameObject).transform):SetAsLastSibling()
    else
      local emptyIcon = nil
      if emptyIndex <= #self.emptyIconList then
        emptyIcon = (self.emptyIconList)[emptyIndex]
      else
        emptyIcon = ((self.ui).obj_EmptyHero):Instantiate()
        ;
        (table.insert)(self.emptyIconList, emptyIcon)
      end
      emptyIndex = emptyIndex + 1
      emptyIcon:SetActive(true)
      ;
      (emptyIcon.transform):SetParent(parentTr)
      ;
      (emptyIcon.transform):SetAsLastSibling()
    end
  end
  do return emptyIndex end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

UINRecommeFormationItem.OnClickCopy = function(self)
  -- function num : 0_3 , upvalues : _ENV, CS_MessageCommon
  if (self.data):IsAllowCopy() then
    local showingWindow = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    showingWindow:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(TipContent.Recomme_Confirm), function()
    -- function num : 0_3_0 , upvalues : _ENV, self
    (UIUtil.OnClickBack)()
    ;
    (self.recommeCtr):ExitRecommeFormation(self.data)
  end
, nil)
  else
    do
      ;
      (CS_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Recomme_Fail))
    end
  end
end

UINRecommeFormationItem.OnClickLookChip = function(self)
  -- function num : 0_4 , upvalues : CS_MessageCommon, _ENV
  if (self.data).chipList == nil or #(self.data).chipList <= 0 then
    (CS_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Recomme_ChipEmpty))
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.ViewChips, function(windows)
    -- function num : 0_4_0 , upvalues : self, _ENV
    if windows ~= nil then
      (windows.transform):SetAsLastSibling()
      if (self.data).chipList ~= nil then
        windows:InitChips((self.data).chipList, self.resloader)
        windows:SetViewChipsCloseCallback(function()
      -- function num : 0_4_0_0 , upvalues : _ENV
      (UIUtil.ReShowTopStatus)()
    end
)
        ;
        (UIUtil.HideTopStatus)()
      end
    end
  end
)
end

UINRecommeFormationItem.OnClickOpenUserInfo = function(self)
  -- function num : 0_5 , upvalues : _ENV
  PlayerDataCenter:GetUserInfoByUID((self.data).playerId, function(userInfoData)
    -- function num : 0_5_0 , upvalues : _ENV
    if userInfoData == nil then
      return 
    end
    local oringLayoutLevel = (UIWindowGlobalConfig[UIWindowTypeID.CommonUserInfo]).LayoutLevel
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (UIWindowGlobalConfig[UIWindowTypeID.CommonUserInfo]).LayoutLevel = (UIWindowGlobalConfig[UIWindowTypeID.RecommeFormation]).LayoutLevel
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonUserInfo, function(win)
      -- function num : 0_5_0_0 , upvalues : userInfoData, _ENV, oringLayoutLevel
      if win == nil then
        return 
      end
      win:InitUserInfoView(userInfoData)
      -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (UIWindowGlobalConfig[UIWindowTypeID.CommonUserInfo]).LayoutLevel = oringLayoutLevel
    end
)
  end
)
end

return UINRecommeFormationItem


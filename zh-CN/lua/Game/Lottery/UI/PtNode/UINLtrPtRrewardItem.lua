local UINLtrPtRrewardItem = class("UINLtrPtRrewardItem", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
UINLtrPtRrewardItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Exchange, self, self._OnClickExchange)
  ;
  (((self.ui).img_Star).gameObject):SetActive(false)
  self.starList = {}
end

UINLtrPtRrewardItem.InitLtrPtRrewardItem = function(self, itemId, costNum, resLoader, exchangeFunc, ptNum, firstAwardId, firstAwardNum)
  -- function num : 0_1 , upvalues : _ENV
  local itemCfg = (ConfigData.item)[itemId]
  if itemCfg == nil then
    error("Can\'t find item, id = " .. tostring(itemId))
    return 
  end
  local heroId = nil
  if itemCfg.action_type == eItemActionType.HeroCard then
    heroId = (itemCfg.arg)[1]
  else
    error("Item is not hero, itemId = " .. tostring(itemId))
    return 
  end
  self.itemId = itemId
  self.costNum = costNum
  self.firstAwardId = firstAwardId
  self.firstAwardNum = firstAwardNum
  self.enableExcange = costNum <= ptNum
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R10 in 'UnsetPending'

  if not self.enableExcange or not Color.white then
    ((self.ui).img_ExchangeBtn).color = Color.gray
    self.exchangeFunc = exchangeFunc
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R10 in 'UnsetPending'

    ;
    ((self.ui).tex_Count).text = tostring(costNum)
    ;
    ((self.ui).has):SetActive((PlayerDataCenter.heroDic)[heroId] ~= nil)
    local heroCfg = (ConfigData.hero_data)[heroId]
    self.heroCfg = heroCfg
    -- DECOMPILER ERROR at PC79: Confused about usage of register: R11 in 'UnsetPending'

    ;
    ((self.ui).tex_HeroName).text = (LanguageUtil.GetLocaleText)(heroCfg.name)
    local careerCfg = (ConfigData.career)[heroCfg.career]
    -- DECOMPILER ERROR at PC92: Confused about usage of register: R12 in 'UnsetPending'

    ;
    ((self.ui).img_Career).sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
    local resCfg = (ConfigData.resource_model)[heroCfg.src_id]
    if resCfg == nil then
      error("resource model Cfg is null,id:" .. tostring(heroCfg.src_id))
      return 
    end
    -- DECOMPILER ERROR at PC109: Confused about usage of register: R13 in 'UnsetPending'

    ;
    ((self.ui).img_Hero).enabled = false
    resLoader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(resCfg.res_Name), function(texture)
    -- function num : 0_1_0 , upvalues : _ENV, self
    if IsNull(texture) then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Hero).texture = texture
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Hero).enabled = true
  end
)
    local rankCfg = (ConfigData.hero_rank)[heroCfg.rank]
    if rankCfg == nil then
      error("Can\'t find rankCfg, id = " .. tostring(heroCfg.rank))
    end
    self:__RefreshStar(rankCfg.star)
    self:__RefreshFirstAward()
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
end

UINLtrPtRrewardItem.__RefreshStar = function(self, heroStar)
  -- function num : 0_2 , upvalues : _ENV
  for k,v in ipairs(self.starList) do
    (v.gameObject):SetActive(false)
    v:SetIndex(0)
  end
  local count = (math.ceil)(heroStar / 2)
  local isHalf = heroStar % 2 == 1
  for i = 1, count do
    local star = (self.starList)[i]
    if star == nil then
      star = ((self.ui).img_Star):Instantiate()
      ;
      (table.insert)(self.starList, star)
    end
    ;
    (star.gameObject):SetActive(true)
    if isHalf and i == count then
      star:SetIndex(1)
    end
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINLtrPtRrewardItem.__RefreshFirstAward = function(self)
  -- function num : 0_3 , upvalues : UINBaseItemWithCount, _ENV
  if self.firstAwardId == nil then
    ((self.ui).firstAward):SetActive(false)
    return 
  end
  ;
  ((self.ui).firstAward):SetActive(true)
  if self.firstAwardItem == nil then
    self.firstAwardItem = (UINBaseItemWithCount.New)()
    ;
    (self.firstAwardItem):Init((self.ui).uINBaseItemWithCount)
  end
  local firstAwardCfg = (ConfigData.item)[self.firstAwardId]
  ;
  (self.firstAwardItem):InitItemWithCount(firstAwardCfg, self.firstAwardNum)
end

UINLtrPtRrewardItem._OnClickExchange = function(self)
  -- function num : 0_4 , upvalues : cs_MessageCommon, _ENV
  if not self.enableExcange then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(10010))
    return 
  end
  if self.exchangeFunc ~= nil then
    (self.exchangeFunc)(self.itemId, self.costNum, self.heroCfg, self.firstAwardId, self.firstAwardNum)
  end
end

UINLtrPtRrewardItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINLtrPtRrewardItem


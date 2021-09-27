local UICommonRewardItem = class("UICommonRewardItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_DoTween = ((CS.DG).Tweening).DOTween
local cs_LoopTypeYoyo = (((CS.DG).Tweening).LoopType).Yoyo
local CS_CanvasGroup = (CS.UnityEngine).CanvasGroup
UICommonRewardItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.baseItem = (UINBaseItemWithCount.New)()
  ;
  (self.baseItem):Init((self.ui).obj_BaseItemWithCount)
  self.convertItemPool = (UIItemPool.New)(UINBaseItemWithCount, (self.ui).obj_BaseItemWithCount)
end

UICommonRewardItem.InitCommonRewardItem = function(self, itemCfg, rewardNum, heroIdSnapshoot, clickEvent)
  -- function num : 0_1 , upvalues : _ENV
  if itemCfg == nil then
    return 
  end
  self.itemCfg = itemCfg
  ;
  (self.baseItem):InitItemWithCount(itemCfg, rewardNum, clickEvent)
  ;
  (self.baseItem):SetNotNeedAnyJump(true)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_ItemName).text = tostring((LanguageUtil.GetLocaleText)(itemCfg.name))
  local hasHero = false
  local heroId = itemCfg.heroId
  hasHero = heroId == nil or heroIdSnapshoot == nil or (heroIdSnapshoot[heroId] and true) or false
  if itemCfg.type ~= eItemType.HeroCard or not hasHero then
    return 
  end
  local heroData = PlayerDataCenter:GetHeroData(heroId)
  local rankCfg = (ConfigData.hero_rank)[(heroData.heroCfg).rank]
  if rankCfg == nil then
    error("Can\'t find rankCfg, id = " .. tostring(heroId))
    return 
  end
  local itemList = {self.baseItem}
  local extraIds = rankCfg.repeat_extra_trans_id
  local extraNums = rankCfg.repeat_extra_trans_num
  ;
  (self.convertItemPool):HideAll()
  for k,id in ipairs(extraIds) do
    local num = extraNums[k]
    local itemCfg = (ConfigData.item)[id]
    if itemCfg == nil then
      error("Cant get itemCfg, id = " .. tostring(id))
    else
      local item = (self.convertItemPool):GetOne()
      item:InitItemWithCount(itemCfg, num)
      ;
      (item.transform):SetAsFirstSibling()
      ;
      (table.insert)(itemList, item)
    end
  end
  self:_PlayTween(itemList)
end

UICommonRewardItem._PlayTween = function(self, itemList)
  -- function num : 0_2 , upvalues : cs_DoTween, _ENV, CS_CanvasGroup, cs_LoopTypeYoyo
  if self.tweenSeq ~= nil then
    (self.tweenSeq):Kill()
    self.tweenSeq = nil
  end
  local tweenSeq = (cs_DoTween.Sequence)()
  for index,item in ipairs(itemList) do
    if item.fade == nil then
      item.fade = (item.gameObject):AddComponent(typeof(CS_CanvasGroup))
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (item.fade).alpha = 1
    end
    if index == 1 then
      tweenSeq:Append(((item.fade):DOFade(0, 1.5)):SetDelay(1.5))
    else
      tweenSeq:Join((((item.fade):DOFade(0, 1.5)):From()):SetDelay(index * 0.35))
    end
  end
  tweenSeq:SetLoops(-1, cs_LoopTypeYoyo)
  self.tweenSeq = tweenSeq
end

UICommonRewardItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  if self.tweenSeq ~= nil then
    (self.tweenSeq):Kill()
    self.tweenSeq = nil
  end
  ;
  (base.OnDelete)(self)
end

return UICommonRewardItem


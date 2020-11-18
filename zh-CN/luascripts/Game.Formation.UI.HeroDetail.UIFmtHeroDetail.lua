-- params : ...
-- function num : 0 , upvalues : _ENV
local UIFmtHeroDetail = class("UIFmtHeroDetail", UIBaseWindow)
local base = UIBaseWindow
local UINHeroDetailItem = require("Game.Formation.UI.HeroDetail.UINHeroDetailItem")
local eFmtHeroDetailState = require("Game.Formation.Enum.eFmtHeroDetailState")
local CS_ResLoader = CS.ResLoader
local CS_LayoutRebuilder = ((CS.UnityEngine).UI).LayoutRebuilder
UIFmtHeroDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroDetailItem, CS_ResLoader
  (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self, self.OnClickBack)
  ;
  ((self.ui).heroDetailItem):SetActive(false)
  self.heroDetailItemPool = (UIItemPool.New)(UINHeroDetailItem, (self.ui).heroDetailItem)
  self.heroDetailItemGoDic = nil
  self.resloader = (CS_ResLoader.Create)()
  self.__onClickFmtHeroDetailItem = BindCallback(self, self.OnClickFmtHeroDetailItem)
  self.__OnBeginDrag = BindCallback(self, self.OnBeginDrag)
  self.__OnDrag = BindCallback(self, self.OnDrag)
  self.__OnEndDrag = BindCallback(self, self.OnEndDrag)
end

UIFmtHeroDetail.InitFmtHeroDetail = function(self, fmtId, fmtCtrl)
  -- function num : 0_1 , upvalues : _ENV
  self.fmtCtrl = fmtCtrl
  self.formationData = (PlayerDataCenter.formationDic)[fmtId]
  if self.formationData == nil then
    error("Can\'t get formationData, formationId = " .. tostring(fmtId))
    return 
  end
  self:RefreshHeroDetail()
end

UIFmtHeroDetail.RefreshHeroDetail = function(self)
  -- function num : 0_2 , upvalues : _ENV, CS_LayoutRebuilder
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).mainTeam).enabled = true
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).benchTeam).enabled = true
  self.heroDetailItemGoDic = {}
  ;
  (self.heroDetailItemPool):HideAll()
  for i = 1, (ConfigData.game_config).max_stage_hero do
    local item = (self.heroDetailItemPool):GetOne()
    ;
    (item.transform):SetParent(((self.ui).mainTeam).transform)
    local fmtIndex = i
    local heroId = ((self.formationData).data)[fmtIndex]
    item:InitFmtHeroDetailItem(fmtIndex, heroId, self, self.resloader, nil, self.__onClickFmtHeroDetailItem)
    item:SetHeroDetailItemDragEvent(self.__OnBeginDrag, self.__OnDrag, self.__OnEndDrag)
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self.heroDetailItemGoDic)[item.gameObject] = item
  end
  ;
  (CS_LayoutRebuilder.ForceRebuildLayoutImmediate)(((self.ui).mainTeam).transform)
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
  for i = 1, (ConfigData.game_config).max_bench_hero do
    local fmtIndex = i + (ConfigData.game_config).max_stage_hero
    local heroId = ((self.formationData).data)[fmtIndex]
    local unlock, lockStr = (fmtCtrl.BenchUnlock)(i, true)
    local item = (self.heroDetailItemPool):GetOne()
    ;
    (item.transform):SetParent(((self.ui).benchTeam).transform)
    item:InitFmtHeroDetailItem(fmtIndex, heroId, self, self.resloader, lockStr, self.__onClickFmtHeroDetailItem)
    item:SetHeroDetailItemDragEvent(self.__OnBeginDrag, self.__OnDrag, self.__OnEndDrag)
    -- DECOMPILER ERROR at PC98: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (self.heroDetailItemGoDic)[item.gameObject] = item
  end
  ;
  (CS_LayoutRebuilder.ForceRebuildLayoutImmediate)(((self.ui).benchTeam).transform)
  -- DECOMPILER ERROR at PC107: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).mainTeam).enabled = false
  -- DECOMPILER ERROR at PC110: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).benchTeam).enabled = false
end

UIFmtHeroDetail.GetHeroDetailItemByGo = function(self, gameObject)
  -- function num : 0_3
  return (self.heroDetailItemGoDic)[gameObject]
end

UIFmtHeroDetail.ChangeFmtSort = function(self, fromFmtIndex, toFmtIndex)
  -- function num : 0_4
  local newFmtData = (self.formationData).data
  newFmtData[fromFmtIndex] = newFmtData[toFmtIndex]
  ;
  (self.fmtCtrl):ModifyFormation(newFmtData)
end

UIFmtHeroDetail.OnClickFmtHeroDetailItem = function(self, fmtHeroDetailState, heroData)
  -- function num : 0_5 , upvalues : eFmtHeroDetailState
  if self.__dragItem ~= nil then
    return 
  end
  if fmtHeroDetailState ~= eFmtHeroDetailState.Lock then
    (self.fmtCtrl):ShowQuickFormation(heroData)
  end
end

UIFmtHeroDetail.OnBeginDrag = function(self, heroItem, eventData)
  -- function num : 0_6 , upvalues : eFmtHeroDetailState, _ENV
  if heroItem:GetFmtHeroDetailState() ~= eFmtHeroDetailState.HasHero or self.__dragItem ~= nil then
    return 
  end
  self.__lastParent = (heroItem.transform).parent
  self.__lastPos = heroItem:GetHeroDetailItemRootPos()
  local newPos = UIManager:Screen2WorldPosition(eventData.position, heroItem.transform)
  self.__dragOffset = heroItem:GetHeroDetailItemRootPos() - newPos
  heroItem:EnableFmtHeroRaycast(false)
  ;
  (heroItem.transform):SetParent(((heroItem.transform).parent).parent)
  self.__inDrag = true
  self.__dragItem = heroItem
end

UIFmtHeroDetail.OnDrag = function(self, heroItem, eventData)
  -- function num : 0_7 , upvalues : _ENV
  if not self.__inDrag or heroItem ~= self.__dragItem then
    return 
  end
  local newPos = UIManager:Screen2WorldPosition(eventData.position, heroItem.transform)
  newPos = newPos + self.__dragOffset
  newPos.y = (heroItem:GetHeroDetailItemRootPos()).y
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (heroItem.transform).position = newPos
end

UIFmtHeroDetail.OnEndDrag = function(self, heroItem, eventData)
  -- function num : 0_8 , upvalues : _ENV, eFmtHeroDetailState
  if not self.__inDrag or heroItem ~= self.__dragItem then
    return 
  end
  self.__inDrag = false
  local targetGo = (eventData.pointerCurrentRaycast).gameObject
  local targetItem = nil
  if not IsNull(targetGo) then
    targetItem = self:GetHeroDetailItemByGo(targetGo)
  end
  if targetItem ~= nil and targetItem:GetFmtHeroDetailState() ~= eFmtHeroDetailState.Lock then
    (heroItem.transform):SetParent((targetItem.transform).parent)
    ;
    (targetItem.transform):SetParent(self.__lastParent)
    local newPos = targetItem:GetHeroDetailItemRootPos()
    targetItem:DragEndTweenHeroDetailItem(self.__lastPos)
    heroItem:DragEndTweenHeroDetailItem(newPos)
    local targetFmtIndex = targetItem:GetFmtHeroDetailIndex()
    self:ChangeFmtSort(heroItem:GetFmtHeroDetailIndex(), targetFmtIndex)
  else
    do
      ;
      (heroItem.transform):SetParent(self.__lastParent)
      heroItem:DragEndTweenHeroDetailItem(self.__lastPos)
      heroItem:EnableFmtHeroRaycast(true)
      self.__dragItem = nil
    end
  end
end

UIFmtHeroDetail.OnClickBack = function(self)
  -- function num : 0_9
  (self.fmtCtrl):ExitFmtHeroDetail()
end

UIFmtHeroDetail.OnDelete = function(self)
  -- function num : 0_10 , upvalues : base
  (self.heroDetailItemPool):DeleteAll()
  ;
  (self.resloader):Put2Pool()
  self.resloader = nil
  ;
  (base.OnDelete)(self)
end

return UIFmtHeroDetail


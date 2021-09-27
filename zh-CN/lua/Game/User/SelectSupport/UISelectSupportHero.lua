local UISelectSupportHero = class("UISelectSupportHero", UIBaseWindow)
local base = UIBaseWindow
local UINHeroHeadWithStarItem = require("Game.CommonUI.Hero.UINHeroHeadWithStarItem")
UISelectSupportHero.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.netWorkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Object)
  ;
  (UIUtil.SetTopStatus)(self, self.OnReturnClick)
  ;
  (UIUtil.AddButtonListenerWithArg)((self.ui).btn_Cancel, self, UIUtil.OnClickBack)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Comfirm, self, self.OnClickConfirm)
  self.itemDic = {}
  self.heroList = {}
  self.__curSelectedHeroData = nil
  self.__onClickHeroHeadItem = BindCallback(self, self.OnClickHeroHeadItem)
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loopScrollRect).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loopScrollRect).onChangeItem = BindCallback(self, self.__OnChangeItem)
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loopScrollRect).onReturnItem = BindCallback(self, self.__OnReturnItem)
  ;
  ((self.ui).obj_Select):SetActive(false)
  self.__OnHeroUpdate = BindCallback(self, self._OnHeroUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__OnHeroUpdate)
end

UISelectSupportHero.InitSelectSupportHero = function(self, index, curSelectHeroId, SelectedHeroIdDic, onChangeCallback)
  -- function num : 0_1 , upvalues : _ENV
  self.index = index
  self.curSelectHeroId = curSelectHeroId
  self.SelectedHeroIdDic = SelectedHeroIdDic
  self.onChangeCallback = onChangeCallback
  local count = 0
  for heroId,heroData in pairs(PlayerDataCenter.heroDic) do
    if curSelectHeroId == heroId or SelectedHeroIdDic[heroId] == nil then
      if curSelectHeroId == heroId then
        self.__curSelectedHeroData = heroData
      end
      ;
      (table.insert)(self.heroList, heroData)
      count = count + 1
    end
  end
  ;
  (table.sort)(self.heroList, function(heroDataA, heroDataB)
    -- function num : 0_1_0
    if heroDataB.rank >= heroDataA.rank then
      do return heroDataA.rank == heroDataB.rank end
      local powA = heroDataA:GetFightingPower()
      local powB = heroDataB:GetFightingPower()
      if powB >= powA then
        do return powA == powB end
        do return heroDataA.dataId < heroDataB.dataId end
        -- DECOMPILER ERROR: 5 unprocessed JMP targets
      end
    end
  end
)
  local targetIndex = ((table.indexof)(self.heroList, self.__curSelectedHeroData) or 1) - 1
  local offset = 0
  if #self.heroList - 5 < targetIndex and #self.heroList % 6 > 2 then
    offset = 50
  end
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).loopScrollRect).totalCount = count
  ;
  ((self.ui).loopScrollRect):RefillCells(targetIndex, offset)
end

UISelectSupportHero.__OnNewItem = function(self, go)
  -- function num : 0_2 , upvalues : UINHeroHeadWithStarItem
  local heroItem = (UINHeroHeadWithStarItem.New)()
  heroItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.itemDic)[go] = heroItem
end

UISelectSupportHero.__OnChangeItem = function(self, go, index)
  -- function num : 0_3 , upvalues : _ENV
  local heroItem = (self.itemDic)[go]
  if heroItem == nil then
    error("Can\'t find heroItem by gameObject")
    return 
  end
  local heroData = (self.heroList)[index + 1]
  if heroData == nil then
    error("Can\'t find levelData by index, index = " .. tonumber(index))
  end
  if self.__curSelectedHeroData == heroData then
    (((self.ui).obj_Select).transform):SetParent(heroItem.transform)
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (((self.ui).obj_Select).transform).anchoredPosition = Vector2.zero
    ;
    ((self.ui).obj_Select):SetActive(true)
  end
  heroItem:InitHead(heroData, nil, nil, self.__onClickHeroHeadItem)
end

UISelectSupportHero.__OnReturnItem = function(self, go)
  -- function num : 0_4
  local heroItem = (self.itemDic)[go]
  if heroItem.heroData == self.__curSelectedHeroData then
    ((self.ui).obj_Select):SetActive(false)
  end
end

UISelectSupportHero.OnClickHeroHeadItem = function(self, heroData)
  -- function num : 0_5 , upvalues : _ENV
  if self.__curSelectedHeroData == heroData then
    self.__curSelectedHeroData = nil
    ;
    ((self.ui).obj_Select):SetActive(false)
  else
    self.__curSelectedHeroData = heroData
    for _,heroItem in pairs(self.itemDic) do
      if heroItem.heroData == heroData then
        (((self.ui).obj_Select).transform):SetParent(heroItem.transform)
        -- DECOMPILER ERROR at PC29: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (((self.ui).obj_Select).transform).anchoredPosition = Vector2.zero
        ;
        ((self.ui).obj_Select):SetActive(true)
      end
    end
  end
end

UISelectSupportHero.OnClickConfirm = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.__curSelectedHeroData == nil and self.curSelectHeroId ~= nil then
    (self.netWorkCtrl):CS_ASSISTANT_Uninstall(self.curSelectHeroId, function()
    -- function num : 0_6_0 , upvalues : _ENV, self
    (PlayerDataCenter.inforData):SetSelfSupportHoreId(self.index, nil)
    if self.onChangeCallback ~= nil then
      (self.onChangeCallback)()
    end
    ;
    (UIUtil.OnClickBack)()
  end
)
  else
    if self.__curSelectedHeroData ~= nil and self.curSelectHeroId ~= (self.__curSelectedHeroData).dataId then
      local heroId = (self.__curSelectedHeroData).dataId
      do
        (self.netWorkCtrl):CS_ASSISTANT_Install(heroId, self.index, function()
    -- function num : 0_6_1 , upvalues : _ENV, self, heroId
    (PlayerDataCenter.inforData):SetSelfSupportHoreId(self.index, heroId)
    if self.onChangeCallback ~= nil then
      (self.onChangeCallback)()
    end
    ;
    (UIUtil.OnClickBack)()
  end
)
      end
    else
      do
        ;
        (UIUtil.OnClickBack)()
      end
    end
  end
end

UISelectSupportHero._OnHeroUpdate = function(self)
  -- function num : 0_7 , upvalues : _ENV
  for _,heroItem in pairs(self.itemDic) do
    heroItem:InitHead(heroItem.heroData, nil, nil, self.__onClickHeroHeadItem)
  end
end

UISelectSupportHero.OnReturnClick = function(self, isClickBackground)
  -- function num : 0_8
  self:Delete()
end

UISelectSupportHero.OnDelete = function(self)
  -- function num : 0_9 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__OnHeroUpdate)
  ;
  (base.OnDelete)(self)
end

return UISelectSupportHero


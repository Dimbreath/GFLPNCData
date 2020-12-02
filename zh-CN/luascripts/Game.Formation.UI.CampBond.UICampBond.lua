-- params : ...
-- function num : 0 , upvalues : _ENV
local UICampBond = class("UICampBond", UIBaseWindow)
local base = UIBaseWindow
local UINCampBondItem = require("Game.Formation.UI.CampBond.UINCampBondItem")
local UINCampBondDetailItem = require("Game.Formation.UI.CampBond.UINCampBondDetailItem")
UICampBond.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINCampBondItem, UINCampBondDetailItem
  (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self, self.OnClickBack)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CloseDetail, self, self.OnClickCloseDetail)
  ;
  (((self.ui).btn_CloseDetail).gameObject):SetActive(false)
  ;
  ((self.ui).bondDetailNode):SetActive(false)
  ;
  ((self.ui).campBondItem):SetActive(false)
  self.bondItemPool = (UIItemPool.New)(UINCampBondItem, (self.ui).campBondItem)
  ;
  ((self.ui).bondDetailItem):SetActive(false)
  self.bondDetailItemPool = (UIItemPool.New)(UINCampBondDetailItem, (self.ui).bondDetailItem)
  self.__ShowBondDetail = BindCallback(self, self.ShowBondDetail)
end

UICampBond.InitCampBond = function(self, campCountDic)
  -- function num : 0_1 , upvalues : _ENV
  local campCountList = {}
  for k,v in pairs((ConfigData.camp_connection).fetterList) do
    local count = campCountDic[k]
    local trigger = false
    for k,v in pairs((ConfigData.camp_connection)[k]) do
      if v.fetters_num <= count then
        trigger = true
        break
      end
    end
    do
      do
        local campCount = {campId = k, count = count, trigger = trigger}
        ;
        (table.insert)(campCountList, campCount)
        -- DECOMPILER ERROR at PC31: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  ;
  (table.sort)(campCountList, function(a, b)
    -- function num : 0_1_0
    if a.count ~= b.count then
      if b.count >= a.count then
        do return a.trigger ~= b.trigger end
        do return a.campId < b.campId end
        do return a.trigger end
        -- DECOMPILER ERROR: 5 unprocessed JMP targets
      end
    end
  end
)
  ;
  (self.bondItemPool):HideAll()
  for k,v in ipairs(campCountList) do
    local bondItem = (self.bondItemPool):GetOne()
    bondItem:InitCampBondItem(v.campId, v.count, self.__ShowBondDetail)
  end
end

UICampBond.ShowBondDetail = function(self, bondItem)
  -- function num : 0_2 , upvalues : _ENV
  local campId, count = bondItem:GetCampBondItemIdCount()
  local maxCount = 0
  for k,v in pairs((ConfigData.camp_connection)[campId]) do
    maxCount = (math.max)(v.fetters_num, maxCount)
  end
  local campFetterList = ((ConfigData.camp_connection).fetterList)[campId]
  if campFetterList == nil then
    error("Can\'t get campFetterList, campId = " .. tostring(campId))
    return 
  end
  ;
  (self.bondDetailItemPool):HideAll()
  for k,v in ipairs(campFetterList) do
    local fetterCfg = ((ConfigData.camp_connection)[campId])[v]
    local isValid = fetterCfg.fetters_num == count
    local describe = fetterCfg:GetDescribe()
    local detailItem = (self.bondDetailItemPool):GetOne()
    detailItem:InitCampBondDetailItem(isValid, fetterCfg.fetters_num, maxCount, describe)
  end
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).campBondListContent).enabled = false
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).campBondListSizeFitter).enabled = false
  bondItem:CampBondItemDetailTween(true, (self.ui).detailHolder, function()
    -- function num : 0_2_0 , upvalues : self
    ((self.ui).bondDetailNode):SetActive(true)
    ;
    (((self.ui).btn_CloseDetail).gameObject):SetActive(true)
  end
)
  self.showDetailBondItem = bondItem
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UICampBond.OnClickCloseDetail = function(self)
  -- function num : 0_3
  if self.showDetailBondItem == nil then
    return 
  end
  ;
  ((self.ui).bondDetailNode):SetActive(false)
  ;
  (((self.ui).btn_CloseDetail).gameObject):SetActive(false)
  ;
  (self.showDetailBondItem):CampBondItemDetailTween(false, nil, function()
    -- function num : 0_3_0 , upvalues : self
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((self.ui).campBondListContent).enabled = true
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((self.ui).campBondListSizeFitter).enabled = true
  end
)
  self.showDetailBondItem = nil
end

UICampBond.OnClickBack = function(self)
  -- function num : 0_4
  self:Delete()
end

UICampBond.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (self.bondItemPool):DeleteAll()
  ;
  (self.bondDetailItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UICampBond


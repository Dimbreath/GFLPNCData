local UINDmRoomEdit = class("UINDmRoomEdit", UIBaseNode)
local base = UIBaseNode
local UINDmFntCategoryTog = require("Game.Dorm.DUI.Room.Edit.UINDmFntCategoryTog")
local UINDmRoomFntList = require("Game.Dorm.DUI.Room.Edit.UINDmRoomFntList")
local UINDmRoomFntOperate = require("Game.Dorm.DUI.Room.Edit.UINDmRoomFntOperate")
local CS_MessageCommon = CS.MessageCommon
UINDmRoomEdit.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINDmRoomFntList, UINDmRoomFntOperate, UINDmFntCategoryTog
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self._OnConfirmClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_PackUp, self, self._OnClearClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ReSet, self, self._OnRestoreClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Sort, self, self._OnSortClicked)
  self.dmRoomFntList = (UINDmRoomFntList.New)()
  ;
  (self.dmRoomFntList):Init((self.ui).fntList)
  self.dmRoomFntOp = (UINDmRoomFntOperate.New)()
  ;
  (self.dmRoomFntOp):Init((self.ui).fntOperate)
  self._onClickFntItemFunc = BindCallback(self, self._OnClickFntItem)
  self._OnSelectFntCategoryFunc = BindCallback(self, self._OnSelectFntCategory)
  self._onDormRoomEditDataChange = BindCallback(self, self._DormRoomEditDataChange)
  self._resLoader = ((CS.ResLoader).Create)()
  local iconPath = PathConsts:GetSpriteAtlasPath("UI_DormRoom")
  self._togIconAtlas = (self._resLoader):LoadABAsset(iconPath)
  ;
  ((self.ui).fntCatgTog):SetActive(false)
  self.fntCategoryTogList = (UIItemPool.New)(UINDmFntCategoryTog, (self.ui).fntCatgTog)
  for k,catgId in ipairs((ConfigData.dorm_fnt_category).dmFntCategoryIdList) do
    local cfg = (ConfigData.dorm_fnt_category)[catgId]
    local togItem = (self.fntCategoryTogList):GetOne()
    local sprite = (self._togIconAtlas):GetSprite(cfg.icon)
    togItem:InitDmFntCategoryTog(cfg, sprite, self._OnSelectFntCategoryFunc)
  end
  self._dmRoomFntOpShow_InWall = true
end

UINDmRoomEdit.InitDmRoomtEdit = function(self, dmRoomCtrl)
  -- function num : 0_1 , upvalues : _ENV
  self.dmRoomCtrl = dmRoomCtrl
  ;
  (UIUtil.SetTopStatus)(self, self._OnCancelClicked)
  self.fntWarehouseCatgList = ((self.dmRoomCtrl).editRoomData):GetFntWarehouseCatgList()
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).fntCatgTogGroup).allowSwitchOff = true
  ;
  ((self.ui).fntCatgTogGroup):SetAllTogglesOff()
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).fntCatgTogGroup).allowSwitchOff = false
  ;
  (((self.fntCategoryTogList).listItem)[1]):SetDmFntCategoryTogOn()
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).typeList).verticalNormalizedPosition = 1
  self:DmRoomEditSelectFntMode(false)
end

UINDmRoomEdit.ReinitDmRoomtEditData = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.fntWarehouseCatgList = ((self.dmRoomCtrl).editRoomData):GetFntWarehouseCatgList()
  if not (self.fntWarehouseCatgList)[self._selCatgId] then
    local fntWarehouseList = table.emptytable
  end
  self:__RefreshFntListUI(fntWarehouseList, true)
end

UINDmRoomEdit.DmRoomEditSelectFntMode = function(self, isEnter)
  -- function num : 0_3 , upvalues : _ENV
  if isEnter then
    self:DmRoomEditOperateShow(true)
    ;
    ((self.ui).listRoot):SetActive(false)
  else
    self:DmRoomEditOperateShow(false)
    ;
    ((self.ui).listRoot):SetActive(true)
    if self.waitDmRoomFntListRefresh then
      if not (self.fntWarehouseCatgList)[self._selCatgId] then
        local fntWarehouseList = table.emptytable
      end
      self:__RefreshFntListUI(fntWarehouseList, false)
      self.waitDmRoomFntListRefresh = false
    end
  end
end

UINDmRoomEdit.DmRoomEditOperateShow = function(self, isShow, inWallVisible)
  -- function num : 0_4
  if inWallVisible then
    self._dmRoomFntOpShow_InWall = isShow
  else
    self._dmRoomFntOpShow = isShow
  end
  if self._dmRoomFntOpShow_InWall and self._dmRoomFntOpShow then
    (self.dmRoomFntOp):Show()
  else
    ;
    (self.dmRoomFntOp):Hide()
  end
end

UINDmRoomEdit._UpdCategoryLimitNum = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local fntCatgCfg = (ConfigData.dorm_fnt_category)[self._selCatgId]
  if fntCatgCfg.limit == 0 then
    ((self.ui).obj_currFntCatg):SetActive(false)
  else
    ;
    ((self.ui).obj_currFntCatg):SetActive(true)
    local sprite = (self._togIconAtlas):GetSprite(fntCatgCfg.icon)
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_CatgIcon).sprite = sprite
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_typeName).text = (LanguageUtil.GetLocaleText)(fntCatgCfg.name)
    local curNum = (((self.dmRoomCtrl).roomEntity).roomData):GetDmRoomFntCategoryNum(self._selCatgId)
    local maxNum = fntCatgCfg.limit
    ;
    ((self.ui).tex_typeCount):SetIndex(0, tostring(curNum), tostring(maxNum))
    local isMax = maxNum <= curNum
    -- DECOMPILER ERROR at PC66: Confused about usage of register: R6 in 'UnsetPending'

    if not isMax or not ((self.ui).catgBgColor)[2] then
      ((self.ui).img_CurrFntCatg).color = ((self.ui).catgBgColor)[1]
      -- DECOMPILER ERROR at PC77: Confused about usage of register: R6 in 'UnsetPending'

      if not isMax or not Color.white then
        ((self.ui).img_CatgIcon).color = Color.black
        -- DECOMPILER ERROR at PC88: Confused about usage of register: R6 in 'UnsetPending'

        if not isMax or not Color.white then
          ((self.ui).tex_typeName).color = Color.black
          -- DECOMPILER ERROR at PC100: Confused about usage of register: R6 in 'UnsetPending'

          if not isMax or not Color.white then
            do
              (((self.ui).tex_typeCount).text).color = Color.black
              -- DECOMPILER ERROR: 10 unprocessed JMP targets
            end
          end
        end
      end
    end
  end
end

UINDmRoomEdit._OnSelectFntCategory = function(self, catgId)
  -- function num : 0_6 , upvalues : _ENV
  if self._selCatgId == catgId then
    return 
  end
  self._selCatgId = catgId
  if not (self.fntWarehouseCatgList)[catgId] then
    local fntWarehouseList = table.emptytable
  end
  self:__RefreshFntListUI(fntWarehouseList, true)
  self:_UpdCategoryLimitNum()
end

UINDmRoomEdit._OnClickFntItem = function(self, fntWarehouseData, fntItem)
  -- function num : 0_7 , upvalues : _ENV, CS_MessageCommon
  if fntWarehouseData.count == 0 then
    return 
  end
  if not fntWarehouseData.isDefaultDmFnt then
    local catgId = (fntWarehouseData.fntCfg).category
    local fntCatgCfg = (ConfigData.dorm_fnt_category)[catgId]
    if fntCatgCfg.limit > 0 then
      local curNum = (((self.dmRoomCtrl).roomEntity).roomData):GetDmRoomFntCategoryNum(catgId)
      local maxNum = fntCatgCfg.limit
      if maxNum <= curNum then
        local msg = (string.format)(ConfigData:GetTipContent(2027), (LanguageUtil.GetLocaleText)(fntCatgCfg.name))
        ;
        (CS_MessageCommon.ShowMessageTipsWithErrorSound)(msg)
        return 
      end
    end
  end
  do
    ;
    (self.dmRoomCtrl):InstallFnt(fntWarehouseData)
  end
end

UINDmRoomEdit._DormRoomEditDataChange = function(self, fntWarehouseDataDic)
  -- function num : 0_8 , upvalues : _ENV
  for fntWarehouseData,isNew in pairs(fntWarehouseDataDic) do
    local catgId = (fntWarehouseData.fntCfg).category
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R8 in 'UnsetPending'

    if isNew then
      if not (self.fntWarehouseCatgList)[catgId] then
        (self.fntWarehouseCatgList)[catgId] = {}
        do
          local catgList = (self.fntWarehouseCatgList)[catgId]
          ;
          (table.insert)(catgList, fntWarehouseData)
          -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  ;
  (self.dmRoomFntList):RefreshDmRoomFntList()
  self.waitDmRoomFntListRefresh = false
  if ((self.ui).listRoot).activeInHierarchy then
    if not (self.fntWarehouseCatgList)[self._selCatgId] then
      local fntWarehouseList = table.emptytable
    end
    self:__RefreshFntListUI(fntWarehouseList, false)
  else
    do
      self.waitDmRoomFntListRefresh = true
      self:_UpdCategoryLimitNum()
    end
  end
end

UINDmRoomEdit._OnConfirmClicked = function(self)
  -- function num : 0_9
  (self.dmRoomCtrl):ConfirmDormRoomEdit()
end

UINDmRoomEdit._OnCancelClicked = function(self)
  -- function num : 0_10 , upvalues : CS_MessageCommon, _ENV
  if (self.dmRoomCtrl):HasDmRoomEdited() then
    (CS_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(2011), function()
    -- function num : 0_10_0 , upvalues : self
    self:_ExitEdit(false)
  end
, nil)
    return false
  else
    self:_ExitEdit(true)
  end
end

UINDmRoomEdit._ExitEdit = function(self, popStack)
  -- function num : 0_11
  (self.dmRoomCtrl):ExitDormRoomEdit(false, popStack)
end

UINDmRoomEdit._OnRestoreClicked = function(self)
  -- function num : 0_12 , upvalues : CS_MessageCommon, _ENV
  (CS_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(2010), function()
    -- function num : 0_12_0 , upvalues : self
    (self.dmRoomCtrl):RestoreDormRoomEdit()
  end
, nil)
end

UINDmRoomEdit._OnSortClicked = function(self)
  -- function num : 0_13
end

UINDmRoomEdit._OnClearClicked = function(self)
  -- function num : 0_14 , upvalues : CS_MessageCommon, _ENV
  (CS_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(2008), function()
    -- function num : 0_14_0 , upvalues : self
    (self.dmRoomCtrl):ClearAllFnt()
  end
, nil)
end

UINDmRoomEdit.OnShow = function(self)
  -- function num : 0_15 , upvalues : _ENV
  MsgCenter:AddListener(eMsgEventId.DormRoomEditDataChange, self._onDormRoomEditDataChange)
end

UINDmRoomEdit.OnHide = function(self)
  -- function num : 0_16 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.DormRoomEditDataChange, self._onDormRoomEditDataChange)
end

UINDmRoomEdit.__RefreshFntListUI = function(self, fntWarehouseList, refill)
  -- function num : 0_17
  local hasData = #fntWarehouseList > 0
  ;
  ((self.ui).fntList):SetActive(hasData)
  ;
  ((self.ui).fntEmpty):SetActive(not hasData)
  if hasData then
    (self.dmRoomFntList):InitDmRoomFntList(fntWarehouseList, self._onClickFntItemFunc)
    ;
    (self.dmRoomFntList):RefreshDmRoomFntList()
    ;
    (self.dmRoomFntList):RefillDmRoomFntList(refill)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINDmRoomEdit.OnDelete = function(self)
  -- function num : 0_18 , upvalues : base
  (self.fntCategoryTogList):DeleteAll()
  ;
  (self.dmRoomFntList):Delete()
  ;
  (self.dmRoomFntOp):Delete()
  if self._resLoader ~= nil then
    (self._resLoader):Put2Pool()
    self._resLoader = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINDmRoomEdit


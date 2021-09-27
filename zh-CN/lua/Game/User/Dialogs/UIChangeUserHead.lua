local UIChangeUserHead = class("UIChangeUserHead", UIBaseNode)
local base = UIBaseNode
local UIToogleItem = require("Game.User.Dialogs.UIToogleItem")
local UIHeadScroll = require("Game.User.Dialogs.UIHeadScroll")
local UIHeadItem = require("Game.User.Dialogs.UIHeadItem")
local UIHeadRight = require("Game.User.Dialogs.UIHeadRight")
local UIHeadSortNode = require("Game.User.Dialogs.UIHeadSortNode")
UIChangeUserHead.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIToogleItem, UIHeadRight, UIHeadSortNode
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.lastTog = 0
  self:InitChooseInfo()
  self.itemDic = {}
  self.Resloader = ((CS.ResLoader).Create)()
  self.tog_Head = (UIToogleItem.New)()
  ;
  (self.tog_Head):Init((self.ui).tog_Head)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.tog_Head).changeValueFunc = BindCallback(self, self.ClickHead)
  self.tog_HeadFrame = (UIToogleItem.New)()
  ;
  (self.tog_HeadFrame):Init((self.ui).tog_HeadFrame)
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.tog_HeadFrame).changeValueFunc = BindCallback(self, self.ClickHeadFrame)
  self.right_Pannel = (UIHeadRight.New)()
  ;
  (self.right_Pannel):Init((self.ui).right_Pannel)
  self.sortNode = (UIHeadSortNode.New)()
  ;
  (self.sortNode):Init((self.ui).sortNode)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Sort, self, self.ShowSortNode)
  -- DECOMPILER ERROR at PC71: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.sortNode).changeValueFunc = BindCallback(self, self.ChangeType)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_ShowHas, self, self.OnSwitchValueChange)
  self.__ClickOneHead = BindCallback(self, self.ClickOneHead)
  self.__ClickOneHeadFrame = BindCallback(self, self.ClickOneHeadFrame)
  ;
  (self.tog_Head):SelectActivityTag()
end

UIChangeUserHead.BindCloseFun = function(self, onCloseCallback)
  -- function num : 0_1
  self._onCloseCallback = onCloseCallback
  ;
  (self.right_Pannel):BindCloseFun(onCloseCallback)
end

UIChangeUserHead.InitChooseInfo = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.showAll = false
  self.showType = 0
  self.lastChoose = 0
  if self.lastChooseItemCfg ~= nil and (self.lastChooseItemCfg).count == 1 then
    self.choosedId = (self.lastChooseItemCfg).id
  else
    self.lastChooseItemCfg = nil
    self.choosedId = (PlayerDataCenter.inforData).avatarId
  end
  if self.lastChooseFrameItemCfg ~= nil and (self.lastChooseFrameItemCfg).count == 1 then
    self.choosedFrameId = (self.lastChooseFrameItemCfg).id
  else
    self.lastChooseFrameItemCfg = nil
    self.choosedFrameId = (PlayerDataCenter.inforData).avatarFrameId
  end
  self.isFirst = true
end

UIChangeUserHead.ChangeType = function(self, type, str)
  -- function num : 0_3
  self.lastChoose = type + 1
  self.showType = type
  self.showList = self:ShowListFiltetr()
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).text_Sort).text = str
  ;
  (self.headList):ReFreshData(#self.showList)
end

UIChangeUserHead.ShowSortNode = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (self.sortNode):InitSortList(self.allList, self.lastChoose)
  self:ChangeImg_Sort()
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.sortNode).BackFun = BindCallback(self, self.ChangeImg_Sort)
  ;
  (self.sortNode):ShowWindow()
end

UIChangeUserHead.ChangeImg_Sort = function(self)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  if ((((self.ui).img_Sort).transform).rotation).z == 0 then
    (((self.ui).img_Sort).transform).rotation = (Vector3.New)(0, 0, 180)
  else
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (((self.ui).img_Sort).transform).rotation = (Vector3.New)(0, 0, 0)
  end
end

UIChangeUserHead.UnSelectTag = function(self)
  -- function num : 0_6
  if ((self.ui).tog_ShowHas).isOn then
    self:OnSwitchValueChange(false)
  else
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).tog_ShowHas).isOn = false
    self:OnSwitchValueChange(false)
  end
end

UIChangeUserHead.OnSwitchValueChange = function(self, flag)
  -- function num : 0_7
  if flag then
    ((self.ui).img_SelectInfo):SetIndex(0)
  else
    ;
    ((self.ui).img_SelectInfo):SetIndex(1)
  end
  self.showAll = flag
  self.showList = self:ShowListFiltetr()
  if self.lastTog == 1 then
    (self.headList):ReFreshData(#self.showList)
  else
    ;
    (self.headFrameList):ReFreshData(#self.showList)
  end
end

UIChangeUserHead.ShowListFiltetr = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local showList = {}
  local tempType = 1
  local tempLastChoose = 2
  for i = 1, #self.allList do
    local listData = (self.allList)[i]
    -- DECOMPILER ERROR at PC20: Unhandled construct in 'MakeBoolean' P1

    if self.lastTog == 1 and listData.id == (PlayerDataCenter.inforData).avatarId then
      tempType = (listData.cfg).type
      tempLastChoose = tempType + 1
    end
    if listData.id == (PlayerDataCenter.inforData).avatarFrameId then
      tempType = (listData.cfg).type
      tempLastChoose = tempType + 1
    end
    if self.showAll then
      (table.insert)(showList, listData)
    else
      if listData.count > 0 then
        (table.insert)(showList, listData)
      end
    end
  end
  ;
  (table.sort)(showList, function(a, b)
    -- function num : 0_8_0
    if b.count >= a.count then
      do return b.count >= a.count end
      if (a.cfg).id >= (b.cfg).id then
        do return a.count ~= b.count end
        -- DECOMPILER ERROR: 4 unprocessed JMP targets
      end
    end
  end
)
  self.isFirst = false
  do
    if self.showType ~= 0 then
      local showTypeList = {}
      for i = 1, #showList do
        local listData = showList[i]
        if (listData.cfg).type == self.showType then
          (table.insert)(showTypeList, listData)
        end
      end
      return showTypeList
    end
    return showList
  end
end

UIChangeUserHead.ClickHead = function(self)
  -- function num : 0_9 , upvalues : UIHeadScroll, _ENV
  if self.lastTog == 1 then
    return 
  end
  self.lastTog = 1
  ;
  (self.right_Pannel):SaveHeadFrame((self.right_Pannel).savedHeadFrameItem)
  self:InitChooseInfo()
  self:ChangeHeadFrame(self:FindHeadFrameCfgFromCfgId(self.choosedFrameId))
  self:ChangeHead(self:FindHeadCfgFromCfgId(self.choosedId))
  self.allList = self:_GetUserHeadData()
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.right_Pannel).isHead = true
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.sortNode).isHead = true
  if self.headFrameList ~= nil then
    ((self.headFrameList).gameObject):SetActive(false)
  end
  if self.headList == nil then
    self.headList = (UIHeadScroll.New)()
    ;
    (self.headList):Init((self.ui).headList)
  end
  ;
  ((self.headList).gameObject):SetActive(true)
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self.headList).ui).scro_List).onInstantiateItem = BindCallback(self, self._OnHeadInstantiateItem)
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self.headList).ui).scro_List).onChangeItem = BindCallback(self, self._OnHeadChangeItem)
  self:Show()
  self.showList = self:ShowListFiltetr()
  self:UnSelectTag()
  ;
  (self.sortNode):InitSortList(self.allList, self.lastChoose)
end

UIChangeUserHead._HasHeadCfg = function(self, cfg)
  -- function num : 0_10 , upvalues : _ENV
  if cfg == nil then
    return 0
  end
  if ((PlayerDataCenter.inforData).heroHeadDict)[cfg.get_id] == true then
    return 1
  else
    return PlayerDataCenter:GetItemCount(cfg.id)
  end
end

UIChangeUserHead._HasHeadFrameCfg = function(self, cfg)
  -- function num : 0_11 , upvalues : _ENV
  if cfg == nil then
    return 0
  else
    return PlayerDataCenter:GetItemCount(cfg.id)
  end
end

UIChangeUserHead._GetUserHeadData = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local cfgAllList = {}
  for id,cfg in pairs(ConfigData.portrait) do
    if not ((PlayerDataCenter.inforData).isHeadLockedDict)[cfg.get_id] and not cfg.is_hide then
      local count = self:_HasHeadCfg(cfg)
      ;
      (table.insert)(cfgAllList, {id = id, cfg = cfg, count = count})
    end
  end
  return cfgAllList
end

UIChangeUserHead._OnHeadInstantiateItem = function(self, go)
  -- function num : 0_13 , upvalues : UIHeadItem
  local item = (UIHeadItem.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.itemDic)[go] = item
end

UIChangeUserHead._OnHeadChangeItem = function(self, go, index)
  -- function num : 0_14
  local item = (self.itemDic)[go]
  local itemCfg = (self.showList)[index + 1]
  item:InitItem(itemCfg, self.__ClickOneHead)
  if (itemCfg.cfg).id == self.choosedId then
    self.lastChooseItemCfg = itemCfg
    self.lastChooseItem = item
    ;
    (((self.lastChooseItem).ui).img_HeadSel):SetActive(true)
  end
end

UIChangeUserHead._OnHeadFrameInstantiateItem = function(self, go)
  -- function num : 0_15 , upvalues : UIHeadItem
  local item = (UIHeadItem.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.itemDic)[go] = item
end

UIChangeUserHead._OnHeadFrameChangeItem = function(self, go, index)
  -- function num : 0_16
  local itemFrame = (self.itemDic)[go]
  local itemCfg = (self.showList)[index + 1]
  itemFrame:InitItem(itemCfg, self.__ClickOneHeadFrame)
  if (itemCfg.cfg).id == self.choosedFrameId then
    self.lastChooseFrameItemCfg = itemCfg
    self.lastChooseFrameItem = itemFrame
    ;
    (((self.lastChooseFrameItem).ui).img_HeadSel):SetActive(true)
  end
end

UIChangeUserHead.ClickHeadFrame = function(self)
  -- function num : 0_17 , upvalues : UIHeadScroll, _ENV
  if self.lastTog == 2 then
    return 
  end
  self.lastTog = 2
  ;
  (self.right_Pannel):SaveHead((self.right_Pannel).savedHeadItem)
  self:InitChooseInfo()
  self:ChangeHead(self:FindHeadCfgFromCfgId(self.choosedId))
  self:ChangeHeadFrame(self:FindHeadFrameCfgFromCfgId(self.choosedFrameId))
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.right_Pannel).isHead = false
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.sortNode).isHead = false
  self.allList = self:_GetUserHeadFrameData()
  if self.headList ~= nil then
    ((self.headList).gameObject):SetActive(false)
  end
  if self.headFrameList == nil then
    self.headFrameList = (UIHeadScroll.New)()
    ;
    (self.headFrameList):Init((self.ui).headList)
  end
  ;
  ((self.headFrameList).gameObject):SetActive(true)
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self.headFrameList).ui).scro_List).onInstantiateItem = BindCallback(self, self._OnHeadFrameInstantiateItem)
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self.headFrameList).ui).scro_List).onChangeItem = BindCallback(self, self._OnHeadFrameChangeItem)
  self:Show()
  self.showList = self:ShowListFiltetr()
  self:UnSelectTag()
  ;
  (self.sortNode):InitSortList(self.allList, self.lastChoose)
end

UIChangeUserHead._GetUserHeadFrameData = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local cfgAllList = {}
  for id,cfg in pairs(ConfigData.portrait_frame) do
    local count = self:_HasHeadFrameCfg(cfg)
    if not cfg.is_hide then
      (table.insert)(cfgAllList, {id = id, cfg = cfg, count = count})
    end
  end
  return cfgAllList
end

UIChangeUserHead.FindHeadCfgFromCfgId = function(self, cfgId)
  -- function num : 0_19 , upvalues : _ENV
  local headCfg = (ConfigData.portrait)[cfgId]
  return {id = cfgId, cfg = headCfg, count = 1}
end

UIChangeUserHead.FindHeadFrameCfgFromCfgId = function(self, cfgId)
  -- function num : 0_20 , upvalues : _ENV
  local headFrameCfg = (ConfigData.portrait_frame)[cfgId]
  return {id = cfgId, cfg = headFrameCfg, count = 1}
end

UIChangeUserHead.ChangeHead = function(self, itemCfg)
  -- function num : 0_21
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.right_Pannel).itemHeadCfg = itemCfg
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  if self:_HasHeadCfg(itemCfg.cfg) > 0 then
    (self.right_Pannel).savedHeadItem = itemCfg
  end
  ;
  (self.right_Pannel):changeHeadState()
end

UIChangeUserHead.ChangeHeadFrame = function(self, itemCfg)
  -- function num : 0_22
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.right_Pannel).itemHeadFrameCfg = itemCfg
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  if self:_HasHeadFrameCfg(itemCfg.cfg) > 0 then
    (self.right_Pannel).savedHeadFrameItem = itemCfg
  end
  ;
  (self.right_Pannel):changeHeadFrameState()
end

UIChangeUserHead.ClickOneHead = function(self, itemCfg, nowchoose)
  -- function num : 0_23
  self:ChangeHead(itemCfg)
  if self.lastChooseItem == nil then
    ((nowchoose.ui).img_HeadSel):SetActive(true)
    self.lastChooseItem = nowchoose
    self.lastChooseItemCfg = nowchoose.itemCfg
  else
    if (nowchoose.itemCfg).id == ((self.lastChooseItem).itemCfg).id then
      ((nowchoose.ui).img_HeadSel):SetActive(true)
    else
      ;
      ((nowchoose.ui).img_HeadSel):SetActive(true)
      ;
      (((self.lastChooseItem).ui).img_HeadSel):SetActive(false)
      self.lastChooseItem = nowchoose
      self.lastChooseItemCfg = nowchoose.itemCfg
    end
  end
  self.choosedId = itemCfg.id
end

UIChangeUserHead.ClickOneHeadFrame = function(self, itemCfg, nowchoose)
  -- function num : 0_24
  self:ChangeHeadFrame(itemCfg)
  if self.lastChooseFrameItem == nil then
    ((nowchoose.ui).img_HeadSel):SetActive(true)
    self.lastChooseFrameItem = nowchoose
    self.lastChooseFrameItemCfg = nowchoose.itemCfg
  else
    if (nowchoose.itemCfg).id == ((self.lastChooseFrameItem).itemCfg).id then
      ((nowchoose.ui).img_HeadSel):SetActive(true)
    else
      ;
      ((nowchoose.ui).img_HeadSel):SetActive(true)
      ;
      (((self.lastChooseFrameItem).ui).img_HeadSel):SetActive(false)
      self.lastChooseFrameItem = nowchoose
      self.lastChooseFrameItemCfg = nowchoose.itemCfg
    end
  end
  self.choosedFrameId = itemCfg.id
end

UIChangeUserHead.OnDelete = function(self)
  -- function num : 0_25 , upvalues : base
  if self.Resloader ~= nil then
    (self.Resloader):Put2Pool()
    self.Resloader = nil
  end
  ;
  (self.tog_Head):OnDelete()
  ;
  (self.tog_HeadFrame):OnDelete()
  ;
  (self.right_Pannel):OnDelete()
  ;
  (self.sortNode):OnDelete()
  ;
  (base.OnDelete)(self)
end

return UIChangeUserHead


-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthInherit = class("UIAthInherit", UIBaseNode)
local base = UIBaseNode
local UIAthSortList = require("Game.Arithmetic.SortList.UIAthSortList")
local UIAthIconItem = require("Game.Arithmetic.SortList.UIAthIconItem")
local UINAthAttrItem = require("Game.Arithmetic.Common.UINAthAttrItem")
local cs_MessageCommon = CS.MessageCommon
UIAthInherit.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIAthIconItem, UINAthAttrItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.__onClickSortListAth = BindCallback(self, self.SetInheritObject)
  self.inhtChoiseIconItem = (UIAthIconItem.New)()
  ;
  (self.inhtChoiseIconItem):Init((self.ui).RUI_ATHIconItem)
  self.inhtChoiseSubAttrItemPool = (UIItemPool.New)(UINAthAttrItem, (self.ui).RTog_SubAttriItem)
  self.allChoiseAttrDict = {}
  self.inhtedIconItem = (UIAthIconItem.New)()
  ;
  (self.inhtedIconItem):Init((self.ui).LUI_ATHIconItem)
  self.inhtedSubAttrItemPool = (UIItemPool.New)(UINAthAttrItem, (self.ui).LTog_SubAttriItem)
  self.allInhtAttrDict = {}
  self.choiseAttrItem = nil
  self.inhtAttrItem = nil
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Inherit, self, self.__OnInherit)
  self.__onUpdateItemEvent = BindCallback(self, self.OnItemUpdateEvent)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
  self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
  self.__OnInheritComplete = BindCallback(self, self.OnInheritComplete)
end

UIAthInherit.OnInitData = function(self, athData)
  -- function num : 0_1 , upvalues : _ENV, UIAthSortList
  self.athData = athData
  ;
  (self.inhtedIconItem):InitAthIconItem(athData, nil)
  ;
  (self.inhtedSubAttrItemPool):HideAll()
  for k,v in ipairs(athData.affixList) do
    local attrItem = (self.inhtedSubAttrItemPool):GetOne()
    do
      local cfg = (ConfigData.ath_affix_pool)[v.id]
      if cfg == nil then
        error("Cant\'t find ath_affix_pool, id = " .. tostring(v.id))
      else
        attrItem:InitAthAttrItem(cfg.affix_para, v.value)
        attrItem:SetAttrColor(v.quality)
        attrItem:SetAttrPara(cfg.affix_para, v.quality)
        -- DECOMPILER ERROR at PC43: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (self.allInhtAttrDict)[attrItem] = k - 1
        local valueChange = BindCallback(function(value)
    -- function num : 0_1_0 , upvalues : self, attrItem
    if value then
      self:__OnInhtAttrChanged(attrItem)
    end
  end
)
        ;
        (((attrItem.ui).tog_SubAttriItem).onValueChanged):AddListener(valueChange)
      end
    end
  end
  if self.sortListNode == nil then
    self.sortListNode = (UIAthSortList.New)()
    ;
    (self.sortListNode):Init((self.ui).aTHSortListNode)
  end
  self.consumeItemCfg = (ConfigData.item)[(ConfigData.game_config).athInheritConsumeItemId]
  -- DECOMPILER ERROR at PC81: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).itemCostIcon).sprite = CRH:GetSprite((self.consumeItemCfg).icon)
  self.consumeItemCount = (ConfigData.game_config).athInheritConsumeItemNum
  self:OnItemUpdateEvent()
end

UIAthInherit.OnShow = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnShow)(self)
  ;
  (self.sortListNode):Show()
  ;
  (self.sortListNode):InitForInherit(self.athData)
  ;
  (self.sortListNode):SetClickSortAthEvent(self.__onClickSortListAth)
  self:CheckBtnAvalible()
end

UIAthInherit.OnItemUpdateEvent = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self.palyerGetConsumeItemCount = PlayerDataCenter:GetItemCount((ConfigData.game_config).athInheritConsumeItemId)
  ;
  ((self.ui).itemCostCountText):SetIndex(0, tostring(self.consumeItemCount .. "(" .. self.palyerGetConsumeItemCount .. ")"))
end

UIAthInherit.CheckBtnAvalible = function(self)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  if self.choiseAttrItem ~= nil and self.inhtAttrItem ~= nil and self.inheritAthData ~= nil and self.athData ~= nil then
    ((self.ui).btn_Inherit).interactable = true
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).btn_Inherit_image).color = Color.white
  else
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).btn_Inherit).interactable = false
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).btn_Inherit_image).color = Color.black
  end
end

UIAthInherit.OnHide = function(self)
  -- function num : 0_5
  if self.sortListNode ~= nil then
    (self.sortListNode):Hide()
  end
  self:ClearAndUpdate()
end

UIAthInherit.SetInheritObject = function(self, athData)
  -- function num : 0_6 , upvalues : cs_MessageCommon, _ENV
  if athData.lockUnlock then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.arithmetic_Inherit_Lock))
    return 
  end
  self.inheritAthData = athData
  local athItem = (self.sortListNode):__GetAthItemByData(self.inheritAthData)
  if athItem ~= nil then
    if self.lastSelectAthItem ~= nil then
      (self.lastSelectAthItem):SelectAth(false)
    end
    athItem:SelectAth(true)
    self.lastSelectAthItem = athItem
  end
  ;
  (self.inhtChoiseIconItem):InitAthIconItem(athData, nil)
  ;
  (self.inhtChoiseSubAttrItemPool):HideAll()
  for k,v in ipairs((self.inheritAthData).affixList) do
    local attrItem = (self.inhtChoiseSubAttrItemPool):GetOne()
    do
      local cfg = (ConfigData.ath_affix_pool)[v.id]
      if cfg == nil then
        error("Cant\'t find ath_affix_pool, id = " .. tostring(v.id))
      else
        attrItem:InitAthAttrItem(cfg.affix_para, v.value)
        attrItem:SetAttrColor(v.quality)
        attrItem:SetAttrPara(cfg.affix_para, v.quality)
        -- DECOMPILER ERROR at PC72: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (self.allChoiseAttrDict)[attrItem] = k - 1
        local valueChange = BindCallback(function(value)
    -- function num : 0_6_0 , upvalues : self, attrItem
    if value then
      self:__OnChoiseAttrChanged(attrItem)
    end
  end
)
        ;
        (((attrItem.ui).tog_SubAttriItem).onValueChanged):AddListener(valueChange)
      end
    end
  end
  self:CheckBtnAvalible()
end

UIAthInherit.__OnChoiseAttrChanged = function(self, attrItem)
  -- function num : 0_7
  if (self.allChoiseAttrDict)[attrItem] ~= nil then
    self.choiseAttrItem = attrItem
    self:CheckBtnAvalible()
  end
end

UIAthInherit.__OnInhtAttrChanged = function(self, attrItem)
  -- function num : 0_8
  if (self.allInhtAttrDict)[attrItem] ~= nil then
    self.inhtAttrItem = attrItem
    self:CheckBtnAvalible()
  end
end

UIAthInherit.ClearAndUpdate = function(self)
  -- function num : 0_9
  (self.inhtChoiseIconItem):Reset()
  self.allChoiseAttrDict = {}
  self.allInhtAttrDict = {}
  self:OnInitData(self.athData)
  ;
  (self.inhtChoiseSubAttrItemPool):HideAll()
  self.inheritAthData = nil
  self.choiseAttrItem = nil
  self.inhtAttrItem = nil
  self:CheckBtnAvalible()
end

UIAthInherit.__OnInherit = function(self)
  -- function num : 0_10 , upvalues : _ENV, cs_MessageCommon
  local athFromUid = (self.inheritAthData).uid
  local athToUid = (self.athData).uid
  local attrFromId = (self.allChoiseAttrDict)[self.choiseAttrItem]
  local attrToId = (self.allInhtAttrDict)[self.inhtAttrItem]
  for k,v in pairs(self.allInhtAttrDict) do
    if k.affix_para == (self.choiseAttrItem).affix_para and k ~= self.inhtAttrItem then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.arithmetic_Inherit_RepeateAttr))
      return 
    end
  end
  if (self.choiseAttrItem).quality ~= 4 then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.arithmetic_Inherit_AttrQualitylimt))
    return 
  end
  if self.palyerGetConsumeItemCount < self.consumeItemCount then
    (cs_MessageCommon.ShowMessageTips)((LanguageUtil.GetLocaleText)((self.consumeItemCfg).name) .. ConfigData:GetTipContent(TipContent.arithmetic_Inherit_ItemInsufficient))
    return 
  end
  ;
  (self.athNetwork):CS_ATH_AthInherit(athFromUid, athToUid, attrFromId, attrToId, self.__OnInheritComplete)
end

UIAthInherit.OnInheritComplete = function(self)
  -- function num : 0_11 , upvalues : cs_MessageCommon, _ENV
  (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.arithmetic_Inherit_Success))
  self:ClearAndUpdate()
end

UIAthInherit.OnDelete = function(self)
  -- function num : 0_12 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
  ;
  (self.inhtChoiseSubAttrItemPool):DeleteAll()
  ;
  (self.inhtedSubAttrItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UIAthInherit


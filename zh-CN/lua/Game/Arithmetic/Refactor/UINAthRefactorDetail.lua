local UINAthRefactorDetail = class("UINAthRefactorDetail", UIBaseNode)
local base = UIBaseNode
local UINAthRfctSubAttrItem = require("Game.Arithmetic.Refactor.UINAthRfctSubAttrItem")
local ArthmeticEnum = require("Game.Arithmetic.ArthmeticEnum")
local UINStOConsumeItem = require("Game.StrategyOverview.UI.Side.UINStOConsumeItem")
UINAthRefactorDetail.ctor = function(self, refactorRoot)
  -- function num : 0_0
  self.refactorRoot = refactorRoot
end

UINAthRefactorDetail.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, UINAthRfctSubAttrItem, UINStOConsumeItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Refactor, self, self.__OnClickRefactor)
  self.__OnSubAttrLockFunc = BindCallback(self, self.__OnClickSubAttrLock)
  self.__onUpdateItemEvent = BindCallback(self, self.OnItemUpdateEvent)
  self.unitSize = (((self.ui).img_Cube).transform).sizeDelta
  ;
  ((self.ui).attriItem):SetActive(false)
  self.subAttrItemPool = (UIItemPool.New)(UINAthRfctSubAttrItem, (self.ui).attriItem)
  ;
  ((self.ui).consumeItem):SetActive(false)
  self.consumeItemPool = (UIItemPool.New)(UINStOConsumeItem, (self.ui).consumeItem)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
end

UINAthRefactorDetail.InitAthRefactorDetail = function(self, athData)
  -- function num : 0_2 , upvalues : _ENV
  self.athData = athData
  local qColor = athData:GetAthColor()
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_Cube).color = qColor
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).mainAttri).color = qColor
  local areaId = athData:GetAthAreaType()
  local areaCfg = (ConfigData.ath_area)[areaId]
  if areaCfg == nil then
    error("Can\'t get areaCfg, areaId = " .. areaId)
  else
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).tex_Area).text = (LanguageUtil.GetLocaleText)(areaCfg.name2)
  end
  ;
  ((self.ui).img_AreaIcon):SetIndex(areaId - 1)
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = athData:GetName()
  self:__RefreshSize()
  self:__RefreshMainAttr()
  self:RefreshRfctDetailSubAttr()
  self:__UpdateConsumeItem()
  self:RefreshCanRefactorBtn()
end

UINAthRefactorDetail.__RefreshSize = function(self)
  -- function num : 0_3 , upvalues : _ENV
  ((self.athData):GetAthSize())
  local size = nil
  local sizeDelta = nil
  if size == 1 then
    sizeDelta = self.unitSize
  else
    if size == 2 then
      sizeDelta = (Vector2.New)((self.unitSize).x, (self.unitSize).y * 2)
    else
      if size == 4 then
        sizeDelta = (Vector2.New)((self.unitSize).x * 2, (self.unitSize).y * 2)
      end
    end
  end
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).img_Cube).transform).sizeDelta = sizeDelta
end

UINAthRefactorDetail.__RefreshMainAttr = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local athData = self.athData
  if #(athData.athMainAttrCfg).attrtibute_id > 0 then
    local attrId = ((athData.athMainAttrCfg).attrtibute_id)[1]
    local attrValue = ((athData.athMainAttrCfg).attrtibute_num)[1]
    local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = CRH:GetSprite(icon)
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).tex_AttriName).text = name
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).tex_AttriNum).text = valueStr
  end
end

UINAthRefactorDetail.RefreshRfctDetailSubAttr = function(self)
  -- function num : 0_5 , upvalues : _ENV, ArthmeticEnum
  local athData = self.athData
  if #athData.affixList == 0 then
    ((self.ui).attriList):SetActive(false)
  else
    ;
    ((self.ui).attriList):SetActive(true)
    ;
    (self.subAttrItemPool):HideAll()
    for k,affix in ipairs(athData.affixList) do
      local cfg = (ConfigData.ath_affix_pool)[affix.id]
      if cfg == nil then
        error("Can\'t find ath_affix_pool, id = " .. tostring(affix.id))
      else
        local color = (ArthmeticEnum.AthQualityColor)[affix.quality]
        local attrItem = (self.subAttrItemPool):GetOne()
        attrItem:InitAthDetailAttr(k, cfg.affix_para, affix.value, color, affix.lock, self.__OnSubAttrLockFunc)
      end
    end
  end
end

UINAthRefactorDetail.__UpdateConsumeItem = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (self.consumeItemPool):HideAll()
  for k,itemId in ipairs((ConfigData.game_config).athRefactorConsumeItemId) do
    local consumeNum = ((ConfigData.game_config).athRefactorConsumeItemNum)[k]
    local consumeItem = (self.consumeItemPool):GetOne()
    consumeItem:InitStOConsumeItem(itemId, consumeNum)
  end
end

UINAthRefactorDetail.OnItemUpdateEvent = function(self, itemUpdate)
  -- function num : 0_7 , upvalues : _ENV
  for k,itemId in ipairs((ConfigData.game_config).athRefactorConsumeItemId) do
    if itemUpdate[itemId] ~= nil then
      local consumeNum = ((ConfigData.game_config).athRefactorConsumeItemNum)[k]
      local consumeItem = ((self.consumeItemPool).listItem)[k]
      consumeItem:InitStOConsumeItem(itemId, consumeNum)
      self:RefreshCanRefactorBtn()
    end
  end
end

UINAthRefactorDetail.__OnClickRefactor = function(self)
  -- function num : 0_8
  (self.refactorRoot):SendAthRefactor()
end

UINAthRefactorDetail.__OnClickSubAttrLock = function(self, index)
  -- function num : 0_9
  (self.refactorRoot):SendAthAffixLock(index)
end

UINAthRefactorDetail.RefreshAthAffixLock = function(self, index, lock)
  -- function num : 0_10
  local attrItem = ((self.subAttrItemPool).listItem)[index]
  attrItem:SetAthRfctSubAttrLock(lock)
end

UINAthRefactorDetail.RefreshCanRefactorBtn = function(self)
  -- function num : 0_11
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).btn_Refactor).interactable = (self.refactorRoot):CanAthRefactor()
end

UINAthRefactorDetail.OnDelete = function(self)
  -- function num : 0_12 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
  ;
  (self.subAttrItemPool):DeleteAll()
  ;
  (self.consumeItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINAthRefactorDetail


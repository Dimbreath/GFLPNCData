-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthDetailItem = class("UINAthDetailItem", UIBaseNode)
local base = UIBaseNode
local UINAthDetailAttr = require("Game.Arithmetic.AthDetail.UINAthDetailAttr")
local UINAthDetailSuitItem = require("Game.Arithmetic.AthDetail.UINAthDetailSuitItem")
local ArthmeticEnum = require("Game.Arithmetic.ArthmeticEnum")
local UINAttrIntroItem = require("Game.Formation.UI.Common.UINHeroAttrIntroItem")
local cs_MessageCommon = CS.MessageCommon
UINAthDetailItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINAthDetailAttr, UINAthDetailSuitItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Lock, self, self.__OnClickLock)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Optimize, self, self.__OnClickOptimize)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Uninstall, self, self.__OnClickUninstall)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Equip, self, self.__OnClickInstall)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Switch, self, self.__OnClickReplace)
  ;
  ((self.ui).attrPopDetail):SetActive(false)
  ;
  ((self.ui).attriItem):SetActive(false)
  self.attriItemPool = (UIItemPool.New)(UINAthDetailAttr, (self.ui).attriItem)
  ;
  ((self.ui).suitInfoItem):SetActive(false)
  self.suitAttriPool = (UIItemPool.New)(UINAthDetailSuitItem, (self.ui).suitInfoItem)
  self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
  self.unitSize = (((self.ui).img_Cube).transform).sizeDelta
end

UINAthDetailItem.InitAthDetailItem = function(self, detailRoot, athData, heroData, isAddPreview, isReplace, isOnlyInfo)
  -- function num : 0_1 , upvalues : ArthmeticEnum, _ENV
  self.detailRoot = detailRoot
  self.athData = athData
  self.heroData = heroData
  ;
  (((self.ui).btn_Uninstall).gameObject):SetActive(false)
  ;
  (((self.ui).btn_Equip).gameObject):SetActive(false)
  ;
  (((self.ui).btn_Switch).gameObject):SetActive(false)
  ;
  ((self.ui).curEquip):SetActive(false)
  ;
  (((self.ui).btn_Optimize).gameObject):SetActive(false)
  if not isOnlyInfo then
    if isReplace then
      if isAddPreview then
        (((self.ui).btn_Switch).gameObject):SetActive(true)
      else
        ;
        ((self.ui).curEquip):SetActive(true)
      end
    else
      if isAddPreview then
        (((self.ui).btn_Equip).gameObject):SetActive(true)
      else
        ;
        (((self.ui).btn_Uninstall).gameObject):SetActive(true)
      end
    end
    local canStrenthen = ArthmeticEnum.StrengthenQuality == athData:GetAthQuality() and athData:GetAthSize() > 1
    ;
    (((self.ui).btn_Optimize).gameObject):SetActive(canStrenthen)
  end
  ;
  (((self.ui).btn_Lock).gameObject):SetActive(not isOnlyInfo)
  local qColor = athData:GetAthColor()
  -- DECOMPILER ERROR at PC93: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).img_Quailty).color = qColor
  -- DECOMPILER ERROR at PC96: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).img_Cube).color = qColor
  -- DECOMPILER ERROR at PC99: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).mainAttri).color = qColor
  local areaId = athData:GetAthAreaType()
  local areaCfg = (ConfigData.ath_area)[areaId]
  if areaCfg == nil then
    error("Can\'t get areaCfg, areaId = " .. areaId)
  else
    -- DECOMPILER ERROR at PC119: Confused about usage of register: R10 in 'UnsetPending'

    ((self.ui).tex_Area).text = (LanguageUtil.GetLocaleText)(areaCfg.name2)
  end
  ;
  ((self.ui).img_AreaIcon):SetIndex(areaId - 1)
  self:__RefreshLock()
  -- DECOMPILER ERROR at PC131: Confused about usage of register: R10 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = athData:GetName()
  self:__RefreshSize()
  self:RefreshAthDetailItemAttr()
  local suitId = athData:GetAthSuit()
  ;
  ((self.ui).suitScroll):SetActive(suitId ~= 0)
  local suitCfltDic = ((ConfigData.arithmetic).suitDic)[athData.suit]
  if suitCfltDic ~= nil then
    local suitAthCount = 0
    for k,suitAthList in pairs(suitCfltDic) do
      for k2,athId in ipairs(suitAthList) do
        local athCfg = (ConfigData.arithmetic)[athId]
        local itemCfg = (ConfigData.item)[athId]
        if itemCfg == nil then
          error("Can\'t find itemCfg, id = " .. tostring(athId))
          break
        end
        local slotId = athCfg.area_type
        local installed = false
        if heroData ~= nil then
          installed = (PlayerDataCenter.allAthData):HeroContainAthById(heroData.dataId, slotId, athId)
        end
        if installed then
          suitAthCount = suitAthCount + 1
        end
      end
    end
    local suitCfg = (ConfigData.ath_suit)[suitId]
    if suitCfg == nil then
      error("Can\'t find suitCfg, id = " .. tostring(suitId))
      return 
    end
    local suitNum = 0
    for k,v in ipairs(suitCfg) do
      if v.num <= suitAthCount then
        suitNum = v.num
      end
    end
    ;
    (self.suitAttriPool):HideAll()
    for k,v in ipairs(suitCfg) do
      local suitCount = v.num
      local info = (LanguageUtil.GetLocaleText)(v.describe)
      local suitItem = (self.suitAttriPool):GetOne()
      suitItem:InitAthDetailSuitItem(suitNum, suitCount, info)
    end
  end
  if (self.ui).optimizeLock ~= nil then
    ((self.ui).optimizeLock):SetActive(not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_pro))
  end
  -- DECOMPILER ERROR: 14 unprocessed JMP targets
end

UINAthDetailItem.RefreshAthDetailItemAttr = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local athData = self.athData
  if #(athData.athMainAttrCfg).attrtibute_id > 0 then
    local attrId = ((athData.athMainAttrCfg).attrtibute_id)[1]
    local attrValue = ((athData.athMainAttrCfg).attrtibute_num)[1]
    local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
    local iconSprite = CRH:GetSprite(icon)
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = iconSprite
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.ui).tex_AttriName).text = name
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.ui).tex_AttriNum).text = valueStr
    self.__showAttrWin = BindCallback(self, self.__showAttrIntro, attrId, iconSprite, ((self.ui).btn_mainAttri).transform)
    self.__hideAttrWin = BindCallback(self, self.__hideAttrIntro)
    ;
    (((self.ui).btn_mainAttri).onPressDown):AddListener(self.__showAttrWin)
    ;
    (((self.ui).btn_mainAttri).onPressUp):AddListener(self.__hideAttrWin)
  end
  do
    self:RefreshAthDetailItemSubAttr(athData.affixList)
  end
end

UINAthDetailItem.RefreshAthDetailItemSubAttr = function(self, affixList)
  -- function num : 0_3 , upvalues : _ENV, ArthmeticEnum
  if #affixList == 0 then
    ((self.ui).attriList):SetActive(false)
  else
    ;
    ((self.ui).attriList):SetActive(true)
    ;
    (self.attriItemPool):HideAll()
    for k,affix in ipairs(affixList) do
      local cfg = (ConfigData.ath_affix_pool)[affix.id]
      if cfg == nil then
        error("Can\'t find ath_affix_pool, id = " .. tostring(affix.id))
      else
        local color = (ArthmeticEnum.AthQualityColor)[affix.quality]
        local attrItem = (self.attriItemPool):GetOne()
        attrItem:InitAthDetailAttr(cfg.affix_para, affix.value, color)
        self:__registerSubAttrItemPressPop(attrItem)
      end
    end
  end
end

UINAthDetailItem.__registerSubAttrItemPressPop = function(self, attrItem)
  -- function num : 0_4 , upvalues : _ENV
  if attrItem.ui ~= nil and (attrItem.ui).button ~= nil then
    attrItem:InjectPressPopFunc(BindCallback(self, self.__showAttrIntro), BindCallback(self, self.__hideAttrIntro))
  end
end

UINAthDetailItem.__showAttrIntro = function(self, attrId, iconSprite, itemTrans)
  -- function num : 0_5 , upvalues : UINAttrIntroItem
  if self.popIntroUI == nil then
    self.popIntroUI = (UINAttrIntroItem.New)()
    ;
    (self.popIntroUI):Init((self.ui).attrPopDetail)
  end
  ;
  (self.popIntroUI):ShowAttrPopIntro(attrId, iconSprite)
  ;
  ((self.popIntroUI).transform):SetParent(itemTrans, false)
  ;
  (self.popIntroUI):Show()
end

UINAthDetailItem.__hideAttrIntro = function(self)
  -- function num : 0_6
  if self.popIntroUI ~= nil then
    (self.popIntroUI):Hide()
  end
end

UINAthDetailItem.__RefreshSize = function(self)
  -- function num : 0_7 , upvalues : _ENV
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

UINAthDetailItem.__RefreshLock = function(self)
  -- function num : 0_8
  local lock = (self.athData).lockUnlock
  ;
  ((self.ui).img_Lock):SetIndex(lock and 1 or 0)
end

UINAthDetailItem.__OnClickLock = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if self.__onLockComplete == nil then
    self.__onLockComplete = BindCallback(self, self.OnAthLockComplete)
  end
  ;
  (self.athNetwork):CS_ATH_AthLock((self.athData).uid, self.__onLockComplete)
end

UINAthDetailItem.OnAthLockComplete = function(self)
  -- function num : 0_10
  self:__RefreshLock()
end

UINAthDetailItem.__OnClickOptimize = function(self)
  -- function num : 0_11 , upvalues : _ENV, cs_MessageCommon, ArthmeticEnum
  do
    if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_pro) then
      local msg = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_pro)
      ;
      (cs_MessageCommon.ShowMessageTips)(msg)
      return 
    end
    local strengthenEnable = ArthmeticEnum.StrengthenQuality == (self.athData):GetAthQuality() and (self.athData):GetAthSize() > 1
    if not strengthenEnable then
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.arithmetic_Strengthlimt))
      return 
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.AthRefactor, function(window)
    -- function num : 0_11_0 , upvalues : self
    if window == nil then
      return 
    end
    window:InitAthRefactor(self.athData, self.heroData)
  end
)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

UINAthDetailItem.__OnClickUninstall = function(self)
  -- function num : 0_12
  (self.detailRoot):OnClickUninstallAth()
end

UINAthDetailItem.__OnClickInstall = function(self)
  -- function num : 0_13
  (self.detailRoot):OnClickInstallAth()
end

UINAthDetailItem.__OnClickReplace = function(self)
  -- function num : 0_14
  (self.detailRoot):OnClickReplaceAth()
end

UINAthDetailItem.__releasePressFunc = function(self)
  -- function num : 0_15
  if self.__showAttrWin ~= nil then
    (((self.ui).btn_mainAttri).onPressDown):RemoveListener(self.__showAttrWin)
  end
  if self.__hideAttrWin ~= nil then
    (((self.ui).btn_mainAttri).onPressUp):RemoveListener(self.__hideAttrWin)
  end
end

UINAthDetailItem.OnDelete = function(self)
  -- function num : 0_16 , upvalues : base
  (self.attriItemPool):DeleteAll()
  ;
  (self.suitAttriPool):DeleteAll()
  self:__releasePressFunc()
  if self.popIntroUI ~= nil then
    (self.popIntroUI):Hide()
    ;
    (self.popIntroUI):OnDelete()
  end
  ;
  (base.OnDelete)(self)
end

return UINAthDetailItem


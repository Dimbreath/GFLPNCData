-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthDetailItem = class("UINAthDetailItem", UIBaseNode)
local base = UIBaseNode
local UINAthDetailAttr = require("Game.Arithmetic.AthDetail.UINAthDetailAttr")
local UINAthSuitAttr = require("Game.Arithmetic.AthSuitDetail.UINAthSuitAttr")
local ArthmeticEnum = require("Game.Arithmetic.ArthmeticEnum")
local cs_MessageCommon = CS.MessageCommon
local StrengthenQuality = 5
UINAthDetailItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINAthDetailAttr, UINAthSuitAttr
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
  ((self.ui).attriItem):SetActive(false)
  self.attriItemPool = (UIItemPool.New)(UINAthDetailAttr, (self.ui).attriItem)
  ;
  ((self.ui).suitAttrItem):SetActive(false)
  self.suitAttriPool = (UIItemPool.New)(UINAthSuitAttr, (self.ui).suitAttrItem)
  self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
end

UINAthDetailItem.InitAthDetailItem = function(self, detailRoot, athData, heroData, isAddPreview, isReplace)
  -- function num : 0_1 , upvalues : StrengthenQuality, _ENV
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
  local canStrenthen = StrengthenQuality == athData:GetAthQuality() and athData:GetAthSize() > 1
  ;
  (((self.ui).btn_Optimize).gameObject):SetActive(canStrenthen)
  -- DECOMPILER ERROR at PC79: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_Quailty).color = athData:GetColor()
  local areaId = athData:GetAthAreaType()
  local areaCfg = (ConfigData.ath_area)[areaId]
  if areaCfg == nil then
    error("Can\'t get areaCfg, areaId = " .. areaId)
  else
    ((self.ui).tex_Area):SetIndex(0, areaCfg.name1)
  end
  self:__RefreshLock()
  -- DECOMPILER ERROR at PC105: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = athData:GetName()
  ;
  ((self.ui).tex_SpaceUsage):SetIndex(0, tostring(athData:GetAthSize()))
  self:RefreshAthDetailItemAttr()
  local suitId = athData:GetAthSuit()
  ;
  ((self.ui).suit):SetActive(suitId ~= 0)
  local suitAthList = ((ConfigData.arithmetic).suitDic)[athData.suit]
  if suitAthList ~= nil then
    local suitAthCount = 0
    for k,athId in ipairs(suitAthList) do
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
      -- DECOMPILER ERROR at PC215: Confused about usage of register: R19 in 'UnsetPending'

      if k == 1 then
        ((self.ui).tex_SuitName).text = (LanguageUtil.GetLocaleText)((((ConfigData.ath_suit).suitParamDic)[suitId]).name)
      end
      local suitCount = v.num
      local textIndex = v.num <= suitNum and 1 or 0
      local info = (LanguageUtil.GetLocaleText)(v.describe)
      local attrItem = (self.suitAttriPool):GetOne()
      attrItem:InitAthSuitAttr(suitCount, info, textIndex)
    end
  end
  do
    if (self.ui).optimizeLock ~= nil then
      local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)
      ;
      ((self.ui).optimizeLock):SetActive(not funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_pro))
    end
    -- DECOMPILER ERROR: 16 unprocessed JMP targets
  end
end

UINAthDetailItem.RefreshAthDetailItemAttr = function(self)
  -- function num : 0_2 , upvalues : _ENV, ArthmeticEnum
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
    ((self.ui).tex_MianAttriNum).text = valueStr
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).tex_MianAttriName).text = name
  end
  do
    if #athData.affixList == 0 then
      ((self.ui).aTHAttriNode):SetActive(false)
    else
      ;
      ((self.ui).aTHAttriNode):SetActive(true)
      ;
      (self.attriItemPool):HideAll()
      for k,affix in ipairs(athData.affixList) do
        local cfg = (ConfigData.ath_affix_pool)[affix.id]
        if cfg == nil then
          error("Can\'t find ath_affix_pool, id = " .. tostring(affix.id))
        else
          local color = Color.black
          if affix.quality == eItemQualityType.Orange then
            color = (ArthmeticEnum.AthQualityColor)[affix.quality]
          end
          local attrItem = (self.attriItemPool):GetOne()
          attrItem:InitAthDetailAttr(cfg.affix_para, affix.value, color)
        end
      end
    end
  end
end

UINAthDetailItem.__RefreshLock = function(self)
  -- function num : 0_3
  local lock = (self.athData).lockUnlock
  ;
  ((self.ui).img_Lock):SetIndex(lock and 1 or 0)
end

UINAthDetailItem.__OnClickLock = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.__onLockComplete == nil then
    self.__onLockComplete = BindCallback(self, self.OnAthLockComplete)
  end
  ;
  (self.athNetwork):CS_ATH_AthLock((self.athData).uid, self.__onLockComplete)
end

UINAthDetailItem.OnAthLockComplete = function(self)
  -- function num : 0_5
  self:__RefreshLock()
end

UINAthDetailItem.__OnClickOptimize = function(self)
  -- function num : 0_6 , upvalues : _ENV, cs_MessageCommon, StrengthenQuality
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock)
  do
    if not funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_pro) then
      local msg = funcUnLockCrtl:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_pro)
      ;
      (cs_MessageCommon.ShowMessageTips)(msg)
      return 
    end
    local strengthenEnable = StrengthenQuality == (self.athData):GetAthQuality() and (self.athData):GetAthSize() > 1
    if not strengthenEnable then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.arithmetic_Strengthlimt))
      return 
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.AthStrengthen, function(window)
    -- function num : 0_6_0 , upvalues : self
    if window == nil then
      return 
    end
    window:InitAthStrengthen(self.athData, self.heroData)
  end
)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

UINAthDetailItem.__OnClickUninstall = function(self)
  -- function num : 0_7
  (self.detailRoot):OnClickUninstallAth()
end

UINAthDetailItem.__OnClickInstall = function(self)
  -- function num : 0_8
  (self.detailRoot):OnClickInstallAth()
end

UINAthDetailItem.__OnClickReplace = function(self)
  -- function num : 0_9
  (self.detailRoot):OnClickReplaceAth()
end

UINAthDetailItem.OnDelete = function(self)
  -- function num : 0_10 , upvalues : base
  (self.attriItemPool):DeleteAll()
  ;
  (self.suitAttriPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINAthDetailItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthDetailItem = class("UINAthDetailItem", UIBaseNode)
local base = UIBaseNode
local UINAthDetailAttr = require("Game.Arithmetic.AthDetail.UINAthDetailAttr")
local UINAthSuitAttr = require("Game.Arithmetic.AthSuitDetail.UINAthSuitAttr")
local ArthmeticEnum = require("Game.Arithmetic.ArthmeticEnum")
local cs_MessageCommon = CS.MessageCommon
local StrengthenQuality = 5
UINAthDetailItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINAthDetailAttr, UINAthSuitAttr
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_Lock, self, self.__OnClickLock);
    (UIUtil.AddButtonListener)((self.ui).btn_Optimize, self,
                               self.__OnClickOptimize);
    (UIUtil.AddButtonListener)((self.ui).btn_Uninstall, self,
                               self.__OnClickUninstall);
    (UIUtil.AddButtonListener)((self.ui).btn_Equip, self, self.__OnClickInstall);
    (UIUtil.AddButtonListener)((self.ui).btn_Switch, self, self.__OnClickReplace);
    ((self.ui).attriItem):SetActive(false)
    self.attriItemPool = (UIItemPool.New)(UINAthDetailAttr, (self.ui).attriItem);
    ((self.ui).suitAttrItem):SetActive(false)
    self.suitAttriPool =
        (UIItemPool.New)(UINAthSuitAttr, (self.ui).suitAttrItem)
    self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
end

UINAthDetailItem.InitAthDetailItem = function(self, detailRoot, athData,
                                              heroData, isAddPreview, isReplace)
    -- function num : 0_1 , upvalues : StrengthenQuality, _ENV
    self.detailRoot = detailRoot
    self.athData = athData
    self.heroData = heroData;
    (((self.ui).btn_Uninstall).gameObject):SetActive(false);
    (((self.ui).btn_Equip).gameObject):SetActive(false);
    (((self.ui).btn_Switch).gameObject):SetActive(false);
    ((self.ui).curEquip):SetActive(false)
    if isReplace then
        if isAddPreview then
            (((self.ui).btn_Switch).gameObject):SetActive(true)
        else

            ((self.ui).curEquip):SetActive(true)
        end
    else
        if isAddPreview then
            (((self.ui).btn_Equip).gameObject):SetActive(true)
        else

            (((self.ui).btn_Uninstall).gameObject):SetActive(true)
        end
    end
    local canStrenthen = StrengthenQuality == athData:GetAthQuality() and
                             athData:GetAthSize() > 1;
    (((self.ui).btn_Optimize).gameObject):SetActive(canStrenthen) -- DECOMPILER ERROR at PC79: Confused about usage of register: R7 in 'UnsetPending'
    ;
    ((self.ui).img_Quailty).color = athData:GetColor()
    local areaId = athData:GetAthAreaType()
    local areaCfg = (ConfigData.ath_area)[areaId]
    if areaCfg == nil then
        error("Can\'t get areaCfg, areaId = " .. areaId)
    else
        ((self.ui).tex_Area):SetIndex(0, areaCfg.name1)
    end
    self:__RefreshLock() -- DECOMPILER ERROR at PC105: Confused about usage of register: R9 in 'UnsetPending'
    ;
    ((self.ui).tex_Name).text = athData:GetName();
    ((self.ui).tex_SpaceUsage):SetIndex(0, tostring(athData:GetAthSize()))
    self:RefreshAthDetailItemAttr()
    local suitId = athData:GetAthSuit();
    ((self.ui).suit):SetActive(suitId ~= 0)
    local suitAthList = ((ConfigData.arithmetic).suitDic)[athData.suit]
    if suitAthList ~= nil then
        local suitAthCount = 0
        for k, athId in ipairs(suitAthList) do
            local athCfg = (ConfigData.arithmetic)[athId]
            local itemCfg = (ConfigData.item)[athId]
            if itemCfg == nil then
                error("Can\'t find itemCfg, id = " .. tostring(athId))
                break
            end
            local slotId = athCfg.area_type
            local installed = false
            if heroData ~= nil then
                installed = (PlayerDataCenter.allAthData):HeroContainAthById(
                                heroData.dataId, slotId, athId)
            end
            if installed then suitAthCount = suitAthCount + 1 end
        end
        local suitCfg = (ConfigData.ath_suit)[suitId]
        if suitCfg == nil then
            error("Can\'t find suitCfg, id = " .. tostring(suitId))
            return
        end
        local suitNum = 0
        for k, v in ipairs(suitCfg) do
            if v.num <= suitAthCount then suitNum = v.num end
        end
        (self.suitAttriPool):HideAll()
        for k, v in ipairs(suitCfg) do
            -- DECOMPILER ERROR at PC215: Confused about usage of register: R19 in 'UnsetPending'

            if k == 1 then
                ((self.ui).tex_SuitName).text =
                    (LanguageUtil.GetLocaleText)(
                        (((ConfigData.ath_suit).suitParamDic)[suitId]).name)
            end
            local suitCount = v.num
            local textIndex = v.num <= suitNum and 1 or 0
            local info = (LanguageUtil.GetLocaleText)(v.describe)
            local attrItem = (self.suitAttriPool):GetOne()
            attrItem:InitAthSuitAttr(suitCount, info, textIndex)
        end
    end
    do
        if (self.ui).optimizeLock ~= nil then
            local funcUnLockCrtl = ControllerManager:GetController(
                                       ControllerTypeId.FunctionUnlock, true);
            ((self.ui).optimizeLock):SetActive(
                not funcUnLockCrtl:ValidateUnlock(
                    proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_pro))
        end
        -- DECOMPILER ERROR: 16 unprocessed JMP targets
    end
end

UINAthDetailItem.RefreshAthDetailItemAttr =
    function(self)
        -- function num : 0_2 , upvalues : _ENV, ArthmeticEnum
        local athData = self.athData
        if #(athData.athMainAttrCfg).attrtibute_id > 0 then
            local attrId = ((athData.athMainAttrCfg).attrtibute_id)[1]
            local attrValue = ((athData.athMainAttrCfg).attrtibute_num)[1]
            local name, valueStr, icon =
                ConfigData:GetAttribute(attrId, attrValue) -- DECOMPILER ERROR at PC23: Confused about usage of register: R7 in 'UnsetPending'
            ;
            ((self.ui).img_Icon).sprite = CRH:GetSprite(icon) -- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'
            ;
            ((self.ui).tex_MianAttriNum).text = valueStr -- DECOMPILER ERROR at PC29: Confused about usage of register: R7 in 'UnsetPending'
            ;
            ((self.ui).tex_MianAttriName).text = name
        end
        do
            if #athData.affixList == 0 then
                ((self.ui).aTHAttriNode):SetActive(false)
            else

                ((self.ui).aTHAttriNode):SetActive(true);
                (self.attriItemPool):HideAll()
                for k, affix in ipairs(athData.affixList) do
                    local cfg = (ConfigData.ath_affix_pool)[affix.id]
                    if cfg == nil then
                        error("Can\'t find ath_affix_pool, id = " ..
                                  tostring(affix.id))
                    else
                        local color = Color.black
                        if affix.quality == eItemQualityType.Orange then
                            color =
                                (ArthmeticEnum.AthQualityColor)[affix.quality]
                        end
                        local attrItem = (self.attriItemPool):GetOne()
                        attrItem:InitAthDetailAttr(cfg.affix_para, affix.value,
                                                   color)
                    end
                end
            end
        end
    end

UINAthDetailItem.__RefreshLock = function(self)
    -- function num : 0_3
    local lock = (self.athData).lockUnlock;
    ((self.ui).img_Lock):SetIndex(lock and 1 or 0)
end

UINAthDetailItem.__OnClickLock = function(self)
    -- function num : 0_4 , upvalues : _ENV
    if self.__onLockComplete == nil then
        self.__onLockComplete = BindCallback(self, self.OnAthLockComplete)
    end
    (self.athNetwork):CS_ATH_AthLock((self.athData).uid, self.__onLockComplete)
end

UINAthDetailItem.OnAthLockComplete = function(self)
    -- function num : 0_5
    self:__RefreshLock()
end

UINAthDetailItem.__OnClickOptimize = function(self)
    -- function num : 0_6 , upvalues : _ENV, cs_MessageCommon, StrengthenQuality
    local funcUnLockCrtl = ControllerManager:GetController(
                               ControllerTypeId.FunctionUnlock)
    do
        if not funcUnLockCrtl:ValidateUnlock(
            proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_pro) then
            local msg = funcUnLockCrtl:GetFuncUnlockDecription(
                            proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_pro);
            (cs_MessageCommon.ShowMessageTips)(msg)
            return
        end
        local strengthenEnable = StrengthenQuality ==
                                     (self.athData):GetAthQuality() and
                                     (self.athData):GetAthSize() > 1
        if not strengthenEnable then
            (cs_MessageCommon.ShowMessageTips)(
                ConfigData:GetTipContent(TipContent.arithmetic_Strengthlimt))
            return
        end
        UIManager:ShowWindowAsync(UIWindowTypeID.AthStrengthen, function(window)
            -- function num : 0_6_0 , upvalues : self
            if window == nil then return end
            window:InitAthStrengthen(self.athData, self.heroData)
        end)
        -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
end

UINAthDetailItem.__OnClickUninstall = function(self)
    -- function num : 0_7
    (self.detailRoot):OnClickUninstallAth()
end

UINAthDetailItem.__OnClickInstall = function(self)
    -- function num : 0_8
    (self.detailRoot):OnClickInstallAth()
end

UINAthDetailItem.__OnClickReplace = function(self)
    -- function num : 0_9
    (self.detailRoot):OnClickReplaceAth()
end

UINAthDetailItem.OnDelete = function(self)
    -- function num : 0_10 , upvalues : base
    (self.attriItemPool):DeleteAll();
    (self.suitAttriPool):DeleteAll();
    (base.OnDelete)(self)
end

return UINAthDetailItem


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthDetailItem = class("UINAthDetailItem", UIBaseNode)
local base = UIBaseNode
local UINAthDetailAttr = require("Game.Arithmetic.AthDetail.UINAthDetailAttr")
local UINAthSuitAttr = require("Game.Arithmetic.AthSuitDetail.UINAthSuitAttr")
local ArthmeticEnum = require("Game.Arithmetic.ArthmeticEnum")
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
  -- function num : 0_1 , upvalues : _ENV, ArthmeticEnum
  self.detailRoot = detailRoot
  self.athData = athData
  ;
  (((self.ui).btn_Optimize).gameObject):SetActive(false)
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
      (((self.ui).btn_Optimize).gameObject):SetActive(true)
      ;
      (((self.ui).btn_Switch).gameObject):SetActive(true)
    else
      ;
      (((self.ui).btn_Optimize).gameObject):SetActive(true)
      ;
      ((self.ui).curEquip):SetActive(true)
    end
  else
    if isAddPreview then
      (((self.ui).btn_Optimize).gameObject):SetActive(true)
      ;
      (((self.ui).btn_Equip).gameObject):SetActive(true)
    else
      ;
      (((self.ui).btn_Optimize).gameObject):SetActive(true)
      ;
      (((self.ui).btn_Uninstall).gameObject):SetActive(true)
    end
  end
  -- DECOMPILER ERROR at PC91: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_Quailty).color = athData:GetColor()
  local areaId = athData:GetAthAreaType()
  local areaCfg = (ConfigData.ath_area)[areaId]
  if areaCfg == nil then
    error("Can\'t get areaCfg, areaId = " .. areaId)
  else
    ;
    ((self.ui).tex_Area):SetIndex(0, areaCfg.name1)
  end
  self:__RefreshLock()
  -- DECOMPILER ERROR at PC117: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = athData:GetName()
  ;
  ((self.ui).tex_SpaceUsage):SetIndex(0, tostring(athData:GetAthSize()))
  if #athData.attrList > 0 then
    local athAttr = (athData.attrList)[1]
    local name, valueStr, icon = ConfigData:GetAttribute(athAttr.id, athAttr.value)
    -- DECOMPILER ERROR at PC144: Confused about usage of register: R12 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = CRH:GetSprite(icon)
    -- DECOMPILER ERROR at PC147: Confused about usage of register: R12 in 'UnsetPending'

    ;
    ((self.ui).tex_MianAttriNum).text = valueStr
    -- DECOMPILER ERROR at PC150: Confused about usage of register: R12 in 'UnsetPending'

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
          if affix.quality == (ArthmeticEnum.eAthQualityType).Orange then
            color = (ArthmeticEnum.AthQualityColor)[affix.quality]
          end
          local attrItem = (self.attriItemPool):GetOne()
          attrItem:InitAthDetailAttr(cfg.affix_para, affix.value, color)
        end
      end
    end
    do
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
            if isAddPreview == false and athId == (self.athData).id then
              do
                suitAthCount = suitAthCount + 1
                if isAddPreview and athId == (self.athData).id then
                  suitAthCount = suitAthCount + 1
                end
                -- DECOMPILER ERROR at PC275: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC275: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC275: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC275: LeaveBlock: unexpected jumping out IF_STMT

              end
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
          -- DECOMPILER ERROR at PC316: Confused about usage of register: R18 in 'UnsetPending'

          if k == 1 then
            ((self.ui).tex_SuitName).text = (LanguageUtil.GetLocaleText)(v.name)
          end
          local suitCount = v.num
          local textIndex = v.num <= suitNum and 1 or 0
          local info = (LanguageUtil.GetLocaleText)(v.describe)
          local attrItem = (self.suitAttriPool):GetOne()
          attrItem:InitAthSuitAttr(suitCount, info, textIndex)
        end
      end
      -- DECOMPILER ERROR: 14 unprocessed JMP targets
    end
  end
end

UINAthDetailItem.__RefreshLock = function(self)
  -- function num : 0_2
  local lock = (self.athData).lockUnlock
  ;
  ((self.ui).img_Lock):SetIndex(lock and 1 or 0)
end

UINAthDetailItem.__OnClickLock = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.__onLockComplete == nil then
    self.__onLockComplete = BindCallback(self, self.OnAthLockComplete)
  end
  ;
  (self.athNetwork):CS_ATH_AthLock((self.athData).uid, self.__onLockComplete)
end

UINAthDetailItem.OnAthLockComplete = function(self)
  -- function num : 0_4
  self:__RefreshLock()
end

UINAthDetailItem.__OnClickOptimize = function(self)
  -- function num : 0_5
end

UINAthDetailItem.__OnClickUninstall = function(self)
  -- function num : 0_6
  (self.detailRoot):OnClickUninstallAth()
end

UINAthDetailItem.__OnClickInstall = function(self)
  -- function num : 0_7
  (self.detailRoot):OnClickInstallAth()
end

UINAthDetailItem.__OnClickReplace = function(self)
  -- function num : 0_8
  (self.detailRoot):OnClickReplaceAth()
end

UINAthDetailItem.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  (self.attriItemPool):DeleteAll()
  ;
  (self.suitAttriPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINAthDetailItem


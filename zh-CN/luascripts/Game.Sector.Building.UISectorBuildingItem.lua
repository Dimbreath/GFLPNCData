-- params : ...
-- function num : 0 , upvalues : _ENV
local UISectorBuildingItem = class("UISectorBuildingItem", UIBaseNode)
local base = UIBaseNode
local logicIndex1 = 1
local logicIndex2 = 2
local CheckerTypeId, CheckerGlobalConfig = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
UISectorBuildingItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.OnClickEvent = nil
  ;
  (UIUtil.AddButtonListener)((self.ui).button, self, self.__OnClickItem)
  self.stateBgColors = {}
  ;
  (UIUtil.LuaUIBindingTable)((self.ui).state, self.stateBgColors)
  self.costInfoState = 0
  self:__ShowProgress(false)
  self.accelerateNode = nil
  self.unlockText = {}
end

UISectorBuildingItem.InitSectorBdItem = function(self, buildingData, built, resLoader)
  -- function num : 0_1 , upvalues : _ENV
  self.id = buildingData.id
  self.buildingData = buildingData
  self.resloader = resLoader
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = buildingData.name
  self:UpdateData(buildingData, built)
  self:UpdateUI()
  if buildingData.state == proto_object_BuildingState.BuildingStateCreate or buildingData.state == proto_object_BuildingState.BuildingStateUpgrade then
    self:UpdateProgressUI(buildingData.progress, TimestampToTime(buildingData.remainSecond))
  end
end

UISectorBuildingItem.Update = function(self, timestamp, isSecond)
  -- function num : 0_2
  if self.accelerateNode ~= nil and (self.accelerateNode).active then
    local progress, remainSecond = (self.buildingData):GetProcess(timestamp)
    if remainSecond > 0 then
      (self.accelerateNode):UpdateTime(remainSecond)
    end
  end
end

UISectorBuildingItem.UpdateProgressUI = function(self, progress, remainTimeText, waitConfirmOver)
  -- function num : 0_3
  if waitConfirmOver then
    self:UpdateUI()
    return 
  end
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_RemainTime).text = remainTimeText
end

UISectorBuildingItem.UpdateData = function(self, buildingData, built)
  -- function num : 0_4
  self.built = built
  self.buildingData = buildingData
end

UISectorBuildingItem.UpdateUI = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local buildingData = self.buildingData
  local canLevelUp = false
  local showProgress = false
  local upgradingPage = false
  ;
  ((self.ui).state):SetActive(false)
  ;
  ((self.ui).img_isMax):SetActive(false)
  ;
  ((self.ui).completed):SetActive(false)
  ;
  (((self.ui).img_CanLevelUp).gameObject):SetActive(false)
  ;
  (self.resloader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorBuilding"), function(spriteAtlas)
    -- function num : 0_5_0 , upvalues : self, buildingData
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = spriteAtlas:GetSprite(buildingData.icon_res)
  end
)
  if not self.built then
    ((self.ui).tex_Level):SetIndex(1)
    ;
    ((self.ui).tex_State):SetIndex(1)
    canLevelUp = buildingData:CanBuild()
    if canLevelUp then
      (((self.ui).img_CanLevelUp).gameObject):SetActive(true)
      ;
      ((self.ui).upGradeStateText):SetIndex(1)
    end
    self.costInfoState = 1
    if not buildingData:Unlock() then
      local level1Cfg = (buildingData.levelConfig)[1]
      local textIndex = 1
      self.unlockText = {}
      for k,v in ipairs(level1Cfg.pre_condition) do
        local isFulfillCondition = ((CheckCondition.CheckLua)({v}, {(level1Cfg.pre_para1)[k]}, {(level1Cfg.pre_para2)[k]}))
        local fillConditionText = nil
        if not isFulfillCondition then
          fillConditionText = (CheckCondition.GetUnlockInfoLua)({v}, {(level1Cfg.pre_para1)[k]}, {(level1Cfg.pre_para2)[k]})
        end
        -- DECOMPILER ERROR at PC111: Confused about usage of register: R14 in 'UnsetPending'

        if fillConditionText ~= nil then
          (self.unlockText)[textIndex] = fillConditionText
          textIndex = textIndex + 1
        end
      end
      ;
      ((self.ui).state):SetActive(true)
      -- DECOMPILER ERROR at PC132: Confused about usage of register: R7 in 'UnsetPending'

      if self.unlockText ~= nil and (self.unlockText)[1] ~= nil then
        (((self.ui).tex_State).text).text = (self.unlockText)[1]
      end
      self:__setStateBgColor(false)
    else
      do
        self:__setStateBgColor(true)
        -- DECOMPILER ERROR at PC144: Confused about usage of register: R5 in 'UnsetPending'

        ;
        ((self.ui).img_Button).color = (self.ui).lockBtnColor
        self:__setTextColor(false)
        self.costInfoState = 0
        -- DECOMPILER ERROR at PC154: Confused about usage of register: R5 in 'UnsetPending'

        ;
        ((self.ui).img_Button).color = (self.ui).normalBtnColor
        ;
        ((self.ui).tex_Level):SetIndex(0, tostring(buildingData.level))
        ;
        ((self.ui).tex_State):SetIndex(2)
        if buildingData.state == proto_object_BuildingState.BuildingStateNormal then
          if self.accelerateNode ~= nil and (self.accelerateNode).active then
            (self.accelerateNode):Hide()
          end
          self:__setStateBgColor(false)
          self:__setTextColor(true)
          if buildingData.maxLevel == buildingData.level then
            ((self.ui).img_isMax):SetActive(true)
          else
            canLevelUp = buildingData:CanUpgrade()
            if canLevelUp then
              (((self.ui).img_CanLevelUp).gameObject):SetActive(true)
              ;
              ((self.ui).upGradeStateText):SetIndex(0)
            end
          end
        else
          if buildingData.waitConfirmOver then
            upgradingPage = true
            ;
            ((self.ui).completed):SetActive(true)
            showProgress = true
            self:UpdateProgressUI(1, TimestampToTime(0))
          else
            ;
            ((self.ui).state):SetActive(true)
            self:__setTextColor(true)
            self:__setStateBgColor(true)
            if buildingData.state == proto_object_BuildingState.BuildingStateCreate then
              self.costInfoState = 3
              ;
              ((self.ui).tex_State):SetIndex(3)
            else
              self.costInfoState = 2
              ;
              ((self.ui).tex_State):SetIndex(4)
            end
            upgradingPage = true
            showProgress = true
          end
        end
        self:__ShowProgress(showProgress)
        self:__UpdateLogic()
      end
    end
  end
end

UISectorBuildingItem.__UpdateLogic = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local inversBuilt = not self.built
  if not inversBuilt or not 1 then
    local lvl = (self.buildingData).level
  end
  if not inversBuilt or not self.buildingData then
    local buildingDynData = (self.buildingData).dynData
  end
  local buffDict = buildingDynData:GetBuffItems(lvl)
  if buffDict ~= nil then
    for k,v in pairs(buffDict) do
      -- DECOMPILER ERROR at PC30: Confused about usage of register: R10 in 'UnsetPending'

      if v ~= nil then
        ((self.ui).tex_Description).text = v.currentInfo
        self.description = v.currentInfo
        return 
      end
    end
  end
end

UISectorBuildingItem.__ShowProgress = function(self, show)
  -- function num : 0_7
  (((self.ui).tex_RemainTime).gameObject):SetActive(show)
end

UISectorBuildingItem.__OnClickItem = function(self)
  -- function num : 0_8
  if self.OnClickEvent ~= nil then
    (self.OnClickEvent)(self.id)
  end
end

UISectorBuildingItem.__setTextColor = function(self, isIdle)
  -- function num : 0_9 , upvalues : _ENV
  if not isIdle or not Color.black then
    local targetColor = Color.white
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).color = targetColor
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).tex_Level).text).color = targetColor
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Description).color = targetColor
end

UISectorBuildingItem.__setStateBgColor = function(self, isActive)
  -- function num : 0_10
  if not isActive or not (self.stateBgColors).activeColor then
    local bgColor = (self.stateBgColors).disactiveColor
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_StateBg).color = bgColor
end

UISectorBuildingItem.GetSctBuildItemStateInfo = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local strText = nil
  if self.unlockText ~= nil then
    for k,v in ipairs(self.unlockText) do
      if not (string.IsNullOrEmpty)(strText) then
        strText = strText .. "\n" .. v
      else
        strText = v
      end
    end
  end
  do
    return strText
  end
end

UISectorBuildingItem.OnDelete = function(self)
  -- function num : 0_12 , upvalues : base
  if self.accelerateNode ~= nil then
    (self.accelerateNode):Hide()
  end
  self.resloader = nil
  self.unlockText = nil
  ;
  (base.OnDelete)(self)
end

return UISectorBuildingItem


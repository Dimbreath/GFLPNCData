-- params : ...
-- function num : 0 , upvalues : _ENV
local UINInfinityLevelItem = class("UINInfinityLevelItem", UIBaseNode)
local base = UIBaseNode
local ePlaceHolderType = (require("Game.Sector.Enum.SectorLevelInfinityEnum")).ePlaceHolderType
UINInfinityLevelItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_levelItem, self, self.OnClick)
  self.passCountList = {}
  ;
  (table.insert)(self.passCountList, (self.ui).obj_Pass)
end

UINInfinityLevelItem.InitInfinityLevel = function(self, levelData, onClickCallback)
  -- function num : 0_1
  self.levelData = levelData
  ;
  ((self.ui).obj_isTopOrDownNode):SetActive(false)
  ;
  ((self.ui).obj_info):SetActive(true)
  self.onClickCallback = onClickCallback
  self:RefreshUI(levelData)
end

UINInfinityLevelItem.InitPlaceHolder = function(self, levelData, topUiObject, buttonUiObject)
  -- function num : 0_2 , upvalues : ePlaceHolderType, _ENV
  self.levelData = levelData
  if levelData.placeHolederType == ePlaceHolderType.Top then
    (topUiObject.transform):SetParent(((self.ui).obj_isTopOrDownNode).transform)
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (topUiObject.transform).anchoredPosition = (Vector2.New)(0, 0)
    topUiObject:SetActive(true)
    buttonUiObject:SetActive(false)
  else
    if levelData.placeHolederType == ePlaceHolderType.Down then
      (buttonUiObject.transform):SetParent(((self.ui).obj_isTopOrDownNode).transform)
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (buttonUiObject.transform).anchoredPosition = (Vector2.New)(0, 0)
      buttonUiObject:SetActive(true)
      topUiObject:SetActive(false)
    end
  end
  ;
  ((self.ui).obj_isTopOrDownNode):SetActive(true)
  ;
  ((self.ui).obj_info):SetActive(false)
end

UINInfinityLevelItem.RefreshUI = function(self, levelData)
  -- function num : 0_3 , upvalues : _ENV
  local cfg = levelData.cfg
  self.levelData = levelData
  ;
  ((self.ui).tex_MainTitle):SetIndex(0, tostring(cfg.index * 10))
  if levelData.isUnlock then
    ((self.ui).obj_passList):SetActive(not levelData.isForbid)
    ;
    ((self.ui).obj_lock):SetActive(levelData.isUnlock and levelData.isForbid)
    if levelData.isUnlock then
      if levelData.isComplete then
        self:RefeshPassCount(#(levelData.cfg).layer)
      elseif levelData.passNum > 0 then
        self:RefeshPassCount(levelData.passNum)
      else
        self:RefeshPassCount(0)
      end
    end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end
end

UINInfinityLevelItem.OnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (self.levelData).isForbid then
    ((CS.MessageCommon).ShowMessageTips)((self.levelData).forbidInfo)
    return 
  end
  -- DECOMPILER ERROR at PC24: Unhandled construct in 'MakeBoolean' P1

  if not (self.levelData).isUnlock and (self.levelData).lockInfo ~= nil then
    ((CS.MessageCommon).ShowMessageTips)((self.levelData).lockInfo)
  end
  do return  end
  if self.onClickCallback ~= nil then
    (self.onClickCallback)(self.levelData, self)
  end
end

UINInfinityLevelItem.RefeshPassCount = function(self, num)
  -- function num : 0_5 , upvalues : _ENV
  for _,go in ipairs(self.passCountList) do
    go:SetActive(false)
  end
  for i = 1, num do
    if (self.passCountList)[i] ~= nil then
      ((self.passCountList)[i]):SetActive(true)
    else
      local newGo = ((self.ui).obj_Pass):Instantiate()
      ;
      (table.insert)(self.passCountList, newGo)
      newGo:SetActive(true)
    end
  end
end

UINInfinityLevelItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINInfinityLevelItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINInfinityLevelItem = class("UINInfinityLevelItem", UIBaseNode)
local base = UIBaseNode
local ePlaceHolderType =
    (require("Game.Sector.Enum.SectorLevelInfinityEnum")).ePlaceHolderType
UINInfinityLevelItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_levelItem, self, self.OnClick)
    self.passCountList = {};
    (table.insert)(self.passCountList, (self.ui).obj_Pass)
end

UINInfinityLevelItem.InitInfinityLevel =
    function(self, levelData, onClickCallback)
        -- function num : 0_1
        self.levelData = levelData;
        ((self.ui).obj_isTopOrDownNode):SetActive(false);
        ((self.ui).obj_info):SetActive(true)
        self.onClickCallback = onClickCallback
        self:RefreshUI(levelData)
    end

UINInfinityLevelItem.InitPlaceHolder = function(self, levelData, topUiObject,
                                                buttonUiObject)
    -- function num : 0_2 , upvalues : ePlaceHolderType, _ENV
    self.levelData = levelData
    if levelData.placeHolederType == ePlaceHolderType.Top then
        (topUiObject.transform):SetParent(
            ((self.ui).obj_isTopOrDownNode).transform) -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'
        ;
        (topUiObject.transform).anchoredPosition = (Vector2.New)(0, 0)
        topUiObject:SetActive(true)
        buttonUiObject:SetActive(false)
    else
        if levelData.placeHolederType == ePlaceHolderType.Down then
            (buttonUiObject.transform):SetParent(
                ((self.ui).obj_isTopOrDownNode).transform) -- DECOMPILER ERROR at PC41: Confused about usage of register: R4 in 'UnsetPending'
            ;
            (buttonUiObject.transform).anchoredPosition = (Vector2.New)(0, 0)
            buttonUiObject:SetActive(true)
            topUiObject:SetActive(false)
        end
    end
    ((self.ui).obj_isTopOrDownNode):SetActive(true);
    ((self.ui).obj_info):SetActive(false)
end

UINInfinityLevelItem.RefreshUI = function(self, levelData)
    -- function num : 0_3 , upvalues : _ENV
    local cfg = levelData.cfg
    self.levelData = levelData;
    ((self.ui).tex_MainTitle):SetIndex(0, tostring(cfg.index * 10))
    if levelData.isUnlock then
        ((self.ui).obj_passList):SetActive(not levelData.isForbid);
        ((self.ui).obj_lock):SetActive(levelData.isUnlock and levelData.isForbid)
        if levelData.isUnlock then
            if levelData.isComplete then
                self:RefeshPassCount(#(levelData.cfg).layer)
            elseif levelData.passNum > 0 then
                self:RefeshPassCount(levelData.passNum)
            else
                self:RefeshPassCount(0)
            end
        end
        -- DECOMPILER ERROR: 5 unprocessed JMP targets
    end
end

UINInfinityLevelItem.OnClick = function(self)
    -- function num : 0_4 , upvalues : _ENV
    if (self.levelData).isForbid then
        ((CS.MessageCommon).ShowMessageTips)((self.levelData).forbidInfo)
        return
    end
    -- DECOMPILER ERROR at PC24: Unhandled construct in 'MakeBoolean' P1

    if not (self.levelData).isUnlock and (self.levelData).lockInfo ~= nil then
        ((CS.MessageCommon).ShowMessageTips)((self.levelData).lockInfo)
    end
    do return end
    if self.onClickCallback ~= nil then
        (self.onClickCallback)(self.levelData, self)
    end
end

UINInfinityLevelItem.RefeshPassCount = function(self, num)
    -- function num : 0_5 , upvalues : _ENV
    for _, go in ipairs(self.passCountList) do go:SetActive(false) end
    for i = 1, num do
        if (self.passCountList)[i] ~= nil then
            ((self.passCountList)[i]):SetActive(true)
        else
            local newGo = ((self.ui).obj_Pass):Instantiate();
            (table.insert)(self.passCountList, newGo)
            newGo:SetActive(true)
        end
    end
end

UINInfinityLevelItem.OnDelete = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnDelete)(self)
end

return UINInfinityLevelItem


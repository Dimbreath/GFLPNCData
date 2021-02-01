-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthItem = class("UINAthItem", UIBaseNode)
local base = UIBaseNode
local ArthmeticEnum = require("Game.Arithmetic.ArthmeticEnum")
local CS_EventTriggerListener = CS.EventTriggerListener
UINAthItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.__OnClickRoot)
end

UINAthItem.InitAthItem = function(self, athData, clickFunc, resloader, inAthTable)
  -- function num : 0_1
  self.athData = athData
  self.clickFunc = clickFunc
  self.inAthTable = inAthTable
  self.resloader = resloader
  self:RereshAthItem()
end

UINAthItem.RereshAthItem = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local athData = self.athData
  local qualityColor = athData:GetAthColor()
  local areaId = athData:GetAthAreaType()
  for k,areaImg in ipairs((self.ui).imgList_Area) do
    if areaId == k then
      (areaImg.gameObject):SetActive(true)
      areaImg.color = qualityColor
    else
      ;
      (areaImg.gameObject):SetActive(false)
    end
  end
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = athData:GetName()
  local suitId = athData:GetAthSuit()
  local suitParamDic = ((ConfigData.ath_suit).suitParamDic)[suitId]
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R6 in 'UnsetPending'

  if (self.ui).img_SuitIcon ~= nil then
    ((self.ui).img_SuitIcon).enabled = false
  end
  if suitParamDic ~= nil then
    (self.resloader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath("AthSuitIcon"), function(spriteAtlas)
    -- function num : 0_2_0 , upvalues : self, suitParamDic
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_SuitIcon).sprite = spriteAtlas:GetSprite(suitParamDic.icon)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_SuitIcon).enabled = true
  end
)
  end
  if suitParamDic ~= nil then
    ((self.ui).obj_SuitDefault):SetActive(athData:GetAthSize() ~= 2)
    if #(athData.athMainAttrCfg).attrtibute_id > 0 then
      local attrId = ((athData.athMainAttrCfg).attrtibute_id)[1]
      local attrValue = ((athData.athMainAttrCfg).attrtibute_num)[1]
      local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
      -- DECOMPILER ERROR at PC86: Confused about usage of register: R11 in 'UnsetPending'

      ;
      ((self.ui).img_AttriIcon).sprite = CRH:GetSprite(icon)
      -- DECOMPILER ERROR at PC89: Confused about usage of register: R11 in 'UnsetPending'

      ;
      ((self.ui).tex_Value).text = valueStr
    end
    self:RefreshAthItemStateLock()
    self:RefreshAthItemStateInstall()
    self:SetAthItemSelect(false)
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

UINAthItem.SetAthItemSelect = function(self, select, isMultiple)
  -- function num : 0_3
  if select then
    ((self.ui).obj_SingleSel):SetActive(not isMultiple)
    ;
    ((self.ui).obj_MultiSel):SetActive(isMultiple)
  else
    ;
    ((self.ui).obj_SingleSel):SetActive(false)
    ;
    ((self.ui).obj_MultiSel):SetActive(false)
  end
end

UINAthItem.SetAthItemRootScrollRectRoot = function(self, scrollRectRoot)
  -- function num : 0_4
  self.scrollRectRoot = scrollRectRoot
end

UINAthItem.__OnClickRoot = function(self)
  -- function num : 0_5
  if self.clickFunc ~= nil then
    (self.clickFunc)(self)
  end
end

UINAthItem.SetAthItemDragFunc = function(self, dragStartFunc, isInTable)
  -- function num : 0_6 , upvalues : CS_EventTriggerListener, _ENV
  self.dragStartFunc = dragStartFunc
  self.isInTable = isInTable
  do
    if isInTable and self.__onBeginDrag == nil then
      local eventTigger = (CS_EventTriggerListener.Get)(self.gameObject)
      self.__onBeginDrag = BindCallback(self, self.OnAthItemBeginDrag)
      eventTigger:onBeginDrag("+", self.__onBeginDrag)
    end
    self.enableDrag = true
  end
end

UINAthItem.OnAthItemBeginDrag = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if not self.enableDrag or self._inDrag then
    return 
  end
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  if not IsNull(self.scrollRectRoot) then
    (self.scrollRectRoot).enabled = false
  end
  AudioManager:PlayAudioById(1031)
  self._inDrag = true
  self:ClearAthItemDragEndTween()
  self:EnableAthItemRaycast(false)
  if self.dragStartFunc ~= nil then
    (self.dragStartFunc)(self, self.isInTable)
  end
end

UINAthItem.OnAthItemDragEnd = function(self)
  -- function num : 0_8 , upvalues : _ENV
  self._inDrag = false
  self:EnableAthItemRaycast(true)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  if not IsNull(self.scrollRectRoot) then
    (self.scrollRectRoot).enabled = true
    return 
  end
end

UINAthItem.SetAthItemPos = function(self, position)
  -- function num : 0_9
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).root).position = position
end

UINAthItem.AthMoveTweenWithRootParent = function(self, anchoredPosition)
  -- function num : 0_10
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.transform).anchoredPosition = anchoredPosition
  self:DragEndTweenAthItem((self.transform).position)
end

UINAthItem.DragEndTweenAthItem = function(self, position)
  -- function num : 0_11
  self:ClearAthItemDragEndTween()
  self.__dragEndTween = (((self.ui).root):DOMove(position, 0.2)):OnComplete(function()
    -- function num : 0_11_0 , upvalues : self
    self:SetAthItemRootParent(nil, true)
  end
)
  self.__rootPos = position
end

UINAthItem.ClearAthItemDragEndTween = function(self)
  -- function num : 0_12
  if self.__dragEndTween ~= nil then
    (self.__dragEndTween):Kill()
    self.__dragEndTween = nil
  end
end

UINAthItem.GetAthItemRootPos = function(self)
  -- function num : 0_13
  if not self._rootPos then
    return (((self.ui).root).transform).position
  end
end

UINAthItem.GetAthItemRoot = function(self)
  -- function num : 0_14
  return (self.ui).root
end

UINAthItem.EnableAthItemRaycast = function(self, enable)
  -- function num : 0_15
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).uiNoDrawRaycast).raycastTarget = enable
end

UINAthItem.RefreshAthItemStateInstall = function(self)
  -- function num : 0_16 , upvalues : _ENV
  local equip = (self.athData).bindInfo ~= nil
  if self.inAthTable then
    equip = false
  end
  ;
  ((self.ui).obj_Equip):SetActive(equip)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Equip).text = nil
  do
    if equip then
      local heroData = (PlayerDataCenter.heroDic)[((self.athData).bindInfo).id]
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R3 in 'UnsetPending'

      if heroData ~= nil then
        ((self.ui).tex_Equip).text = heroData:GetName()
      end
    end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

UINAthItem.RefreshAthItemStateLock = function(self)
  -- function num : 0_17
  ((self.ui).obj_Lock):SetActive((self.athData).lockUnlock)
end

UINAthItem.GetAthItemData = function(self)
  -- function num : 0_18
  return self.athData
end

UINAthItem.SetAthItemRootParent = function(self, parent, reset, withoutSetPos)
  -- function num : 0_19
  if reset then
    ((self.ui).root):SetParent(self.transform)
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

    if not withoutSetPos then
      ((self.ui).root).anchoredPosition = self.__rootAnchoredPosition
    end
    if self.__OnResetAthItemRootParent ~= nil then
      (self.__OnResetAthItemRootParent)()
      self.__OnResetAthItemRootParent = nil
    end
  else
    if self.__rootAnchoredPosition == nil then
      self.__rootAnchoredPosition = ((self.ui).root).anchoredPosition
    end
    ;
    ((self.ui).root):SetParent(parent)
  end
end

UINAthItem.SetAthItemRootParentResetFunc = function(self, callBack)
  -- function num : 0_20
  self.__OnResetAthItemRootParent = callBack
end

UINAthItem.SetAsTransparentAthItem = function(self, parent, athData, resloader)
  -- function num : 0_21 , upvalues : _ENV
  (self.transform):SetParent(parent)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.transform).position = (parent.transform).position
  self:InitAthItem(athData, nil, resloader, nil)
  if self.__rootCanvasGroup == nil then
    self.__rootCanvasGroup = (self.gameObject):AddComponent(typeof((CS.UnityEngine).CanvasGroup))
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self.__rootCanvasGroup).alpha = 0.5
  end
end

UINAthItem.SetAthItemSuit = function(self, suitItem)
  -- function num : 0_22
  self.suitItem = suitItem
end

UINAthItem.TryReturnAthItemSuit = function(self, returnFunc)
  -- function num : 0_23
  if self.suitItem ~= nil then
    returnFunc(self.suitItem)
    self.suitItem = nil
  end
end

UINAthItem.OnDelete = function(self)
  -- function num : 0_24 , upvalues : base
  if self.subAttrPool ~= nil then
    (self.subAttrPool):DeleteAll()
  end
  self:ClearAthItemDragEndTween()
  ;
  (base.OnDelete)(self)
end

UINAthItem.OnDelete = function(self)
  -- function num : 0_25 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthItem


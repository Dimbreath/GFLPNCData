local UILogicPreviewNodeBase = require("Game.CommonUI.LogicPreviewNode.UILogicPreviewNodeBase")
local UINAttrOutLineWindow = class("UINHeroStateSkillItem", UILogicPreviewNodeBase)
local base = UILogicPreviewNodeBase
local UINAttrIntroItem = require("Game.Formation.UI.Common.UINHeroAttrIntroItem")
UINAttrOutLineWindow.OnInit = function(self)
  -- function num : 0_0 , upvalues : base
  (base.OnInit)(self)
  ;
  (base.InitWithClass)(self, nil, nil)
  ;
  (self.headAttrPool):HideAll()
  ;
  (self.rowItemPool):HideAll()
end

UINAttrOutLineWindow.OnShow = function(self)
  -- function num : 0_1 , upvalues : _ENV, base
  (UIUtil.SetTopStatus)(self, base._Close)
  ;
  (base.OnShow)(self)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).verticalNormalizedPosition = 1
  ;
  (UIUtil.HideTopStatus)()
end

UINAttrOutLineWindow.OnHide = function(self)
  -- function num : 0_2 , upvalues : base, _ENV
  (base.Hide)(self)
  ;
  (UIUtil.ReShowTopStatus)()
  AudioManager:PlayAudioById(1068)
  local heroStateWin = UIManager:GetWindow(UIWindowTypeID.HeroState)
  if heroStateWin ~= nil and heroStateWin.active then
    heroStateWin:AddAllTouch()
  end
end

UINAttrOutLineWindow.OnUpdateAttrData = function(self, name, attrDataList)
  -- function num : 0_3 , upvalues : _ENV
  ((self.ui).tex_SkillName):SetIndex(2, name)
  if attrDataList == nil then
    return 
  end
  self.attrDataList = attrDataList
  ;
  (self.rowItemPool):HideAll()
  for index = 1, #self.attrDataList do
    local rowItem = (self.rowItemPool):GetOne()
    rowItem:InitWithClass()
    local curData = (self.attrDataList)[index]
    local gridPool = rowItem.attrPool
    if gridPool ~= nil then
      gridPool:HideAll()
      local nameItem = gridPool:GetOne()
      nameItem:InitAttrItem(curData.name)
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R11 in 'UnsetPending'

      ;
      ((nameItem.ui).layoutment).minWidth = 575
      local basicValueItem = gridPool:GetOne()
      basicValueItem:InitAttrItem((curData.attrValueStrs)[1])
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R12 in 'UnsetPending'

      ;
      ((basicValueItem.ui).tex_Attri).alignment = 5
      if (curData.attrValueStrs)[2] ~= nil then
        local rateValueItem = gridPool:GetOne()
        rateValueItem:InitAttrItem("  +" .. (curData.attrValueStrs)[2], nil, (self.ui).color_orange)
        -- DECOMPILER ERROR at PC64: Confused about usage of register: R13 in 'UnsetPending'

        ;
        ((rateValueItem.ui).tex_Attri).alignment = 5
      else
        do
          do
            local rateValueItem = gridPool:GetOne()
            rateValueItem:InitAttrItem("")
            do
              local iconSprite = CRH:GetSprite(curData.icon)
              -- DECOMPILER ERROR at PC77: Confused about usage of register: R11 in 'UnsetPending'

              ;
              ((rowItem.ui).attrIcon).sprite = iconSprite
              rowItem:InjectPressAndUpFunc(BindCallback(self, self.__onAttrPressDown, curData.attrId, iconSprite, rowItem.transform), BindCallback(self, self.__onAttrPressUp))
              -- DECOMPILER ERROR at PC91: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC91: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC91: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC91: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC91: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC91: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
end

UINAttrOutLineWindow.__onAttrPressDown = function(self, valueId, iconSprite, itemTrans)
  -- function num : 0_4 , upvalues : UINAttrIntroItem
  local velocitySqr = (((self.ui).scrollRect).velocity).sqrMagnitude
  if velocitySqr > 0 then
    return 
  end
  if self.uiAttrIntro == nil then
    self.uiAttrIntro = (UINAttrIntroItem.New)()
    ;
    (self.uiAttrIntro):Init((self.ui).uINAttrPopDetail)
  end
  ;
  (self.uiAttrIntro):ShowAttrPopIntro(valueId, iconSprite)
  ;
  ((self.uiAttrIntro).transform):SetParent(itemTrans, false)
  ;
  (self.uiAttrIntro):Show()
end

UINAttrOutLineWindow.__onAttrPressUp = function(self)
  -- function num : 0_5
  if self.uiAttrIntro ~= nil then
    (self.uiAttrIntro):Hide()
  end
end

UINAttrOutLineWindow.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  if self.uiAttrIntro ~= nil then
    (self.uiAttrIntro):Hide()
    ;
    (self.uiAttrIntro):OnDelete()
  end
  ;
  (base.OnDelete)(self)
end

return UINAttrOutLineWindow


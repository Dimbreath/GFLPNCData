-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthIconItem = class("UIAthIconItem", UIBaseNode)
local base = UIBaseNode
UIAthIconItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  if (self.ui).rootBtn ~= nil then
    (UIUtil.AddButtonListener)((self.ui).rootBtn, self, self.OnClick)
  end
end

UIAthIconItem.InitAthIconItem = function(self, athData, clickEvent)
  -- function num : 0_1 , upvalues : _ENV
  self.athData = athData
  self.clickEvent = clickEvent
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  if (self.ui).tex_ATHName ~= nil then
    ((self.ui).tex_ATHName).text = athData:GetName()
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite(athData:GetIcon())
  ;
  ((self.ui).tex_ATHSpace):SetIndex(0, tostring(athData.size))
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).quality).color = athData:GetColor()
end

UIAthIconItem.OnClick = function(self)
  -- function num : 0_2
  if self.clickEvent ~= nil then
    (self.clickEvent)(self.athData, self)
  end
end

UIAthIconItem.SelectAth = function(self, select)
  -- function num : 0_3
  ((self.ui).img_OnSelect):SetActive(select)
end

UIAthIconItem.AthEquipToHero = function(self, nameId)
  -- function num : 0_4 , upvalues : _ENV
  ((self.ui).img_OnState):SetActive(true)
  ;
  ((self.ui).tex_OnState):SetIndex(1, (LanguageUtil.GetLocaleText)(nameId))
end

UIAthIconItem.AthCantEquip = function(self)
  -- function num : 0_5
  ((self.ui).img_OnState):SetActive(true)
  ;
  ((self.ui).tex_OnState):SetIndex(2)
end

UIAthIconItem.AthDefaultState = function(self)
  -- function num : 0_6
  ((self.ui).img_OnState):SetActive(false)
end

UIAthIconItem.Reset = function(self)
  -- function num : 0_7
  self.athData = nil
  self.clickEvent = nil
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = nil
  ;
  ((self.ui).tex_ATHSpace):SetIndex(0, "")
end

UIAthIconItem.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnDelete)(self)
end

return UIAthIconItem


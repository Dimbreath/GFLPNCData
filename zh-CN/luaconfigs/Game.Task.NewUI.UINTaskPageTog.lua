-- params : ...
-- function num : 0 , upvalues : _ENV
local UINTaskPageTog = class("UINTaskPageTog", UIBaseNode)
local base = UIBaseNode
UINTaskPageTog.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Task)
  self.group = nil
  self.isMult = false
  local oringinalSize = (self.transform).sizeDelta
  local target = (Vector2.New)(1.0666666666667 * oringinalSize.x, oringinalSize.y)
  self.extendTween = (((self.transform):DOSizeDelta(target, 0.25)):SetAutoKill(false)):Pause()
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_taskPageTog, self, self.OnValueChage)
end

UINTaskPageTog.InitPageTog = function(self, groupIndex, group, InitSubPages, OnSelectPage)
  -- function num : 0_1
  self.groupIndex = groupIndex
  self.group = group
  self.isMult = #group > 1
  self.InitSubPages = InitSubPages
  self.OnSelectPage = OnSelectPage
  local name, name_en = (self.ctrl):GetPageName(self.groupIndex)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_TypeName).text = name
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_TypeEN).text = name_en
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINTaskPageTog.OnValueChage = function(self, bool)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if bool then
    ((self.ui).tex_TypeName).color = (self.ui).color_black
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_TypeEN).color = (self.ui).color_black
    ;
    (self.extendTween):PlayForward()
    ;
    ((self.ui).img_Select):SetIndex(1)
    if self.isMult then
      local nameList = {}
      for subIndex,_ in ipairs(self.group) do
        local name, name_en = (self.ctrl):GetPageName(self.groupIndex, subIndex + 1)
        nameList[subIndex] = name
      end
      if self.InitSubPages ~= nil then
        (self.InitSubPages)(self.group, nameList)
      end
    else
      do
        if self.InitSubPages ~= nil then
          (self.InitSubPages)()
        end
        if self.OnSelectPage ~= nil then
          (self.OnSelectPage)((self.group)[1], self.groupIndex)
        end
        -- DECOMPILER ERROR at PC62: Confused about usage of register: R2 in 'UnsetPending'

        ;
        ((self.ui).tex_TypeName).color = (self.ui).color_gray
        -- DECOMPILER ERROR at PC67: Confused about usage of register: R2 in 'UnsetPending'

        ;
        ((self.ui).tex_TypeEN).color = (self.ui).color_gray
        ;
        (self.extendTween):PlayBackwards()
        ;
        ((self.ui).img_Select):SetIndex(0)
      end
    end
  end
end

UINTaskPageTog.SetRedDotActive = function(self, bool)
  -- function num : 0_3
  ((self.ui).obj_RedDot):SetActive(bool)
end

UINTaskPageTog.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  if self.extendTween ~= nil then
    (self.extendTween):Kill()
    self.extendTween = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINTaskPageTog


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCampFetterTog = class("UINCampFetterTog", UIBaseNode)
local base = UIBaseNode
UINCampFetterTog.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.singleWidth = (((self.ui).img_TakeEff).sizeDelta).x
  local oringinalSize = (self.transform).sizeDelta
  local target = (Vector2.New)(1.0666666666667 * oringinalSize.x, oringinalSize.y)
  self.extendTween = (((self.transform):DOSizeDelta(target, 0.25)):SetAutoKill(false)):Pause()
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_CampItem, self, self.__OnValueChage)
end

UINCampFetterTog.InitCampFetterTog = function(self, campId, count, triggerNum, clickEvent)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R5 in 'UnsetPending'

  (self.gameObject).name = tostring(campId)
  self.campId = campId
  self.count = count
  self.clickEvent = clickEvent
  self:__RefreshTogNameAndNum(campId, count)
  self:__RefreshTriggerNum(triggerNum)
end

UINCampFetterTog.__RefreshTogNameAndNum = function(self, campId, count)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(((ConfigData.camp)[campId]).name)
  ;
  ((self.ui).texInfo_HeroCount):SetIndex(0, tostring(count))
end

UINCampFetterTog.__RefreshTriggerNum = function(self, triggerNum)
  -- function num : 0_3 , upvalues : _ENV
  local width = self.singleWidth * triggerNum
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_TakeEff).sizeDelta = (Vector3.New)(width, (((self.ui).img_TakeEff).sizeDelta).y)
end

UINCampFetterTog.__OnValueChage = function(self, bool)
  -- function num : 0_4
  if bool then
    if self.clickEvent ~= nil then
      (self.clickEvent)(self.campId, self.count)
    end
    ;
    (self.extendTween):PlayForward()
    ;
    ((self.ui).img_Select):SetIndex(1)
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).color = (self.ui).color_selected
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_HeroCount).color = (self.ui).color_selected
  else
    ;
    (self.extendTween):PlayBackwards()
    ;
    ((self.ui).img_Select):SetIndex(0)
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).color = (self.ui).color_notSelected
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_HeroCount).color = (self.ui).color_notSelected
  end
end

UINCampFetterTog.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (self.extendTween):Kill()
  ;
  (base.OnDelete)(self)
end

return UINCampFetterTog


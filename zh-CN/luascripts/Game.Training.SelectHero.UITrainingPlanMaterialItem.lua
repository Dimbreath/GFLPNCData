-- params : ...
-- function num : 0 , upvalues : _ENV
local UITrainingPlanMaterialItem = class("UITrainingPlanMaterialItem", UIBaseNode)
local base = UIBaseNode
UITrainingPlanMaterialItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.OnClickEvent = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).rootBtn, self, self.__OnClickRootButton)
  self:Select(false)
end

UITrainingPlanMaterialItem.InitMatItem = function(self, resloader, id, time)
  -- function num : 0_1 , upvalues : _ENV
  self.id = id
  self.resloader = resloader
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  if time < 2 then
    ((self.ui).img_framePic).color = HeroRareColor[eHeroCardRareType.R]
  else
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

    if time == 2 then
      ((self.ui).img_framePic).color = HeroRareColor[eHeroCardRareType.SR]
    else
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).img_framePic).color = HeroRareColor[eHeroCardRareType.SSR]
    end
  end
  local minutes = time
  local hours = (math.floor)(time / 60)
  local remainSeconds = time - hours * 60
  if hours == 0 then
    ((self.ui).tex_Time):SetIndex(1, tostring(minutes))
  else
    if remainSeconds == 0 then
      ((self.ui).tex_Time):SetIndex(0, tostring(hours))
    else
      ;
      ((self.ui).tex_Time):SetIndex(2, tostring(hours), tostring(remainSeconds))
    end
  end
end

UITrainingPlanMaterialItem.Select = function(self, select)
  -- function num : 0_2
  ((self.ui).img_OnClick):SetActive(select)
end

UITrainingPlanMaterialItem.__OnClickRootButton = function(self)
  -- function num : 0_3
  if self.OnClickEvent ~= nil then
    (self.OnClickEvent)(self.id)
  end
end

UITrainingPlanMaterialItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  self.resloader = nil
  ;
  (base.OnDelete)(self)
end

return UITrainingPlanMaterialItem


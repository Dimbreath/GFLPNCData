local UINSupportPageBtn = class("UINSupportPageBtn", UIBaseNode)
local base = UIBaseNode
UINSupportPageBtn.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Page, self, self.OnClickSupportPageBtn)
end

UINSupportPageBtn.InitSupportPageBtn = function(self, index, clickAction, resloader)
  -- function num : 0_1 , upvalues : _ENV
  self.index = index
  self.clickAction = clickAction
  do
    if index ~= 0 then
      local careerCfg = (ConfigData.career)[index]
      -- DECOMPILER ERROR at PC13: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(careerCfg.name)
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).img_Icon).sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
    end
    self:SetSelectState(false)
  end
end

UINSupportPageBtn.OnClickSupportPageBtn = function(self)
  -- function num : 0_2
  if self.clickAction ~= nil then
    (self.clickAction)(self.index)
  end
end

UINSupportPageBtn.SetSelectState = function(self, flag)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if not flag or not (self.ui).color_ImgSelected then
    ((self.ui).img_Buttom).color = (self.ui).color_ImgUnSelect
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

    if not flag or not (self.ui).color_TextSelected then
      ((self.ui).tex_Name).color = (self.ui).color_TextUnSelect
    end
  end
end

UINSupportPageBtn.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINSupportPageBtn


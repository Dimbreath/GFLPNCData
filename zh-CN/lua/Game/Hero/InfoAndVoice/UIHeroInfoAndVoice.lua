local UIHeroInfoAndVoice = class("UIHeroInfoAndVoice", UIBaseNode)
local base = UIBaseNode
UIHeroInfoAndVoice.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnBtnCloseClicked)
end

UIHeroInfoAndVoice.InitHeroData = function(self, heroData, uiHeroList)
  -- function num : 0_1
  self.heroData = heroData
  self.uiHeroList = uiHeroList
  self:RefreshHeroData()
end

UIHeroInfoAndVoice.RefreshHeroData = function(self)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).tex_HeroName).text = (self.heroData):GetName()
end

UIHeroInfoAndVoice.OnBtnCloseClicked = function(self)
  -- function num : 0_3
  if self.uiHeroList ~= nil then
    self:Hide()
    ;
    (self.uiHeroList):OpenStatePanel()
  end
end

UIHeroInfoAndVoice.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UIHeroInfoAndVoice


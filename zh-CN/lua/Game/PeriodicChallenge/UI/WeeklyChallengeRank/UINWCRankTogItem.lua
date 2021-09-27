local UINWCRankTogItem = class("UINWCRankTogItem", UIBaseNode)
local base = UIBaseNode
UINWCRankTogItem.eTogType = {curTermRankList = 1, previousTermRankList = 2, rankRewardList = 3}
UINWCRankTogItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Page, self, self.__OnClick)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self.ui).tex_PageName).text).color = (self.ui).col_NameUnSel
end

UINWCRankTogItem.InitWCRankTogItem = function(self, eTogType, clickCallback)
  -- function num : 0_1
  ((self.ui).tex_PageName):SetIndex(eTogType - 1)
  self.clickCallback = clickCallback
end

UINWCRankTogItem.__OnClick = function(self, bool)
  -- function num : 0_2
  if bool then
    if self.clickCallback ~= nil then
      (self.clickCallback)()
    end
    ;
    ((self.ui).img_PageBG):SetIndex(1)
  else
    ;
    ((self.ui).img_PageBG):SetIndex(0)
  end
  if bool ~= true or not (self.ui).col_NameSel then
    local col = (self.ui).col_NameUnSel
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).tex_PageName).text).color = col
end

UINWCRankTogItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINWCRankTogItem


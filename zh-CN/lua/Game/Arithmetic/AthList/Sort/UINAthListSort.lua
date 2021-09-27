local UINAthListSort = class("UINAthListSort", UIBaseNode)
local base = UIBaseNode
local UINAthListSortKindItem = require("Game.Arithmetic.AthList.Sort.UINAthListSortKindItem")
local AthSortEnum = require("Game.Arithmetic.AthList.Sort.AthSortEnum")
UINAthListSort.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINAthListSortKindItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Bg, self, self._OnClickBg)
  self._SelectSortKindFunc = BindCallback(self, self._SelectSortKind)
  ;
  ((self.ui).sortKindItem):SetActive(false)
  self.sortItemPool = (UIItemPool.New)(UINAthListSortKindItem, (self.ui).sortKindItem)
end

UINAthListSort.InitAthListSort = function(self, athListRoot, isConsumeAth)
  -- function num : 0_1 , upvalues : AthSortEnum
  self.athListRoot = athListRoot
  self._isInit = true
  local kindCount = isConsumeAth and 2 or AthSortEnum.KindTypeMaxCount
  for kindType = 1, kindCount do
    for kindValue = 1, (AthSortEnum.eKindTypeNum)[kindType] do
      local sortItem = (self.sortItemPool):GetOne()
      sortItem:InitAthListSortKindItem(kindType, kindValue, self._SelectSortKindFunc)
    end
  end
  ;
  (((self.sortItemPool).listItem)[2]):SetAthListSortKindItemTogOn()
  ;
  (self.athListRoot):ChangeAthListSort(self.curKindType, self.curKindValue, self.curName, true)
  self._isInit = false
end

UINAthListSort.ShowAthListSort = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:Show()
  ;
  (UIUtil.SetTopStatus)(self, self.Hide)
end

UINAthListSort._SelectSortKind = function(self, kindType, kindValue, name)
  -- function num : 0_3
  self.curKindType = kindType
  self.curKindValue = kindValue
  self.curName = name
  if not self._isInit then
    self:_OnClickBg()
  end
end

UINAthListSort._OnClickBg = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (UIUtil.OnClickBack)()
  ;
  (self.athListRoot):ChangeAthListSort(self.curKindType, self.curKindValue, self.curName)
end

UINAthListSort.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (self.sortItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINAthListSort


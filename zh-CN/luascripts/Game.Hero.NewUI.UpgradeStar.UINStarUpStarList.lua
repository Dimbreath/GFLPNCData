-- params : ...
-- function num : 0 , upvalues : _ENV
local UINStarUpStarList = class("UINStarUpStarList", UIBaseNode)
local base = UIBaseNode
UINStarUpStarList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.StarList = {}
  ;
  (table.insert)(self.StarList, (self.ui).starItem)
end

UINStarUpStarList.InitStarList = function(self, rare, starNum)
  -- function num : 0_1 , upvalues : _ENV
  for _,starGo in ipairs(self.StarList) do
    (starGo.gameObject):SetActive(false)
  end
  local count = (math.ceil)(starNum / 2)
  local isHalf = starNum % 2 == 1
  for i = 1, count do
    if (self.StarList)[i] ~= nil then
      (((self.StarList)[i]).gameObject):SetActive(true)
      ;
      ((self.StarList)[i]):SetIndex(0)
    else
      local imgItemInfo = (((self.ui).starItem):Instantiate()):GetComponent(typeof(CS.UiImageItemInfo))
      ;
      (table.insert)(self.StarList, imgItemInfo)
      ;
      (imgItemInfo.gameObject):SetActive(true)
    end
  end
  if isHalf then
    ((self.StarList)[count]):SetIndex(1)
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UINStarUpStarList.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINStarUpStarList


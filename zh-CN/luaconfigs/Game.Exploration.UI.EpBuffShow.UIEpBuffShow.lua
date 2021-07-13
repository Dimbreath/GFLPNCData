-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpBuffShow = class("UIBaseWindow", UIBaseWindow)
local base = UIBaseWindow
local UIEpBuffShowItem = require("Game.Exploration.UI.EpBuffShow.UIEpBuffShowItem")
UIEpBuffShow.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  ((self.ui).iconItem):SetActive(false)
  ;
  ((self.ui).nameItem):SetActive(false)
  self.buffItemList = {}
  ;
  (((self.ui).ani_buffShow).onComplete):AddListener(BindCallback(self, self.__OnBuffAniPlayerComplete))
end

UIEpBuffShow.InitEpBuffShow = function(self, buffList)
  -- function num : 0_1 , upvalues : _ENV, UIEpBuffShowItem
  for k,epBuffCfg in pairs(buffList) do
    local iconObj = ((self.ui).iconItem):Instantiate()
    iconObj:SetActive(true)
    local nameObj = ((self.ui).nameItem):Instantiate()
    nameObj:SetActive(true)
    local buffItem = (UIEpBuffShowItem.New)()
    buffItem:InitEpBuffShowItem(iconObj, nameObj, epBuffCfg)
    ;
    (table.insert)(self.buffItemList, buffItem)
  end
end

UIEpBuffShow.__OnBuffAniPlayerComplete = function(self)
  -- function num : 0_2
  self:Delete()
end

UIEpBuffShow.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UIEpBuffShow


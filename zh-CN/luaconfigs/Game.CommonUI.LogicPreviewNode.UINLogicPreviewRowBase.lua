-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLogicPreviewRowBase = class("UINLogicPreviewRowBase", UIBaseNode)
local base = UIBaseNode
local UINLogicPreviewAttrItemBase = require("Game.CommonUI.LogicPreviewNode.UINLogicPreviewAttrItemBase")
UINLogicPreviewRowBase.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self:RegisterButtonPress()
end

UINLogicPreviewRowBase.RegisterButtonPress = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if (self.ui).button ~= nil then
    self.__pressDown = BindCallback(self, self.__onPressDown)
    ;
    (((self.ui).button).onPress):AddListener(self.__pressDown)
    self.__pressUp = BindCallback(self, self.__onPressUp)
    ;
    (((self.ui).button).onPressUp):AddListener(self.__pressUp)
  end
end

UINLogicPreviewRowBase.InjectPressAndUpFunc = function(self, pressDownFunc, pressUpFunc)
  -- function num : 0_2
  self.__pressDownFunc = pressDownFunc
  self.__pressUpFunc = pressUpFunc
end

UINLogicPreviewRowBase.InitWithClass = function(self, AttrItemClass)
  -- function num : 0_3 , upvalues : UINLogicPreviewAttrItemBase, _ENV
  if self.attrPool == nil then
    if not AttrItemClass then
      AttrItemClass = UINLogicPreviewAttrItemBase
    end
    ;
    ((self.ui).tex_Attri):SetActive(false)
    self.attrPool = (UIItemPool.New)(AttrItemClass, (self.ui).tex_Attri)
  end
end

UINLogicPreviewRowBase.__onPressDown = function(self)
  -- function num : 0_4
  if self.__pressDownFunc ~= nil then
    (self.__pressDownFunc)()
  end
end

UINLogicPreviewRowBase.__onPressUp = function(self)
  -- function num : 0_5
  if self.__pressUpFunc ~= nil then
    (self.__pressUpFunc)()
  end
end

UINLogicPreviewRowBase.__onReleaseButtonListener = function(self)
  -- function num : 0_6
  if (self.ui).button ~= nil then
    if self.__pressDown ~= nil then
      (((self.ui).button).onPress):RemoveListener(self.__pressDown)
    end
    if self.__pressUp ~= nil then
      (((self.ui).button).onPressUp):RemoveListener(self.__pressUp)
    end
  end
end

UINLogicPreviewRowBase.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  self:__onReleaseButtonListener()
  ;
  (self.attrPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINLogicPreviewRowBase


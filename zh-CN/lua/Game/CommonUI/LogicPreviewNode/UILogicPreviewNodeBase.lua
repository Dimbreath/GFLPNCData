local UILogicPreviewNodeBase = class("UILogicPreviewNodeBase", UIBaseNode)
local base = UIBaseNode
local UINLogicPreviewAttrItemBase = require("Game.CommonUI.LogicPreviewNode.UINLogicPreviewAttrItemBase")
local UINLogicPreviewRowBase = require("Game.CommonUI.LogicPreviewNode.UINLogicPreviewRowBase")
UILogicPreviewNodeBase.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self._OnClickClose)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Bg, self, self._OnClickClose)
end

UILogicPreviewNodeBase.InitWithClass = function(self, headAttrClass, rowItemClass)
  -- function num : 0_1 , upvalues : UINLogicPreviewAttrItemBase, UINLogicPreviewRowBase, _ENV
  if not headAttrClass then
    headAttrClass = UINLogicPreviewAttrItemBase
  end
  if not rowItemClass then
    rowItemClass = UINLogicPreviewRowBase
  end
  ;
  ((self.ui).tex_HeadAttri):SetActive(false)
  self.headAttrPool = (UIItemPool.New)(headAttrClass, (self.ui).tex_HeadAttri)
  ;
  ((self.ui).rowItem):SetActive(false)
  self.rowItemPool = (UIItemPool.New)(rowItemClass, (self.ui).rowItem)
end

UILogicPreviewNodeBase._Close = function(self)
  -- function num : 0_2
  self:Hide()
end

UILogicPreviewNodeBase._OnClickClose = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (UIUtil.OnClickBack)()
end

UILogicPreviewNodeBase.OnShow = function(self)
  -- function num : 0_4 , upvalues : base, _ENV
  (base.OnShow)(self)
  AudioManager:PlayAudioById(1067)
end

UILogicPreviewNodeBase.OnHide = function(self)
  -- function num : 0_5 , upvalues : _ENV, base
  AudioManager:PlayAudioById(1068)
  ;
  (base.OnHide)(self)
end

UILogicPreviewNodeBase.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (self.headAttrPool):DeleteAll()
  ;
  (self.rowItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UILogicPreviewNodeBase


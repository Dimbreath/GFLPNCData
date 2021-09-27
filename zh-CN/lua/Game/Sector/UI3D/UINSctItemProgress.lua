local UINSctItemProgress = class("UINSctItemProgress", UIBaseNode)
local base = UIBaseNode
UINSctItemProgress.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.__OnClickRootBtn)
end

UINSctItemProgress.InitSctProgress = function(self, sectorId, isStage, clickFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.sectorId = sectorId
  self.clickFunc = clickFunc
  local value = isStage and 0 or 1
  ;
  ((self.ui).img_Icon):SetIndex(value)
  ;
  ((self.ui).tex_Tile):SetIndex(value)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.gameObject).name = tostring(sectorId) .. "_" .. tostring(value)
end

UINSctItemProgress.SetSctProgressPosConstraint = function(self, sourceTransform)
  -- function num : 0_2
  local source = ((self.ui).posConstraint):GetSource(0)
  source.sourceTransform = sourceTransform
  ;
  ((self.ui).posConstraint):SetSource(0, source)
end

UINSctItemProgress.SetSctProgress = function(self, progress)
  -- function num : 0_3 , upvalues : _ENV
  progress = (math.floor)(progress * 100)
  ;
  ((self.ui).tex_Progress):SetIndex(0, tostring(progress))
end

UINSctItemProgress.ShowSctProgressRedDot = function(self, show)
  -- function num : 0_4
  ((self.ui).obj_RedDot):SetActive(show)
end

UINSctItemProgress.__OnClickRootBtn = function(self)
  -- function num : 0_5
  if self.clickFunc ~= nil then
    (self.clickFunc)(self.sectorId)
  end
end

UINSctItemProgress.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINSctItemProgress


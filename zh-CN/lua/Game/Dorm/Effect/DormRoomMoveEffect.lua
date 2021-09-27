local DormRoomMoveEffect = class("DormRoomMoveEffect")
local PlayShowTime = 0.4
local PlayHideTime = 0.3
local MatAniKey = "_Anim"
DormRoomMoveEffect.ctor = function(self, go, useNewMat)
  -- function num : 0_0 , upvalues : _ENV
  self.gameObject = go
  self.transform = go.transform
  self.erender1 = (go.transform):FindComponent("shelter1", eUnityComponentID.Renderer)
  self.erender2 = (go.transform):FindComponent("shelter2", eUnityComponentID.Renderer)
  self.useNewMat = useNewMat
  if useNewMat then
    self.mat1 = (self.erender1).material
    self.mat2 = (self.erender2).material
  else
    self.mat1 = (self.erender1):GetMaterial()
    self.mat2 = (self.erender2):GetMaterial()
  end
end

DormRoomMoveEffect.StartPlayShow = function(self)
  -- function num : 0_1 , upvalues : MatAniKey, PlayShowTime
  local mat1 = self.mat1
  local mat2 = self.mat2
  mat1:DOKill()
  mat2:DOKill()
  mat1:SetFloat(MatAniKey, 0)
  mat2:SetFloat(MatAniKey, 0)
  mat1:DOFloat(1, "_Anim", PlayShowTime)
  mat2:DOFloat(1, "_Anim", PlayShowTime)
end

DormRoomMoveEffect.StartHideShow = function(self)
  -- function num : 0_2 , upvalues : PlayHideTime
  local mat1 = self.mat1
  local mat2 = self.mat2
  mat1:DOKill()
  mat2:DOKill()
  mat1:DOFloat(0, "_Anim", PlayHideTime)
  mat2:DOFloat(0, "_Anim", PlayHideTime)
end

DormRoomMoveEffect.ClearMoveEffect = function(self)
  -- function num : 0_3
  if not (self.gameObject).activeInHierarchy then
    return 
  end
  local mat1 = self.mat1
  local mat2 = self.mat2
  mat1:DOKill()
  mat2:DOKill()
  ;
  (self.gameObject):SetActive(false)
end

return DormRoomMoveEffect


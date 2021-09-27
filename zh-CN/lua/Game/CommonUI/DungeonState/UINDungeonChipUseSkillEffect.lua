local UINDungeonChipUseSkillEffect = class("UINDungeonChipUseSkillEffect", UIBaseNode)
local base = UIBaseNode
UINDungeonChipUseSkillEffect.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.onPlayEndCallBack = nil
  self.__isStart = false
  self.__Duration = 1
  self.__PlayedTime = 0
  self.__OnUpdate = BindCallback(self, self._OnUpdate)
end

UINDungeonChipUseSkillEffect.PlayEffect = function(self, chipItem)
  -- function num : 0_1 , upvalues : _ENV
  local color = ItemQualityColor[(chipItem.chipData):GetQuality()]
  ;
  ((self.ui).fX_UI_DungeonStateInfo_OutLine):ChangeParticleStartColor(color)
  self.chipItem = chipItem
  ;
  (self.transform):SetParent(chipItem.transform, false)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).localPosition = Vector3.zero
  ;
  ((self.ui).fX_UI_DungeonStateInfo_OutLine):Play()
  if not self.__isStart then
    self.__isStart = true
    self.__PlayedTime = 0
    UpdateManager:AddUpdate(self.__OnUpdate)
  end
end

UINDungeonChipUseSkillEffect._OnUpdate = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.__PlayedTime = self.__PlayedTime + Time.deltaTime
  if self.__Duration < self.__PlayedTime then
    self:StopUseChipEffect()
  end
end

UINDungeonChipUseSkillEffect.StopUseChipEffect = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.__isStart then
    self.__isStart = false
    UpdateManager:RemoveUpdate(self.__OnUpdate)
    if self.ui ~= nil and (self.ui).fX_UI_DungeonStateInfo_OutLine ~= nil then
      ((self.ui).fX_UI_DungeonStateInfo_OutLine):Stop()
    end
    if self.onPlayEndCallBack ~= nil then
      (self.onPlayEndCallBack)(self)
    end
  end
end

UINDungeonChipUseSkillEffect.OnHide = function(self)
  -- function num : 0_4 , upvalues : base
  self:StopUseChipEffect()
  ;
  (base.OnHide)(self)
end

UINDungeonChipUseSkillEffect.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINDungeonChipUseSkillEffect


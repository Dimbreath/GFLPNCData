local UIEpPlayerPos = class("UIEpPlayerPos", UIBaseNode)
local base = UIBaseNode
UIEpPlayerPos.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIEpPlayerPos.SetPlayerPos = function(self, position)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.transform).position = position
end

UIEpPlayerPos.ShowPlayerPosSmall = function(self, show, withTween, callBack)
  -- function num : 0_2 , upvalues : _ENV
  self:__KillTween_SmallFade()
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  if withTween then
    if show then
      ((self.ui).smallNode).alpha = 0
      self.__smallFadeTween = (((self.ui).smallNode):DOFade(1, (ConfigData.buildinConfig).EpMapCursorShowDuration)):OnComplete(callBack)
    else
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).smallNode).alpha = 1
      self.__smallFadeTween = (((self.ui).smallNode):DOFade(0, (ConfigData.buildinConfig).EpMapCursorFadeDuration)):OnComplete(callBack)
    end
  else
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R4 in 'UnsetPending'

    if show then
      ((self.ui).smallNode).alpha = 1
    else
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).smallNode).alpha = 0
    end
  end
  if show then
    self:ShowPlayerPosLarge(false)
  end
  self.smallIsShow = show
end

UIEpPlayerPos.ShowPlayerPosLarge = function(self, show, withTween, callBack)
  -- function num : 0_3 , upvalues : _ENV
  self:__KillTween_LargeFade()
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  if withTween then
    if show then
      ((self.ui).largeNode).alpha = 0
      self.__largeFadeTween = (((self.ui).largeNode):DOFade(1, (ConfigData.buildinConfig).EpMapCursorShowDuration)):OnComplete(callBack)
    else
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).largeNode).alpha = 1
      self.__largeFadeTween = (((self.ui).largeNode):DOFade(0, (ConfigData.buildinConfig).EpMapCursorFadeDuration)):OnComplete(callBack)
    end
  else
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R4 in 'UnsetPending'

    if show then
      ((self.ui).largeNode).alpha = 1
    else
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).largeNode).alpha = 0
    end
  end
  if show then
    self:ShowPlayerPosSmall(false)
  end
  self.largeIsShow = show
end

UIEpPlayerPos.__KillTween_SmallFade = function(self)
  -- function num : 0_4
  if self.__smallFadeTween ~= nil then
    (self.__smallFadeTween):Kill()
    self.__smallFadeTween = nil
  end
end

UIEpPlayerPos.__KillTween_LargeFade = function(self)
  -- function num : 0_5
  if self.__largeFadeTween ~= nil then
    (self.__largeFadeTween):Kill()
    self.__largeFadeTween = nil
  end
end

UIEpPlayerPos.PlayerPosIsShowSmall = function(self)
  -- function num : 0_6
  return self.smallIsShow
end

UIEpPlayerPos.PlayerPosIsShowLarge = function(self)
  -- function num : 0_7
  return self.largeIsShow
end

UIEpPlayerPos.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  self:__KillTween_SmallFade()
  self:__KillTween_LargeFade()
  ;
  (base.OnDelete)(self)
end

return UIEpPlayerPos


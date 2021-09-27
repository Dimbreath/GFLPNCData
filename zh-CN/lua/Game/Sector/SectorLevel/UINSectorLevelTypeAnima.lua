local UINSectorLevelTypeAnima = class("UINSectorLevelTypeAnima", UIBaseNode)
local base = UIBaseNode
UINSectorLevelTypeAnima.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.aniNameList = {"UI_SectorLevel_StageNormal", "UI_SectorLevel_StageHard", "UI_SectorLevel_StageEndless"}
  self:_StopStageAnima()
end

UINSectorLevelTypeAnima.ShowStageAnima = function(self, difficulty)
  -- function num : 0_1
  self:_InitStageUI(difficulty)
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).fade).alpha = 1
  ;
  ((self.ui).Ani_Logo):Play()
  ;
  ((self.ui).Ani_StageType):Play()
  ;
  ((self.ui).fadeTween):DOPlay()
end

UINSectorLevelTypeAnima._StopStageAnima = function(self)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).fade).alpha = 0
  ;
  ((self.ui).Ani_Logo):Stop()
  ;
  ((self.ui).Ani_StageType):Stop()
  ;
  ((self.ui).fadeTween):DORewind()
end

UINSectorLevelTypeAnima._InitStageUI = function(self, difficulty)
  -- function num : 0_3 , upvalues : _ENV
  self:_StopStageAnima()
  local diff = difficulty
  ;
  ((self.ui).tex_StageType):SetIndex(diff - 1)
  ;
  ((self.ui).tex_StageTypeEn):SetIndex(diff - 1)
  local col = ((self.ui).col_Colors)[diff]
  for index,v in ipairs((self.ui).com_SetColors) do
    v.color = col
  end
  for index,v in ipairs((self.ui).obj_Logos) do
    v:SetActive(index == diff)
  end
  local clipName = (self.aniNameList)[diff]
  local clip = ((self.ui).Ani_Logo):GetClip(clipName)
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).Ani_Logo).clip = clip
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINSectorLevelTypeAnima.Delete = function(self)
  -- function num : 0_4 , upvalues : base
  ((self.ui).fadeTween):DOKill()
  ;
  (base.OnDelete)(self)
end

return UINSectorLevelTypeAnima


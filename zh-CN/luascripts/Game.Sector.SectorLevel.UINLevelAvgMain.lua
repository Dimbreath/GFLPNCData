-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLevelAvgMain = class("UINLevelAvgMain", UIBaseNode)
local base = UIBaseNode
local verticalAnchor = (Vector2.New)(0.5, 1)
local horizontalAnchor = (Vector2.New)(0, 0.5)
local aniSelectTweenSizeDelta = (Vector2.New)(10, 10)
UINLevelAvgMain.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).rootBtn, self, self.OnClickLevelAvgMain)
end

UINLevelAvgMain.InitLAvgMain = function(self, avgCfg, arrangeCfg, clickEvent, resLoader)
  -- function num : 0_1 , upvalues : _ENV, verticalAnchor, horizontalAnchor
  self.avgCfg = avgCfg
  self.clickEvent = clickEvent
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Pic).enabled = false
  resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorLevelIcon"), function(spriteAtlas)
    -- function num : 0_1_0 , upvalues : self, avgCfg
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Pic).sprite = spriteAtlas:GetSprite(avgCfg.pic)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Pic).enabled = true
  end
)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Tile).text = (LanguageUtil.GetLocaleText)(avgCfg.name)
  ;
  ((self.ui).tex_SubTile):SetIndex(0, tostring(avgCfg.number))
  self:RefreshLAvgMainState()
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R5 in 'UnsetPending'

  if arrangeCfg.vertical then
    (self.transform).anchorMin = verticalAnchor
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self.transform).anchorMax = verticalAnchor
  else
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self.transform).anchorMin = horizontalAnchor
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self.transform).anchorMax = horizontalAnchor
  end
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.transform).anchoredPosition = (Vector2.New)((arrangeCfg.pos)[1], (arrangeCfg.pos)[2])
  self:SelectedLAvgMain(false)
end

UINLevelAvgMain.OnClickLevelAvgMain = function(self)
  -- function num : 0_2
  if self.clickEvent ~= nil then
    (self.clickEvent)(self)
  end
end

UINLevelAvgMain.SelectedLAvgMain = function(self, select)
  -- function num : 0_3 , upvalues : aniSelectTweenSizeDelta
  ((self.ui).obj_Select):SetActive(select)
  self:__ClearTween()
  if select then
    self.__selectSizeTween = ((((self.ui).ani_Select).transform):DOSizeDelta(aniSelectTweenSizeDelta, 1)):SetLoops(-1)
    self.__selectFadeTween = ((((self.ui).ani_Select):DOFade(0, 1)):SetLoops(-1)):SetDelay(0.3)
  end
end

UINLevelAvgMain.ShowRedDotLAvgMain = function(self, show)
  -- function num : 0_4
  ((self.ui).redDot):SetActive(show)
end

UINLevelAvgMain.RefreshLAvgMainState = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  self.isUnlock = avgPlayCtrl:IsAvgUnlock((self.avgCfg).id)
  ;
  ((self.ui).noEntry):SetActive(not self.isUnlock)
  ;
  ((self.ui).clearLevel):SetActive(avgPlayCtrl:IsAvgPlayed((self.avgCfg).id))
end

UINLevelAvgMain.IsLAvgMainUnlock = function(self)
  -- function num : 0_6
  return self.isUnlock
end

UINLevelAvgMain.GetLAvgMainCfg = function(self)
  -- function num : 0_7
  return self.avgCfg
end

UINLevelAvgMain.__ClearTween = function(self)
  -- function num : 0_8
  if self.__selectSizeTween ~= nil then
    (self.__selectSizeTween):Rewind()
    ;
    (self.__selectSizeTween):Kill()
    self.__selectSizeTween = nil
    ;
    (self.__selectFadeTween):Rewind()
    ;
    (self.__selectFadeTween):Kill()
    self.__selectFadeTween = nil
  end
end

UINLevelAvgMain.OnReturnLAvgMainItem = function(self)
  -- function num : 0_9
  self:__ClearTween()
end

UINLevelAvgMain.OnDelete = function(self)
  -- function num : 0_10 , upvalues : base
  self:__ClearTween()
  ;
  (base.OnDelete)(self)
end

return UINLevelAvgMain


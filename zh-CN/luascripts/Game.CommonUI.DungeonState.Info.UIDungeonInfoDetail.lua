-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDungeonInfoDetail = class("UIDungeonInfoDetail", UIBaseWindow)
local base = UIBaseWindow
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local UINDungeonInfoChipDetail = require("Game.CommonUI.DungeonState.Info.UINDungeonInfoChipDetail")
local UINDungeonInfoHeroDetail = require("Game.CommonUI.DungeonState.Info.UINDungeonInfoHeroDetail")
local UINBattleGirdInfoNode = require("Game.Battle.UI.Grid.UINBattleGirdInfoNode")
local CS_ResLoader = CS.ResLoader
UIDungeonInfoDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : CS_ResLoader, UINDungeonInfoChipDetail, UINDungeonInfoHeroDetail, UINBattleGirdInfoNode, _ENV
  self.resloader = (CS_ResLoader.Create)()
  self.chipDetailNode = (UINDungeonInfoChipDetail.New)()
  ;
  (self.chipDetailNode):Init((self.ui).obj_chipDetail)
  self.heroDetailNode = (UINDungeonInfoHeroDetail.New)()
  ;
  (self.heroDetailNode):Init((self.ui).obj_heroDetail)
  self.battleGirdInfoNode = (UINBattleGirdInfoNode.New)()
  ;
  (self.battleGirdInfoNode):Init((self.ui).battleGirdInfoNode)
  self.isShowingChipDetail = false
  self.isShowingHeroDetail = false
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Retreat, self, self.OnClickRetreat)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_background, self, self.OnClickBlank)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Left, self, self.OnClickLeftButton)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Right, self, self.OnClickRightButton)
end

UIDungeonInfoDetail.ShowChipDetail = function(self, chipDataList, index, DeselectAllItemCallBack, SelectItemCallBack)
  -- function num : 0_1 , upvalues : _ENV
  if self.isShowingHeroDetail then
    self:OnClickRetreat()
    DeselectAllItemCallBack()
    return 
  end
  ;
  (self.chipDetailNode):InitChipInfo(chipDataList, index)
  ;
  (self.chipDetailNode):Show()
  ;
  (self.battleGirdInfoNode):Hide()
  self.deselectChipCallBack = DeselectAllItemCallBack
  self.SelectChipByIndexCallBack = SelectItemCallBack
  if not self.isShowingChipDetail then
    MsgCenter:Broadcast(eMsgEventId.OnDungeonDetailWinChange, true)
  end
  self.isShowingChipDetail = true
end

UIDungeonInfoDetail.HideChipDetail = function(self)
  -- function num : 0_2
  self.isShowingChipDetail = false
  ;
  (self.chipDetailNode):Hide()
  if self.deselectChipCallBack ~= nil then
    (self.deselectChipCallBack)()
  end
end

UIDungeonInfoDetail.SwitchChip = function(self, bool)
  -- function num : 0_3
  local index = (self.chipDetailNode):SwitchChip(bool)
  ;
  (self.SelectChipByIndexCallBack)(index - 1)
end

UIDungeonInfoDetail.ShowHeroDetail = function(self, dynHeroData, deselectCallBack, switchBack)
  -- function num : 0_4 , upvalues : _ENV
  if self.isShowingChipDetail then
    self:OnClickRetreat()
    deselectCallBack()
    return 
  end
  ;
  (self.heroDetailNode):InitHeroInfo(dynHeroData, self.resloader)
  ;
  (self.heroDetailNode):Show()
  self:__ShowHeroEffctGrid(dynHeroData)
  self.deselectHeroCallBack = deselectCallBack
  self.switchHeroCallBack = switchBack
  if not self.isShowingHeroDetail then
    MsgCenter:Broadcast(eMsgEventId.OnDungeonDetailWinChange, true)
  end
  self.isShowingHeroDetail = true
end

UIDungeonInfoDetail.HideHeroDetail = function(self)
  -- function num : 0_5
  (self.heroDetailNode):Hide()
  self.isShowingHeroDetail = false
  if self.deselectHeroCallBack ~= nil then
    (self.deselectHeroCallBack)()
  end
end

UIDungeonInfoDetail.SwitchHero = function(self, bool)
  -- function num : 0_6
  (self.switchHeroCallBack)(bool)
end

UIDungeonInfoDetail.__ShowHeroEffctGrid = function(self, dynHeroData)
  -- function num : 0_7 , upvalues : _ENV
  local needShowGridInfo = false
  if ((CS.BattleManager).Instance).IsInBattle then
    local battleCtrl = ((CS.BattleManager).Instance).CurBattleController
    local effectGrid = (battleCtrl.neutralController):GetHeroEffectGrid(dynHeroData.dataId)
    if effectGrid ~= nil then
      needShowGridInfo = true
      ;
      (self.battleGirdInfoNode):InitBattleGridInfo(effectGrid.gridData)
    end
  end
  do
    if needShowGridInfo then
      (self.battleGirdInfoNode):Show()
    else
      ;
      (self.battleGirdInfoNode):Hide()
    end
  end
end

UIDungeonInfoDetail.OnClickRetreat = function(self)
  -- function num : 0_8 , upvalues : _ENV
  self:HideChipDetail()
  self:HideHeroDetail()
  self:Hide()
  MsgCenter:Broadcast(eMsgEventId.OnDungeonDetailWinChange, false)
end

UIDungeonInfoDetail.OnClickBlank = function(self)
  -- function num : 0_9
  self:OnClickRetreat()
end

UIDungeonInfoDetail.OnClickLeftButton = function(self)
  -- function num : 0_10
  if self.isShowingChipDetail then
    self:SwitchChip(false)
  end
  if self.isShowingHeroDetail then
    self:SwitchHero(false)
  end
end

UIDungeonInfoDetail.OnClickRightButton = function(self)
  -- function num : 0_11
  if self.isShowingChipDetail then
    self:SwitchChip(true)
  end
  if self.isShowingHeroDetail then
    self:SwitchHero(true)
  end
end

UIDungeonInfoDetail.OnDelete = function(self)
  -- function num : 0_12 , upvalues : base
  (self.resloader):Put2Pool()
  self.resloader = nil
  ;
  (base.OnDelete)(self)
end

return UIDungeonInfoDetail


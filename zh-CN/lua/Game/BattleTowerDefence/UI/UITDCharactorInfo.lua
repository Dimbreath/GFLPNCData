local UITDCharactorInfo = class("UITDCharactorInfo", UIBaseWindow)
local csBattleManager = CS.BattleManager
local base = UIBaseWindow
UITDCharactorInfo.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_ShowInfo, self, self.OnClickCharactorInfo)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Retreat, self, self.OnClickRetreat)
end

UITDCharactorInfo.OnShow = function(self)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.OnShow)(self)
  MsgCenter:Broadcast(eMsgEventId.TDOpenBulletTime, true)
  MsgCenter:Broadcast(eMsgEventId.TDDisplayOtherUI, false)
end

UITDCharactorInfo.InitCharactor = function(self, hero, reTreatTowerAction)
  -- function num : 0_2
  self.hero = hero
  self:TDCharactorCutdown()
  self.__reTreatTowerAction = reTreatTowerAction
end

UITDCharactorInfo.OnClickCharactorInfo = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local dungeonStateWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonStateWindow ~= nil then
    dungeonStateWindow:OnHeroCoordChanged()
    dungeonStateWindow:ShowHero((self.hero).character)
  end
end

UITDCharactorInfo.OnClickRetreat = function(self)
  -- function num : 0_4
  if self.__reTreatTowerAction ~= nil then
    (self.__reTreatTowerAction)(self.hero)
  end
  self:Hide()
end

UITDCharactorInfo.TDCharactorCutdown = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.hero == nil then
    return 
  end
  local dynPlayer = (BattleUtil.GetCurDynPlayer)()
  if dynPlayer == nil then
    return 
  end
  local returnEnergy = (ConfigData.game_config).towerMoneyMax - dynPlayer:GetMoneyCount()
  returnEnergy = (math.min)(returnEnergy, (self.hero):GetTDTowerLoadOffReturnEnergy())
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Token).text = tostring(returnEnergy)
end

UITDCharactorInfo.OnHide = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.OnHide)(self)
  self.hero = nil
  MsgCenter:Broadcast(eMsgEventId.TDCloseBulletTime)
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  MsgCenter:Broadcast(eMsgEventId.TDDisplayOtherUI, true)
end

return UITDCharactorInfo


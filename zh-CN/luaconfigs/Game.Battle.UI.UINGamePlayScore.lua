-- params : ...
-- function num : 0 , upvalues : _ENV
local UINGamePlayScore = class("UINGamePlayScore", UIBaseNode)
local base = UIBaseNode
local GamePlayScoreType = {Number = 1, Timer = 2, Collect = 3}
UINGamePlayScore.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, GamePlayScoreType
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.listScoreNode = {}
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.listScoreNode)[GamePlayScoreType.Number] = (self.ui).damageNode
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.listScoreNode)[GamePlayScoreType.Timer] = (self.ui).timerNode
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.listScoreNode)[GamePlayScoreType.Collect] = (self.ui).collect
  self.listScoreFunc = {}
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.listScoreFunc)[GamePlayScoreType.Number] = self.__BattleScoreNumber
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.listScoreFunc)[GamePlayScoreType.Timer] = self.__BattleScoreTimer
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.listScoreFunc)[GamePlayScoreType.Collect] = self.__BattleCollect
  self.listInitFunc = {}
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.listInitFunc)[GamePlayScoreType.Collect] = self.__InitShowCollect
  self.__ChangeBattleScoreActive = BindCallback(self, self.ChangeBattleScoreActive)
  self.__ChangeBattleScoreValue = BindCallback(self, self.ChangeBattleScoreValue)
  MsgCenter:AddListener(eMsgEventId.ChangeBattleScoreActive, self.__ChangeBattleScoreActive)
  MsgCenter:AddListener(eMsgEventId.ChangeBattleScoreValue, self.__ChangeBattleScoreValue)
end

UINGamePlayScore.ChangeBattleScoreActive = function(self, nodeId, active)
  -- function num : 0_1 , upvalues : _ENV
  local node = (self.listScoreNode)[nodeId]
  if node == nil then
    error("not game play score id:" .. tostring(nodeId))
    return 
  end
  if not active then
    active = false
  end
  node:SetActive(active)
  local initFunc = (self.listInitFunc)[nodeId]
  if initFunc ~= nil then
    initFunc(self)
  end
end

UINGamePlayScore.ChangeBattleScoreValue = function(self, nodeId, value)
  -- function num : 0_2 , upvalues : _ENV
  local func = (self.listScoreFunc)[nodeId]
  if func == nil then
    error("not game play score id:" .. tostring(nodeId))
    return 
  end
  if not value then
    value = 0
  end
  func(self, value)
end

UINGamePlayScore.__BattleScoreNumber = function(self, value)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_Damage).text = tostring(value)
end

UINGamePlayScore.__BattleScoreTimer = function(self, value)
  -- function num : 0_4 , upvalues : _ENV
  local min = (math.floor)(value / 60)
  local sec = (math.floor)(value % 60)
  local text = (string.format)("%d:%d", min, sec)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Timer).text = tostring(value)
end

UINGamePlayScore.__BattleCollect = function(self, value)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_CollectNum).text = tostring(FormatNum(value / 10)) .. "%"
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_CollectBar).fillAmount = value / 1000
end

UINGamePlayScore.__InitShowCollect = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local bdCtrl = BattleDungeonManager:GetDungeonCtrl()
  if bdCtrl == nil then
    return 
  end
  local dungeonStageCfg = (ConfigData.battle_dungeon)[bdCtrl.dungeonId]
  local play_para, wave_battlesCfg, curWaveCfg = nil, nil, nil
  if dungeonStageCfg ~= nil then
    play_para = dungeonStageCfg.play_para
  end
  if play_para ~= nil then
    wave_battlesCfg = (ConfigData.wave_battles)[play_para]
  end
  if wave_battlesCfg ~= nil then
    curWaveCfg = wave_battlesCfg[((bdCtrl.sceneCtrl).sceneWave).cur]
  end
  if curWaveCfg == nil then
    return 
  end
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_CollectName).text = (LanguageUtil.GetLocaleText)(curWaveCfg.bar_text)
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_CollectIcon).sprite = CRH:GetSprite(curWaveCfg.bar_icon)
end

UINGamePlayScore.OnDelete = function(self)
  -- function num : 0_7 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.ChangeBattleScoreActive, self.__ChangeBattleScoreActive)
  MsgCenter:RemoveListener(eMsgEventId.ChangeBattleScoreValue, self.__ChangeBattleScoreValue)
  ;
  (base.OnDelete)(self)
end

return UINGamePlayScore


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINBattleResultWeekly = class("UINBattleResultWeekly", UIBaseNode)
local base = UIBaseNode
local UINMonsterLevel = require("Game.Exploration.UI.MonsterLevel.UINMonsterLevel")
UINBattleResultWeekly.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINMonsterLevel
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.monsterLevelNode = (UINMonsterLevel.New)()
  ;
  (self.monsterLevelNode):Init((self.ui).monsterLevel)
  ;
  (((self.ui).btn_CCInterstInfo).onPress):AddListener(BindCallback(self, self.__OnCCInterestPress))
  ;
  (((self.ui).btn_CCInterstInfo).onPressUp):AddListener(BindCallback(self, self.__OnCCInterestOnPressUp))
end

UINBattleResultWeekly.InitBattleResultWeekly = function(self, roomMoneyNum)
  -- function num : 0_1 , upvalues : _ENV
  local dynPlayer = ExplorationManager:GetDynPlayer()
  local allAddCC = dynPlayer:GetEpMoneyLastAddNum()
  ;
  (((self.ui).obj_DetailList)[1]):SetActive(roomMoneyNum > 0)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (((self.ui).tex_DetailList)[1]).text = tostring(roomMoneyNum)
  local interestAdd = allAddCC - roomMoneyNum
  if interestAdd <= 0 then
    interestAdd = (math.floor)(dynPlayer:GetMoneyCount() * ((ConfigData.game_config).intrerestConstNum)[1] / 1000)
    if ((ConfigData.game_config).intrerestConstNum)[2] < interestAdd then
      interestAdd = ((ConfigData.game_config).intrerestConstNum)[2]
    end
  end
  ;
  (((self.ui).obj_DetailList)[2]):SetActive(interestAdd > 0)
  -- DECOMPILER ERROR at PC61: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.ui).tex_DetailList)[2]).text = tostring(interestAdd)
  local lastStoreAddExp = ((ExplorationManager.epCtrl).residentStoreCtrl):GetResidentStoreLastAddExp()
  ;
  (((self.ui).obj_DetailList)[3]):SetActive(lastStoreAddExp > 0)
  -- DECOMPILER ERROR at PC82: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (((self.ui).tex_DetailList)[3]).text = tostring(lastStoreAddExp)
  local lastMonsterExpAdd = dynPlayer:GetEpMonsterLevelLastExpAdd()
  ;
  (((self.ui).obj_DetailList)[4]):SetActive(lastMonsterExpAdd > 0)
  -- DECOMPILER ERROR at PC100: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (((self.ui).tex_DetailList)[4]).text = tostring(lastMonsterExpAdd)
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

UINBattleResultWeekly.__OnCCInterestPress = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  win:SetTitleAndContext(nil, ConfigData:GetTipContent(TipContent.WCCCInterst))
  win:FloatTo((((self.ui).obj_DetailList)[2]).transform, (FloatAlignEnum.HAType).left, (FloatAlignEnum.VAType).up, nil, nil, UIManager:GetMainCamera())
end

UINBattleResultWeekly.__OnCCInterestOnPressUp = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

UINBattleResultWeekly.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINBattleResultWeekly


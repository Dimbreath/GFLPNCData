-- params : ...
-- function num : 0 , upvalues : _ENV
local UINMonsterLevel = class("UINMonsterLevel", UIBaseNode)
local UINMonsterLevelPreview = require("Game.Exploration.UI.MonsterLevel.UINMonsterLevelPreview")
UINMonsterLevel.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINMonsterLevelPreview
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_MstPreview, self, self.OpenMonsterLevelPreview)
  self.__everygridsize = (((self.ui).img_Count).sizeDelta).x
  local maxSizeDelta = ((self.ui).img_TotalCount).sizeDelta
  self.__gridHeight = maxSizeDelta.y
  self.__maxExpWidth = maxSizeDelta.x
  self.UINMonsterLevelDataPreview = (UINMonsterLevelPreview.New)()
  ;
  (self.UINMonsterLevelDataPreview):Init((self.ui).logicPreviewNode)
  ;
  (self.UINMonsterLevelDataPreview):Hide()
end

UINMonsterLevel.InitMonsterLevelUI = function(self, dynPlayer)
  -- function num : 0_1 , upvalues : _ENV
  if dynPlayer.epCommonData == nil or (dynPlayer.epCommonData).monster == nil then
    return 
  end
  local monsterData = (dynPlayer.epCommonData).monster
  self:Show()
  self:UpdateMonsterLevelByData(monsterData)
  self.__UpdateMonsterLevelByData = BindCallback(self, self.UpdateMonsterLevelByData)
  MsgCenter:AddListener(eMsgEventId.UpdateEpMonsterLevel, self.__UpdateMonsterLevelByData)
end

UINMonsterLevel.UpdateMonsterLevelByData = function(self, monsterLevelData)
  -- function num : 0_2
  self:UpdateMonsterLevelUI(monsterLevelData.lv, monsterLevelData.exp)
end

UINMonsterLevel.UpdateMonsterLevelUI = function(self, level, exp)
  -- function num : 0_3 , upvalues : _ENV
  local monsterLevelCfg = (ConfigData.monster_level)[level]
  if monsterLevelCfg == nil then
    error("monster level cfg is null,level:" .. tostring(level))
    return 
  end
  local exp = exp - monsterLevelCfg.exp
  if self.__lastLevel ~= level then
    self.__lastLevel = level
    self:__UpdateMonsterLevel(level, monsterLevelCfg)
  end
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Count).sizeDelta = (Vector2.New)(self.__everygridsize * exp, self.__gridHeight)
end

UINMonsterLevel.__UpdateMonsterLevel = function(self, level, monsterLevelCfg)
  -- function num : 0_4 , upvalues : _ENV
  local isFullLevel = (ConfigData.monster_level).monster_level_max <= level
  ;
  (((self.ui).tex_Max).gameObject):SetActive(isFullLevel)
  ;
  ((self.ui).levelNode):SetActive(not isFullLevel)
  local sign = ""
  if monsterLevelCfg.hp_amplify > 0 then
    sign = "+"
  end
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Num1).text = sign .. GetPreciseDecimalStr(monsterLevelCfg.hp_amplify / 10, 1) .. "%"
  sign = ""
  if monsterLevelCfg.pow_amplify > 0 then
    sign = "+"
  end
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Num2).text = sign .. GetPreciseDecimalStr(monsterLevelCfg.pow_amplify / 10, 1) .. "%"
  -- DECOMPILER ERROR at PC55: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_MonsterLv).text = tostring(level)
  do
    if not isFullLevel then
      local scale = self.__maxExpWidth / (self.__everygridsize * monsterLevelCfg.levelexp)
      -- DECOMPILER ERROR at PC71: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).img_TotalCount).localScale = (Vector3.New)(scale, 1, 1)
      -- DECOMPILER ERROR at PC81: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).img_TotalCount).sizeDelta = (Vector2.New)(self.__everygridsize * monsterLevelCfg.levelexp, self.__gridHeight)
    end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

UINMonsterLevel.OpenMonsterLevelPreview = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.UINMonsterLevelDataPreview ~= nil then
    if self._onLevelPreviewClose == nil then
      self._onLevelPreviewClose = BindCallback(self, self.SetDungeonStateInfoBuffListActive, true)
    end
    ;
    (self.UINMonsterLevelDataPreview):Show()
    ;
    (self.UINMonsterLevelDataPreview):InitMonsterLevelPreview(self.__lastLevel, self._onLevelPreviewClose)
    self:SetDungeonStateInfoBuffListActive(false)
  end
end

UINMonsterLevel.SetDungeonStateInfoBuffListActive = function(self, Active)
  -- function num : 0_6 , upvalues : _ENV
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, Active)
end

UINMonsterLevel.OnDelete = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self.__UpdateMonsterLevelByData ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.UpdateEpMonsterLevel, self.__UpdateMonsterLevelByData)
  end
  if self.UINMonsterLevelDataPreview ~= nil then
    (self.UINMonsterLevelDataPreview):Delete()
    self.UINMonsterLevelDataPreview = nil
  end
end

return UINMonsterLevel


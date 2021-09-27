local UIBattleEnemyDetail = class("UIBattleEnemyDetail", UIBaseWindow)
local base = UIBaseWindow
local UINEnemySkillItem = require("Game.Battle.UI.UINEnemySkillItem")
local UINEnemyTagItem = require("Game.Battle.UI.UINEnemyTagItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local UINBattleGirdInfoNode = require("Game.Battle.UI.Grid.UINBattleGirdInfoNode")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local CS_ResLoader = CS.ResLoader
local cs_Edge = ((CS.UnityEngine).RectTransform).Edge
UIBattleEnemyDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : UINBattleGirdInfoNode, _ENV, UINEnemySkillItem, UINEnemyTagItem
  self.battleGirdInfoNode = (UINBattleGirdInfoNode.New)()
  ;
  (self.battleGirdInfoNode):Init((self.ui).battleGirdInfoNode)
  ;
  ((self.ui).skillIntroItem):SetActive(false)
  self.skillItemPool = (UIItemPool.New)(UINEnemySkillItem, (self.ui).skillIntroItem)
  ;
  ((self.ui).obj_tag):SetActive(false)
  self.tagItemPool = (UIItemPool.New)(UINEnemyTagItem, (self.ui).obj_tag)
  self.__onShowSkillDetail = BindCallback(self, self.__ShowSkillDetail)
  self.__OnChipDetailActiveChange = BindCallback(self, self.OnChipDetailActiveChange)
  MsgCenter:AddListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  self.resloader = ((CS.ResLoader).Create)()
end

UIBattleEnemyDetail.InitBattleEnemyDetail = function(self, dynRole, isNew)
  -- function num : 0_1 , upvalues : _ENV
  if isNew then
    ((self.ui).obj_isNew):SetActive(true)
  else
    ;
    ((self.ui).obj_isNew):SetActive(false)
  end
  AudioManager:PlayAudioById(1079)
  self.dynRole = dynRole
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = dynRole:GetName()
  local careerId = dynRole:GetCareer()
  local careerCfg = (ConfigData.career)[careerId]
  if careerCfg == nil then
    error("Can\'t find careerCfg, campId = " .. tostring(careerId))
  else
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).img_Career).sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
  end
  local path = PathConsts:GetCharacterSmallPicPath(dynRole:GetResPicName())
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_EnemyPic).enabled = false
  ;
  (self.resloader):LoadABAssetAsync(path, function(texture)
    -- function num : 0_1_0 , upvalues : _ENV, self
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

    if texture ~= nil and not IsNull(self.gameObject) then
      ((self.ui).img_EnemyPic).enabled = true
      -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((self.ui).img_EnemyPic).texture = texture
    end
  end
)
  if not dynRole.isShowInfoBar then
    ((self.ui).obj_power):SetActive(false)
  else
    ;
    ((self.ui).obj_power):SetActive(true)
    -- DECOMPILER ERROR at PC80: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_Power).text = tostring(dynRole:GetFightingPower())
  end
  -- DECOMPILER ERROR at PC85: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Content).text = dynRole:GetMonsterInfo()
  ;
  (self.skillItemPool):HideAll()
  local originSkiilList = dynRole:GetOriginSkillList()
  for k,skillData in pairs(originSkiilList) do
    if not skillData:IsCommonAttack() then
      local skillItem = (self.skillItemPool):GetOne()
      skillItem:InitEnemySkillIntroItem(skillData, self.__onShowSkillDetail)
    end
  end
  if #(self.skillItemPool).listItem > 0 then
    ((self.ui).obj_skills):SetActive(true)
  else
    ;
    ((self.ui).obj_skills):SetActive(false)
  end
  ;
  (self.tagItemPool):HideAll()
  local monsterTag, isCS = (self.dynRole):GetRoleTag()
  local tagEnd = nil
  local tagStart = 1
  if isCS then
    tagStart = 0
    tagEnd = monsterTag.Count - 1
  else
    tagEnd = #monsterTag
  end
  for i = tagStart, tagEnd do
    local tagId = monsterTag[i]
    if tagId ~= nil then
      local tagCfg = (ConfigData.monster_tag)[tagId]
      if tagCfg == nil then
        error("Can\'t find tagCfg id=" .. tagId)
      else
        local item = (self.tagItemPool):GetOne()
        item:InitEnemyTagItem((LanguageUtil.GetLocaleText)(tagCfg.tag))
      end
    end
  end
  self:__ShowEnemyEffctGrid(dynRole.x, dynRole.y)
  UIManager:HideWindow(UIWindowTypeID.RichIntro)
  self.selSkillData = nil
end

UIBattleEnemyDetail.__ShowSkillDetail = function(self, skillData)
  -- function num : 0_2 , upvalues : _ENV
  if self.selSkillData == skillData then
    return 
  end
  self.selSkillData = skillData
  self.__onSkillIntroWindowOpen = BindCallback(self, self.SkillIntroWindowOpen, skillData)
  UIManager:ShowWindowAsync(UIWindowTypeID.RichIntro, function(win)
    -- function num : 0_2_0 , upvalues : self
    if win ~= nil then
      (self.__onSkillIntroWindowOpen)(win)
    end
  end
)
end

UIBattleEnemyDetail.SkillIntroWindowOpen = function(self, skillData, win)
  -- function num : 0_3 , upvalues : cs_Edge
  win:ShowIntroBySkillData((self.ui).introHolder, skillData, nil, true, (self.ui).modifier, false, true)
  win:SetIntroListPosition(cs_Edge.Left, cs_Edge.Top)
end

UIBattleEnemyDetail.__ShowEnemyEffctGrid = function(self, x, y)
  -- function num : 0_4 , upvalues : _ENV
  local needShowGridInfo = false
  if ((CS.BattleManager).Instance).IsInBattle then
    local battleCtrl = ((CS.BattleManager).Instance).CurBattleController
    local effectGrid = (battleCtrl.EfcGridController):GetEffectGrid(x, y)
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

UIBattleEnemyDetail.OnChipDetailActiveChange = function(self, active)
  -- function num : 0_5
  if active and self.active then
    self:Hide()
    self._changeHide = true
    return 
  end
  if self._changeHide then
    self:Show()
    self._changeHide = false
  end
end

UIBattleEnemyDetail.OnDelete = function(self)
  -- function num : 0_6 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  UIManager:HideWindow(UIWindowTypeID.RichIntro)
  self.selSkillData = nil
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  ;
  (self.skillItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UIBattleEnemyDetail


local UINBtnCommanderSkill = class("UINBtnCommanderSkill", UIBaseNode)
local base = UIBaseNode
local UINCommanderSkill = require("Game.Formation.UI.UINCommanderSkill")
local CommanderSkillTreeData = require("Game.CommanderSkill.CommanderSkillTreeData")
UINBtnCommanderSkill.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINCommanderSkill
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CommanderSkill, self, self.OnClickItem)
  ;
  ((self.ui).skillItem):SetActive(false)
  self.itemPool = (UIItemPool.New)(UINCommanderSkill, (self.ui).skillItem)
  ;
  ((self.ui).redDot):SetActive(false)
end

UINBtnCommanderSkill.InitBtnCommanderSkill = function(self, resloader, clickFunc)
  -- function num : 0_1
  self.resloader = resloader
  self.clickFunc = clickFunc
end

UINBtnCommanderSkill.RefreshCstByTreeInfo = function(self, cstTreeData)
  -- function num : 0_2
  self.cstTreeData = cstTreeData
  self.treeId = cstTreeData.treeId
  self.skills = cstTreeData:GetUsingCmdSkillList()
  self.isFixed = false
  self:__RefreshCstBtnUI()
end

UINBtnCommanderSkill.RefreshCstByIdAndList = function(self, treeId, skills, isFixed)
  -- function num : 0_3 , upvalues : CommanderSkillTreeData
  do
    if not isFixed and treeId ~= 0 then
      local fmtCSTData = (CommanderSkillTreeData.New)(treeId)
      fmtCSTData:ApplySavingData(skills)
      self.cstTreeData = fmtCSTData
    end
    self.treeId = treeId
    self.skills = skills
    self.isFixed = isFixed
    self:__RefreshCstBtnUI()
  end
end

UINBtnCommanderSkill.__RefreshCstBtnUI = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local treeCfg = (ConfigData.commander_skill)[self.treeId]
  if treeCfg == nil or self.isFixed then
    (((self.ui).img_ComSkillIcon).gameObject):SetActive(false)
    ;
    ((self.ui).tex_ComSkillName):SetIndex(1)
  else
    local treeName = (LanguageUtil.GetLocaleText)(treeCfg.name)
    ;
    ((self.ui).tex_ComSkillName):SetIndex(0, treeName)
    ;
    (((self.ui).img_ComSkillIcon).gameObject):SetActive(false)
    ;
    (self.resloader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommanderSkillIcons"), function(spriteAtlas)
    -- function num : 0_4_0 , upvalues : self, treeCfg
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_ComSkillIcon).sprite = spriteAtlas:GetSprite(treeCfg.icon)
    ;
    (((self.ui).img_ComSkillIcon).gameObject):SetActive(true)
  end
)
  end
  do
    ;
    (self.itemPool):HideAll()
    local cstUnlockCfg = (ConfigData.commander_skill_unlock)[self.treeId or 0]
    if cstUnlockCfg ~= nil then
      (table.sort)(self.skills, function(a, b)
    -- function num : 0_4_1 , upvalues : cstUnlockCfg
    local aCfg = cstUnlockCfg[a]
    local bCfg = cstUnlockCfg[b]
    if aCfg == nil or bCfg == nil then
      return true
    end
    if aCfg.place >= bCfg.place then
      do return aCfg.place == bCfg.place end
      do return a < b end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
)
    end
    if self.skills ~= nil and #self.skills > 0 then
      for index,skillId in ipairs(self.skills) do
        local item = (self.itemPool):GetOne()
        -- DECOMPILER ERROR at PC80: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (item.gameObject).name = tostring(index)
        item:InitCommanderSkill(skillId, self.resloader)
      end
    end
    do
      if not self.isFixed then
        local hasOverloadSkill2Install = (self.cstTreeData):CSTHasOverloadSkill2Install()
        ;
        ((self.ui).redDot):SetActive(hasOverloadSkill2Install)
      end
    end
  end
end

UINBtnCommanderSkill.GetCmderSkillItemByIndex = function(self, index)
  -- function num : 0_5
  return ((self.itemPool).listItem)[index]
end

UINBtnCommanderSkill.SetCmderRootRaycastActive = function(self, active)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).cg_CmderSkill).blocksRaycasts = active
end

UINBtnCommanderSkill.OnClickItem = function(self)
  -- function num : 0_7
  if self.clickFunc ~= nil then
    (self.clickFunc)(self.cstTreeData)
  end
end

return UINBtnCommanderSkill


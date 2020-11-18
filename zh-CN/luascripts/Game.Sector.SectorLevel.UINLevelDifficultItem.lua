-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLevelDifficultItem = class("UINLevelDifficultItem", UIBaseNode)
local base = UIBaseNode
local eDifficulty = (require("Game.Sector.Enum.SectorLevelDetailEnum")).eDifficulty
local eDifficultyName = (require("Game.Sector.Enum.SectorLevelDetailEnum")).eDifficultyName
UINLevelDifficultItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).rootBtn, self, self.__OnClickRootBtn)
end

UINLevelDifficultItem.InitLevelDiffItem = function(self, sectorId, difficulty, clickEvent)
  -- function num : 0_1
  self.clickEvent = clickEvent
  self:RefreshLevelDiffItem(sectorId, difficulty)
end

UINLevelDifficultItem.RefreshLevelDiffItem = function(self, sectorId, difficulty)
  -- function num : 0_2 , upvalues : eDifficultyName, eDifficulty, _ENV
  self.difficulty = difficulty
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.gameObject).name = "DiffBtn_" .. eDifficultyName[difficulty]
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  if difficulty == eDifficulty.normal then
    ((self.ui).tex_Diffi).color = Color.black
  else
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Diffi).color = Color.white
  end
  ;
  ((self.ui).texInfo_Diffi):SetIndex(difficulty - 1)
  ;
  ((self.ui).img_Diffi):SetIndex(difficulty - 1)
  if difficulty == (ConfigData.sector_stage).difficultyCount + 1 then
    (((self.ui).tex_LevelCount).gameObject):SetActive(false)
    return 
  end
  local sectorTotalCount = (((ConfigData.sector_stage).sectorTotalCountDic)[sectorId])[difficulty]
  local sectorLevelList = (((ConfigData.sector_stage).sectorDiffDic)[sectorId])[difficulty]
  local passCount = 0
  for index,sectorId in ipairs(sectorLevelList) do
    if (PlayerDataCenter.sectorStage):IsStageComplete(sectorId) then
      passCount = passCount + 1
    end
  end
  ;
  (((self.ui).tex_LevelCount).gameObject):SetActive(true)
  ;
  ((self.ui).tex_LevelCount):SetIndex(0, tostring(passCount), tostring(sectorTotalCount))
end

UINLevelDifficultItem.__OnClickRootBtn = function(self)
  -- function num : 0_3
  if self.clickEvent ~= nil then
    (self.clickEvent)(self.difficulty)
  end
end

UINLevelDifficultItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINLevelDifficultItem


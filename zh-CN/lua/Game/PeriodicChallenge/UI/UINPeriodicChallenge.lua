local UINPeriodicChallenge = class("UINPeriodicChallenge", UIBaseNode)
local base = UIBaseNode
local UINPeriodicInfoItem = require("Game.PeriodicChallenge.UI.UINPeriodicInfoItem")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
UINPeriodicChallenge.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_node, self, self.OnClickDetail)
end

UINPeriodicChallenge.InitPeriodicItem = function(self, id, eChallenge, parentNode)
  -- function num : 0_1 , upvalues : SectorLevelDetailEnum
  self.detailType = (SectorLevelDetailEnum.eDetailType).PeriodicChallenge
  self.dungeonId = id
  self.eChallenge = eChallenge
  self.parentNode = parentNode
  self.isSelected = false
end

UINPeriodicChallenge.InitWeeklyItem = function(self, id, parentNode)
  -- function num : 0_2 , upvalues : SectorLevelDetailEnum
  self.detailType = (SectorLevelDetailEnum.eDetailType).WeeklyChallenge
  self.dungeonId = id
  self.parentNode = parentNode
  self.isSelected = false
end

UINPeriodicChallenge.OnClickDetail = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local has, dungeonId, moduleId = ExplorationManager:HasUncompletedEp()
  if has and self.dungeonId ~= dungeonId and (moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration) then
    ExplorationManager:TryToShowCurrentLevelTips()
    return 
  end
  if (self.parentNode).selectedItem == self then
    return 
  end
  ;
  (self.parentNode):OnClickItemCallback(self, true)
end

UINPeriodicChallenge.SetSelectState = function(self, flag)
  -- function num : 0_4 , upvalues : _ENV
  ((self.ui).img_Select):SetActive(flag)
  self.isSelected = flag
  if flag then
    ((self.ui).wave):DOPlayForward()
    AudioManager:PlayAudioById(1107)
  else
    ;
    ((self.ui).wave):DOPlayBackwards()
    AudioManager:PlayAudioById(1108)
  end
end

return UINPeriodicChallenge


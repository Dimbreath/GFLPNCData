-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBuildingQueueItem = class("UIBuildingQueueItem", UIBaseNode)
local base = UIBaseNode
UIBuildingQueueItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.OnFinishEvent = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Finish, self, self.OnClickFinishButton)
end

UIBuildingQueueItem.UpdateQueueProgress = function(self, buitData, sectorName)
  -- function num : 0_1 , upvalues : _ENV
  self.builtData = buitData
  local name = buitData.name
  if sectorName == nil then
    ((self.ui).tex_BuildInfo):SetIndex(0, name)
  else
    ;
    ((self.ui).tex_BuildInfo):SetIndex(1, (LanguageUtil.GetLocaleText)(sectorName), name)
  end
  local progress = buitData.progress
  self:__SwitchUI(progress ~= 1)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Fill).fillAmount = progress
  ;
  ((self.ui).tex_Time):SetIndex(0, TimestampToTime(buitData.remainSecond))
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIBuildingQueueItem.__SwitchUI = function(self, inUpgrading)
  -- function num : 0_2
  (((self.ui).btn_Finish).gameObject):SetActive(not inUpgrading)
  ;
  (((self.ui).tex_Time).gameObject):SetActive(inUpgrading)
  ;
  ((self.ui).tex_Sdate):SetActive(inUpgrading)
end

UIBuildingQueueItem.OnClickFinishButton = function(self)
  -- function num : 0_3
  if self.OnFinishEvent ~= nil then
    (self.OnFinishEvent)((self.builtData).id)
  end
end

UIBuildingQueueItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UIBuildingQueueItem


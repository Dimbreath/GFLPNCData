-- params : ...
-- function num : 0 , upvalues : _ENV
local UISectorTask = class("UISectorTask", UIBaseWindow)
local base = UIBaseWindow
local UINSectorTaskItem = require("Game.Sector.SectorTask.UINSectorTaskItem")
local UINSectorTaskAchiveItem = require("Game.Sector.SectorTask.UINSectorTaskAchiveItem")
local UInSectorTaskRewardFloat = require("Game.Sector.SectorTask.UInSectorTaskRewardFloat")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
UISectorTask.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UInSectorTaskRewardFloat, UINSectorTaskAchiveItem
  self.curSectorId = nil
  self.sectorTaskDatas = nil
  self.itemDic = {}
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_taskScroll).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_taskScroll).onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.viewReward = (UInSectorTaskRewardFloat.New)()
  ;
  (self.viewReward):Init((self.ui).viewReward)
  self.SectorTaskController = ControllerManager:GetController(ControllerTypeId.SectorTaskCtrl, true)
  self.achivParentWidth = (((self.ui).achivParent).rect).width
  ;
  (UIUtil.SetTopStatus)(self, self.__OnClickReturn)
  self.rewardItemPool = (UIItemPool.New)(UINSectorTaskAchiveItem, (self.ui).obj_rewardItem)
  ;
  ((self.ui).obj_rewardItem):SetActive(false)
  self.__refillTaskList = BindCallback(self, self.__RefillTaskList)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__refillTaskList)
  MsgCenter:AddListener(eMsgEventId.TaskDelete, self.__refillTaskList)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__refillTaskList)
  self.__refreshSectorAchivUI = BindCallback(self, self.__RefreshSectorAchivUI)
  MsgCenter:AddListener(eMsgEventId.SectorPickReward, self.__refreshSectorAchivUI)
  self.__onItemUpdate = BindCallback(self, self.__OnItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemUpdate)
  self.__showAchivRewardsFloatWin = BindCallback(self, self.__ShowAchivRewardsFloatWin)
end

UISectorTask.InitSectorTask = function(self, curSectorId, closeCallback)
  -- function num : 0_1
  self.curSectorId = curSectorId
  self.closeCallback = closeCallback
  self.initTween = true
  self:__RefreshAchivTaskUI()
  self:__RefreshSectorAchivUI()
end

UISectorTask.__RefreshAchivTaskUI = function(self)
  -- function num : 0_2
  self.sectorTaskDatas = (self.SectorTaskController):GetSectorTaskDatas(self.curSectorId)
  local num = #self.sectorTaskDatas
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).loop_taskScroll).totalCount = num
  ;
  ((self.ui).loop_taskScroll):RefreshCells()
end

UISectorTask.__OnNewItem = function(self, go)
  -- function num : 0_3 , upvalues : UINSectorTaskItem
  local taskItem = (UINSectorTaskItem.New)()
  taskItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.itemDic)[go] = taskItem
end

UISectorTask.__OnChangeItem = function(self, go, index)
  -- function num : 0_4 , upvalues : _ENV
  local taskItem = (self.itemDic)[go]
  if taskItem == nil then
    error("Can\'t find goodItem by gameObject")
    return 
  end
  local taskData = (self.sectorTaskDatas)[index + 1]
  taskItem:RefreshSectorTaskItem(taskData)
end

UISectorTask.__RefillTaskList = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local oldNum = (table.count)(self.sectorTaskDatas)
  self.sectorTaskDatas = (self.SectorTaskController):GetSectorTaskDatas(self.curSectorId)
  local num = #self.sectorTaskDatas
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

  if oldNum <= num then
    ((self.ui).loop_taskScroll).totalCount = num
    ;
    ((self.ui).loop_taskScroll):RefillCells()
  else
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).loop_taskScroll).totalCount = num
    ;
    ((self.ui).loop_taskScroll):RefreshCells()
  end
end

UISectorTask.__RefreshSectorAchivUI = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local starId, starCount, starTotalCount = (self.SectorTaskController):GetSectorAchievementScore(self.curSectorId)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  if starCount <= 9 then
    ((self.ui).tex_Trim).text = "0"
  else
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_Trim).text = ""
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Point).text = tostring(starCount)
  local fillAmount = starCount / starTotalCount
  if not self.initTween then
    ((self.ui).img_Process):DOKill(true)
    ;
    ((self.ui).img_Process):DOFillAmount(fillAmount, 0.35)
  else
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).img_Process).fillAmount = fillAmount
    self.initTween = false
  end
  ;
  (self.rewardItemPool):HideAll()
  local sectorAchivDatas = (self.SectorTaskController):GetSectorAchievementDatas(self.curSectorId)
  for _,achivData in ipairs(sectorAchivDatas) do
    local item = (self.rewardItemPool):GetOne()
    item:InitSectorTaskAchiveItem(self.curSectorId, achivData, self.__showAchivRewardsFloatWin)
    local starNum = ((achivData.achiveCfg).conditionNums)[1]
    -- DECOMPILER ERROR at PC70: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (item.transform).localPosition = (Vector3.New)(starNum / starTotalCount * self.achivParentWidth, 0, 0)
  end
end

UISectorTask.__OnItemUpdate = function(self, itemIdList)
  -- function num : 0_7 , upvalues : _ENV
  local sectorAchieveCfgs = (ConfigData.sectorAchievement)[self.curSectorId]
  local starId = ((sectorAchieveCfgs[1]).conditionIds)[1]
  if itemIdList[starId] == nil then
    return 
  end
  ;
  (PlayerDataCenter.sectorAchievementDatas):UpdateSectorAchivRedDot(self.curSectorId)
  self:__RefreshSectorAchivUI()
end

UISectorTask.__ShowAchivRewardsFloatWin = function(self, rewardItem, achivRewardIds, achivRewardNums)
  -- function num : 0_8 , upvalues : HAType, VAType, _ENV
  (self.viewReward):FloatTo(rewardItem.transform, HAType.autoCenter, VAType.up)
  ;
  (self.viewReward):RefreshItems(achivRewardIds, achivRewardNums)
  ;
  (self.viewReward):Show()
  AudioManager:PlayAudioById(1055)
end

UISectorTask.__OnClickReturn = function(self)
  -- function num : 0_9
  if self.closeCallback ~= nil then
    (self.closeCallback)()
  end
  self:Delete()
end

UISectorTask.OnDelete = function(self)
  -- function num : 0_10 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__refillTaskList)
  MsgCenter:RemoveListener(eMsgEventId.TaskDelete, self.__refillTaskList)
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__refillTaskList)
  MsgCenter:RemoveListener(eMsgEventId.SectorPickReward, self.__refreshSectorAchivUI)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemUpdate)
  ;
  (base.OnDelete)(self)
end

return UISectorTask


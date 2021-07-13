-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHeroTask = class("UIHeroTask", UIBaseWindow)
local base = UIBaseWindow
local UINHeroTaskItem = require("Game.Hero.NewUI.HeroTask.UINHeroTaskItem")
local TaskData = require("Game.Task.Data.TaskData")
local TaskEnum = require("Game.Task.TaskEnum")
local cs_ResLoader = CS.ResLoader
UIHeroTask.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.itemDic = {}
  self.heroTaskDataDic = {}
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_scroll).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_scroll).onChangeItem = BindCallback(self, self.__OnChangeItem)
  ;
  (UIUtil.AddButtonListenerWithArg)((self.ui).btn_background, self, UIUtil.OnClickBack)
  ;
  (UIUtil.AddButtonListenerWithArg)((self.ui).btn_Close, self, UIUtil.OnClickBack)
  ;
  (UIUtil.SetTopStatus)(self, self.__OnClickReturn)
  ;
  (UIUtil.HideTopStatus)()
  self._b__RefreshHeroTask = BindCallback(self, self.__RefreshHeroTask)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self._b__RefreshHeroTask)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self._b__RefreshHeroTask)
end

UIHeroTask.InitHeroTask = function(self, heroData, resloader, bigImgResloader, closeCallback)
  -- function num : 0_1 , upvalues : _ENV
  self.closeCallback = closeCallback
  if heroData == nil then
    error("heroData is nill")
    return 
  end
  self.heroData = heroData
  self.heroTaskIds = (self.heroData):GetHeroTaskIds()
  self:__RefreshHeroInfoUI(resloader, bigImgResloader)
  self:__RefreshHeroTask()
end

UIHeroTask.__RefreshHeroInfoUI = function(self, resloader, bigImgResloader)
  -- function num : 0_2 , upvalues : cs_ResLoader, _ENV
  local actualResloader, actualBigImgResloader = nil, nil
  if resloader == nil then
    if self.resloader == nil then
      self.resloader = (cs_ResLoader.Create)()
    end
    actualResloader = resloader
  else
    actualResloader = resloader
  end
  if bigImgResloader == nil then
    if self.bigImgResloader == nil then
      self.bigImgResloader = (cs_ResLoader.Create)()
    end
    actualBigImgResloader = self.bigImgResloader
  else
    actualBigImgResloader = bigImgResloader
  end
  local campIcon = (LanguageUtil.GetLocaleText)(((self.heroData):GetCampCfg()).icon)
  actualResloader:LoadABAssetAsync(PathConsts:GetCampPicPath(campIcon), function(texture)
    -- function num : 0_2_0 , upvalues : _ENV, self
    if IsNull(self.transform) then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Camp).texture = texture
  end
)
  actualBigImgResloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath((self.heroData):GetResPicName()), function(prefab)
    -- function num : 0_2_1 , upvalues : _ENV, self
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate(((self.ui).heroHolder).transform)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroTask")
  end
)
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Quality).text = HeroRareString[(self.heroData).rare]
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (self.heroData):GetName()
  -- DECOMPILER ERROR at PC64: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_ENName).text = (self.heroData):GetEnName()
end

UIHeroTask.__RefreshHeroTask = function(self)
  -- function num : 0_3 , upvalues : _ENV, TaskData
  local taskNum = #self.heroTaskIds
  local finishedTaskNum = 0
  for index,taskId in ipairs(self.heroTaskIds) do
    local taskData = ((PlayerDataCenter.allTaskData).taskDatas)[taskId]
    if taskData == nil then
      finishedTaskNum = finishedTaskNum + 1
      local stcData = (ConfigData.task)[taskId]
      if stcData == nil then
        error("can\'t read hero task cfg taksId:" .. tostring(taskId))
        return 
      end
      local faketaskData = (TaskData.CreatePickedTaskData)(stcData)
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (self.heroTaskDataDic)[index] = faketaskData
    else
      do
        do
          -- DECOMPILER ERROR at PC34: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (self.heroTaskDataDic)[index] = taskData
          -- DECOMPILER ERROR at PC35: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC35: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC35: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  ;
  ((self.ui).tex_taskCount):SetIndex(0, tostring(finishedTaskNum), tostring(taskNum))
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).loop_scroll).totalCount = taskNum
  ;
  ((self.ui).loop_scroll):RefreshCells()
end

UIHeroTask.__OnNewItem = function(self, go)
  -- function num : 0_4 , upvalues : UINHeroTaskItem
  local taskItem = (UINHeroTaskItem.New)()
  taskItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.itemDic)[go] = taskItem
end

UIHeroTask.__OnChangeItem = function(self, go, index)
  -- function num : 0_5 , upvalues : _ENV
  local taskItem = (self.itemDic)[go]
  if taskItem == nil then
    error("Can\'t find goodItem by gameObject")
    return 
  end
  local taskData = (self.heroTaskDataDic)[index + 1]
  taskItem:InitHeroTaskItem(taskData)
end

UIHeroTask.__OnClickReturn = function(self)
  -- function num : 0_6
  if self.closeCallback ~= nil then
    (self.closeCallback)()
  end
  self:Delete()
end

UIHeroTask.OnHide = function(self)
  -- function num : 0_7 , upvalues : _ENV
  (UIUtil.ReShowTopStatus)()
end

UIHeroTask.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self._b__RefreshHeroTask)
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self._b__RefreshHeroTask)
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIHeroTask


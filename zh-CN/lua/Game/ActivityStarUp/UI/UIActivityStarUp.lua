local UIActivityStarUp = class("UIActivityStarUp", UIBaseWindow)
local base = UIBaseWindow
local UINActivityStarUpTask = require("Game.ActivityStarUp.UI.UINActivityStarUpTask")
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local ActivityStarUpEnum = require("Game.ActivityStarUp.ActivityStarUpEnum")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroLookTargetController = require("Game.Hero.Live2D.HeroLookTargetController")
local TaskEnum = require("Game.Task.TaskEnum")
local CS_OasisCameraController = CS.OasisCameraController
UIActivityStarUp.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithReceived
  ((self.ui).rewardItem):SetActive(false)
  self.rewardPool = (UIItemPool.New)(UINBaseItemWithReceived, (self.ui).rewardItem)
  self.__TaskUpdateCallback = BindCallback(self, self.TaskUpdateCallback)
  self.__ActivityChange = BindCallback(self, self.ActivityChange)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__ActivityChange)
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scroll_task).onInstantiateItem = BindCallback(self, self.OnInstantiateItem)
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scroll_task).onChangeItem = BindCallback(self, self.OnTaskChangeItem)
  self.taskItemDic = {}
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Preview, self, self.OnClickPreview)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Get, self, self.OnClickReward)
  self.heroId = 0
  self.skinId = 0
end

UIActivityStarUp.OnShow = function(self)
  -- function num : 0_1 , upvalues : _ENV, base
  do
    if self.l2dBinding ~= nil then
      local interation = (((self.l2dBinding).renderController).transform):GetComponent(typeof((((((CS.Live2D).Cubism).Samples).OriginalWorkflow).Demo).CubismInterationController))
      if interation ~= nil then
        interation:RestartBodyAnimation()
      end
    end
    ;
    (base.OnShow)(self)
  end
end

UIActivityStarUp.InitWindow = function(self, id)
  -- function num : 0_2 , upvalues : _ENV
  self.activityInfo = ((PlayerDataCenter.activityStarUpData).dataDic)[id]
  self:UpdateStage()
  self:DealExtraParam()
end

UIActivityStarUp.UpdateStage = function(self)
  -- function num : 0_3 , upvalues : _ENV, TaskEnum
  local stageId = (self.activityInfo).curStageId
  if stageId == nil then
    stageId = #((self.activityInfo).cfg).phase
  end
  local mainTask, childTasks = (self.activityInfo):GetTasks(stageId)
  self.mainTask = mainTask
  self.childTasks = childTasks
  local stagePhase = (((self.activityInfo).cfg).phase)[stageId]
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Head).text = (LanguageUtil.GetLocaleText)(stagePhase.name)
  ;
  ((self.ui).tex_CurrStage):SetIndex(0, tostring(stageId), tostring(#((self.activityInfo).cfg).phase))
  ;
  (self.rewardPool):HideAll()
  for i,v in ipairs(((self.mainTask).stcData).rewardIds) do
    local item = (self.rewardPool):GetOne(true)
    local itemCfg = (ConfigData.item)[v]
    local num = (((self.mainTask).stcData).rewardNums)[i]
    item:InitItemWithCount(itemCfg, num, nil, (self.mainTask).state == (TaskEnum.eTaskState).Picked)
  end
  self:UpdateMainTaskState()
  self:SortChildTask()
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIActivityStarUp.SortChildTask = function(self)
  -- function num : 0_4 , upvalues : _ENV, TaskEnum
  (table.sort)(self.childTasks, function(a, b)
    -- function num : 0_4_0 , upvalues : TaskEnum
    if a.state ~= b.state then
      if a.state == (TaskEnum.eTaskState).Picked then
        return false
      else
        if b.state == (TaskEnum.eTaskState).Picked then
          return true
        end
      end
    end
    local aComplect = a:CheckComplete()
    local bComplect = b:CheckComplete()
    if not aComplect or not true then
      do return aComplect == bComplect or false end
      if (a.stcData).order >= (b.stcData).order then
        do return (a.stcData).order == (b.stcData).order end
        do return a.id < b.id end
        -- DECOMPILER ERROR: 3 unprocessed JMP targets
      end
    end
  end
)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scroll_task).totalCount = #self.childTasks
  ;
  ((self.ui).scroll_task):RefillCells()
  local compolectCount = 0
  for i = 1, #self.childTasks do
    if ((self.childTasks)[i]).state == (TaskEnum.eTaskState).Picked then
      compolectCount = compolectCount + 1
    end
  end
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_CompleteCount).text = tostring(compolectCount) .. "/" .. tostring(#self.childTasks)
end

UIActivityStarUp.UpdateMainTaskState = function(self)
  -- function num : 0_5 , upvalues : TaskEnum, _ENV
  local isFinish = (self.mainTask).state == (TaskEnum.eTaskState).Picked
  local isComplect = (self.mainTask):CheckComplete()
  for i,v in ipairs((self.rewardPool).listItem) do
    v:SetPickedUIActive(isFinish)
  end
  ;
  ((self.ui).obj_Unfinish):SetActive((not isComplect and not isFinish))
  if isComplect then
    (((self.ui).btn_Get).gameObject):SetActive(not isFinish)
    ;
    ((self.ui).obj_Completed):SetActive(isFinish)
    if isComplect then
      ((self.ui).redDot_reward):SetActive(not isFinish)
      -- DECOMPILER ERROR: 6 unprocessed JMP targets
    end
  end
end

UIActivityStarUp.TaskUpdateCallback = function(self, taskData)
  -- function num : 0_6 , upvalues : _ENV
  if taskData.id == (self.mainTask).id then
    self:UpdateMainTaskState()
  else
    for k,v in pairs(self.taskItemDic) do
      if (v.taskInfo).id == taskData.id then
        v:UpdateUI()
        break
      end
    end
  end
end

UIActivityStarUp.ActivityChange = function(self, taskCfg)
  -- function num : 0_7 , upvalues : _ENV
  if (self.activityInfo):ContainsTask(taskCfg.id) then
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_7_0 , upvalues : taskCfg
    if window ~= nil then
      window:InitRewardsItem(taskCfg.rewardIds, taskCfg.rewardNums)
    end
  end
)
    if taskCfg.id == (self.mainTask).id then
      self:UpdateStage()
    else
      local _, childTasks = (self.activityInfo):GetTasks()
      self.childTasks = childTasks
      self:SortChildTask()
    end
  end
end

UIActivityStarUp.OnInstantiateItem = function(self, go)
  -- function num : 0_8 , upvalues : UINActivityStarUpTask
  local item = (UINActivityStarUpTask.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.taskItemDic)[go] = item
end

UIActivityStarUp.OnTaskChangeItem = function(self, go, index)
  -- function num : 0_9
  ((self.taskItemDic)[go]):InitItem((self.childTasks)[index + 1])
end

UIActivityStarUp.CloseUINoClick = function(self)
  -- function num : 0_10 , upvalues : _ENV
  (UIUtil.OnClickBack)()
end

UIActivityStarUp.OnClickPreview = function(self)
  -- function num : 0_11 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.ActivityStarUpRewardPreview, function(window)
    -- function num : 0_11_0 , upvalues : self
    if window ~= nil then
      window:InitView(self.activityInfo)
    end
  end
)
end

UIActivityStarUp.OnClickReward = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local taskCtr = ControllerManager:GetController(ControllerTypeId.Task)
  taskCtr:SendCommitQuestReward(self.mainTask)
end

UIActivityStarUp.DealExtraParam = function(self)
  -- function num : 0_13 , upvalues : _ENV, ActivityStarUpEnum, HeroCubismInteration
  if self.l2dModelIns ~= nil then
    DestroyUnityObject(self.l2dModelIns)
  end
  if self.bigImgGameObject ~= nil then
    DestroyUnityObject(self.bigImgGameObject)
  end
  for k,params in pairs(((self.activityInfo).cfg).extra_para) do
    if k == (ActivityStarUpEnum.eActivityExtraParamType).Live2DShow then
      local heroId = params[1]
      self.heroId = heroId
      self.skinId = 0
      local isLocked = false
      local resCfg = (ConfigData.resource_model)[heroId]
      local resName = resCfg.res_Name
      local resPath = PathConsts:GetCharacterLive2DPath(resName)
      local haveLive2D = ((CS.ResManager).Instance):ContainsAsset(resPath)
      local isLocked = (HeroCubismInteration.JudgeL2DLocked)(self.skinId)
      self.l2dBinding = nil
      if haveLive2D and not isLocked then
        self:LoadLive2D(resPath, params)
        break
      end
      self:LoadPic(resName, params)
      break
    else
      do
        if k == (ActivityStarUpEnum.eActivityExtraParamType).HeroPicShow then
          local heroId = params[1]
          local resCfg = (ConfigData.resource_model)[heroId]
          local resName = resCfg.res_Name
          self:LoadPic(resName, params)
          break
        end
        do
          -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

UIActivityStarUp.LoadLive2D = function(self, path, params)
  -- function num : 0_14 , upvalues : _ENV, HeroCubismInteration, HeroLookTargetController
  if self.Live2DResloader ~= nil then
    (self.Live2DResloader):Put2Pool()
    self.Live2DResloader = nil
  end
  if self.heroCubismInteration ~= nil then
    (self.heroCubismInteration):Delete()
    self.heroCubismInteration = nil
  end
  self.Live2DResloader = ((CS.ResLoader).Create)()
  ;
  (self.Live2DResloader):LoadABAssetAsync(path, function(l2dModelAsset)
    -- function num : 0_14_0 , upvalues : _ENV, self, HeroCubismInteration, HeroLookTargetController
    DestroyUnityObject(self.l2dModelIns)
    self.l2dModelIns = l2dModelAsset:Instantiate(((self.ui).heroHolder).transform)
    ;
    ((self.l2dModelIns).transform):SetLayer(LayerMask.UI)
    local cs_CubismInterationController = ((self.l2dModelIns).gameObject):GetComponent(typeof((((((CS.Live2D).Cubism).Samples).OriginalWorkflow).Demo).CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = (HeroCubismInteration.New)()
      local heroId = self.heroId
      local skinId = self.skinId
      ;
      (self.heroCubismInteration):InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
    end
    do
      self.l2dBinding = {}
      ;
      (UIUtil.LuaUIBindingTable)(self.l2dModelIns, self.l2dBinding)
      local cubismLookController = ((self.l2dModelIns).gameObject):GetComponent(typeof(((((CS.Live2D).Cubism).Framework).LookAt).CubismLookController))
      ;
      (HeroLookTargetController.OpenLookTarget)(cubismLookController, ((self.l2dBinding).lookTarget).gameObject, UIManager:GetUICamera())
      -- DECOMPILER ERROR at PC75: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.l2dBinding).renderController).SortingLayer = "UINormal"
      -- DECOMPILER ERROR at PC78: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.l2dBinding).renderController).InfluencedByUICanvas = true
      -- DECOMPILER ERROR at PC83: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.l2dBinding).renderController).uiCanvasGroup = (self.ui).canvasGroup
      ;
      ((self.l2dBinding).commonPerpectiveHandle):SetL2DPosType("ActivityStarUp", false)
    end
  end
)
end

UIActivityStarUp.LoadPic = function(self, path, params)
  -- function num : 0_15 , upvalues : _ENV
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  self.bigImgResloader = ((CS.ResLoader).Create)()
  ;
  (self.bigImgResloader):LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(path), function(prefab)
    -- function num : 0_15_0 , upvalues : _ENV, self
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate(((self.ui).heroHolder).transform)
  end
)
end

UIActivityStarUp.OnDelete = function(self)
  -- function num : 0_16 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__ActivityChange)
  if self.Live2DResloader ~= nil then
    (self.Live2DResloader):Put2Pool()
    self.Live2DResloader = nil
  end
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  if self.heroCubismInteration ~= nil then
    (self.heroCubismInteration):Delete()
    self.heroCubismInteration = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIActivityStarUp


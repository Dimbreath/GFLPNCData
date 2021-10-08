local UIActivityFrameMain = class("UIActivityFrameMain", UIBaseWindow)
local base = UIBaseWindow
local ActivityFrameData = require("Game.ActivityFrame.ActivityFrameData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
local UINActivityFrameItem = require("Game.ActivityFrame.UI.UINActivityFrameItem")
local openActivityPanelParam = {
[(ActivityFrameEnum.eActivityUIType).StarUp] = {UIType = UIWindowTypeID.ActivityStarUp, InitFunction = "InitWindow"}
, 
[(ActivityFrameEnum.eActivityUIType).BattlePass] = {UIType = UIWindowTypeID.EventBattlePass, InitFunction = "InitBattlePassUI"}
, 
[(ActivityFrameEnum.eActivityUIType).EventGrowBag] = {UIType = UIWindowTypeID.EventGrowBag, InitFunction = "InitEventGrow"}
, 
[(ActivityFrameEnum.eActivityUIType).SevenDayLogin] = {UIType = UIWindowTypeID.EventNoviceSign, InitFunction = "InitNoviceSign"}
, 
[(ActivityFrameEnum.eActivityUIType).FestivalSign] = {UIType = UIWindowTypeID.EventFestivalSignIn, InitFunction = "InitEventFestivalSignIn"}
, 
[(ActivityFrameEnum.eActivityUIType).dailySignIn] = {UIType = UIWindowTypeID.EventSignin, InitFunction = "InitEventSignin"}
, 
[(ActivityFrameEnum.eActivityUIType).Tickets] = {UIType = UIWindowTypeID.EventWeChat, InitFunction = "InitWeChat"}
}
UIActivityFrameMain.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINActivityFrameItem
  (UIUtil.SetTopStatus)(self, self.OnClickClose)
  self.swithItemPool = (UIItemPool.New)(UINActivityFrameItem, (self.ui).tog_SwitchItem)
  ;
  ((self.ui).tog_SwitchItem):SetActive(false)
  self.__OnSelectActivityItem = BindCallback(self, self.OnSelectActivityItem)
  self.resloader = ((CS.ResLoader).Create)()
end

UIActivityFrameMain.ActivityParamDeal = function(self, activityList)
  -- function num : 0_1 , upvalues : _ENV, ActivityFrameEnum, BattlePassEnum
  self.activityTypeDic = {}
  for k,actFrameData in pairs(activityList) do
    local UIType = nil
    if actFrameData.actCat == (ActivityFrameEnum.eActivityType).StarUp then
      UIType = (ActivityFrameEnum.eActivityUIType).StarUp
    else
      if actFrameData.actCat == (ActivityFrameEnum.eActivityType).BattlePass then
        local cfg = (ConfigData.battlepass_type)[actFrameData.actId]
        if cfg ~= nil and cfg.condition == (BattlePassEnum.ConditionType).AchievementLevel then
          UIType = (ActivityFrameEnum.eActivityUIType).EventGrowBag
        else
          if cfg ~= nil and cfg.condition == (BattlePassEnum.ConditionType).BattlePassLevel then
            UIType = (ActivityFrameEnum.eActivityUIType).BattlePass
          end
        end
      else
        do
          if actFrameData.actCat == (ActivityFrameEnum.eActivityType).SevenDayLogin then
            local signData = ((PlayerDataCenter.eventNoviceSignData).dataDic)[actFrameData.actId]
            if signData ~= nil and signData:IsFestivalSign() then
              UIType = (ActivityFrameEnum.eActivityUIType).FestivalSign
            else
              UIType = (ActivityFrameEnum.eActivityUIType).SevenDayLogin
            end
          else
            do
              do
                if actFrameData.actCat == (ActivityFrameEnum.eActivityType).dailySignIn then
                  UIType = (ActivityFrameEnum.eActivityUIType).dailySignIn
                else
                  if actFrameData.actCat == (ActivityFrameEnum.eActivityType).Tickets then
                    UIType = (ActivityFrameEnum.eActivityUIType).Tickets
                  end
                end
                -- DECOMPILER ERROR at PC83: Confused about usage of register: R8 in 'UnsetPending'

                ;
                (self.activityTypeDic)[actFrameData.id] = UIType
                -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
    end
  end
end

UIActivityFrameMain.InitFrameMain = function(self, enterType, activityId)
  -- function num : 0_2 , upvalues : _ENV
  self.frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local actDic = (self.frameCtrl):GetShowByEnterType(enterType)
  if (table.count)(actDic) == 0 then
    error("该活动入口没有已开启活动： enterType is " .. tostring(enterType))
    return 
  end
  local list = {}
  for _,activityFrameDate in pairs(actDic) do
    (table.insert)(list, activityFrameDate)
  end
  ;
  (table.sort)(list, function(a, b)
    -- function num : 0_2_0
    do return a.order < b.order end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  self:ActivityParamDeal(list)
  if #list == 0 then
    error("该活动入口没有已开启活动： enterType is " .. tostring(enterType))
    return 
  end
  ;
  (self.swithItemPool):HideAll()
  local targetInedx = nil
  for index,activityFrameDate in ipairs(list) do
    local item = (self.swithItemPool):GetOne()
    item:InitActivitySwitchItem(activityFrameDate, self.__OnSelectActivityItem, self.resloader)
    if activityId ~= nil and activityFrameDate:GetActivityFrameId() == activityId then
      targetInedx = index
    end
  end
  self:CancelAndSetActivityFrameListener(enterType)
  if targetInedx == nil then
    (((self.swithItemPool).listItem)[1]):SelectActivityTag()
  else
    ;
    (((self.swithItemPool).listItem)[targetInedx]):SelectActivityTag()
  end
end

UIActivityFrameMain.OnSelectActivityItem = function(self, tag, flag)
  -- function num : 0_3 , upvalues : openActivityPanelParam, _ENV
  if flag then
    local id = (tag.activityFrameData).id
    do
      if id == self.selectedId then
        return 
      end
      if (self.activityTypeDic)[id] == nil then
        return 
      end
      local openParam = openActivityPanelParam[(self.activityTypeDic)[self.selectedId]]
      if self.selectedId ~= nil and (self.activityTypeDic)[id] ~= (self.activityTypeDic)[self.selectedId] then
        UIManager:DeleteWindow(openParam.UIType)
      end
      self.selectedId = id
      openParam = openActivityPanelParam[(self.activityTypeDic)[self.selectedId]]
      UIManager:ShowWindowAsync(openParam.UIType, function(window)
    -- function num : 0_3_0 , upvalues : self, openParam, tag
    (window.transform):SetParent((self.ui).pageNode)
    ;
    (window[openParam.InitFunction])(window, (tag.activityFrameData).actId)
  end
)
    end
  end
end

UIActivityFrameMain.CancelAndSetActivityFrameListener = function(self, enterType)
  -- function num : 0_4 , upvalues : ActivityFrameEnum, _ENV
  self.entertype = enterType
  local oldRedDotDynPath = self.redDotDynPath
  local node = nil
  if enterType == (ActivityFrameEnum.eActivityEnterType).Novice then
    self.redDotDynPath = RedDotDynPath.ActivityFrameNovicePath
    _ = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityFrameNovice)
  else
    if enterType == (ActivityFrameEnum.eActivityEnterType).LimitTime then
      self.redDotDynPath = RedDotDynPath.ActivityFrameLimitTimePath
      -- DECOMPILER ERROR at PC34: Overwrote pending register: R3 in 'AssignReg'

      _ = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityFrameLimitTime)
    else
      self.redDotDynPath = nil
    end
  end
  if node ~= nil then
    self:OnListenerActivityCallback(node)
  end
  if oldRedDotDynPath ~= self.redDotDynPath then
    if self.__OnListenerActivityCallback == nil then
      self.__OnListenerActivityCallback = BindCallback(self, self.OnListenerActivityCallback)
    end
    if oldRedDotDynPath ~= nil then
      RedDotController:RemoveListener(oldRedDotDynPath, self.__OnListenerActivityCallback)
    end
    if self.redDotDynPath ~= nil then
      RedDotController:AddListener(self.redDotDynPath, self.__OnListenerActivityCallback)
    end
  end
end

UIActivityFrameMain.OnListenerActivityCallback = function(self, node)
  -- function num : 0_5 , upvalues : _ENV
  for _,swithItem in pairs((self.swithItemPool).listItem) do
    local childNode = node:GetChild((swithItem.activityFrameData).id)
    swithItem:ActivityTagReddotShow(childNode ~= nil and childNode:GetRedDotCount() > 0)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIActivityFrameMain.OnClickClose = function(self)
  -- function num : 0_6
  self:OnCloseWin()
  self:Delete()
end

UIActivityFrameMain.OnDelete = function(self)
  -- function num : 0_7 , upvalues : openActivityPanelParam, _ENV, base
  self:CancelAndSetActivityFrameListener(nil)
  do
    if self.selectedId ~= nil then
      local openParam = openActivityPanelParam[(self.activityTypeDic)[self.selectedId]]
      UIManager:DeleteWindow(openParam.UIType, true)
    end
    if self.closeCallback ~= nil then
      (self.closeCallback)()
    end
    ;
    (self.swithItemPool):DeleteAll()
    local openParam = openActivityPanelParam[(self.activityTypeDic)[self.selectedId]]
    if self.resloader ~= nil then
      (self.resloader):Put2Pool()
      self.resloader = nil
    end
    ;
    (base.OnDelete)(self)
  end
end

return UIActivityFrameMain


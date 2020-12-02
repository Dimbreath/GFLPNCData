-- params : ...
-- function num : 0 , upvalues : _ENV
local UITrainingPlanNode = class("UITrainingPlanNode", UIBaseNode)
local base = UIBaseNode
local MaterialItem = require("Game.Training.SelectHero.UITrainingPlanMaterialItem")
local cs_MessageCommon = CS.MessageCommon
UITrainingPlanNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.OnSelectEvent = nil
  self.OnConfirmEvent = nil
  self.OnCancelEvent = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.__OnClickConfim)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, self.__OnClickCancel)
  ;
  ((self.ui).materialItem):SetActive(false)
  self.__matItems = {}
end

UITrainingPlanNode.InitPlanNode = function(self, resloader, efficiencyCfg)
  -- function num : 0_1 , upvalues : _ENV, MaterialItem
  self.efficiencyCfg = efficiencyCfg
  for i,time in ipairs((ConfigData.game_config).trainingTimeCfg) do
    local go = ((self.ui).materialItem):Instantiate()
    go:SetActive(true)
    local item = (MaterialItem.New)()
    item:Init(go)
    item:InitMatItem(resloader, i, time)
    item.OnClickEvent = BindCallback(self, self.__OnSeletctPlan)
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.__matItems)[i] = item
  end
end

UITrainingPlanNode.__OnSeletctPlan = function(self, id)
  -- function num : 0_2 , upvalues : _ENV
  for k,v in pairs(self.__matItems) do
    v:Select(v.id == id)
  end
  local time = ((ConfigData.game_config).trainingTimeCfg)[id]
  local efficiency = self:__GetEfficiency()
  local costExp = time * efficiency
  local buffRatio = 0
  local totalExp = costExp * (1 + buffRatio)
  self.__efficencyId = id
  self.__costExp = costExp
  ;
  ((self.ui).tex_UseGlobalExp):SetIndex(0, tostring(costExp))
  ;
  ((self.ui).tex_Gain):SetIndex(0, tostring(buffRatio * 100))
  if self.OnSelectEvent ~= nil then
    (self.OnSelectEvent)(totalExp)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UITrainingPlanNode.__GetEfficiency = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for i = #self.efficiencyCfg, 1, -1 do
    local cfg = (self.efficiencyCfg)[i]
    if (CheckCondition.CheckLua)(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2) then
      return cfg.training_para
    end
  end
  error("找不到符合的经验效率")
end

UITrainingPlanNode.ResetSelect = function(self)
  -- function num : 0_4 , upvalues : _ENV
  for k,v in pairs(self.__matItems) do
    v:Select(false)
  end
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self.ui).tex_UseGlobalExp).text).text = ""
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self.ui).tex_Gain).text).text = ""
  self.__efficencyId = nil
  self.__costExp = nil
end

UITrainingPlanNode.__OnClickCancel = function(self)
  -- function num : 0_5
  self:ResetSelect()
  if self.OnCancelEvent ~= nil then
    (self.OnCancelEvent)()
  end
end

UITrainingPlanNode.__OnClickConfim = function(self)
  -- function num : 0_6 , upvalues : cs_MessageCommon, _ENV
  if self.__efficencyId == nil then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Train_SelectPlan))
    return 
  end
  if self.OnConfirmEvent ~= nil then
    (self.OnConfirmEvent)(self.__efficencyId, self.__costExp)
  end
end

UITrainingPlanNode.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return UITrainingPlanNode


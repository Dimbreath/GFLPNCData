local RecommeFormationController = class("RecommeFormationController", ControllerBase)
local base = ControllerBase
local CS_MessageCommon = CS.MessageCommon
local RecommeFormationData = require("Game.Formation.Data.RecommeFormationData")
RecommeFormationController.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.isRecommeSortForCount = false
  self.heroNetwork = NetworkManager:GetNetwork(NetworkTypeID.Hero)
end

RecommeFormationController.IsCanReqRecomme = function(self, stageId, isShowTip)
  -- function num : 0_1 , upvalues : _ENV, CS_MessageCommon
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Recommend) then
    if isShowTip then
      (CS_MessageCommon.ShowMessageTipsWithErrorSound)(FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Recommend))
    end
    return false
  end
  local unlockCfg = (ConfigData.system_open)[proto_csmsg_SystemFunctionID.SystemFunctionID_Recommend]
  if stageId <= (unlockCfg.pre_para1)[1] then
    if isShowTip then
      (CS_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Recomme_Forbid))
    end
    return false
  end
  return true
end

RecommeFormationController.ReqRecommeFormation = function(self, stageId, isOpenFormationCopy)
  -- function num : 0_2 , upvalues : _ENV
  if not self:IsCanReqRecomme(stageId, true) then
    return 
  end
  self.isOpenFormationCopy = isOpenFormationCopy or false
  self.reqRecordStageId = stageId
  if self.recommeFormationCache ~= nil and (self.recommeFormationCache).stageId == stageId and PlayerDataCenter.timestamp < (self.recommeFormationCache).refreshTime then
    UIManager:ShowWindowAsync(UIWindowTypeID.RecommeFormation, function(window)
    -- function num : 0_2_0 , upvalues : self
    window:InitRecommeFormation(self.isOpenFormationCopy, self.recommeFormationCache, self)
  end
)
  else
    ;
    (self.heroNetwork):CS_RECOMMANDFORMATION_Detail(self.reqRecordStageId)
  end
end

RecommeFormationController.ReceiveRecommeFormation = function(self, msg)
  -- function num : 0_3 , upvalues : RecommeFormationData, CS_MessageCommon, _ENV
  self.recommeFormationCache = (RecommeFormationData.CreateData)(self.reqRecordStageId, msg)
  if #(self.recommeFormationCache).list == 0 then
    (CS_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Recomme_Empty))
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.RecommeFormation, function(window)
    -- function num : 0_3_0 , upvalues : self
    window:InitRecommeFormation(self.isOpenFormationCopy, self.recommeFormationCache, self)
  end
)
end

RecommeFormationController.ExitRecommeFormation = function(self, singleData)
  -- function num : 0_4 , upvalues : _ENV, CS_MessageCommon
  if singleData == nil then
    return 
  end
  local formationCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
  if formationCtrl ~= nil then
    local newHeroDic = singleData:CopyFormation()
    local isChange = formationCtrl:UpdateFormationHero(newHeroDic)
    if isChange then
      if (table.count)(newHeroDic) == singleData:GetHaveCount() then
        (CS_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Recomme_SuccessAll))
      else
        ;
        (CS_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Recomme_SuccessPart))
      end
    else
      ;
      (CS_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Recomme_Sample))
    end
  end
end

return RecommeFormationController


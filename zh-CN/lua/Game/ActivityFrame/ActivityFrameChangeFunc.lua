local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local HomeEnum = require("Game.Home.HomeEnum")
local ActivityFrameChangeFunc = {[(ActivityFrameEnum.eActivityType).DungeonDouble] = function(activityFrameData)
  -- function num : 0_0 , upvalues : _ENV
  local isOpen = activityFrameData:GetCouldRuningActivity()
  local actId = activityFrameData.actId
  local doubleActivityCfg = (ConfigData.activity_double)[actId]
  if doubleActivityCfg == nil then
    error("can\'t find doubleActivityCfg with actId:" .. tostring(actId))
    return 
  end
  for index,logic in ipairs(doubleActivityCfg.logic) do
    if isOpen then
      local para1 = (doubleActivityCfg.para1)[index]
      local para2 = (doubleActivityCfg.para2)[index]
      local para3 = (doubleActivityCfg.para3)[index]
      ;
      (PlayerDataCenter.playerBonus):InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_Double_Active, actId, logic, para1, para2, para3)
    else
      do
        do
          ;
          (PlayerDataCenter.playerBonus):UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_Double_Active, actId, logic)
          do break end
          -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  MsgCenter:Broadcast(eMsgEventId.OnBattleDungeonLimitChange)
end
}
return ActivityFrameChangeFunc


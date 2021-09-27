local UINSctNewbeeInfo = class("UINSctNewbeeInfo", UIBaseNode)
UINSctNewbeeInfo.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_STNewbee, self, self.OnSctNewbeeClicked)
end

UINSctNewbeeInfo.InitSctNewbeeInfo = function(self, sectorId, clickFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.__clickFunc = clickFunc
  local sectorCfg = (ConfigData.sector)[sectorId]
  if sectorCfg == nil then
    error("Cant get sectorCfg, sectorId = " .. tostring(sectorId))
    return 
  end
  self.sectorCfg = sectorCfg
  local completeIntro = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_CompleteIntro)
  ;
  ((self.ui).img_Newbee):SetIndex(completeIntro and 1 or 0)
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R5 in 'UnsetPending'

  if completeIntro then
    ((self.ui).tex_Newbee).fontSize = (self.ui).size_complete
  end
end

UINSctNewbeeInfo.OnSctNewbeeClicked = function(self)
  -- function num : 0_2
  if self.__clickFunc ~= nil then
    (self.__clickFunc)((self.sectorCfg).id)
  end
end

return UINSctNewbeeInfo


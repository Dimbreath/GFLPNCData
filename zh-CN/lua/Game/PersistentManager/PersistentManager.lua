local PersistentManager = {}
local cs_FilePathHelper = (CS.FilePathHelper).Instance
local pb = require("pb")
;
(pb.option)("int64_as_number")
;
(pb.option)("enum_as_value")
PersistentManager.InitManager = function(self)
  -- function num : 0_0 , upvalues : _ENV, pb
  local cs_Resources = (CS.UnityEngine).Resources
  local resloader = ((CS.ResLoader).Create)()
  for k,v in ipairs(PersistentConfig.PersistentProtoFiles) do
    local pbTextAsset = resloader:LoadABAsset(PathConsts.PbFilePath .. v)
    ;
    (pb.load)(pbTextAsset.bytes)
    ;
    (cs_Resources.UnloadAsset)(pbTextAsset)
  end
  resloader:Put2Pool()
  self.DataModels = {}
  ;
  ((CS.MonoDriver).Instance):SetOnApplicationPause(BindCallback(self, self.SaveAllModelData))
end

PersistentManager.__encodeAndSaveData = function(self, packageId, data)
  -- function num : 0_1 , upvalues : _ENV, pb
  local dataConfig = (PersistentConfig.PackageData)[packageId]
  if dataConfig == nil then
    error("cant find persisten_package:" .. packageId)
    return 
  end
  local dataTable = nil
  if dataConfig.SaveSingleton then
    dataTable = (self.DataModels)[packageId]
  else
    dataTable = data
  end
  if dataTable == nil then
    return 
  end
  if not dataTable:IsPstDataDirty() then
    return 
  end
  local encodeTable = dataTable:GetSaveEncodeTable()
  local msgContent = (pb.encode)(dataConfig.PbName, encodeTable)
  local filePath = dataTable:GetSaveDataFilePath()
  if (string.IsNullOrEmpty)(filePath) == nil then
    return 
  end
  self:SaveData(filePath, msgContent)
  dataTable:ResetPstDataDirty()
end

local DecodeData = function(PbName, content)
  -- function num : 0_2 , upvalues : pb
  local msg = (pb.decode)(PbName, content)
  return msg
end

PersistentManager.LoadAndDecodeData = function(self, packageId, ...)
  -- function num : 0_3 , upvalues : _ENV, DecodeData
  local dataConfig = (PersistentConfig.PackageData)[packageId]
  if dataConfig == nil then
    error("cant find persisten_package:" .. packageId)
    return 
  end
  if dataConfig.DataType == (PersistentConfig.DataType).User and self.playerId == nil then
    error("cant get ueserModel on user log out")
    return 
  end
  local dataModel = ((dataConfig.DataModel).New)(...)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R4 in 'UnsetPending'

  if dataConfig.SaveSingleton then
    (self.DataModels)[packageId] = dataModel
  end
  local filePath = dataModel:GetSaveDataFilePath()
  local content = self:LoadData(filePath)
  do
    if content ~= nil then
      local status, data = xpcall(DecodeData, debug.traceback, dataConfig.PbName, content)
      if status then
        dataModel:InitBySaveData(data)
        return dataModel
      else
        warn("PersistentManager decode proto failed:" .. data)
        dataModel:InitByDefaultData()
        self:SaveModelData(packageId)
        return dataModel
      end
    end
    dataModel:InitByDefaultData()
    return dataModel
  end
end

PersistentManager.SaveAllModelData = function(self)
  -- function num : 0_4 , upvalues : _ENV
  for _,v in ipairs(PersistentConfig.ModelSaveList) do
    if v ~= nil then
      self:__encodeAndSaveData(v)
    end
  end
end

PersistentManager.SaveModelData = function(self, modelId, data)
  -- function num : 0_5
  self:__encodeAndSaveData(modelId, data)
end

PersistentManager.HandleLogOut = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.playerId == PlayerDataCenter.playerId then
    self:SaveAllModelData()
  end
  self:UnLoadAllData()
end

PersistentManager.GetDataModel = function(self, packageId)
  -- function num : 0_7 , upvalues : _ENV
  if (self.DataModels)[packageId] == nil then
    error("Fail to get model data,model id:" .. tostring((PersistentConfig.ePackage).UserData))
    return nil
  end
  return (self.DataModels)[packageId]
end

PersistentManager.SaveData = function(self, filePath, content)
  -- function num : 0_8 , upvalues : cs_FilePathHelper
  cs_FilePathHelper:WriteBytesToFile(filePath, content)
end

PersistentManager.LoadData = function(self, filePath)
  -- function num : 0_9 , upvalues : cs_FilePathHelper
  return cs_FilePathHelper:ReadBytesFromFile(filePath)
end

PersistentManager.UnLoadAllData = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local tmpDataModels = {}
  for packageId,dataModel in pairs(self.DataModels) do
    local dataConfig = (PersistentConfig.PackageData)[packageId]
    if dataConfig ~= nil and not dataConfig.LogoutUnload then
      tmpDataModels[packageId] = dataModel
    end
  end
  self.DataModels = tmpDataModels
  self.playerId = nil
end

return PersistentManager


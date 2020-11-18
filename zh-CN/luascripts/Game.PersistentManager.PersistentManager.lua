-- params : ...
-- function num : 0 , upvalues : _ENV
local PersistentManager = class("PersistentManager")
local cs_ResLoader = CS.ResLoader
local cs_Resources = (CS.UnityEngine).Resources
local cs_FilePathHelper = (CS.FilePathHelper).Instance
local cs_MonoDriver = (CS.MonoDriver).Instance
local PstConfig = require("Game.PersistentManager.PersistentData.PersistentConfig")
local pb = require("pb")
;
(pb.option)("int64_as_number")
;
(pb.option)("enum_as_value")
PersistentManager.InitManager = function(self)
  -- function num : 0_0 , upvalues : cs_ResLoader, _ENV, PstConfig, pb, cs_Resources, cs_MonoDriver
  local resloader = (cs_ResLoader.Create)()
  for k,v in ipairs(PstConfig.PersistentProtoFiles) do
    local pbTextAsset = resloader:LoadABAsset(PathConsts.PbFilePath .. v)
    ;
    (pb.load)(pbTextAsset.bytes)
    ;
    (cs_Resources.UnloadAsset)(pbTextAsset)
  end
  resloader:Put2Pool()
  self.DataModels = {}
  cs_MonoDriver:SetOnApplicationPause(BindCallback(self, self.SaveAllModelData))
end

PersistentManager.__encodeAndSaveData = function(self, packageId)
  -- function num : 0_1 , upvalues : PstConfig, _ENV, pb
  local dataConfig = (PstConfig.PackageData)[packageId]
  if dataConfig == nil then
    error("cant find persisten_package:" .. packageId)
    return 
  end
  local dataTable = self:GetDataModelWithConfig(packageId, dataConfig)
  if dataTable == nil then
    if dataConfig.DataType == (PstConfig.DataType).User and self.playerId == nil then
      return 
    end
    error("fail to get or create data model,id:" .. packageId)
    return 
  end
  local encodeTable = dataTable:GetSaveEncodeTable()
  local msgContent = (pb.encode)(dataConfig.PbName, encodeTable)
  local filePath = self:GetDataFilePath(dataConfig.DataType, dataConfig.FileName)
  if (string.IsNullOrEmpty)(filePath) == nil then
    return 
  end
  self:SaveData(filePath, msgContent)
end

local DecodeData = function(PbName, content)
  -- function num : 0_2 , upvalues : pb
  local msg = (pb.decode)(PbName, content)
  return msg
end

PersistentManager.LoadAndDecodeData = function(self, packageId)
  -- function num : 0_3 , upvalues : PstConfig, _ENV, DecodeData
  local dataConfig = (PstConfig.PackageData)[packageId]
  if dataConfig == nil then
    error("cant find persisten_package:" .. packageId)
    return 
  end
  if dataConfig.DataType == (PstConfig.DataType).User and self.playerId == nil then
    return 
  end
  local dataModel = self:GetDataModelWithConfig(packageId, dataConfig)
  if dataModel == nil then
    error("fail to get or create data model,id:" .. packageId)
    return 
  end
  local filePath = self:GetDataFilePath(dataConfig.DataType, dataConfig.FileName)
  local content = self:LoadData(filePath)
  do
    if content ~= nil then
      local status, data = xpcall(DecodeData, debug.traceback, dataConfig.PbName, content)
      if status then
        dataModel:InitBySaveData(data)
        return 
      else
        warn("PersistentManager decode proto failed:" .. data)
      end
    end
    dataModel:InitByDefaultData()
  end
end

PersistentManager.GetDataFilePath = function(self, dataType, fileName)
  -- function num : 0_4 , upvalues : PstConfig, _ENV
  -- DECOMPILER ERROR at PC17: Unhandled construct in 'MakeBoolean' P1

  if dataType == (PstConfig.DataType).User and self.playerId ~= nil and self.playerId == PlayerDataCenter.playerId then
    return PathConsts:GetPersistentUserDataPath(PlayerDataCenter.strPlayerId)
  end
  if dataType == (PstConfig.DataType).System then
    if fileName == nil then
      error("cant get the data fileName:" .. fileName)
      return 
    end
    return PathConsts:GetPersistentSystemDataPath(fileName)
  end
end

PersistentManager.LoadAllModelData = function(self)
  -- function num : 0_5 , upvalues : _ENV, PstConfig
  for _,v in ipairs(PstConfig.ModelSaveList) do
    if v ~= nil then
      self:LoadAndDecodeData(v)
    end
  end
end

PersistentManager.SaveAllModelData = function(self)
  -- function num : 0_6 , upvalues : _ENV, PstConfig
  for _,v in ipairs(PstConfig.ModelSaveList) do
    if v ~= nil then
      self:__encodeAndSaveData(v)
    end
  end
end

PersistentManager.SaveModelData = function(self, modelId)
  -- function num : 0_7 , upvalues : _ENV, PstConfig
  for _,v in ipairs(PstConfig.ModelSaveList) do
    self:__encodeAndSaveData(modelId)
  end
end

PersistentManager.HandleLogOut = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.playerId == PlayerDataCenter.playerId then
    self:SaveAllModelData()
  end
  self:UnLoadAllData()
end

PersistentManager.GetDataModelWithConfig = function(self, packageId, dataConfig)
  -- function num : 0_9 , upvalues : PstConfig
  if (self.DataModels)[packageId] == nil then
    if dataConfig.DataType == (PstConfig.DataType).User and self.playerId == nil then
      return 
    end
    local dataModel = ((dataConfig.DataModle).New)()
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self.DataModels)[packageId] = dataModel
  end
  do
    return (self.DataModels)[packageId]
  end
end

PersistentManager.GetDataModel = function(self, packageId)
  -- function num : 0_10 , upvalues : PstConfig, _ENV
  local dataConfig = (PstConfig.PackageData)[packageId]
  if dataConfig == nil then
    error("cant find persisten_package:" .. packageId)
    return 
  end
  if (self.DataModels)[packageId] == nil then
    if dataConfig.DataType == (PstConfig.DataType).User and self.playerId == nil then
      return 
    end
    local dataModel = ((dataConfig.DataModle).New)()
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self.DataModels)[packageId] = dataModel
  end
  do
    if (self.DataModels)[packageId] == nil then
      error("Fail to get model data,model id:" .. tostring((PstConfig.ePackage).UserData))
    end
    return (self.DataModels)[packageId]
  end
end

PersistentManager.SaveData = function(self, filePath, content)
  -- function num : 0_11 , upvalues : cs_FilePathHelper
  cs_FilePathHelper:WriteBytesToFile(filePath, content)
end

PersistentManager.LoadData = function(self, filePath)
  -- function num : 0_12 , upvalues : cs_FilePathHelper
  return cs_FilePathHelper:ReadBytesFromFile(filePath)
end

PersistentManager.UnLoadAllData = function(self)
  -- function num : 0_13 , upvalues : _ENV, PstConfig
  local tmpDataModels = {}
  for packageId,dataModel in pairs(self.DataModels) do
    local dataConfig = (PstConfig.PackageData)[packageId]
    if dataConfig ~= nil and not dataConfig.LogoutUnload then
      tmpDataModels[packageId] = dataModel
    end
  end
  self.DataModels = tmpDataModels
  self.playerId = nil
end

return PersistentManager


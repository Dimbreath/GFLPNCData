-- params : ...
-- function num : 0 , upvalues : _ENV
local PersistentConfig = {}
PersistentConfig.ePackage = {None = 0, UserData = 1, SystemData = 2}
PersistentConfig.DataType = {System = 0, User = 1}
PersistentConfig.PersistentProtoFiles = {"user_data.pb.bytes", "system_data.pb.bytes"}
PersistentConfig.ModelSaveList = {(PersistentConfig.ePackage).UserData, (PersistentConfig.ePackage).SystemData}
PersistentConfig.PackageData = {
[(PersistentConfig.ePackage).UserData] = {PbName = "save_data.user_data", DataType = (PersistentConfig.DataType).User, DataModle = require("Game.PersistentManager.PersistentData.UserData"), LogoutUnload = true}
, 
[(PersistentConfig.ePackage).SystemData] = {PbName = "save_data.system_data", DataType = (PersistentConfig.DataType).System, FileName = "system_data", DataModle = require("Game.PersistentManager.PersistentData.SystemSaveData"), LogoutUnload = false}
}
return PersistentConfig


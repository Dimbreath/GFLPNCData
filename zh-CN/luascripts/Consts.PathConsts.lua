-- params : ...
-- function num : 0 , upvalues : _ENV
local cs_PathConsts = CS.PathConsts
PathConsts = {SpriteAtlasExtension = cs_PathConsts.SpriteAtlasExtension, PrefabExtension = cs_PathConsts.PrefabExtension, DataExtension = ".dat", SpriteAtlasPathHead = cs_PathConsts.SpriteAtlasPathHead, UIPrefabPathHead = cs_PathConsts.UIPrefabPathHead, ModelPrefabPath = cs_PathConsts.ModelPrefabPath, OasisBuildingPath = cs_PathConsts.OasisBuildingPrefabPath, OasisBuildingEffectPath = "Res/Effect/Prefabs/OasisBuilding/", SectorPath = "Res/Model/Sector/", PbFilePath = "Res/pb/", SkillIconPathHead = "Res/Images/SkillIcons/", CharacterPicPathHead = cs_PathConsts.CharacterPicPathHead, CharacterBigImgPrefabHead = cs_PathConsts.CharacterBigImgPrefabHead, FriendshipDungeonPicHead = "Res/Images/HeroStoryLevel/", MaterialDungeonPicHead = "Res/Images/MaterialLevel/Background/", OasisBuildingIconPath = "Res/Images/OasisBuilding/", AchievementIconPath = "Res/Images/AchievementIcon/", AchivLevelIconPath = "Res/Images/AchivLevelIcon/", MaterialDungeonBGIconPath = "Res/Images/MaterialLevel/Icon/", DormRoomPath = "Res/Model/Dorm/Rooms/", DormFntPath = "Res/Model/Dorm/Furnitures/", AvgImgPath = "Res/Images/Avg/", FormationPath = "Res/Model/Formation/", CampIconPath = "Res/Images/CampIcon/", EffectPath = "Res/Effect/Prefabs/", PersistentUserDataPath = cs_PathConsts.PersistentDataPath .. "save_data/user_data/", PersistentDataPath = cs_PathConsts.PersistentDataPath .. "save_data/", SectorBackgroundPath = "Res/Images/SectorLevel/", BannerPicPath = "Res/Images/HomeAdv/"}
-- DECOMPILER ERROR at PC49: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetModelPrefabPath = function(self, prefabName)
  -- function num : 0_0
  return self.ModelPrefabPath .. prefabName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetUIPrefabPath = function(self, resName)
  -- function num : 0_1 , upvalues : _ENV
  if (string.IsNullOrEmpty)(resName) then
    return ""
  else
    return self.UIPrefabPathHead .. resName .. self.PrefabExtension
  end
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetOasisBuildingPrefabPath = function(self, resName)
  -- function num : 0_2 , upvalues : _ENV
  if (string.IsNullOrEmpty)(resName) then
    return ""
  else
    return self.OasisBuildingPath .. resName .. self.PrefabExtension
  end
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetOasisBuildingEffetPrefabPath = function(self, resName)
  -- function num : 0_3 , upvalues : _ENV
  if (string.IsNullOrEmpty)(resName) then
    return ""
  else
    return self.OasisBuildingEffectPath .. resName .. self.PrefabExtension
  end
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetSectorPrefabPath = function(self, resName)
  -- function num : 0_4 , upvalues : _ENV
  if (string.IsNullOrEmpty)(resName) then
    return ""
  else
    return self.SectorPath .. resName .. self.PrefabExtension
  end
end

-- DECOMPILER ERROR at PC64: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetSkillIconPath = function(self, skillIcon)
  -- function num : 0_5
  return self.SkillIconPathHead .. skillIcon .. ".png"
end

-- DECOMPILER ERROR at PC67: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetCharacterPicPath = function(self, resName)
  -- function num : 0_6
  return self.CharacterPicPathHead .. resName .. "/" .. "npic_" .. resName .. ".png"
end

-- DECOMPILER ERROR at PC70: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetCharacterLive2DPath = function(self, resName)
  -- function num : 0_7
  return self.CharacterPicPathHead .. resName .. "/L2D/" .. resName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC73: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetCharacterBigImgPrefabPath = function(self, resName)
  -- function num : 0_8
  return self.CharacterBigImgPrefabHead .. resName .. "/" .. "lpic_" .. resName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC76: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetCharacterSmallPicPath = function(self, resName)
  -- function num : 0_9
  return self.CharacterPicPathHead .. resName .. "/" .. "spic_" .. resName .. ".png"
end

-- DECOMPILER ERROR at PC79: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetCharacterModelPrefabPath = function(self, prefabName)
  -- function num : 0_10
  return self.CharacterBigImgPrefabHead .. prefabName .. "/" .. "model_" .. prefabName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC82: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetFriendshipDungeonPicPath = function(self, resName)
  -- function num : 0_11
  return self.FriendshipDungeonPicHead .. "HeroStory" .. resName .. ".png"
end

-- DECOMPILER ERROR at PC85: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetMaterailDungeonPicPath = function(self, resName)
  -- function num : 0_12
  return self.MaterialDungeonPicHead .. "MatBg" .. resName .. ".png"
end

-- DECOMPILER ERROR at PC88: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetOasisBuildingIconPath = function(self, resName)
  -- function num : 0_13
  return self.OasisBuildingIconPath .. resName .. ".png"
end

-- DECOMPILER ERROR at PC91: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetAchievementIconPath = function(self, resName)
  -- function num : 0_14
  return self.AchievementIconPath .. resName .. ".png"
end

-- DECOMPILER ERROR at PC94: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetMaterialDungeonBGIconPath = function(self, resName)
  -- function num : 0_15
  return self.MaterialDungeonBGIconPath .. resName .. ".png"
end

-- DECOMPILER ERROR at PC97: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetAchivLevelIconPath = function(self, resName)
  -- function num : 0_16
  return self.AchivLevelIconPath .. resName .. ".png"
end

-- DECOMPILER ERROR at PC100: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetDormRoomPath = function(self, resName)
  -- function num : 0_17
  return self.DormRoomPath .. resName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC103: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetDormFntPath = function(self, resName)
  -- function num : 0_18
  return self.DormFntPath .. resName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC106: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetCharacterDormModelPath = function(self, prefabName)
  -- function num : 0_19
  return self.CharacterBigImgPrefabHead .. prefabName .. "/" .. "dmodel_" .. prefabName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC109: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetAvgImgPath = function(self, name)
  -- function num : 0_20
  return self.AvgImgPath .. name .. ".png"
end

-- DECOMPILER ERROR at PC112: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetFormationModelPath = function(self, prefabName)
  -- function num : 0_21
  return self.FormationPath .. prefabName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC115: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetCampPicPath = function(self, resName)
  -- function num : 0_22
  return self.CampIconPath .. resName .. ".png"
end

-- DECOMPILER ERROR at PC118: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetAtlasAssetPath = function(self, atlasName)
  -- function num : 0_23
  return self.SpriteAtlasPathHead .. atlasName .. self.SpriteAtlasExtension
end

-- DECOMPILER ERROR at PC121: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetEffectPath = function(self, prefabName)
  -- function num : 0_24
  return self.EffectPath .. prefabName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC124: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetPersistentUserDataPath = function(self, strplayerId)
  -- function num : 0_25
  return self.PersistentUserDataPath .. strplayerId .. self.DataExtension
end

-- DECOMPILER ERROR at PC127: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetPersistentSystemDataPath = function(self, fileName)
  -- function num : 0_26
  return self.PersistentDataPath .. fileName .. self.DataExtension
end

-- DECOMPILER ERROR at PC130: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetSectorBackgroundPath = function(self, resName)
  -- function num : 0_27
  return self.SectorBackgroundPath .. resName .. ".png"
end

-- DECOMPILER ERROR at PC133: Confused about usage of register: R1 in 'UnsetPending'

PathConsts.GetBannerPicPath = function(self, fileName)
  -- function num : 0_28
  return self.BannerPicPath .. fileName .. ".png"
end



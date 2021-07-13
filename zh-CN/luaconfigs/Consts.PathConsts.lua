-- params : ...
-- function num : 0 , upvalues : _ENV
local cs_PathConsts = CS.PathConsts
local cs_FilePathHelper = (CS.FilePathHelper).Instance
PathConsts = {SpriteAtlasExtension = cs_PathConsts.SpriteAtlasExtension, PrefabExtension = cs_PathConsts.PrefabExtension, DataExtension = ".dat", SpriteAtlasPathHead = cs_PathConsts.SpriteAtlasPathHead, UIPrefabPathHead = cs_PathConsts.UIPrefabPathHead, ModelPrefabPath = cs_PathConsts.ModelPrefabPath, OasisBuildingPath = cs_PathConsts.OasisBuildingPrefabPath, OasisBuildingEffectPath = "Res/Effect/Prefabs/OasisBuilding/", SectorPath = "Res/Model/Sector/", PbFilePath = "Res/pb/", SkillIconPathHead = "Res/Images/SkillIcons/", CharacterPicPathHead = cs_PathConsts.CharacterPicPathHead, CharacterBigImgPrefabHead = cs_PathConsts.CharacterBigImgPrefabHead, FriendshipDungeonPicHead = "Res/Images/HeroStoryLevel/", MaterialDungeonPicHead = "Res/Images/MaterialLevel/Background/", OasisBuildingIconPath = "Res/Images/OasisBuilding/", AchievementIconPath = "Res/Images/AchievementIcon/", AchivLevelIconPath = "Res/Images/AchivLevelIcon/", MaterialDungeonBGIconPath = "Res/Images/MaterialLevel/Icon/", DormRoomPath = "Res/Model/Dorm/Rooms/", DormFntPath = "Res/Model/Dorm/Furnitures/", AvgImgPath = "Res/Images/Avg/", FormationPath = "Res/Model/Formation/", CampIconPath = "Res/Images/CampIcon/", EffectPath = "Res/Effect/Prefabs/", PersistentUserDataPath = cs_PathConsts.PersistentDataPath .. "save_data/user_data/", PersistentDataPath = cs_PathConsts.PersistentDataPath .. "save_data/", PersistentDeployDataPath = cs_PathConsts.PersistentDataPath .. "save_data/deploy_data/", PersistentBannerCachePath = cs_PathConsts.PersistentDataPath .. "res_cache/banner_img/", SectorBackgroundPath = "Res/Images/SectorLevel/", BannerPicPath = "Res/Images/HomeAdv/", LotteryPicPath = "Res/Images/Lottery/", LotteryModelPath = "Res/Model/LotteryShow/", SeceneIconPicPath = "Res/Images/SectorIcon/", ImagePath = "Res/Images/", FactoryPath = "Res/Model/Factory/", CampVideoPath = "GetHero/", UltSkillVideoPath = "UltSkill/", LuaSkillScriptsPath = cs_PathConsts.LuaSkillScriptsPath, TreeDCanvasPath = "Res/UIPrefabs/Common/", ShopGiftBgPath = "Res/Images/Shop/GiftBag/", ShopRecommendPath = "Res/Images/Shop/Recommend/"}
-- DECOMPILER ERROR at PC72: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetImagePath = function(self, name)
  -- function num : 0_0
  return self.ImagePath .. name .. ".png"
end

-- DECOMPILER ERROR at PC75: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetHeroVideoPath = function(self, videoName)
  -- function num : 0_1
  return self.CampVideoPath .. videoName
end

-- DECOMPILER ERROR at PC78: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetModelPrefabPath = function(self, prefabName)
  -- function num : 0_2
  return self.ModelPrefabPath .. prefabName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC81: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetUIPrefabPath = function(self, resName)
  -- function num : 0_3 , upvalues : _ENV
  if (string.IsNullOrEmpty)(resName) then
    return ""
  else
    return self.UIPrefabPathHead .. resName .. self.PrefabExtension
  end
end

-- DECOMPILER ERROR at PC84: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetOasisBuildingPrefabPath = function(self, resName)
  -- function num : 0_4 , upvalues : _ENV
  if (string.IsNullOrEmpty)(resName) then
    return ""
  else
    return self.OasisBuildingPath .. resName .. self.PrefabExtension
  end
end

-- DECOMPILER ERROR at PC87: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetOasisBuildingEffetPrefabPath = function(self, resName)
  -- function num : 0_5 , upvalues : _ENV
  if (string.IsNullOrEmpty)(resName) then
    return ""
  else
    return self.OasisBuildingEffectPath .. resName .. self.PrefabExtension
  end
end

-- DECOMPILER ERROR at PC90: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetOasisPrefabPath = function(self, resName)
  -- function num : 0_6 , upvalues : _ENV
  if (string.IsNullOrEmpty)(resName) then
    return ""
  else
    return "Res/Model/Oasis/" .. resName .. self.PrefabExtension
  end
end

-- DECOMPILER ERROR at PC93: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetSectorPrefabPath = function(self, resName)
  -- function num : 0_7 , upvalues : _ENV
  if (string.IsNullOrEmpty)(resName) then
    return ""
  else
    return self.SectorPath .. resName .. self.PrefabExtension
  end
end

-- DECOMPILER ERROR at PC96: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetSkillIconPath = function(self, skillIcon)
  -- function num : 0_8
  return self.SkillIconPathHead .. skillIcon .. ".png"
end

-- DECOMPILER ERROR at PC99: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetCharacterPicPath = function(self, resName)
  -- function num : 0_9
  return self.CharacterPicPathHead .. resName .. "/npic_" .. resName .. ".png"
end

-- DECOMPILER ERROR at PC102: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetCharacterLive2DPath = function(self, resName)
  -- function num : 0_10
  return self.CharacterPicPathHead .. resName .. "/L2D/" .. resName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC105: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetCharacterFaceImgPath = function(self, resName, faceId)
  -- function num : 0_11
  return self.CharacterPicPathHead .. resName .. "/Face/" .. resName .. "_face_" .. faceId .. ".png"
end

-- DECOMPILER ERROR at PC108: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetCharacterBigImgPrefabPath = function(self, resName)
  -- function num : 0_12
  return self.CharacterBigImgPrefabHead .. resName .. "/lpic_" .. resName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC111: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetCharacterSmallPicPath = function(self, resName)
  -- function num : 0_13
  return self.CharacterPicPathHead .. resName .. "/spic_" .. resName .. ".png"
end

-- DECOMPILER ERROR at PC114: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetCharacterModelPrefabPath = function(self, prefabName)
  -- function num : 0_14 , upvalues : cs_FilePathHelper
  return cs_FilePathHelper:GetCharacterModelPrefabPath(prefabName)
end

-- DECOMPILER ERROR at PC117: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetFriendshipDungeonPicPath = function(self, resName)
  -- function num : 0_15
  return self.FriendshipDungeonPicHead .. "HeroStory" .. resName .. ".png"
end

-- DECOMPILER ERROR at PC120: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetMaterailDungeonPicPath = function(self, resName)
  -- function num : 0_16
  return self.MaterialDungeonPicHead .. "MatBg" .. resName .. ".png"
end

-- DECOMPILER ERROR at PC123: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetOasisBuildingIconPath = function(self, resName)
  -- function num : 0_17
  return self.OasisBuildingIconPath .. resName .. ".png"
end

-- DECOMPILER ERROR at PC126: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetMaterialDungeonBGIconPath = function(self, resName)
  -- function num : 0_18
  return self.MaterialDungeonBGIconPath .. resName .. ".png"
end

-- DECOMPILER ERROR at PC129: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetAchivLevelIconPath = function(self, resName)
  -- function num : 0_19
  return self.AchivLevelIconPath .. resName .. ".png"
end

-- DECOMPILER ERROR at PC132: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetDormRoomPath = function(self, resName)
  -- function num : 0_20
  return self.DormRoomPath .. resName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC135: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetDormFntPath = function(self, resName)
  -- function num : 0_21
  return self.DormFntPath .. resName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC138: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetCharacterDormModelPath = function(self, prefabName)
  -- function num : 0_22
  return self.CharacterBigImgPrefabHead .. prefabName .. "/dmodel_" .. prefabName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC141: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetAvgImgPath = function(self, name)
  -- function num : 0_23
  return self.AvgImgPath .. name .. ".png"
end

-- DECOMPILER ERROR at PC144: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetFormationModelPath = function(self, prefabName)
  -- function num : 0_24
  return self.FormationPath .. prefabName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC147: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetCampPicPath = function(self, resName)
  -- function num : 0_25
  return self.CampIconPath .. resName .. ".png"
end

-- DECOMPILER ERROR at PC150: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetAtlasAssetPath = function(self, atlasName)
  -- function num : 0_26
  return self.SpriteAtlasPathHead .. atlasName .. self.SpriteAtlasExtension
end

-- DECOMPILER ERROR at PC153: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetEffectPath = function(self, prefabName)
  -- function num : 0_27
  return self.EffectPath .. prefabName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC156: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetPersistentUserDataPath = function(self, strplayerId)
  -- function num : 0_28
  return self.PersistentUserDataPath .. strplayerId .. self.DataExtension
end

-- DECOMPILER ERROR at PC159: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetPersistentSystemDataPath = function(self, fileName)
  -- function num : 0_29
  return self.PersistentDataPath .. fileName .. self.DataExtension
end

-- DECOMPILER ERROR at PC162: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetPersistentDeployDataPath = function(self, strplayerId, fileName)
  -- function num : 0_30
  return self.PersistentDeployDataPath .. strplayerId .. "/" .. fileName .. self.DataExtension
end

-- DECOMPILER ERROR at PC165: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetPersistentBannerCachePath = function(self, fileName)
  -- function num : 0_31
  return self.PersistentBannerCachePath .. fileName .. ".png"
end

-- DECOMPILER ERROR at PC168: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetSectorBackgroundPath = function(self, resName)
  -- function num : 0_32
  return self.SectorBackgroundPath .. resName .. ".png"
end

-- DECOMPILER ERROR at PC171: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetSectorStrategyOverviewBgPath = function(self, resName)
  -- function num : 0_33
  return "Res/Images/StrategyOverview/" .. resName .. ".png"
end

-- DECOMPILER ERROR at PC174: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetBannerPicPath = function(self, fileName)
  -- function num : 0_34
  return self.BannerPicPath .. fileName .. ".png"
end

-- DECOMPILER ERROR at PC177: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetLotteryPicPath = function(self, fileName)
  -- function num : 0_35
  return self.LotteryPicPath .. fileName .. ".png"
end

-- DECOMPILER ERROR at PC180: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetLotteryModelPath = function(self, fileName)
  -- function num : 0_36
  return self.LotteryModelPath .. fileName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC183: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetSeceneIconPicPath = function(self, resName)
  -- function num : 0_37
  return self.SeceneIconPicPath .. resName .. ".png"
end

-- DECOMPILER ERROR at PC186: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetFactoryPath = function(self, resName)
  -- function num : 0_38
  return self.FactoryPath .. resName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC189: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetSpriteAtlasPath = function(self, resName)
  -- function num : 0_39
  return self.SpriteAtlasPathHead .. resName .. ".spriteatlas"
end

-- DECOMPILER ERROR at PC192: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetTreeDCanvasPath = function(self, canvasName)
  -- function num : 0_40
  return self.TreeDCanvasPath .. canvasName .. ".prefab"
end

-- DECOMPILER ERROR at PC195: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetShopGiftBgPath = function(self, resName)
  -- function num : 0_41
  return self.ShopGiftBgPath .. resName .. ".png"
end

-- DECOMPILER ERROR at PC198: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetShopRecommendPath = function(self, resName)
  -- function num : 0_42
  return self.ShopRecommendPath .. resName .. ".png"
end



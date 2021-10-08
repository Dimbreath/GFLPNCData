local cs_PathConsts = CS.PathConsts
local cs_FilePathHelper = (CS.FilePathHelper).Instance
PathConsts = {SpriteAtlasExtension = cs_PathConsts.SpriteAtlasExtension, PrefabExtension = cs_PathConsts.PrefabExtension, DataExtension = ".dat", SpriteAtlasPathHead = cs_PathConsts.SpriteAtlasPathHead, UIPrefabPathHead = cs_PathConsts.UIPrefabPathHead, ModelPrefabPath = cs_PathConsts.ModelPrefabPath, OasisBuildingPath = cs_PathConsts.OasisBuildingPrefabPath, OasisBuildingEffectPath = "Res/Effect/Prefabs/OasisBuilding/", SectorPath = "Res/Model/Sector/", PbFilePath = "Res/pb/", SkillIconPathHead = "Res/Images/SkillIcons/", CharacterPicPathHead = cs_PathConsts.CharacterPicPathHead, CharacterBigImgPrefabHead = cs_PathConsts.CharacterBigImgPrefabHead, FriendshipDungeonPicHead = "Res/Images/HeroStoryLevel/", MaterialDungeonPicHead = "Res/Images/MaterialLevel/Background/", OasisBuildingIconPath = "Res/Images/OasisBuilding/", AchievementIconPath = "Res/Images/AchievementIcon/", AchivLevelIconPath = "Res/Images/AchivLevelIcon/", MaterialDungeonBGIconPath = "Res/Images/MaterialLevel/Icon/", DormPath = "Res/Model/Dorm/", DormRoomPath = "Res/Model/Dorm/Rooms/", DormFntPath = "Res/Model/Dorm/Furnitures/", AvgImgPath = "Res/Images/Avg/", AvgNounImgPath = "Res/Images/Avg/NounDes/", FormationPath = "Res/Model/Formation/", CampIconPath = "Res/Images/CampIcon/", EffectPath = "Res/Effect/Prefabs/", PersistentUserDataPath = cs_PathConsts.PersistentDataPath .. "save_data/user_data/", PersistentDataPath = cs_PathConsts.PersistentDataPath .. "save_data/", PersistentDeployDataPath = cs_PathConsts.PersistentDataPath .. "save_data/deploy_data/", PersistentBannerCachePath = cs_PathConsts.PersistentDataPath .. "res_cache/banner_img/", PersistentNoticeCachePath = cs_PathConsts.PersistentDataPath .. "res_cache/notice_cache/", SectorBackgroundPath = "Res/Images/SectorLevel/", BannerPicPath = "Res/Images/HomeAdv/", LotteryPicPath = "Res/Images/Lottery/", LotteryModelPath = "Res/Model/LotteryShow/", SeceneIconPicPath = "Res/Images/SectorIcon/", ImagePath = "Res/Images/", FactoryPath = "Res/Model/Factory/", CampVideoPath = "GetHero/", UltSkillVideoPath = "UltSkill/", SectorLoadVideoPath = "SectorLoading/", SectorCompleteVideoPath = "SectorAnimation/", LuaSkillScriptsPath = cs_PathConsts.LuaSkillScriptsPath, TreeDCanvasPath = "Res/UIPrefabs/Common/", FestivalSignPath = "Res/UIPrefabs/FestivalSignIn/", ShopGiftBgPath = "Res/Images/Shop/GiftBag/", ShopRecommendPath = "Res/Images/Shop/Recommend/", GuideTipsPathHead = "Res/Images/Guide/", UserInfoDressUpPathHead = "Res/Images/UserInfoDressUp/"}
-- DECOMPILER ERROR at PC83: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetImagePath = function(self, name)
  -- function num : 0_0
  return self.ImagePath .. name .. ".png"
end

-- DECOMPILER ERROR at PC86: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetHeroVideoPath = function(self, videoName)
  -- function num : 0_1
  return self.CampVideoPath .. videoName
end

-- DECOMPILER ERROR at PC89: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetSectorLoadVideoPath = function(self, videoName)
  -- function num : 0_2
  return self.SectorLoadVideoPath .. videoName
end

-- DECOMPILER ERROR at PC92: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetModelPrefabPath = function(self, prefabName)
  -- function num : 0_3
  return self.ModelPrefabPath .. prefabName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC95: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetUIPrefabPath = function(self, resName)
  -- function num : 0_4 , upvalues : _ENV
  if (string.IsNullOrEmpty)(resName) then
    return ""
  else
    return self.UIPrefabPathHead .. resName .. self.PrefabExtension
  end
end

-- DECOMPILER ERROR at PC98: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetOasisBuildingPrefabPath = function(self, resName)
  -- function num : 0_5 , upvalues : _ENV
  if (string.IsNullOrEmpty)(resName) then
    return ""
  else
    return self.OasisBuildingPath .. resName .. self.PrefabExtension
  end
end

-- DECOMPILER ERROR at PC101: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetOasisBuildingEffetPrefabPath = function(self, resName)
  -- function num : 0_6 , upvalues : _ENV
  if (string.IsNullOrEmpty)(resName) then
    return ""
  else
    return self.OasisBuildingEffectPath .. resName .. self.PrefabExtension
  end
end

-- DECOMPILER ERROR at PC104: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetOasisPrefabPath = function(self, resName)
  -- function num : 0_7 , upvalues : _ENV
  if (string.IsNullOrEmpty)(resName) then
    return ""
  else
    return "Res/Model/Oasis/" .. resName .. self.PrefabExtension
  end
end

-- DECOMPILER ERROR at PC107: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetSectorPrefabPath = function(self, resName)
  -- function num : 0_8 , upvalues : _ENV
  if (string.IsNullOrEmpty)(resName) then
    return ""
  else
    return self.SectorPath .. resName .. self.PrefabExtension
  end
end

-- DECOMPILER ERROR at PC110: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetSkillIconPath = function(self, skillIcon)
  -- function num : 0_9
  return self.SkillIconPathHead .. skillIcon .. ".png"
end

-- DECOMPILER ERROR at PC113: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetProfessorModelPath = function(self, sexName, resName)
  -- function num : 0_10
  return self.CharacterPicPathHead .. sexName .. "/" .. resName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC116: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetCharacterTexturePath = function(self, path)
  -- function num : 0_11
  return self.CharacterPicPathHead .. path .. ".png"
end

-- DECOMPILER ERROR at PC119: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetCharacterPicPath = function(self, resName)
  -- function num : 0_12
  return self.CharacterPicPathHead .. resName .. "/npic_" .. resName .. ".png"
end

-- DECOMPILER ERROR at PC122: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetCharacterLive2DPath = function(self, resName)
  -- function num : 0_13
  return self.CharacterPicPathHead .. resName .. "/L2D/" .. resName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC125: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetCharacterFaceImgPath = function(self, resName, faceId)
  -- function num : 0_14
  return self.CharacterPicPathHead .. resName .. "/Face/" .. resName .. "_face_" .. faceId .. ".png"
end

-- DECOMPILER ERROR at PC128: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetCharacterBigImgPrefabPath = function(self, resName)
  -- function num : 0_15
  return self.CharacterBigImgPrefabHead .. resName .. "/lpic_" .. resName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC131: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetCharacterSmallPicPath = function(self, resName)
  -- function num : 0_16
  return self.CharacterPicPathHead .. resName .. "/spic_" .. resName .. ".png"
end

-- DECOMPILER ERROR at PC134: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetCharacterModelPrefabPath = function(self, prefabName, perfectLevel, extraPreSign)
  -- function num : 0_17 , upvalues : cs_FilePathHelper
  if not perfectLevel then
    perfectLevel = -1
  end
  return cs_FilePathHelper:GetCharacterModelPrefabPath(prefabName, perfectLevel, extraPreSign)
end

-- DECOMPILER ERROR at PC137: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetFriendshipDungeonPicPath = function(self, resName)
  -- function num : 0_18
  return self.FriendshipDungeonPicHead .. "HeroStory" .. resName .. ".png"
end

-- DECOMPILER ERROR at PC140: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetMaterailDungeonPicPath = function(self, resName)
  -- function num : 0_19
  return self.MaterialDungeonPicHead .. "MatBg" .. resName .. ".png"
end

-- DECOMPILER ERROR at PC143: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetOasisBuildingIconPath = function(self, resName)
  -- function num : 0_20
  return self.OasisBuildingIconPath .. resName .. ".png"
end

-- DECOMPILER ERROR at PC146: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetMaterialDungeonBGIconPath = function(self, resName)
  -- function num : 0_21
  return self.MaterialDungeonBGIconPath .. resName .. ".png"
end

-- DECOMPILER ERROR at PC149: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetAchivLevelIconPath = function(self, resName)
  -- function num : 0_22
  return self.AchivLevelIconPath .. resName .. ".png"
end

-- DECOMPILER ERROR at PC152: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetDormPath = function(self, resName)
  -- function num : 0_23
  return self.DormPath .. resName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC155: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetDormRoomPath = function(self, resName)
  -- function num : 0_24
  return self.DormRoomPath .. resName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC158: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetDormFntPath = function(self, resName)
  -- function num : 0_25
  return self.DormFntPath .. resName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC161: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetCharacterDormModelPath = function(self, prefabName)
  -- function num : 0_26
  return self.CharacterBigImgPrefabHead .. prefabName .. "/dmodel_" .. prefabName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC164: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetCharacterFightModelPath = function(self, prefabName)
  -- function num : 0_27
  return self.CharacterBigImgPrefabHead .. prefabName .. "/fmodel_" .. prefabName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC167: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetAvgImgPath = function(self, name)
  -- function num : 0_28
  return self.AvgImgPath .. name .. ".png"
end

-- DECOMPILER ERROR at PC170: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetFormationModelPath = function(self, prefabName)
  -- function num : 0_29
  return self.FormationPath .. prefabName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC173: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetCampPicPath = function(self, resName)
  -- function num : 0_30
  return self.CampIconPath .. resName .. ".png"
end

-- DECOMPILER ERROR at PC176: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetAvgNounImgPath = function(self, ImgName)
  -- function num : 0_31
  return self.AvgNounImgPath .. ImgName .. ".png"
end

-- DECOMPILER ERROR at PC179: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetAtlasAssetPath = function(self, atlasName)
  -- function num : 0_32
  return self.SpriteAtlasPathHead .. atlasName .. self.SpriteAtlasExtension
end

-- DECOMPILER ERROR at PC182: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetEffectPath = function(self, prefabName)
  -- function num : 0_33
  return self.EffectPath .. prefabName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC185: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetPersistentUserDataPath = function(self, strplayerId)
  -- function num : 0_34
  return self.PersistentUserDataPath .. strplayerId .. self.DataExtension
end

-- DECOMPILER ERROR at PC188: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetPersistentSystemDataPath = function(self, fileName)
  -- function num : 0_35
  return self.PersistentDataPath .. fileName .. self.DataExtension
end

-- DECOMPILER ERROR at PC191: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetPersistentDeployDataPath = function(self, strplayerId, fileName)
  -- function num : 0_36
  return self.PersistentDeployDataPath .. strplayerId .. "/" .. fileName .. self.DataExtension
end

-- DECOMPILER ERROR at PC194: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetPersistentBannerCachePath = function(self, fileName)
  -- function num : 0_37
  return self.PersistentBannerCachePath .. fileName .. ".png"
end

-- DECOMPILER ERROR at PC197: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetPersistentNoticeCachePath = function(self, fileName)
  -- function num : 0_38
  return self.PersistentNoticeCachePath .. fileName .. ".png"
end

-- DECOMPILER ERROR at PC200: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetSectorBackgroundPath = function(self, resName)
  -- function num : 0_39
  return self.SectorBackgroundPath .. resName .. ".png"
end

-- DECOMPILER ERROR at PC203: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetSectorStrategyOverviewBgPath = function(self, resName)
  -- function num : 0_40
  return "Res/Images/StrategyOverview/" .. resName .. ".png"
end

-- DECOMPILER ERROR at PC206: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetBannerPicPath = function(self, fileName)
  -- function num : 0_41
  return self.BannerPicPath .. fileName .. ".png"
end

-- DECOMPILER ERROR at PC209: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetLotteryPicPath = function(self, fileName)
  -- function num : 0_42
  return self.LotteryPicPath .. fileName .. ".png"
end

-- DECOMPILER ERROR at PC212: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetLotteryModelPath = function(self, fileName)
  -- function num : 0_43
  return self.LotteryModelPath .. fileName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC215: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetSeceneIconPicPath = function(self, resName)
  -- function num : 0_44
  return self.SeceneIconPicPath .. resName .. ".png"
end

-- DECOMPILER ERROR at PC218: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetFactoryPath = function(self, resName)
  -- function num : 0_45
  return self.FactoryPath .. resName .. self.PrefabExtension
end

-- DECOMPILER ERROR at PC221: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetSpriteAtlasPath = function(self, resName)
  -- function num : 0_46
  return self.SpriteAtlasPathHead .. resName .. ".spriteatlas"
end

-- DECOMPILER ERROR at PC224: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetTreeDCanvasPath = function(self, canvasName)
  -- function num : 0_47
  return self.TreeDCanvasPath .. canvasName .. ".prefab"
end

-- DECOMPILER ERROR at PC227: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetShopGiftBgPath = function(self, resName)
  -- function num : 0_48
  return self.ShopGiftBgPath .. resName .. ".png"
end

-- DECOMPILER ERROR at PC230: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetShopRecommendPath = function(self, resName)
  -- function num : 0_49
  return self.ShopRecommendPath .. resName .. ".png"
end

-- DECOMPILER ERROR at PC233: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetGuideTipsPath = function(self, path, resName)
  -- function num : 0_50
  return self.GuideTipsPathHead .. path .. "/" .. resName .. ".png"
end

-- DECOMPILER ERROR at PC236: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetUserDressUpPath = function(self, resName)
  -- function num : 0_51
  return self.UserInfoDressUpPathHead .. resName .. ".png"
end

-- DECOMPILER ERROR at PC239: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetSectorCompleteVideoPath = function(self, sectorId)
  -- function num : 0_52
  return self.SectorCompleteVideoPath .. "SectorAnimation_" .. sectorId
end

-- DECOMPILER ERROR at PC242: Confused about usage of register: R2 in 'UnsetPending'

PathConsts.GetFestivalSignPath = function(self, path)
  -- function num : 0_53
  return self.FestivalSignPath .. path .. ".prefab"
end



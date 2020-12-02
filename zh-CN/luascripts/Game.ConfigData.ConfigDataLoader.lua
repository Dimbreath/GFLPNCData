-- params : ...
-- function num : 0 , upvalues : _ENV
require("Game.ConfigData.ConfigData")
local ConfigDataLoader = {}
local data_name_list = {
{"locale_text", "locale_text"}
, 
{"factory", "factory"}
, 
{"shop", "shop"}
, 
{"shop_normal", "shop_normal"}
, 
{"item_currency", "item_currency_price"}
, 
{"gashapon_para", "gashapon_para"}
, 
{"gashapon", "gashapon"}
, 
{"gashapon_buildfree_pool", "gashapon_buildfree_pool"}
, 
{"gashapon_reward_pool", "gashapon_reward_pool"}
, 
{"building", "oasis_building"}
, 
{"buildingLevel", "oasis_building_level"}
, 
{"buildingBuff", "building_buff"}
, 
{"training", "training"}
, 
{"task", "task"}
, 
{"taskStep", "task_step"}
, 
{"sectorAchievement", "sector_achievement"}
, 
{"game_config", "game_config"}
, 
{"hero_data", "hero_data"}
, 
{"hero_level", "hero_level"}
, 
{"hero_skill", "hero_skill"}
, 
{"hero_skill_level", "hero_skill_level"}
, 
{"hero_rank", "hero_rank"}
, 
{"hero_star", "hero_star"}
, 
{"item", "item"}
, 
{"sector", "sector"}
, 
{"sector_stage", "sector_stage"}
, 
{"sector_unlock_mention", "sector_unlock_mention"}
, 
{"active", "active"}
, 
{"achievement_level", "achievement_level"}
, 
{"achievement", "achievement"}
, 
{"chip", "chip"}
, 
{"chip_tag", "chip_tag"}
, 
{"chip_intro", "chip_intro"}
, 
{"resource_model", "resource_model"}
, 
{"camp", "camp"}
, 
{"career", "career"}
, 
{"camp_connection", "camp_connection"}
, 
{"exploration_treasure", "exploration_treasure"}
, 
{"treasure_logic2", "treasure_logic2"}
, 
{"monster", "monster"}
, 
{"event", "event"}
, 
{"event_choice", "event_choice"}
, 
{"event_upgrade", "event_upgrade"}
, 
{"event_jump", "event_jump"}
, 
{"exploration_reconsitution", "exploration_reconsitution"}
, 
{"exploration", "exploration"}
, 
{"ep_function_pool", "exploration_function_pool"}
, 
{"attribute", "attribute"}
, 
{"exploration_buff", "exploration_buff"}
, 
{"exploration_roomtype", "exploration_roomtype"}
, 
{"exploration_shop", "exploration_shop"}
, 
{"audio", "audio"}
, 
{"audio_category", "audio_category"}
, 
{"system_open", "system_open"}
, 
{"guide", "guide"}
, 
{"guide_step", "guide_step"}
, 
{"tips_guide", "tips_guide"}
, 
{"oasis_area", "oasis_area"}
, 
{"system_jump", "system_jump"}
, 
{"arithmetic", "arithmetic"}
, 
{"ath_affix_pool", "ath_affix_pool"}
, 
{"ath_attribute_pool", "ath_attribute_pool"}
, 
{"ath_efficiency", "ath_efficiency"}
, 
{"ath_suit", "ath_suit"}
, 
{"ath_area", "ath_area"}
, 
{"ath_shard", "ath_shard"}
, 
{"ath_affix_lv", "ath_affix_lv"}
, 
{"ath_reconsitution", "ath_reconsitution"}
, 
{"anti_addiction", "anti_addiction"}
, 
{"dorm_house", "dorm_house"}
, 
{"dorm_room", "dorm_room"}
, 
{"dorm_comfort", "dorm_comfort"}
, 
{"dorm_furniture", "dorm_furniture"}
, 
{"dorm_ai", "dorm_ai"}
, 
{"dorm_action", "dorm_action"}
, 
{"dorm_interpoint", "dorm_interpoint"}
, 
{"tip_language", "tip_language"}
, 
{"star_score", "star_score"}
, 
{"life_skill", "life_skill"}
, 
{"friendship_level", "friendship_level"}
, 
{"friendship_gift", "friendship_gift"}
, 
{"friendship_hero", "friendship_hero"}
, 
{"friendship_foster", "friendship_foster"}
, 
{"friendship_total_level", "friendship_total_level"}
, 
{"battle_dungeon", "battle_dungeon"}
, 
{"material_dungeon", "material_dungeon"}
, 
{"hero_score", "hero_score"}
, 
{"scene", "scene"}
, 
{"level_arrange", "level_arrange"}
, 
{"overclock", "overclock"}
, 
{"event_random", "event_random"}
, 
{"story_avg", "story_avg"}
, 
{"story_condition_text", "story_condition_text"}
, 
{"commander_skill", "commander_skill"}
, 
{"commander_skill_unlock", "commander_skill_unlock"}
, 
{"commander_skill_level", "commander_skill_level"}
, 
{"commander_skill_master_level", "commander_skill_master_level"}
, 
{"monster_tag", "monster_tag"}
, 
{"battle_grid", "battle_grid"}
, 
{"shop_page", "shop_page"}
, 
{"shop_hero", "shop_hero"}
, 
{"shop_resource", "shop_resource"}
, 
{"exploration_discard", "exploration_discard"}
, 
{"banner", "banner"}
, 
{"avg_character", "avg_character"}
, 
{"homeside_info", "homeside_info"}
, 
{"overload", "overload"}
, 
{"dungeon_info", "dungeon_info"}
}
ConfigDataLoader.LoadConfigHead = "LuaConfigs."
ConfigDataLoader.GetConfigNameList = function()
  -- function num : 0_0 , upvalues : data_name_list
  return data_name_list
end

ConfigDataLoader.AfterLoadConfigComplete = function()
  -- function num : 0_1 , upvalues : _ENV
  ConfigData:InitConfigData()
  ;
  ((CS.GameData).instance):InitGameConfigFromLua(ConfigData.game_config, ConfigData.buildinConfig)
  require("Game.ConfigData.LanguageUtil")
end

return ConfigDataLoader


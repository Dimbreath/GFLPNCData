local __rt_1 = {}
local resource_model = {
[1001] = {atk1_frames = 28, atk1_trigger_frames = 9, atk2_frames = 28, atk2_trigger_frames = 8, res_Name = "persicaria", 
win_effect_id = {100111}
}
, 
[1002] = {atk1_frames = 21, atk1_trigger_frames = 10, atk2_frames = 29, atk2_trigger_frames = 11, base_move_spd = 80, id = 1002, res_Name = "anna"}
, 
[1003] = {atk1_frames = 28, atk1_trigger_frames = 10, atk2_frames = 28, atk2_trigger_frames = 21, base_move_spd = 120, id = 1003, res_Name = "sol", 
win_effect_id = {100308}
}
, 
[1004] = {atk1_frames = 23, atk1_trigger_frames = 8, atk2_frames = 23, atk2_trigger_frames = 8, base_move_spd = 120, id = 1004, res_Name = "simo"}
, 
[1005] = {atk1_frames = 22, atk1_trigger_frames = 6, atk2_frames = 28, atk2_trigger_frames = 8, base_move_spd = 80, hit_target_type = 2, id = 1005, res_Name = "croque"}
, 
[1006] = {atk1_frames = 28, atk1_trigger_frames = 6, atk2_frames = 28, atk2_trigger_frames = 7, id = 1006, res_Name = "fresnel"}
, 
[1007] = {atk1_frames = 26, atk1_trigger_frames = 5, atk2_frames = 26, atk2_trigger_frames = 5, base_move_spd = 130, id = 1007, res_Name = "chelsea", 
win_effect_id = {100708}
}
, 
[1008] = {atk1_frames = 33, atk1_trigger_frames = 18, atk2_frames = 55, atk2_trigger_frames = 42, base_move_spd = 80, id = 1008, res_Name = "gin", 
win_effect_id = {100806}
}
, 
[1009] = {atk1_frames = 22, atk1_trigger_frames = 8, atk2_frames = 19, atk2_trigger_frames = 9, id = 1009, res_Name = "mai"}
, 
[1010] = {atk1_frames = 40, atk1_trigger_frames = 25, atk2_frames = 40, atk2_trigger_frames = 25, base_move_spd = 80, hit_target_type = 2, id = 1010, res_Name = "evelyn", 
win_effect_id = {101008}
}
, 
[1011] = {atk1_frames = 24, atk1_trigger_frames = 8, atk2_frames = 24, atk2_trigger_frames = 9, id = 1011, res_Name = "camellia"}
, 
[1012] = {atk1_frames = 21, atk1_trigger_frames = 6, atk2_frames = 22, atk2_trigger_frames = 10, base_move_spd = 120, id = 1012, res_Name = "max"}
, 
[1013] = {atk1_frames = 31, atk1_trigger_frames = 7, atk2_frames = 30, atk2_trigger_frames = 7, base_move_spd = 150, id = 1013, res_Name = "betty", 
win_effect_id = {101308}
}
, 
[1014] = {atk1_frames = 21, atk1_trigger_frames = 7, atk2_frames = 21, atk2_trigger_frames = 7, base_move_spd = 120, id = 1014, res_Name = "choco"}
, 
[1015] = {atk1_frames = 30, atk1_trigger_frames = 10, atk2_frames = 30, atk2_trigger_frames = 10, base_move_spd = 140, id = 1015, res_Name = "panakeia", 
win_effect_id = {101517}
}
, 
[1016] = {atk1_frames = 21, atk1_trigger_frames = 5, atk2_frames = 23, atk2_trigger_frames = 7, base_move_spd = 120, id = 1016, res_Name = "banxsy", 
win_effect_id = {101608, 101609}
}
, 
[1017] = {atk1_frames = 22, atk1_trigger_frames = 6, atk2_frames = 22, atk2_trigger_frames = 6, id = 1017, res_Name = "angela", 
win_effect_id = {101701}
}
, 
[1018] = {atk1_frames = 32, atk1_trigger_frames = 7, atk2_frames = 27, atk2_trigger_frames = 6, id = 1018, res_Name = "florence", 
win_effect_id = {101811}
}
, 
[1019] = {atk1_frames = 23, atk1_trigger_frames = 8, atk2_frames = 28, atk2_trigger_frames = 8, base_move_spd = 130, id = 1019, res_Name = "fern", 
win_effect_id = {101903}
}
, 
[1020] = {atk1_frames = 41, atk1_trigger_frames = 12, atk2_frames = 38, atk2_trigger_frames = 12, base_move_spd = 80, hit_target_type = 2, id = 1020, res_Name = "yanny", 
win_effect_id = {102008}
}
, 
[1021] = {atk1_frames = 22, atk1_trigger_frames = 6, atk2_frames = 39, atk2_trigger_frames = 7, base_move_spd = 80, id = 1021, res_Name = "groove", 
win_effect_id = {102101}
}
, 
[1022] = {atk1_frames = 28, atk1_trigger_frames = 10, atk2_frames = 34, atk2_trigger_frames = 12, base_move_spd = 120, id = 1022, res_Name = "aki", 
win_effect_id = {102203}
}
, 
[1023] = {atk1_frames = 22, atk1_trigger_frames = 12, atk2_frames = 22, atk2_trigger_frames = 10, hit_target_type = 2, id = 1023, res_Name = "bonee", 
win_effect_id = {102301}
}
, 
[1024] = {atk1_frames = 21, atk1_trigger_frames = 10, atk2_frames = 21, atk2_trigger_frames = 9, base_move_spd = 120, id = 1024, res_Name = "earhart"}
, 
[1025] = {atk1_frames = 29, atk1_trigger_frames = 9, atk2_frames = 26, atk2_trigger_frames = 10, id = 1025, res_Name = "twigs", 
win_effect_id = {102510, 102511}
}
, 
[1026] = {atk1_frames = 27, atk1_trigger_frames = 13, atk2_frames = 27, atk2_trigger_frames = 15, id = 1026, res_Name = "nanaka"}
, 
[1027] = {atk1_frames = 32, atk1_trigger_frames = 6, atk2_frames = 32, atk2_trigger_frames = 6, base_move_spd = 80, hit_target_type = 2, id = 1027, res_Name = "zion", 
win_effect_id = {102701}
}
, 
[1028] = {atk1_frames = 23, atk1_trigger_frames = 11, atk2_frames = 23, atk2_trigger_frames = 11, id = 1028, res_Name = "vee"}
, 
[1029] = {atk1_frames = 32, atk1_trigger_frames = 15, atk2_frames = 29, atk2_trigger_frames = 15, id = 1029, res_Name = "willow", 
win_effect_id = {102908, 102909, 102910, 102911}
}
, 
[1030] = {atk1_frames = 28, atk1_trigger_frames = 11, atk2_frames = 38, atk2_trigger_frames = 14, id = 1030, res_Name = "ksenia", 
win_effect_id = {103002}
}
, 
[1031] = {atk1_frames = 30, atk1_trigger_frames = 8, atk2_frames = 30, atk2_trigger_frames = 8, base_move_spd = 120, id = 1031, res_Name = "imhotep"}
, 
[1032] = {atk1_frames = 41, atk1_trigger_frames = 7, atk2_frames = 41, atk2_trigger_frames = 7, base_move_spd = 150, id = 1032, res_Name = "octogen", 
win_effect_id = {103210}
}
, 
[1033] = {atk1_frames = 18, atk1_trigger_frames = 5, atk2_frames = 29, atk2_trigger_frames = 6, id = 1033, res_Name = "rise"}
, 
[1034] = {atk1_frames = 29, atk1_trigger_frames = 6, atk2_frames = 31, atk2_trigger_frames = 8, base_move_spd = 130, id = 1034, 
win_effect_id = {103401}
}
, 
[1035] = {atk1_frames = 17, atk1_trigger_frames = 7, atk2_frames = 20, atk2_trigger_frames = 9, base_move_spd = 120, id = 1035, res_Name = "jessie"}
, 
[1036] = {atk1_frames = 15, atk1_trigger_frames = 7, atk2_frames = 15, atk2_trigger_frames = 9, base_move_spd = 80, id = 1036, res_Name = "lam"}
, 
[1037] = {atk1_frames = 20, atk1_trigger_frames = 7, atk2_frames = 25, atk2_trigger_frames = 8, id = 1037, res_Name = "hubble", 
win_effect_id = {103701}
}
, 
[1038] = {atk1_frames = 25, atk1_trigger_frames = 5, atk2_frames = 25, atk2_trigger_frames = 5, base_move_spd = 150, id = 1038, res_Name = "sakuya", 
win_effect_id = {103804, 103805, 103806}
}
, 
[1039] = {atk1_frames = 33, atk1_trigger_frames = 6, atk2_frames = 33, atk2_trigger_frames = 10, base_move_spd = 130, id = 1039, res_Name = "centaureissi"}
, 
[1040] = {atk1_frames = 30, atk1_trigger_frames = 12, atk2_frames = 30, atk2_trigger_frames = 12, id = 1040, res_Name = "dusevnyj"}
, 
[2001] = {atk1_frames = 18, atk1_trigger_frames = 6, atk2_frames = 18, atk2_trigger_frames = 7, id = 2001, res_Name = "raider"}
, 
[2002] = {atk1_frames = 18, atk1_trigger_frames = 4, atk2_frames = 18, atk2_trigger_frames = 4, base_move_spd = 50, id = 2002, res_Name = "purger"}
, 
[2003] = {atk1_frames = 23, atk1_trigger_frames = 12, atk2_frames = 23, atk2_trigger_frames = 12, base_move_spd = 120, id = 2003, res_Name = "patience"}
, 
[2004] = {atk1_frames = 28, atk1_trigger_frames = 14, atk2_frames = 28, atk2_trigger_frames = 14, hit_target_type = 2, id = 2004, res_Name = "reverence"}
, 
[2005] = {atk1_frames = 23, atk1_trigger_frames = 12, atk2_frames = 28, atk2_trigger_frames = 13, boss_lpic = "faith_avg/lpic_faith_avg", hit_target_type = 2, id = 2005, res_Name = "faith"}
, 
[2006] = {atk1_frames = 18, atk1_trigger_frames = 5, atk2_frames = 18, atk2_trigger_frames = 5, id = 2006, res_Name = "refactor"}
, 
[2007] = {atk1_frames = 21, atk1_trigger_frames = 9, atk2_frames = 21, atk2_trigger_frames = 9, id = 2007, res_Name = "defender"}
, 
[2008] = {atk1_frames = 24, atk1_trigger_frames = 9, atk2_frames = 27, atk2_trigger_frames = 9, hit_target_type = 2, id = 2008, res_Name = "fortitude"}
, 
[2009] = {atk1_frames = 15, atk1_trigger_frames = 7, atk2_frames = 19, atk2_trigger_frames = 9, boss_lpic = "mara_avg/lpic_mara_avg", id = 2009, res_Name = "mara"}
, 
[2010] = {atk1_frames = 15, atk1_trigger_frames = 7, atk2_frames = 19, atk2_trigger_frames = 9, extend_res = "mara", id = 2010, res_Name = "mara-blue"}
, 
[2011] = {atk1_frames = 26, atk1_trigger_frames = 12, atk2_frames = 29, atk2_trigger_frames = 12, base_move_spd = 50, hit_target_type = 2, id = 2011, res_Name = "protector"}
, 
[2012] = {atk1_frames = 20, atk1_trigger_frames = 5, atk2_frames = 20, atk2_trigger_frames = 6, id = 2012, res_Name = "temperance"}
, 
[2013] = {atk1_frames = 18, atk1_trigger_frames = 6, atk2_frames = 18, atk2_trigger_frames = 7, extend_res = "raider", id = 2013, res_Name = "raider2"}
, 
[2014] = {atk1_frames = 18, atk1_trigger_frames = 4, atk2_frames = 18, atk2_trigger_frames = 4, base_move_spd = 50, extend_res = "purger", id = 2014, res_Name = "purger2"}
, 
[2015] = {atk1_frames = 21, atk1_trigger_frames = 9, atk2_frames = 21, atk2_trigger_frames = 9, extend_res = "defender", id = 2015, res_Name = "defender2"}
, 
[2016] = {atk1_frames = 26, atk1_trigger_frames = 12, atk2_frames = 29, atk2_trigger_frames = 12, extend_res = "protector", hit_target_type = 2, id = 2016, res_Name = "protector2"}
, 
[2017] = {atk1_frames = 18, atk1_trigger_frames = 5, atk2_frames = 18, atk2_trigger_frames = 5, extend_res = "refactor", id = 2017, res_Name = "refactor2"}
, 
[2018] = {atk1_frames = 10, atk1_trigger_frames = 10, atk2_frames = 10, atk2_trigger_frames = 10, base_move_spd = 10, hit_target_type = 2, id = 2018, res_Name = "portal"}
, 
[2019] = {atk1_frames = 21, atk1_trigger_frames = 7, atk2_frames = 21, atk2_trigger_frames = 7, id = 2019, res_Name = "beelneith"}
, 
[2020] = {atk1_frames = 30, atk1_trigger_frames = 15, atk2_frames = 30, atk2_trigger_frames = 17, base_move_spd = 80, id = 2020, res_Name = "gabrie"}
, 
[2021] = {atk1_frames = 21, atk1_trigger_frames = 7, atk2_frames = 21, atk2_trigger_frames = 7, id = 2021, res_Name = "hesperus"}
, 
[2022] = {atk1_frames = 25, atk1_trigger_frames = 10, atk2_frames = 25, atk2_trigger_frames = 10, boss_lpic = "hope/lpic_hope", id = 2022, res_Name = "hope"}
, 
[2023] = {atk1_frames = 24, atk1_trigger_frames = 9, atk2_frames = 18, atk2_trigger_frames = 8, base_move_spd = 80, boss_lpic = "love/lpic_love", id = 2023, res_Name = "love"}
, 
[2024] = {atk1_frames = 20, atk1_trigger_frames = 11, atk2_frames = 20, atk2_trigger_frames = 10, base_move_spd = 80, id = 2024, res_Name = "diligence"}
, 
[2025] = {atk1_frames = 21, atk1_trigger_frames = 7, atk2_frames = 21, atk2_trigger_frames = 11, base_move_spd = 80, hit_target_type = 2, id = 2025, res_Name = "kindness"}
, 
[2026] = {atk1_frames = 24, atk1_trigger_frames = 12, atk2_frames = 24, atk2_trigger_frames = 12, base_move_spd = 60, id = 2026, res_Name = "wisdom"}
, 
[2027] = {atk1_frames = 15, atk1_trigger_frames = 9, atk2_frames = 15, atk2_trigger_frames = 9, base_move_spd = 0, death_frames = 35, id = 2027, res_Name = "imhotep_bird", skin_adapt = "*_bird"}
, 
[2028] = {atk1_frames = 17, atk1_trigger_frames = 11, atk2_frames = 17, atk2_trigger_frames = 11, base_move_spd = 0, id = 2028, res_Name = "imhotep_snake", skin_adapt = "*_snake"}
, 
[2029] = {atk1_frames = 25, atk1_trigger_frames = 11, atk2_frames = 25, atk2_trigger_frames = 11, base_move_spd = 80, id = 2029, res_Name = "twiner"}
, 
[2030] = {atk1_frames = 13, atk1_trigger_frames = 6, atk2_frames = 20, atk2_trigger_frames = 7, base_move_spd = 80, hit_target_type = 2, id = 2030, res_Name = "impactor"}
, 
[2031] = {atk1_frames = 20, atk1_trigger_frames = 9, atk2_frames = 20, atk2_trigger_frames = 9, id = 2031, res_Name = "patience_entropy"}
, 
[2032] = {atk1_frames = 24, atk1_trigger_frames = 12, atk2_frames = 24, atk2_trigger_frames = 12, base_move_spd = 60, id = 2032, res_Name = "wisdom_entropy"}
, 
[2033] = {atk1_frames = 26, atk1_trigger_frames = 7, atk2_frames = 34, atk2_trigger_frames = 12, base_move_spd = 150, id = 2033, res_Name = "fern_dragon", skin_adapt = "*_dragon"}
, 
[2034] = {atk1_frames = 25, atk1_trigger_frames = 10, atk2_frames = 25, atk2_trigger_frames = 10, extend_res = "hope", id = 2034, res_Name = "hope_low"}
, 
[2035] = {atk1_frames = 18, atk1_trigger_frames = 5, atk2_frames = 18, atk2_trigger_frames = 5, id = 2035, res_Name = "mercy"}
, 
[2036] = {atk1_frames = 21, atk1_trigger_frames = 3, atk2_frames = 21, atk2_trigger_frames = 6, hit_target_type = 2, id = 2036, res_Name = "thrower"}
, 
[2037] = {death_frames = 0, id = 2037, res_Name = "mercy_effect"}
, 
[2038] = {atk1_frames = 21, atk1_trigger_frames = 3, atk2_frames = 21, atk2_trigger_frames = 6, extend_res = "thrower", hit_target_type = 2, id = 2038, res_Name = "thrower2"}
, 
[2039] = {atk1_frames = 18, atk1_trigger_frames = 4, atk2_frames = 18, atk2_trigger_frames = 4, base_move_spd = 50, extend_res = "purger", id = 2039, res_Name = "purger3"}
, 
[2040] = {base_move_spd = 0, hit_target_type = 0, id = 2040, res_Name = "digimine_red"}
, 
[2041] = {atk1_frames = 23, atk1_trigger_frames = 8, atk2_frames = 23, atk2_trigger_frames = 8, base_move_spd = 120, id = 2041, res_Name = "simo_shadow"}
, 
[2046] = {atk1_frames = 10, atk1_trigger_frames = 10, atk2_frames = 10, atk2_trigger_frames = 10, base_move_spd = 10, hit_target_type = 2, id = 2046, res_Name = "portal_entropy"}
, 
[2047] = {atk1_frames = 30, atk1_trigger_frames = 15, atk2_frames = 30, atk2_trigger_frames = 17, base_move_spd = 80, id = 2047, res_Name = "eosphorus"}
, 
[3001] = {base_move_spd = 0, death_frames = 0, hit_target_type = 2, id = 3001, res_Name = "roadblock3"}
, 
[3002] = {base_move_spd = 0, death_frames = 0, hit_target_type = 2, id = 3002, res_Name = "roadblock1"}
, 
[3003] = {base_move_spd = 0, death_frames = 0, hit_target_type = 2, id = 3003, res_Name = "roadblock4"}
, 
[3004] = {base_move_spd = 0, death_frames = 0, hit_target_type = 2, id = 3004, res_Name = "roadblock2"}
, 
[3005] = {base_move_spd = 0, death_frames = 0, hit_target_type = 2, id = 3005, res_Name = "sector_obstacles_blue"}
, 
[3006] = {base_move_spd = 0, death_frames = 0, hit_target_type = 2, id = 3006, res_Name = "sector_obstacles_red"}
, 
[3007] = {base_move_spd = 0, death_frames = 0, hit_target_type = 0, id = 3007, res_Name = "beelneith_cake"}
, 
[3008] = {base_move_spd = 0, hit_target_type = 0, id = 3008, res_Name = "professor"}
, 
[3009] = {base_move_spd = 0, hit_target_type = 0, id = 3009, res_Name = "digimine"}
, 
[3010] = {base_move_spd = 0, hit_target_type = 0, id = 3010, res_Name = "memeko"}
, 
[3011] = {death_frames = 0, id = 3011, res_Name = "td_route_monster"}
, 
[3012] = {base_move_spd = 0, hit_target_type = 2, id = 3012, res_Name = "tower_defence"}
, 
[3013] = {base_move_spd = 0, hit_target_type = 3, id = 3013, res_Name = "monstertower_defence"}
, 
[102501] = {atk1_frames = 29, atk1_trigger_frames = 9, atk2_frames = 26, atk2_trigger_frames = 10, id = 102501, res_Name = "twigs_swimsuit"}
}
local __default_values = {atk1_frames = 0, atk1_trigger_frames = 0, atk2_frames = 0, atk2_trigger_frames = 0, base_move_spd = 100, boss_lpic = "", death_frames = 45, extend_res = "", hit_target_type = 1, id = 1001, res_Name = "abigail", skin_adapt = "", win_effect_id = __rt_1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in (_ENV.pairs)(resource_model) do
  (_ENV.setmetatable)(v, base)
end
local __rawdata = {__basemetatable = base}
;
(_ENV.setmetatable)(resource_model, {__index = __rawdata})
return resource_model


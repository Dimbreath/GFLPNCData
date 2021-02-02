-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local __rt_2 = {1011}
local __rt_3 = {1021}
local guide_step = {
[100] = {condition = 1, delay = 0, guide_skip = false, info = 128888, info_type = 0, step_type = 0, target_type = 0, wait_target = false}
, 
[101] = {delay = 0, id = 101, info_type = 0, op_refresh = true, target_name = "Down/Btn_Sector", target_parent = 1}
, 
[102] = {delay = 1.5, id = 102, info = 251769, info_type = 0, target_name = "SectorHolder/1", target_parent = "shanqu", target_type = 2}
, 
[103] = {delay = 0, id = 103, info = 289308, info_type = 0, target_name = "DeploySectorTeam/Btn_Start", target_parent = 8}
, 
[201] = {condition = 3, delay = 0, guide_skip = false, id = 201, info = 135197, info_type = 0, step_type = 0, target_type = 0, wait_target = false}
, 
[202] = {id = 202, info = 308335, info_type = 0, target_name = "return GuideUtil.GetEpFirstRoomTarget()", target_type = 3}
, 
[301] = {condition = 4, id = 301, info = 235328, info_type = 0, target_name = "GameMain/UIRoot/Normal/UI_Battle/Panel_Battle/RightLayout/BattleStart", target_type = 2}
, 
[401] = {condition = 5, delay = 1.2, id = 401, info_type = 0, target_name = "PropHolder/2", target_parent = 102}
, 
[402] = {condition = 5, id = 402, info_type = 0, target_name = "PropHolder/2/Select", target_parent = 102}
, 
[403] = {condition = 6, delay = 2, id = 403, info_type = 0, target_name = "Btn_Contiune", target_parent = 4}
, 
[501] = {condition = 1, delay = 1, id = 501, info = 125485, info_type = 0, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/Btn_Exproation/Btn_ContinueEp", target_parent = 1}
, 
[600] = {condition = 1, delay = 0, guide_skip = false, id = 600, info = 296206, info_type = 0, step_type = 0, target_type = 0, wait_target = false}
, 
[601] = {id = 601, info = 22181, info_type = 0, op_refresh = true, target_name = "Down/Btn_Oasis", target_parent = 1, wait_target = false}
, 
[602] = {delay = 1.5, id = 602, info_type = 0, target_name = "SidebarButton", target_parent = 3}
, 
[603] = {delay = 0.8, id = 603, info = 369299, info_type = 0, target_name = "BuildingSidebar/Scroll View/Content/1002", target_parent = 3}
, 
[604] = {delay = 1.2, id = 604, info_type = 0, target_name = "BulidInfoNode/UpgradeInfo/ReadyPage/Btn_Upgrade", target_parent = 16}
, 
[605] = {delay = 0.8, id = 605, info_type = 0, target_name = "BulidInfoNode/Btn_Close", target_parent = 16}
, 
[700] = {condition = 1, delay = 1, id = 700, info = 193402, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/Btn_Exproation", target_parent = 1}
, 
[701] = {avg_name = "cpt00_tutorial_06", delay = 1, guide_skip = false, id = 701, info_type = 0, step_type = 2, target_parent = "002_Sector_001", target_type = 2}
, 
[702] = {delay = 0.8, id = 702, info = 230150, target_name = "SectorRoot/UICanvas/InfoNode/1/InfoItem", target_parent = "002_Sector_001", target_type = 2}
, 
[703] = {id = 703, info = 117445, target_name = "return GuideUtil.LocationSectorStageItem(1101)", target_type = 3}
, 
[704] = {id = 704, info = 75381, target_name = "DetailNode/BtnGroup/Btn_Battle", target_parent = 75}
, 
[705] = {delay = 1, id = 705, info = 195526, target_name = "Buttom/Btn_Battle", target_parent = "002_Sector_001", target_type = 2}
, 
[800] = {avg_name = "cpt00_tutorial_08", condition = 3, condition_arg = __rt_2, guide_skip = false, id = 800, info_type = 0, step_type = 2, target_type = 0}
, 
[801] = {delay = 0.4, id = 801, info = 436537, target_name = "return GuideUtil.GetEpFirstRoomTarget()", target_type = 3}
, 
[900] = {condition = 15, delay = 0.4, id = 900, info = 237152, step_type = 5, target_name = "UINEnemyDetail", target_parent = 206}
, 
[901] = {delay = 0.4, id = 901, info = 412262, target_name = "Frame/Btn_BattleStart", target_type = 2}
, 
[1000] = {condition = 5, delay = 0.9, id = 1000, info = 488309, target_name = "Frame/PropList/10222", target_parent = 102}
, 
[1001] = {delay = 0.3, id = 1001, info = 9294, target_name = "Frame/PropList/10222", target_parent = 102}
, 
[1101] = {condition = 7, id = 1101, info = 72689, target_name = "Frame/TreasureNode/TreasureList/1/UINChipItemDetail", target_parent = 130}
, 
[1102] = {delay = 0.3, id = 1102, info = 119286, target_name = "Frame/TreasureNode/TreasureList/1/UINChipItemDetail", target_parent = 130}
, 
[1200] = {avg_name = "cpt00_tutorial_13", condition = 3, condition_arg = __rt_2, delay = 0, guide_skip = false, id = 1200, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[1201] = {condition = 8, id = 1201, info = 114106, target_name = "Frame/EventNode/ChoiceList/Rect/1", target_parent = 131}
, 
[1202] = {delay = 0.2, id = 1202, info = 96195, target_name = "Frame/EventNode/ChoiceList/Rect/1", target_parent = 131}
, 
[1300] = {condition = 9, delay = 0.2, id = 1300, info = 32600, target_name = "Top/TopButtonGroup/Btn_Back", target_parent = 74}
, 
[1301] = {delay = 0.2, id = 1301, info = 1321, target_name = "Top/TopButtonGroup/Btn_Back", target_parent = 76}
, 
[1302] = {condition = 1, delay = 1, id = 1302, info = 290340, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/OasisLayout/Btn_Oasis_BIG", target_parent = 1}
, 
[1303] = {avg_name = "cpt00_tutorial_11", guide_skip = false, id = 1303, info_type = 0, step_type = 2, target_type = 0}
, 
[1305] = {id = 1305, info = 432435, target_name = "Btn_Editor", target_parent = 1500}
, 
[1306] = {id = 1306, info = 64428, target_name = "Frame/ScrollRect/Rect/1", target_parent = 9}
, 
[1307] = {id = 1307, info = 487841, target_name = "SelectNode/Editor/Btn_Confirm", target_parent = 1500}
, 
[1308] = {id = 1308, info = 30437, target_name = "TopButtonGroup/Btn_Back", target_parent = 2}
, 
[1321] = {condition = 9, delay = 0.2, id = 1321, info = 339785, target_name = "TopButtonGroup/Btn_GoHome", target_parent = 2}
, 
[1351] = {avg_name = "cpt00_tutorial_18", custom_code = "GuideUtil.UnlockOasisMask()", delay = 0, guide_skip = false, id = 1351, info_type = 0, step_type = 3, target_parent = "003_Oasis_001", target_type = 2}
, 
[1352] = {avg_name = "cpt00_tutorial_18", condition = 1, custom_code = "GuideUtil.UnlockOasisMask()", delay = 0, guide_skip = false, id = 1352, info_type = 0, step_type = 3, target_parent = "003_Oasis_001", target_type = 2}
, 
[1400] = {condition = 10, id = 1400, info = 483434, target_name = "UINode/BuildingSidebar/BuildingList/Rect/1_2/DetailItem/Upgraded/But_Accelerate", target_parent = 3}
, 
[1401] = {id = 1401, info = 364964, target_name = "QuickUpgraded/Frame/Right/btn_DoComplete", target_parent = 3}
, 
[1402] = {avg_name = "cpt00_tutorial_16", condition = 10, delay = 0, guide_skip = false, id = 1402, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[1497] = {condition = 10, id = 1497, info = 83270, target_name = "TopButtonGroup/Btn_GoHome", target_parent = 2}
, 
[1500] = {condition = 1, delay = 0.8, id = 1500, info = 176166, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/Btn_HeroList_BIG", target_parent = 1}
, 
[1501] = {delay = 0.7, id = 1501, info = 230861, target_name = "return GuideUtil.GetHeroListHeroItem(1003,true,false)", target_parent = "300", target_type = 3}
, 
[1502] = {id = 1502, info = 81788, target_name = "Center/Level/Btn_LevelUp", target_parent = 301}
, 
[1503] = {delay = 0.4, id = 1503, info = 114366, info_pos = "9", step_type = 5, target_name = "Detail/LevelNode", target_parent = 309}
, 
[1504] = {delay = 0.4, id = 1504, info = 308493, info_pos = "2", step_type = 5, target_name = "Detail/AttriNode", target_parent = 309}
, 
[1505] = {delay = 0.3, id = 1505, info = 265676, info_pos = "4", step_type = 5, target_name = "Control/ItemList", target_parent = 309}
, 
[1506] = {delay = 0.3, id = 1506, info = 362430, target_name = "Control/CanUP/Btn_Confirm", target_parent = 309}
, 
[1598] = {condition = 9, id = 1598, info = 32600, target_name = "TopButtonGroup/Btn_GoHome", target_parent = 2}
, 
[1599] = {delay = 0.8, id = 1599, info = 176166, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/Btn_HeroList_BIG", target_parent = 1}
, 
[1600] = {condition = 11, 
condition_arg = {1, 1102}
, delay = 1, id = 1600, info = 508284, target_name = "Formation(Clone)/Scene/BasePlatform4", target_parent = "002_Sector_001", target_type = 2}
, 
[1601] = {delay = 0.6, id = 1601, info = 481187, info_type = 0, target_name = "return GuideUtil.GetHeroListHeroItem(1021,true,true)", target_parent = "82", target_type = 3}
, 
[1602] = {delay = 0.3, id = 1602, info = 455385, info_type = 0, target_name = "return GuideUtil.GetHeroListHeroItem(1006,true,true)", target_parent = "82", target_type = 3}
, 
[1603] = {delay = 0.2, id = 1603, info = 426986, target_name = "Right/Btn_Comfirm", target_parent = 82}
, 
[1604] = {condition = 11, delay = 0.2, id = 1604, info = 368412, target_name = "Buttom/Btn_Battle", target_parent = "002_Sector_001", target_type = 2}
, 
[1700] = {avg_name = "cpt00_tutorial_12", condition = 3, condition_arg = __rt_3, guide_skip = false, id = 1700, info_type = 0, step_type = 2, target_type = 0}
, 
[1800] = {avg_name = "cpt00_tutorial_19", condition = 4, delay = 0, guide_skip = false, id = 1800, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[1801] = {delay = 0.4, id = 1801, info = 475729, info_pos = "2", target_name = "BattleHolder/FloorTileHolder/(1, 2)", target_parent = "006_Arena_003", target_type = 2}
, 
[1802] = {custom_code = "GuideUtil.StartBattleDeployGuide(1,4,1,2)", delay = 0, guide_skip = false, id = 1802, info = 459353, info_pos = "2", step_type = 3, target_type = 0, wait_target = false}
, 
[1900] = {avg_name = "cpt00_tutorial_14", condition = 3, condition_arg = __rt_3, delay = 0, guide_skip = false, id = 1900, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[2000] = {condition = 9, delay = 0.4, guide_skip = false, id = 2000, info = 367625, target_name = "TopButtonGroup/Btn_GoHome", target_parent = 2}
, 
[2001] = {condition = 1, delay = 1, id = 2001, info = 102617, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/Btn_HeroList_BIG", target_parent = 1}
, 
[2002] = {delay = 1, id = 2002, info = 102617, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/Btn_HeroList_BIG", target_parent = 1}
, 
[2003] = {id = 2003, info = 40587, target_name = "return GuideUtil.GetHeroListHeroItem(1003,true,false)", target_parent = "300", target_type = 3}
, 
[2004] = {id = 2004, info = 341052, target_name = "Center/Btn_StarUp", target_parent = 301}
, 
[2005] = {id = 2005, info = 496205, target_name = "InfoNode/consumeNode/NotFullRank/Btn_StarUp", target_parent = 304}
, 
[2100] = {avg_name = "cpt00_tutorial_15", condition = 3, 
condition_arg = {1031}
, delay = 0, guide_skip = false, id = 2100, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[2200] = {condition = 9, delay = 0.2, id = 2200, info = 246488, target_name = "Top/TopButtonGroup/Btn_Back", target_parent = 74}
, 
[2201] = {id = 2201, info = 460856, target_name = "SectorRoot/UICanvas/ProgressNode/1_1", target_parent = "002_Sector_001", target_type = 2}
, 
[2202] = {id = 2202, info = 384389, target_name = "ConstructionInfo/BuildIngList/202/2003", target_parent = 18}
, 
[2203] = {id = 2203, info = 489732, target_name = "QuickUpgraded/3DModifier/Frame/Right/btn_DoComplete", target_parent = 18}
, 
[2300] = {condition = 1, delay = 1, id = 2300, info = 267314, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/Btn_HeroList_BIG", target_parent = 1}
, 
[2301] = {condition = 9, delay = 0.2, id = 2301, info = 367625, target_name = "Top/TopButtonGroup/Btn_GoHome", target_parent = 74}
, 
[2302] = {condition = 14, delay = 0.6, id = 2302, info = 97579, op_refresh = true, target_name = "Buttom/Detail/HeroSkillList/Btn_Skill", target_parent = 301}
, 
[2303] = {delay = 1, id = 2303, info = 520324, target_name = "SkillNode/obj_skillItem2/SkillUpgradeItem", target_parent = 306}
, 
[2304] = {id = 2304, info = 17606, step_type = 5, target_name = "InfoNode/SkillDetailNode/SkillDetaiList", target_parent = 306}
, 
[2305] = {delay = 1, first_code = "GuideManager:AddGuideFeature(1)", id = 2305, info = 440674, target_name = "InfoNode/ItemList/ExtrItem(Clone)/UINBaseItem", target_parent = 306}
, 
[2306] = {delay = 0.8, id = 2306, info = 422053, target_name = "Frame/Detail/Normal/Layout/List/JumpList/Rect/jumpInfoItem(Clone)/JumpDescrItem(Clone)/Btn_Goto", target_parent = 40}
, 
[2401] = {condition = 1, id = 2401, info = 35944, target_name = "Main/Left/Btn_Task", target_parent = 1}
, 
[2402] = {id = 2402, info = 229889, target_name = "TaskPage/BasePos/TaskListNode/Rect/taskItem0/StepItem/RewardItemList/State/Btn_ItemClick", target_parent = 25}
, 
[2501] = {condition = 11, id = 2501, info = 506295, target_name = "Buttom/Btn_CommanderSkill", target_parent = 80}
, 
[2502] = {id = 2502, info = 160370, target_name = "TreeInfo/Btn_TreeLevel", target_parent = 123}
, 
[2503] = {delay = 0.3, id = 2503, info = 54289, target_name = "SkillUpgradeNode/Frame/ItemList/MaterialItem(Clone)/UINBaseItem", target_parent = 123}
, 
[2504] = {delay = 0.2, id = 2504, info = 171110, target_name = "SkillUpgradeNode/Frame/Btn_Confirm", target_parent = 123}
, 
[2505] = {delay = 0.2, id = 2505, info = 107783, info_pos = "2", target_name = "TopButtonGroup/Btn_Back", target_parent = 2}
, 
[2506] = {delay = 0.3, id = 2506, info = 479162, target_name = "TreeDetail/SkillPageNode/ActiveSkillNode/ActiveSkillList/ActiveSkillItem (2)", target_parent = 123}
, 
[2507] = {delay = 0.3, id = 2507, info = 156029, target_name = "TreeDetail/SkillPageNode/OverLoadNode/OverloadList/overloadSkill1", target_parent = 123}
, 
[2508] = {delay = 0.2, guide_skip = false, id = 2508, info = 323624, step_type = 5, target_name = "TreeDetail/SkillPageNode/OverLoadNode/OverloadList/overloadSkill2", target_parent = 123}
, 
[2600] = {condition = 14, delay = 1, id = 2600, info = 151620, info_pos = "5", target_name = "Buttom/Detail/AlgorithmNode", target_parent = 301}
, 
[2601] = {guide_skip = false, id = 2601, info = 241688, info_pos = "6", step_type = 5, target_name = "InfoNode/AreaList", target_parent = 1000}
, 
[2602] = {delay = 0.2, guide_skip = false, id = 2602, info = 72558, info_pos = "7", step_type = 5, target_name = "InfoNode/AreaList", target_parent = 1000}
, 
[2603] = {delay = 0.3, id = 2603, info = 472829, info_pos = "7", target_name = "InfoNode/AreaList/1", target_parent = 1000}
, 
[2604] = {delay = 0.3, guide_skip = false, id = 2604, info = 524197, info_pos = "2", step_type = 5, target_name = "ATHListNode/List", target_parent = 1000}
, 
[2605] = {delay = 0.3, id = 2605, info = 396288, target_name = "ATHListNode/List/AreaNode/Scroll/Rect/AthGroup(Clone)/1", target_parent = 1000}
, 
[2606] = {delay = 0.3, id = 2606, info = 41680, target_name = "ListDetailPos/UINATHDetailItem(Clone)/BtnGroup/Btn_Equip", target_parent = 1003}
, 
[2607] = {delay = 0.3, guide_skip = false, id = 2607, info = 220148, step_type = 5, target_name = "InfoNode/AreaList/1", target_parent = 1000}
, 
[2608] = {delay = 0.3, id = 2608, info = 202477, target_name = "TopButtonGroup/Btn_Back", target_parent = 2}
, 
[2609] = {delay = 0.2, id = 2609, info = 324889, target_name = "Btn_Efficiency", target_parent = 1000}
, 
[2610] = {delay = 0.4, id = 2610, info = 24429, info_pos = "2", step_type = 5, target_name = "ATHListNode", target_parent = 1001}
, 
[2611] = {delay = 0.4, id = 2611, info = 422113, info_type = 1000, step_type = 5, target_name = "ATHListNode/List/AreaNode/AreaTogGroup", target_parent = 1000}
, 
[2612] = {delay = 0.4, id = 2612, info = 254529, info_type = 1000, step_type = 5, target_name = "InfoNode/Info/Pages", target_parent = 1000}
, 
[2701] = {condition = 12, delay = 0.8, first_code = "GuideUtil.SectorForceFocus(22)", id = 2701, info = 408976, info_pos = "8", target_name = "SectorRoot/UICanvas/SectorDungeonRoot/Btn_FriendshipDungeon", target_parent = "002_Sector_001", target_type = 2}
, 
[2702] = {id = 2702, info = 392890, step_type = 5, target_name = "Frontground/Main/HeroList/Rect", target_parent = 72}
, 
[2703] = {id = 2703, info = 16049, target_name = "Frontground/Main/StoryDetailNode/2DMaskLayer/LevelRewardNode/Level/01", target_parent = 72}
, 
[2704] = {id = 2704, info = 82997, step_type = 5, target_name = "Frontground/Main/StoryDetailNode/2DMaskLayer/LevelRewardNode/MaybeReward/ItemWithCount(Clone)/UINBaseItem", target_parent = 72}
, 
[2705] = {delay = 0.3, id = 2705, info = 27960, step_type = 5, target_name = "Frontground/Top/LimitCount", target_parent = 72}
, 
[2706] = {delay = 0.3, id = 2706, info = 360406, target_name = "Frontground/Main/StoryDetailNode/2DMaskLayer/Btn_Friendship", target_parent = 72}
, 
[2707] = {delay = 1, id = 2707, info = 181486, step_type = 5, target_name = "SkillNode/PresentNode/PresentScroll", target_parent = 70}
, 
[2708] = {delay = 0.3, id = 2708, info = 10440, step_type = 5, target_name = "SkillNode/Scroll/Rect", target_parent = 70}
, 
[2801] = {condition = 12, delay = 0.8, first_code = "GuideUtil.SectorForceFocus(11)", id = 2801, info = 314329, target_name = "SectorRoot/UICanvas/SectorDungeonRoot/Btn_ItemDungeon", target_parent = "002_Sector_001", target_type = 2}
, 
[2802] = {id = 2802, info = 466046, step_type = 5, target_name = "Frontground/Main/Scroll/Rect/DungeonList", target_parent = 97}
, 
[2803] = {delay = 0.3, id = 2803, info = 357679, target_name = "Frontground/Main/Scroll/Rect/DungeonList/BIT GATHERING", target_parent = 97}
, 
[2804] = {delay = 0.3, id = 2804, info = 363607, target_name = "Frontground/Main/DungeonDetailNode/2DMaskLayer/LevelRewardNode/Level/01", target_parent = 97}
, 
[2805] = {delay = 0.3, guide_skip = false, id = 2805, info = 381694, step_type = 5, target_name = "Frontground/Main/DungeonDetailNode/2DMaskLayer/LevelRewardNode/NormalReward", target_parent = 97}
, 
[2901] = {condition = 9, delay = 0.3, id = 2901, info = 110882, target_name = "SectorInfo/DiffBtn_normal", target_parent = 74}
, 
[2902] = {delay = 0.3, id = 2902, info = 241683, target_name = "SectorInfo/DiffcultListHolder/DiffBtn_nightmare", target_parent = 74}
, 
[3000] = {delay = 0.2, id = 3000, info = 32600, target_name = "TopButtonGroup/Btn_GoHome", target_parent = 2}
, 
[3001] = {condition = 1, delay = 1, id = 3001, info = 422412, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/OasisLayout/Btn_Oasis_BIG", target_parent = 1}
, 
[3002] = {delay = 1, id = 3002, info = 275082, target_name = "UINode/BuildingSidebar/BuildingList/Rect/1_2/1003", target_parent = 3}
, 
[3003] = {id = 3003, info = 260478, target_name = "UINode/BuildingSidebar/BuildingList/Rect/1_2/DetailItem/Upgraded/Btn_Upgrade", target_parent = 3}
, 
[3200] = {condition = 18, delay = 0.3, id = 3200, info = 243724, step_type = 5, target_name = "StrengthPage/Page/OptimizPage/ATHNode", target_parent = 1005}
, 
[3201] = {delay = 0.3, id = 3201, info = 362747, target_name = "StrengthPage/Page/OptimizPage/ATHNode/AffixList/1", target_parent = 1005}
, 
[3202] = {delay = 0.2, id = 3202, info = 35070, step_type = 5, target_name = "StrengthPage/Page/OptimizPage/UpgadeNode/Slider", target_parent = 1005}
, 
[3203] = {delay = 0.2, id = 3203, info = 102013, step_type = 5, target_name = "StrengthPage/Page/OptimizPage/UpgadeNode/FailBar", target_parent = 1005}
, 
[3204] = {delay = 0.3, id = 3204, info = 280163, target_name = "StrengthPage/ToggleGroup/Tog_Dismantle", target_parent = 1005}
, 
[3205] = {delay = 0.3, id = 3205, info = 417680, info_pos = "2", step_type = 5, target_name = "ATHListNode", target_parent = 1005}
, 
[3300] = {delay = 0.2, id = 3300, info = 312231, target_name = "StrengthPage/ToggleGroup/Tog_refactor", target_parent = 1005}
, 
[3301] = {condition = 18, delay = 0.2, id = 3301, info = 213066, step_type = 5, target_name = "Frame/ATHDetailItem/AffixList", target_parent = 1007}
, 
[3302] = {delay = 0.3, id = 3302, info = 139338, step_type = 5, target_name = "Frame/ATHDetailItem/AffixList", target_parent = 1007}
, 
[3303] = {delay = 0.2, id = 3303, info = 259664, step_type = 5, target_name = "Frame/LeftArea/Scrollbar", target_parent = 1007}
, 
[3304] = {delay = 0.2, id = 3304, info = 2419, step_type = 5, target_name = "Frame/ATHDetailItem/Btn_Refactor", target_parent = 1007}
, 
[3400] = {condition = 1, delay = 1, id = 3400, info = 184214, op_refresh = true, target_name = "Main/Right/PageTog/Tog_FuncPageItem3", target_parent = 1}
, 
[3401] = {delay = 0.3, id = 3401, info = 127344, target_name = "Main/Right/PageList/Rect/OasisPage/Btn_Factor", target_parent = 1}
, 
[3402] = {id = 3402, info = 284873, target_name = "Rooms/Factory_B_002", target_parent = "008_Factory_001", target_type = 2}
, 
[3403] = {delay = 0.3, id = 3403, info = 411374, target_name = "FactoryRomeNode/FactoryRoomFunc/Btn_Production", target_parent = 1300}
, 
[3404] = {delay = 0.4, id = 3404, info = 392789, target_name = "OrderListNode/FactoryItemList/Rect/FactoryItem(Clone)", target_parent = 1300}
, 
[3405] = {delay = 0.3, id = 3405, info = 428559, target_name = "FactoryOrderNode/Btn_Add", target_parent = 1300}
, 
[3406] = {delay = 0.3, id = 3406, info = 247764, step_type = 5, target_name = "FactoryOrderNode/Btn_Confirm", target_parent = 1300}
, 
[3407] = {delay = 0.3, id = 3407, info = 479980, step_type = 5, target_name = "FactoryRomeNode/EnterhNode", target_parent = 1300}
, 
[3408] = {delay = 0.3, id = 3408, info = 329462, target_name = "OrderListNode/ToggleGroup/Tog_Dig", target_parent = 1300}
, 
[3500] = {condition = 9, delay = 0.2, id = 3500, info = 183853, target_name = "TopButtonGroup/Btn_GoHome", target_parent = 2}
, 
[3501] = {delay = 1, id = 3501, info = 310929, op_refresh = true, target_name = "Main/Left/Btn_ActivityStarUp", target_parent = 1}
, 
[3502] = {delay = 0.8, id = 3502, info = 507522, step_type = 5, target_name = "CanvasAdd/TaskNode/Scroll/Rect", target_parent = 1600}
, 
[3503] = {delay = 0.4, id = 3503, info = 358968, step_type = 5, target_name = "CanvasAdd/TaskNode/Reward", target_parent = 1600}
, 
[3504] = {delay = 0.4, id = 3504, info = 205798, step_type = 5, target_name = "CanvasAdd/TitleInfo", target_parent = 1600}
, 
[3600] = {condition = 4, id = 3600, info = 435389, step_type = 5, target_name = "Frame/Tog_Auto", target_parent = 204}
, 
[3601] = {delay = 0.4, id = 3601, info = 191436, step_type = 5, target_name = "Frame/Btn_SpeedUP", target_parent = 204}
, 
[3700] = {condition = 11, delay = 0.8, id = 3700, info = 502295, target_name = "Buttom/CampList/Btn_Title", target_parent = 80}
, 
[3701] = {delay = 0.4, id = 3701, info = 57282, step_type = 5, target_name = "Frame/Camp/List", target_parent = 83}
, 
[3702] = {delay = 0.4, id = 3702, info = 496198, info_pos = "2", step_type = 5, target_name = "Frame/BondEff/List", target_parent = 83}
, 
[3703] = {id = 3703, info = 335701, step_type = 5, target_name = "Frame/Camp/List", target_parent = 83}
, 
[3800] = {condition = 1, delay = 1, id = 3800, info = 432225, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/Btn_Exproation", target_parent = 1}
, 
[3801] = {delay = 1, id = 3801, info = 105608, target_name = "SectorRoot/UICanvas/InfoNode/1/InfoItem", target_parent = "002_Sector_001", target_type = 2}
, 
[3802] = {delay = 0.8, id = 3802, info = 312855, target_name = "return GuideUtil.LocationSectorStageItem(1101,true)", target_type = 3}
, 
[3803] = {delay = 0.6, id = 3803, info = 442618, target_name = "DetailNode/BtnGroup/Btn_ViewAvg", target_parent = 75}
, 
[3804] = {condition = 1, delay = 0.6, id = 3804, info = 125171, op_refresh = true, target_name = "Main/Right/PageTog/Tog_FuncPageItem2", target_parent = 1}
, 
[3900] = {condition = 9, id = 3900, info = 136864, target_name = "return GuideUtil.LocationSectorStageItem(1102)", target_type = 3}
, 
[3901] = {id = 3901, info = 518890, target_name = "DetailNode/BtnGroup/Btn_Battle", target_parent = 75}
, 
[3902] = {condition = 1, delay = 1, id = 3902, info = 432225, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/Btn_Exproation", target_parent = 1}
, 
[3903] = {delay = 1, id = 3903, info = 3917, target_name = "SectorRoot/UICanvas/InfoNode/1/InfoItem", target_parent = "002_Sector_001", target_type = 2}
, 
[4000] = {condition = 9, delay = 0.3, id = 4000, info = 13255, target_name = "SectorInfo/DiffBtn_normal", target_parent = 74}
, 
[4001] = {delay = 0.3, id = 4001, info = 464880, target_name = "SectorInfo/DiffcultListHolder/DiffBtn_infinity", target_parent = 74}
, 
[4002] = {delay = 0.6, id = 4002, info = 166076, info_pos = "2", step_type = 5, target_name = "DifficultList/UI_SectorLevelInfinityMap(Clone)/UIAdapter/ScrollRect", target_parent = 74}
, 
[4003] = {avg_name = "cpt00_tutorial_25", delay = 0, guide_skip = false, id = 4003, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[4100] = {avg_name = "cpt00_tutorial_22", condition = 3, 
condition_arg = {1051}
, delay = 0, guide_skip = false, id = 4100, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[4200] = {condition = 12, delay = 1, first_code = "GuideUtil.SectorForceFocus(23)", id = 4200, info = 54622, target_name = "SectorRoot/UICanvas/SectorDungeonRoot/Btn_DailyChallengeButton", target_parent = "002_Sector_001", target_type = 2}
, 
[4201] = {id = 4201, info = 233985, target_name = "LevelNode/DailyNode", target_parent = 140}
, 
[4202] = {delay = 0.4, id = 4202, info = 482992, step_type = 5, target_name = "DetailNode/Detail/NormalNode", target_parent = 75}
, 
[4203] = {delay = 0.4, id = 4203, info = 510778, step_type = 5, target_name = "DetailNode/BtnGroup/Btn_Battle", target_parent = 75}
, 
[4300] = {condition = 12, delay = 0.3, guide_skip = false, id = 4300, info = 96906, target_name = "Btn_StrategyOverview", target_parent = 76}
, 
[4301] = {delay = 0.3, guide_skip = false, id = 4301, info = 375394, step_type = 5, target_name = "StOList/Rect/Unlock/ChessLayout/TechItem(Clone)", target_parent = 1400}
, 
[4302] = {delay = 0.3, guide_skip = false, id = 4302, info = 347448, step_type = 5, target_name = "Side/Down/Consume/List", target_parent = 1400}
, 
[4303] = {delay = 0.3, guide_skip = false, id = 4303, info = 169761, info_type = 0, step_type = 5, target_name = "Side/Down/Consume/List", target_parent = 1400}
, 
[4400] = {condition = 1, delay = 0.6, id = 4400, info = 303609, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/OasisLayout/btn_Store", target_parent = 1}
, 
[4401] = {avg_name = "cpt00_tutorial_23", delay = 0, guide_skip = false, id = 4401, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[4500] = {avg_name = "cpt00_tutorial_24", condition = 9, delay = 0, guide_skip = false, id = 4500, info = 261934, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[90101] = {condition = 16, delay = 2.5, id = 90101, info = 395040, op_refresh = true, step_type = 5, target_name = "Frame/RewardLayout/CCNode", target_parent = 4}
, 
[100001] = {avg_name = "cpt00_tutorial_01", delay = 0, guide_skip = false, id = 100001, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[100002] = {id = 100002, info = 234548, target_name = "Frame/Btn_BattleStart", target_parent = 204}
, 
[100101] = {avg_name = "cpt00_tutorial_02", delay = 0, guide_skip = false, id = 100101, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[100102] = {id = 100102, info = 24000, target_name = "PlayerSkillNode/1", target_parent = 203}
, 
[101101] = {id = 101101, info = 234548, target_name = "Frame/Btn_BattleStart", target_parent = 204}
, 
[101201] = {avg_name = "cpt00_tutorial_04", delay = 0, guide_skip = false, id = 101201, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[101202] = {id = 101202, info = 15338, target_name = "UltimateNode/HeroList/1005", target_parent = 203}
, 
[101301] = {avg_name = "cpt00_tutorial_03x", delay = 0, guide_skip = false, id = 101301, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[101302] = {id = 101302, info = 24000, target_name = "PlayerSkillNode/2", target_parent = 203}
, 
[140101] = {condition = 1, delay = 1.5, id = 140101, info = 41652, info_type = 0, op_refresh = true, target_name = "RotateWithMian/MainUI/Middle/Btn_Oasis", target_parent = 1}
, 
[140102] = {id = 140102, info = 360483, info_type = 0, target_name = "UINode/Btn_OpenSide", target_parent = 3}
, 
[140103] = {id = 140103, info = 132118, info_type = 0, target_name = "UINode/BuildingSidebar/BuildingList/Rect/1_2/1003", target_parent = 3}
, 
[140201] = {guide_skip = false, id = 140201, info = 3505, target_name = "Frame/ScrollRect/Rect/1", target_parent = 9}
, 
[140202] = {guide_skip = false, id = 140202, info = 254793, target_name = "SelectNode/Editor/Btn_Confirm", target_parent = 1500}
, 
[140203] = {condition = 1, delay = 1, guide_skip = false, id = 140203, info = 310115, target_name = "Main/Right/PageList/Rect/CenterPage/OasisLayout/Btn_Oasis_BIG", target_parent = 1}
, 
[140204] = {guide_skip = false, id = 140204, info = 369442, target_name = "Btn_Editor", target_parent = 1500}
, 
[140205] = {delay = 2, guide_skip = false, id = 140205, info = 366807, target_name = "ResNode/1003", target_parent = 1500}
, 
[150100] = {condition = 1, delay = 1.7, id = 150100, info = 473226, op_refresh = true, target_name = "Main/Right/PageTog/Tog_FuncPageItem1", target_parent = 1}
, 
[150101] = {delay = 1.7, id = 150101, info = 473226, op_refresh = true, target_name = "Main/Right/PageTog/Tog_FuncPageItem1", target_parent = 1}
, 
[150102] = {id = 150102, info = 489635, target_name = "Main/Right/PageList/Rect/HeroPage/Btn_Lottery", target_parent = 1}
, 
[150103] = {id = 150103, info = 507854, op_refresh = true, target_name = "Buttom/Btn_Once", target_parent = 13}
, 
[150104] = {id = 150104, info = 129396, target_name = "Frame/YesNoNode/ButtonYes", target_parent = 1200}
, 
[150105] = {condition = 17, delay = 0.4, id = 150105, info = 513268, target_name = "Buttom/InfoScroll/Rect/2", target_parent = 13}
, 
[150106] = {delay = 0.2, id = 150106, info = 159122, op_refresh = true, target_name = "Buttom/Btn_Once", target_parent = 13}
, 
[150107] = {condition = 17, delay = 1.2, id = 150107, info = 513268, target_name = "Buttom/InfoScroll/Rect/2", target_parent = 13}
, 
[150201] = {guide_skip = false, id = 150201, info = 249080, target_name = "InfoNode/Btn_LimitUp", target_parent = 302}
, 
[160101] = {condition = 1, delay = 1, id = 160101, info = 458098, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/Btn_Exproation", target_parent = 1}
, 
[160102] = {delay = 1, id = 160102, info = 182517, target_name = "SectorRoot/UICanvas/InfoNode/1/InfoItem", target_parent = "002_Sector_001", target_type = 2}
, 
[160103] = {id = 160103, info = 136864, target_name = "return GuideUtil.LocationSectorStageItem(1102)", target_type = 3}
, 
[160104] = {id = 160104, info = 518890, target_name = "DetailNode/BtnGroup/Btn_Battle", target_parent = 75}
, 
[160105] = {delay = 0.2, id = 160105, info = 368412, target_name = "Buttom/Btn_Battle", target_parent = "002_Sector_001", target_type = 2}
, 
[200001] = {condition = 1, id = 200001, info = 41652, target_name = "RotateWithMian/MainUI/Middle/Btn_Oasis", target_parent = 1}
, 
[200002] = {id = 200002, info = 360483, target_name = "UINode/Btn_OpenSide", target_parent = 3}
, 
[200003] = {id = 200003, info = 435007, target_name = "UINode/BuildingSidebar/BuildingList/Rect/1_2/1011", target_parent = 3}
, 
[200004] = {id = 200004, info = 264065, target_name = "UINode/BuildingSidebar/BuildingList/Rect/1_2/DetailItem/Upgraded/Btn_Upgrade", target_parent = 3}
, 
[300001] = {avg_name = "cpt00_tutorial_03xx", condition = 9, delay = 0, guide_skip = false, id = 300001, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[1001201] = {condition = 5, delay = 1, id = 1001201, info = 429144, target_name = "Frame/PropList/10206", target_parent = 102}
, 
[1001202] = {delay = 0.3, id = 1001202, info = 24681, target_name = "Frame/PropList/10206", target_parent = 102}
, 
[1002201] = {condition = 1, delay = 1, id = 1002201, info = 140098, op_refresh = true, target_name = "RotateWithMian/MainUI/Middle/Btn_Exproation", target_parent = 1}
, 
[1002202] = {delay = 1.5, id = 1002202, info = 460856, target_name = "SectorRoot/UICanvas/ProgressNode/1_1", target_parent = "002_Sector_001", target_type = 2}
}
local __default_values = {avg_name = "", condition = 0, condition_arg = __rt_1, custom_code = "", delay = 0.5, first_code = "", guide_skip = true, id = 100, info = "", info_pos = "", info_type = 1001, op_refresh = false, step_type = 1, target_name = "", target_parent = "", target_type = 1, wait_target = true}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in (_ENV.pairs)(guide_step) do
  (_ENV.setmetatable)(v, base)
end
local __rawdata = {__basemetatable = base}
;
(_ENV.setmetatable)(guide_step, {__index = __rawdata})
return guide_step


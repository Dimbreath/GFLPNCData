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
[700] = {condition = 1, delay = 1, id = 700, info = 457529, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/Btn_Exproation", target_parent = 1}
, 
[701] = {avg_name = "cpt00_tutorial_06", delay = 1, guide_skip = false, id = 701, info_type = 0, step_type = 2, target_parent = "002_Sector_001", target_type = 2}
, 
[702] = {delay = 0.8, id = 702, info = 264145, target_name = "SectorRoot/UICanvas/InfoNode/1/InfoItem", target_parent = "002_Sector_001", target_type = 2}
, 
[703] = {id = 703, info = 381873, target_name = "return GuideUtil.LocationSectorStageItem(1101)", target_type = 3}
, 
[704] = {id = 704, info = 363410, target_name = "DetailNode/BtnGroup/Btn_Battle", target_parent = 75}
, 
[705] = {delay = 1, id = 705, info = 138658, target_name = "Buttom/Btn_Battle", target_parent = "002_Sector_001", target_type = 2}
, 
[800] = {avg_name = "cpt00_tutorial_08", condition = 3, condition_arg = __rt_2, guide_skip = false, id = 800, info_type = 0, step_type = 2, target_type = 0}
, 
[801] = {delay = 0.4, id = 801, info = 142653, target_name = "return GuideUtil.GetEpFirstRoomTarget()", target_type = 3}
, 
[900] = {condition = 15, delay = 0.4, id = 900, info = 329823, step_type = 5, target_name = "UINEnemyDetail", target_parent = 206}
, 
[901] = {delay = 0.4, id = 901, info = 111076, target_name = "Frame/Btn_BattleStart", target_type = 2}
, 
[1000] = {condition = 5, delay = 0.9, id = 1000, info = 4944, target_name = "PropList/10162", target_parent = 102}
, 
[1001] = {delay = 0.3, id = 1001, info = 148527, target_name = "PropList/10162", target_parent = 102}
, 
[1101] = {condition = 7, id = 1101, info = 267374, target_name = "Frame/TreasureNode/TreasureList/1/UINChipItemDetail", target_parent = 130}
, 
[1102] = {delay = 0.3, id = 1102, info = 519500, target_name = "Frame/TreasureNode/TreasureList/1/UINChipItemDetail", target_parent = 130}
, 
[1200] = {avg_name = "cpt00_tutorial_13", condition = 3, condition_arg = __rt_2, delay = 0, guide_skip = false, id = 1200, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[1201] = {condition = 8, id = 1201, info = 340205, target_name = "Frame/EventNode/ChoiceList/Rect/1", target_parent = 131}
, 
[1202] = {delay = 0.2, id = 1202, info = 307010, target_name = "Frame/EventNode/ChoiceList/Rect/1", target_parent = 131}
, 
[1300] = {condition = 9, delay = 0.2, id = 1300, info = 32600, target_name = "Top/TopButtonGroup/Btn_Back", target_parent = 74}
, 
[1301] = {delay = 0.2, id = 1301, info = 1321, target_name = "Top/TopButtonGroup/Btn_Back", target_parent = 76}
, 
[1302] = {condition = 1, delay = 1, id = 1302, info = 290340, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/OasisLayout/Btn_Oasis_BIG", target_parent = 1}
, 
[1303] = {avg_name = "cpt00_tutorial_11", guide_skip = false, id = 1303, info_type = 0, step_type = 2, target_type = 0}
, 
[1305] = {id = 1305, info = 259793, target_name = "UINode/BuildingSidebar/BuildingList/Rect/1_2/1004", target_parent = 3}
, 
[1306] = {id = 1306, info = 504065, target_name = "UINode/BuildingSidebar/BuildingList/Rect/1_2/DetailItem/Upgraded/Btn_Upgrade", target_parent = 3}
, 
[1307] = {id = 1307, info = 504065, target_name = "Upgraded/But_Accelerate", target_parent = 3}
, 
[1321] = {condition = 9, delay = 0.2, id = 1321, info = 32600, target_name = "Top/TopButtonGroup/Btn_GoHome", target_parent = 74}
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
[1497] = {condition = 10, id = 1497, info = 224431, target_name = "UINode/Top/TopButtonGroup/Btn_GoHome", target_parent = 3}
, 
[1500] = {condition = 1, delay = 0.8, id = 1500, info = 134962, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/Btn_HeroList_BIG", target_parent = 1}
, 
[1501] = {delay = 0.7, id = 1501, info = 424494, target_name = "return GuideUtil.GetHeroListHeroItem(1021,true,false)", target_parent = "300", target_type = 3}
, 
[1502] = {id = 1502, info = 279749, target_name = "Center/Btn_LevelUp", target_parent = 301}
, 
[1503] = {delay = 1, id = 1503, info = 3998, target_name = "InfoNode/UpgradeItemNode/5001/ChipItemWithCount/UINBaseItem", target_parent = 302}
, 
[1504] = {delay = 0.3, id = 1504, info = 221561, target_name = "InfoNode/Btn_StarUp", target_parent = 302}
, 
[1600] = {condition = 11, 
condition_arg = {1, 1102}
, delay = 1, id = 1600, info = 281161, target_name = "Formation(Clone)/Scene/BasePlatform4", target_parent = "002_Sector_001", target_type = 2}
, 
[1601] = {delay = 0.3, id = 1601, info = 481187, info_type = 0, target_name = "return GuideUtil.GetHeroListHeroItem(1021,true,true)", target_parent = "82", target_type = 3}
, 
[1602] = {delay = 0.3, id = 1602, info = 455385, info_type = 0, target_name = "return GuideUtil.GetHeroListHeroItem(1006,true,true)", target_parent = "82", target_type = 3}
, 
[1603] = {delay = 0.2, id = 1603, info = 426986, target_name = "Right/Btn_Comfirm", target_parent = 82}
, 
[1604] = {delay = 0.2, id = 1604, info = 138658, target_name = "Buttom/Btn_Battle", target_parent = "002_Sector_001", target_type = 2}
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
[2000] = {condition = 9, delay = 0.4, guide_skip = false, id = 2000, info = 32600, target_name = "Top/TopButtonGroup/Btn_GoHome", target_parent = 74}
, 
[2001] = {condition = 1, delay = 1, id = 2001, info = 203342, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/Btn_HeroList_BIG", target_parent = 1}
, 
[2002] = {delay = 1, id = 2002, info = 203342, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/Btn_HeroList_BIG", target_parent = 1}
, 
[2003] = {id = 2003, info = 340389, target_name = "return GuideUtil.GetHeroListHeroItem(1003,true,false)", target_parent = "300", target_type = 3}
, 
[2004] = {id = 2004, info = 64103, target_name = "Center/Btn_StarUp", target_parent = 301}
, 
[2005] = {id = 2005, info = 509803, target_name = "InfoNode/Btn_StarUp", target_parent = 304}
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
[2301] = {condition = 9, delay = 0.2, id = 2301, info = 32600, target_name = "Top/TopButtonGroup/Btn_GoHome", target_parent = 74}
, 
[2302] = {delay = 1.6, id = 2302, info = 267314, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/Btn_HeroList_BIG", target_parent = 1}
, 
[2303] = {delay = 0.7, id = 2303, info = 210743, target_name = "return GuideUtil.GetHeroListHeroItem(1021,true,false)", target_parent = "300", target_type = 3}
, 
[2304] = {id = 2304, info = 313586, target_name = "Buttom/Detail/HeroSkillList/Btn_Skill", target_parent = 301}
, 
[2305] = {delay = 1, id = 2305, info = 28397, target_name = "SkillNode/obj_skillItem2/SkillUpgradeItem", target_parent = 306}
, 
[2306] = {id = 2306, info = 353128, target_name = "InfoNode/Btn_Confirm", target_parent = 306}
, 
[2401] = {condition = 1, id = 2401, info = 35944, target_name = "Main/Left/Btn_Task", target_parent = 1}
, 
[2402] = {id = 2402, info = 229889, target_name = "TaskPage/BasePos/TaskListNode/Rect/taskItem0/StepItem/RewardItemList/State/Btn_ItemClick", target_parent = 25}
, 
[2501] = {condition = 11, id = 2501, info = 200817, target_name = "Buttom/Btn_CommanderSkill", target_parent = 80}
, 
[2502] = {id = 2502, info = 45817, target_name = "TreeInfo/Btn_TreeLevel", target_parent = 123}
, 
[2503] = {delay = 0.3, id = 2503, info = 310384, target_name = "SkillUpgradeNode/Frame/ItemList/MaterialItem(Clone)/UINBaseItem", target_parent = 123}
, 
[2504] = {delay = 0.2, id = 2504, info = 286964, target_name = "SkillUpgradeNode/Frame/Btn_Confirm", target_parent = 123}
, 
[2505] = {delay = 0.2, id = 2505, info = 287787, info_pos = "2", target_name = "Top/TopButtonGroup/Btn_Back", target_parent = 123}
, 
[2506] = {delay = 0.3, id = 2506, info = 352781, target_name = "TreeDetail/SkillPageNode/ActiveSkillNode/ActiveSkillList/ActiveSkillItem (2)", target_parent = 123}
, 
[2507] = {delay = 0.3, id = 2507, info = 42779, target_name = "TreeDetail/SkillPageNode/OverLoadNode/OverloadList/overloadSkill1", target_parent = 123}
, 
[2508] = {delay = 0.2, guide_skip = false, id = 2508, info = 109137, step_type = 5, target_name = "TreeDetail/SkillPageNode/OverLoadNode/OverloadList/overloadSkill2", target_parent = 123}
, 
[2600] = {condition = 14, delay = 1, id = 2600, info = 483979, info_pos = "5", target_name = "Buttom/Detail/AlgorithmNode", target_parent = 301}
, 
[2601] = {guide_skip = false, id = 2601, info = 467731, info_pos = "6", step_type = 5, target_name = "AlgorithmDetail/Left", target_parent = 1000}
, 
[2602] = {delay = 0.2, guide_skip = false, id = 2602, info = 201391, info_pos = "7", step_type = 5, target_name = "AlgorithmDetail/AreaList", target_parent = 1000}
, 
[2603] = {delay = 0.3, id = 2603, info = 102520, info_pos = "7", target_name = "AlgorithmDetail/AreaList/A", target_parent = 1000}
, 
[2604] = {delay = 0.3, guide_skip = false, id = 2604, info = 484979, info_pos = "2", step_type = 5, target_name = "ATHListNode", target_parent = 1000}
, 
[2605] = {delay = 0.3, id = 2605, info = 260002, target_name = "ATHListNode/ScrollListAll/Content/0/1", target_parent = 1000}
, 
[2606] = {delay = 0.3, id = 2606, info = 146728, target_name = "ListDetailPos/ATHDetailItem(Clone)/BtnGroup/Btn_Equip", target_parent = 1003}
, 
[2607] = {delay = 0.3, guide_skip = false, id = 2607, info = 489309, step_type = 5, target_name = "AlgorithmDetail/Left/TableNode", target_parent = 1000}
, 
[2608] = {delay = 0.3, id = 2608, info = 475064, target_name = "Top/TopButtonGroup/Btn_Back", target_parent = 1000}
, 
[2609] = {delay = 0.2, id = 2609, info = 270437, target_name = "AlgorithmDetail/Efficiency/Btn_Efficiency/Btn_EfficiencyAdd", target_parent = 1000}
, 
[2610] = {delay = 0.4, id = 2610, info = 503498, info_pos = "2", step_type = 5, target_name = "ATHListNode", target_parent = 1001}
, 
[2701] = {condition = 12, id = 2701, info = 435891, info_pos = "8", target_name = "SectorRoot/UICanvas/SectorDungeonRoot/Btn_FriendshipDungeon", target_parent = "002_Sector_001", target_type = 2}
, 
[2702] = {id = 2702, info = 479274, step_type = 5, target_name = "Frontground/Main/HeroList/Rect", target_parent = 72}
, 
[2703] = {id = 2703, info = 376083, target_name = "Frontground/Main/StoryDetailNode/2DMaskLayer/LevelRewardNode/Level/EP01", target_parent = 72}
, 
[2704] = {id = 2704, info = 312453, step_type = 5, target_name = "Frontground/Main/StoryDetailNode/2DMaskLayer/LevelRewardNode/MaybeReward/ItemWithCount(Clone)/UINBaseItem", target_parent = 72}
, 
[2705] = {delay = 0.3, id = 2705, info = 27960, step_type = 5, target_name = "Frontground/Top/LimitCount", target_parent = 72}
, 
[2706] = {delay = 0.3, id = 2706, info = 154083, target_name = "Frontground/Main/StoryDetailNode/2DMaskLayer/Btn_Friendship", target_parent = 72}
, 
[2707] = {delay = 1, id = 2707, info = 515467, step_type = 5, target_name = "SkillNode/PresentNode/PresentScroll", target_parent = 70}
, 
[2708] = {delay = 0.3, id = 2708, info = 82928, step_type = 5, target_name = "SkillNode/Scroll/Rect", target_parent = 70}
, 
[2801] = {condition = 12, id = 2801, info = 40818, target_name = "SectorRoot/UICanvas/SectorDungeonRoot/Btn_ItemDungeon", target_parent = "002_Sector_001", target_type = 2}
, 
[2802] = {id = 2802, info = 153827, step_type = 5, target_name = "Frontground/Main/DungeonList", target_parent = 97}
, 
[2803] = {delay = 0.3, id = 2803, info = 416902, target_name = "Frontground/Main/DungeonList/MISSION DATA GATHERING", target_parent = 97}
, 
[2804] = {delay = 0.3, id = 2804, info = 123818, target_name = "Frontground/Main/DungeonDetailNode/2DMaskLayer/LevelRewardNode/Level/EP01", target_parent = 97}
, 
[2805] = {delay = 0.3, guide_skip = false, id = 2805, info = 504620, step_type = 5, target_name = "Frontground/Main/DungeonDetailNode/2DMaskLayer/LevelRewardNode/MaybeReward/ItemWithCount(Clone)/UINBaseItem", target_parent = 97}
, 
[2901] = {condition = 9, delay = 0.3, id = 2901, info = 110882, target_name = "SectorInfo/DiffBtn_normal", target_parent = 74}
, 
[2902] = {delay = 0.3, id = 2902, info = 327323, target_name = "SectorInfo/DiffcultListHolder/DiffBtn_nightmare", target_parent = 74}
, 
[3000] = {delay = 0.2, id = 3000, info = 32600, target_name = "Top/TopButtonGroup/Btn_GoHome", target_parent = 74}
, 
[3001] = {condition = 1, delay = 1, id = 3001, info = 422412, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/OasisLayout/Btn_Oasis_BIG", target_parent = 1}
, 
[3002] = {id = 3002, info = 275082, target_name = "UINode/BuildingSidebar/BuildingList/Rect/1_2/1003", target_parent = 3}
, 
[3003] = {id = 3003, info = 260478, target_name = "UINode/BuildingSidebar/BuildingList/Rect/1_2/DetailItem/Upgraded/Btn_Upgrade", target_parent = 3}
, 
[3200] = {condition = 18, delay = 0.3, id = 3200, info = 395775, step_type = 5, target_name = "StrengthPage/Page/OptimizPage/ATHNode", target_parent = 1005}
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
[3300] = {condition = 18, delay = 0.2, id = 3300, info = 2778, target_name = "StrengthPage/ToggleGroup/Tog_refactor", target_parent = 1005}
, 
[3301] = {delay = 0.2, id = 3301, info = 73043, step_type = 5, target_name = "StrengthPage/Page/RefactorPage/RefactorNode", target_parent = 1005}
, 
[3302] = {delay = 0.3, id = 3302, info = 180834, step_type = 5, target_name = "StrengthPage/Page/RefactorPage/RefactorNode/Befor", target_parent = 1005}
, 
[3303] = {delay = 0.2, id = 3303, info = 236293, step_type = 5, target_name = "StrengthPage/Page/RefactorPage/RefactorNode/After", target_parent = 1005}
, 
[3304] = {delay = 0.2, id = 3304, info = 195994, step_type = 5, target_name = "StrengthPage/Page/RefactorPage/ConsumeList", target_parent = 1005}
, 
[3400] = {condition = 1, delay = 1, id = 3400, info = 461261, op_refresh = true, target_name = "Main/Right/PageTog/Tog_FuncPageItem3", target_parent = 1}
, 
[3401] = {delay = 0.3, id = 3401, info = 224880, target_name = "Main/Right/PageList/Rect/OasisPage/Btn_Factor", target_parent = 1}
, 
[3402] = {id = 3402, info = 496360, target_name = "Rooms/Factory_A_001", target_parent = "008_Factory_001", target_type = 2}
, 
[3403] = {delay = 0.3, id = 3403, info = 411374, target_name = "FactoryRomeNode/FactoryRoomFunc/Btn_Production", target_parent = 1300}
, 
[3404] = {delay = 0.4, id = 3404, info = 388661, step_type = 5, target_name = "OrderListNode", target_parent = 1300}
, 
[3405] = {delay = 0.3, id = 3405, info = 15013, target_name = "OrderNode/Btn_Add", target_parent = 1300}
, 
[3406] = {delay = 0.3, id = 3406, info = 469333, target_name = "OrderNode/Btn_Confirm", target_parent = 1300}
, 
[3407] = {delay = 0.3, id = 3407, info = 479980, step_type = 5, target_name = "FactoryRomeNode/EnterhNode", target_parent = 1300}
, 
[90101] = {condition = 16, delay = 2.5, id = 90101, info = 129317, op_refresh = true, step_type = 5, target_name = "Frame/RewardLayout/CCNode", target_parent = 4}
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
[150100] = {condition = 1, delay = 1.7, id = 150100, info = 472206, op_refresh = true, target_name = "Main/Right/PageTog/Tog_FuncPageItem1", target_parent = 1}
, 
[150101] = {delay = 1.7, id = 150101, info = 472206, op_refresh = true, target_name = "Main/Right/PageTog/Tog_FuncPageItem1", target_parent = 1}
, 
[150102] = {id = 150102, info = 489635, target_name = "Main/Right/PageList/Rect/HeroPage/Btn_Lottery", target_parent = 1}
, 
[150103] = {id = 150103, info = 507854, op_refresh = true, target_name = "Buttom/Btn_Once", target_parent = 13}
, 
[150104] = {id = 150104, info = 129396, target_name = "Frame/YesNoNode/ButtonYes", target_parent = 1200}
, 
[150105] = {condition = 17, delay = 0.2, id = 150105, info = 513268, target_name = "Buttom/InfoScroll/Rect/2", target_parent = 13}
, 
[150106] = {delay = 0.2, id = 150106, info = 159122, op_refresh = true, target_name = "Buttom/Btn_Once", target_parent = 13}
, 
[150107] = {condition = 17, delay = 0.8, id = 150107, info = 513268, target_name = "Buttom/InfoScroll/Rect/2", target_parent = 13}
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
[1001201] = {condition = 5, delay = 1, id = 1001201, info = 507128, target_name = "PropList/10145", target_parent = 102}
, 
[1001202] = {delay = 0.3, id = 1001202, info = 252848, target_name = "PropList/10145", target_parent = 102}
, 
[1002201] = {condition = 1, delay = 1, id = 1002201, info = 140098, op_refresh = true, target_name = "RotateWithMian/MainUI/Middle/Btn_Exproation", target_parent = 1}
, 
[1002202] = {delay = 1.5, id = 1002202, info = 460856, target_name = "SectorRoot/UICanvas/ProgressNode/1_1", target_parent = "002_Sector_001", target_type = 2}
}
local __default_values = {avg_name = "", condition = 0, condition_arg = __rt_1, custom_code = "", delay = 0.5, guide_skip = true, id = 100, info = "", info_pos = "", info_type = 1001, op_refresh = false, step_type = 1, target_name = "", target_parent = "", target_type = 1, wait_target = true}
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


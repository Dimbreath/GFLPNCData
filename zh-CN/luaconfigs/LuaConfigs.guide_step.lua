-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local __rt_2 = {1}
local __rt_3 = {1011}
local __rt_4 = {170, 260}
local __rt_5 = {1021}
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
[501] = {condition = 1, condition_arg = __rt_2, delay = 1, id = 501, info = 3204, op_refresh = true, target_name = "Right/Mask/PageList/Rect/Btn_Exproation/Btn_ContinueEp", target_parent = 1}
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
[700] = {condition = 1, delay = 1, id = 700, info = 257023, op_refresh = true, target_name = "Right/Mask/PageList/Rect/Btn_Exproation", target_parent = 1}
, 
[701] = {avg_name = "cpt00_tutorial_06", delay = 1, guide_skip = false, id = 701, info_type = 0, step_type = 2, target_parent = "002_Sector_001", target_type = 2}
, 
[702] = {delay = 0.8, id = 702, info = 409303, target_name = "SectorRoot/UICanvas/InfoNode/1/InfoItem", target_parent = "002_Sector_001", target_type = 2}
, 
[703] = {id = 703, info = 368240, target_name = "return GuideUtil.LocationSectorStageItem(1101)", target_type = 3}
, 
[704] = {id = 704, info = 203610, target_name = "DetailNode/BtnGroup/Btn_Battle", target_parent = 75}
, 
[705] = {delay = 1, id = 705, info = 465031, target_name = "NotEditorNode/Btn_Battle", target_parent = "002_Sector_001", target_type = 2}
, 
[800] = {avg_name = "cpt00_tutorial_08", condition = 3, condition_arg = __rt_3, guide_skip = false, id = 800, info_type = 0, step_type = 2, target_type = 0}
, 
[801] = {delay = 0.4, id = 801, info = 493809, target_name = "return GuideUtil.GetEpFirstRoomTarget()", target_type = 3}
, 
[900] = {condition = 15, delay = 0.4, id = 900, info = 2375, step_type = 5, target_name = "UINEnemyDetail", target_parent = 206}
, 
[901] = {delay = 0.4, id = 901, info = 379486, target_name = "Frame/Btn_BattleStart", target_type = 2}
, 
[1000] = {condition = 5, delay = 0.9, id = 1000, info = 54061, target_name = "Frame/PropList/10222/UINEpChipDetail/Root/ItemHolder/UINBaseChipDetail/BtnHolder/Btn_Click", target_parent = 102}
, 
[1001] = {delay = 0.3, id = 1001, info = 339215, target_name = "Frame/PropList/10222/UINEpChipDetail/Root/ItemHolder/UINBaseChipDetail/BtnHolder/Btn_Click", target_parent = 102}
, 
[1101] = {condition = 7, id = 1101, info = 522054, target_name = "Frame/TreasureNode/TreasureList/10207/UINEpChipDetail/Root/ItemHolder/UINBaseChipDetail/BtnHolder/Btn_Click", target_parent = 130}
, 
[1102] = {delay = 0.3, id = 1102, info = 327201, target_name = "Frame/TreasureNode/TreasureList/10207/UINEpChipDetail/Root/ItemHolder/UINBaseChipDetail/BtnHolder/Btn_Click", target_parent = 130}
, 
[1200] = {avg_name = "cpt00_tutorial_13", condition = 3, condition_arg = __rt_3, delay = 0, guide_skip = false, id = 1200, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[1201] = {condition = 8, id = 1201, info = 495092, target_name = "Frame/EventNode/ChoiceList/Rect/1/ItemNode", target_parent = 131}
, 
[1202] = {condition = 8, delay = 0.2, id = 1202, info = 23311, target_name = "Frame/EventNode/ChoiceList/Rect/2/ItemNode", target_parent = 131}
, 
[1300] = {condition = 9, delay = 0.2, id = 1300, info = 32600, target_name = "Top/TopButtonGroup/Btn_Back", target_parent = 74}
, 
[1301] = {delay = 0.2, id = 1301, info = 1321, target_name = "Top/TopButtonGroup/Btn_Back", target_parent = 76}
, 
[1302] = {condition = 1, delay = 1, id = 1302, info = 383124, op_refresh = true, target_name = "Right/Mask/PageList/Rect/Btn_Oasis", target_parent = 1}
, 
[1303] = {avg_name = "cpt00_tutorial_11", guide_skip = false, id = 1303, info_type = 0, step_type = 2, target_type = 0}
, 
[1305] = {id = 1305, info = 403565, target_name = "Btn_Editor", target_parent = 1500}
, 
[1306] = {id = 1306, info = 464277, target_name = "Frame/ScrollRect/Rect/1", target_parent = 9}
, 
[1307] = {id = 1307, info = 377955, target_name = "SelectNode/Editor/Btn_Confirm", target_parent = 1500}
, 
[1308] = {id = 1308, info = 1503, target_name = "TopButtonGroup/Btn_Back", target_parent = 2}
, 
[1321] = {complete_code = "GuideUtil.CancelReturnHomeCv()", condition = 9, delay = 0.2, guide_skip = false, id = 1321, info = 169866, target_name = "TopButtonGroup/Btn_GoHome", target_parent = 2}
, 
[1349] = {delay = 0.2, id = 1349, info = 515774, info_pos = "5", step_type = 5, target_name = "Frame/Scroll", target_parent = 3}
, 
[1350] = {delay = 0.2, id = 1350, info = 132820, target_name = "TopButtonGroup/Btn_GoHome", target_parent = 2}
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
[1497] = {condition = 10, id = 1497, info = 132820, target_name = "TopButtonGroup/Btn_GoHome", target_parent = 2}
, 
[1498] = {delay = 0.2, id = 1498, info = 202111, target_name = "Frame/Scroll/Rect/MAIN SYSTEM/List/1", target_parent = 3}
, 
[1500] = {condition = 1, delay = 0.8, id = 1500, info = 176166, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/Btn_HeroList_BIG", target_parent = 1}
, 
[1501] = {delay = 0.7, id = 1501, info = 230861, target_name = "return GuideUtil.GetHeroListHeroItem(1003,true,false)", target_parent = "300", target_type = 3}
, 
[1502] = {id = 1502, info = 81788, target_name = "Center/Level/Btn_LevelUp", target_parent = 301}
, 
[1503] = {delay = 0.7, id = 1503, info = 74198, info_pos = "9", step_type = 5, target_name = "Detail/LevelNode", target_parent = 309}
, 
[1504] = {delay = 0.4, id = 1504, info = 18467, info_pos = "2", step_type = 5, target_name = "Detail/AttriNode", target_parent = 309}
, 
[1505] = {delay = 0.3, id = 1505, info = 315654, info_pos = "4", step_type = 5, target_name = "Control/ItemList", target_parent = 309}
, 
[1506] = {delay = 0.3, id = 1506, info = 89871, target_name = "Control/CanUP/Btn_Confirm", target_parent = 309}
, 
[1507] = {condition = 24, custom_size = __rt_4, delay = 0.8, id = 1507, info = 408649, target_name = "return GuideUtil.GetHeroPotentialFmtPlat()", target_type = 3}
, 
[1508] = {id = 1508, info = 74198, target_name = "Center/Level/Btn_QuickLevelUp", target_parent = 301}
, 
[1509] = {id = 1509, info = 249080, target_name = "Control/CanUP/Btn_Confirm", target_parent = 309}
, 
[1598] = {condition = 9, id = 1598, info = 32600, target_name = "TopButtonGroup/Btn_GoHome", target_parent = 2}
, 
[1599] = {delay = 0.8, id = 1599, info = 176166, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/Btn_HeroList_BIG", target_parent = 1}
, 
[1600] = {condition = 11, 
condition_arg = {1, 1102}
, delay = 1, guide_skip = false, id = 1600, info = 20516, target_name = "NotEditorNode/Normal/Btn_Editor", target_parent = 80}
, 
[1601] = {custom_code = "GuideUtil.StartFormationGuide(1021,4)", delay = 0, guide_skip = false, id = 1601, info = 89076, info_pos = "1", step_type = 3, target_type = 0, wait_target = false}
, 
[1602] = {custom_code = "GuideUtil.StartFormationGuide(1006,5)", delay = 0, guide_skip = false, id = 1602, info = 117937, info_pos = "1", step_type = 3, target_type = 0, wait_target = false}
, 
[1603] = {guide_skip = false, id = 1603, info = 275402, target_name = "EditorNode/Btn_Close", target_parent = 80}
, 
[1604] = {condition = 11, id = 1604, info = 422805, target_name = "NotEditorNode/Btn_Battle", target_parent = "002_Sector_001", target_type = 2}
, 
[1700] = {avg_name = "cpt00_tutorial_12", condition = 3, condition_arg = __rt_5, guide_skip = false, id = 1700, info_type = 0, step_type = 2, target_type = 0}
, 
[1800] = {avg_name = "cpt00_tutorial_19", condition = 4, delay = 0, guide_skip = false, id = 1800, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[1801] = {delay = 0.4, id = 1801, info = 475729, info_pos = "2", target_name = "BattleHolder/FloorTileHolder/(1, 2)", target_parent = "006_Arena_003", target_type = 2}
, 
[1802] = {custom_code = "GuideUtil.StartBattleDeployGuide(1,4,1,2)", delay = 0, guide_skip = false, id = 1802, info = 265736, info_pos = "11", step_type = 3, target_type = 0, wait_target = false}
, 
[1900] = {avg_name = "cpt00_tutorial_14", condition = 3, condition_arg = __rt_5, delay = 0, guide_skip = false, id = 1900, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[2000] = {condition = 9, delay = 0.4, guide_skip = false, id = 2000, info = 226886, target_name = "TopButtonGroup/Btn_GoHome", target_parent = 2}
, 
[2001] = {condition = 1, delay = 1, id = 2001, info = 66471, op_refresh = true, target_name = "Right/Mask/PageList/Rect/Btn_HeroList", target_parent = 1}
, 
[2002] = {delay = 1, id = 2002, info = 432054, op_refresh = true, target_name = "Right/Mask/PageList/Rect/Btn_HeroList", target_parent = 1}
, 
[2003] = {id = 2003, info = 389466, target_name = "return GuideUtil.GetHeroListHeroItem(1003,true,false)", target_parent = "300", target_type = 3}
, 
[2004] = {id = 2004, info = 291158, target_name = "Center/Btn_StarUp", target_parent = 301}
, 
[2005] = {id = 2005, info = 96923, target_name = "InfoNode/consumeNode/NotFullRank/Btn_StarUp", target_parent = 304}
, 
[2006] = {delay = 0.2, id = 2006, info = 132820, target_name = "Frame/Scroll/Rect/MAIN SYSTEM/List/1", target_parent = 3}
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
[2300] = {condition = 1, delay = 1, id = 2300, info = 70662, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/Btn_HeroList_BIG", target_parent = 1}
, 
[2301] = {condition = 9, delay = 0.2, id = 2301, info = 367625, target_name = "Top/TopButtonGroup/Btn_GoHome", target_parent = 74}
, 
[2302] = {condition = 14, delay = 0.6, id = 2302, info = 70662, op_refresh = true, target_name = "Buttom/Detail/HeroSkillList/Btn_Skill", target_parent = 301}
, 
[2303] = {delay = 1, id = 2303, info = 222675, target_name = "SkillNode/Rect/obj_skillItem2/SkillUpgradeItem", target_parent = 306}
, 
[2304] = {id = 2304, info = 451690, step_type = 5, target_name = "InfoNode/SkillDetailNode/Scroll/SkillDetaiList", target_parent = 306}
, 
[2305] = {delay = 1, first_code = "GuideManager:AddGuideFeature(1)", id = 2305, info = 449377, target_name = "InfoNode/ItemList/ExtrItem(Clone)/UINBaseItem", target_parent = 306}
, 
[2306] = {delay = 0.8, id = 2306, info = 441542, target_name = "Frame/Detail/Normal/Layout/List/JumpList/Rect/jumpInfoItem(Clone)/JumpDescrItem(Clone)/Btn_Goto", target_parent = 40}
, 
[2401] = {condition = 1, id = 2401, info = 35944, target_name = "Main/Left/Btn_Task", target_parent = 1}
, 
[2402] = {id = 2402, info = 229889, target_name = "TaskPage/BasePos/TaskListNode/Rect/taskItem0/StepItem/RewardItemList/State/Btn_ItemClick", target_parent = 25}
, 
[2501] = {condition = 11, id = 2501, info = 236197, target_name = "NotEditorNode/Btn_CommanderSkill", target_parent = 80}
, 
[2502] = {id = 2502, info = 489927, info_pos = "2", step_type = 5, target_name = "SkillNode/SkillList", target_parent = 123}
, 
[2503] = {delay = 0.3, id = 2503, info = 163440, info_pos = "10", step_type = 5, target_name = "SkillNode/Passive", target_parent = 123}
, 
[2504] = {delay = 0.2, id = 2504, info = 437702, step_type = 5, target_name = "SkillNode/OverrideNode/OverrideSkill1/Skill/Btn_Root", target_parent = 123}
, 
[2505] = {delay = 0.2, id = 2505, info = 159500, info_pos = "2", target_name = "Btn_TreeLevel", target_parent = 123}
, 
[2506] = {delay = 0.3, id = 2506, info = 97697, step_type = 5, target_name = "CSTLevelUpNode/Frame/Normal/ScrollRect/Rect", target_parent = 123}
, 
[2507] = {delay = 0.3, id = 2507, info = 464917, target_name = "CSTLevelUpNode/Frame/Info/Cost/List/5005/Btn_Add", target_parent = 123}
, 
[2508] = {delay = 0.2, id = 2508, info = 279169, target_name = "CSTLevelUpNode/Frame/Normal/Btn_Upgrade", target_parent = 123}
, 
[2509] = {delay = 0.2, id = 2509, info = 472837, target_name = "CSTLevelUpNode/Frame/Btn_Close", target_parent = 123}
, 
[2510] = {delay = 0.4, id = 2510, info = 436657, target_name = "SkillNode/OverrideNode/OverrideSkill1/Skill/Btn_Root", target_parent = 123}
, 
[2511] = {delay = 0.4, id = 2511, info = 320922, step_type = 5, target_name = "CSTDetailNode/Buttom", target_parent = 123}
, 
[2512] = {delay = 0.3, id = 2512, info = 477981, target_name = "CSTDetailNode/Btn_Equip", target_parent = 123}
, 
[2513] = {delay = 0.3, id = 2513, info = 435248, info_pos = "2", step_type = 5, target_name = "TreeList", target_parent = 123}
, 
[2600] = {condition = 14, delay = 1, id = 2600, info = 172366, info_pos = "5", target_name = "Buttom/Detail/AlgorithmNode", target_parent = 301}
, 
[2601] = {guide_skip = false, id = 2601, info = 350016, info_pos = "6", step_type = 5, target_name = "InfoNode/AreaList", target_parent = 1000}
, 
[2602] = {delay = 0.2, guide_skip = false, id = 2602, info = 145788, info_pos = "7", step_type = 5, target_name = "InfoNode/AreaList", target_parent = 1000}
, 
[2603] = {delay = 0.3, id = 2603, info = 28359, info_pos = "7", target_name = "InfoNode/AreaList/1", target_parent = 1000}
, 
[2604] = {delay = 0.3, guide_skip = false, id = 2604, info = 135023, info_pos = "2", step_type = 5, target_name = "ATHListNode/List", target_parent = 1000}
, 
[2605] = {delay = 0.3, id = 2605, info = 25229, target_name = "return GuideUtil.GetSpaceAthByAthList(1)", target_type = 3}
, 
[2606] = {delay = 0.3, id = 2606, info = 1834, target_name = "ListDetailPos/UINATHDetailItem(Clone)/BtnGroup/Btn_Equip", target_parent = 1003}
, 
[2607] = {delay = 0.3, guide_skip = false, id = 2607, info = 34349, step_type = 5, target_name = "InfoNode/AreaList/1", target_parent = 1000}
, 
[2608] = {delay = 0.3, id = 2608, info = 241054, target_name = "TopButtonGroup/Btn_Back", target_parent = 2}
, 
[2609] = {delay = 0.2, id = 2609, info = 109090, target_name = "Btn_Efficiency", target_parent = 1000}
, 
[2610] = {delay = 0.4, id = 2610, info = 97892, info_pos = "2", step_type = 5, target_name = "ATHListNode", target_parent = 1001}
, 
[2611] = {delay = 0.4, id = 2611, info = 35007, info_type = 1000, step_type = 5, target_name = "ATHListNode/List/AreaTogGroup", target_parent = 1000}
, 
[2612] = {delay = 0.4, id = 2612, info = 156431, info_type = 1000, step_type = 5, target_name = "InfoNode/Info/Pages", target_parent = 1000}
, 
[2701] = {condition = 12, delay = 0.8, first_code = "GuideUtil.SectorForceFocus(22)", id = 2701, info = 106405, info_pos = "8", target_name = "SectorRoot/UICanvas/SectorDungeonRoot/Btn_FriendshipDungeon", target_parent = "002_Sector_001", target_type = 2}
, 
[2702] = {id = 2702, info = 523958, step_type = 5, target_name = "Frontground/Main/HeroList/Rect", target_parent = 72}
, 
[2703] = {id = 2703, info = 218639, target_name = "Frontground/Main/StoryDetailNode/2DMaskLayer/LevelRewardNode/Level/01", target_parent = 72}
, 
[2704] = {id = 2704, info = 446662, step_type = 5, target_name = "Frontground/Main/StoryDetailNode/2DMaskLayer/LevelRewardNode/MaybeReward/ItemWithCount(Clone)/UINBaseItem", target_parent = 72}
, 
[2705] = {delay = 0.3, id = 2705, info = 60425, step_type = 5, target_name = "Frontground/Top/LimitCount", target_parent = 72}
, 
[2706] = {delay = 0.3, id = 2706, info = 290564, target_name = "Frontground/Main/StoryDetailNode/2DMaskLayer/Btn_Friendship", target_parent = 72}
, 
[2707] = {delay = 1, id = 2707, info = 57813, step_type = 5, target_name = "SkillNode/PresentNode/PresentScroll", target_parent = 70}
, 
[2708] = {delay = 0.3, id = 2708, info = 258757, step_type = 5, target_name = "SkillNode/Scroll/Rect", target_parent = 70}
, 
[2801] = {condition = 12, delay = 0.8, first_code = "GuideUtil.SectorForceFocus(11)", id = 2801, info = 105984, target_name = "SectorRoot/UICanvas/SectorDungeonRoot/Btn_ItemDungeon", target_parent = "002_Sector_001", target_type = 2}
, 
[2802] = {id = 2802, info = 92242, step_type = 5, target_name = "Frontground/Main/Scroll/Rect/DungeonList", target_parent = 97}
, 
[2803] = {delay = 0.3, id = 2803, info = 306133, target_name = "Frontground/Main/Scroll/Rect/DungeonList/DGC GATHERING", target_parent = 97}
, 
[2804] = {delay = 0.3, id = 2804, info = 258972, target_name = "Frontground/Main/DungeonDetailNode/2DMaskLayer/LevelRewardNode/Level/01", target_parent = 97}
, 
[2805] = {delay = 0.3, guide_skip = false, id = 2805, info = 232134, step_type = 5, target_name = "Frontground/Main/DungeonDetailNode/2DMaskLayer/LevelRewardNode/NormalReward", target_parent = 97}
, 
[2901] = {condition = 9, delay = 0.3, id = 2901, info = 255777, target_name = "SectorInfo/DiffBtn_normal", target_parent = 74}
, 
[2902] = {delay = 0.3, id = 2902, info = 212185, target_name = "SectorInfo/DiffcultListHolder/DiffBtn_nightmare", target_parent = 74}
, 
[3000] = {delay = 0.2, id = 3000, info = 32600, target_name = "TopButtonGroup/Btn_GoHome", target_parent = 2}
, 
[3001] = {condition = 1, delay = 1, id = 3001, info = 422412, op_refresh = true, target_name = "Main/Right/PageList/Rect/CenterPage/OasisLayout/Btn_Oasis_BIG", target_parent = 1}
, 
[3002] = {delay = 1, id = 3002, info = 275082, target_name = "UINode/BuildingSidebar/BuildingList/Rect/1_2/1003", target_parent = 3}
, 
[3003] = {id = 3003, info = 260478, target_name = "UINode/BuildingSidebar/BuildingList/Rect/1_2/DetailItem/Upgraded/Btn_Upgrade", target_parent = 3}
, 
[3200] = {condition = 18, delay = 0.3, id = 3200, info = 121048, step_type = 5, target_name = "StrengthPage/Page/OptimizPage/ATHNode", target_parent = 1005}
, 
[3201] = {delay = 0.3, id = 3201, info = 4610, target_name = "StrengthPage/Page/OptimizPage/ATHNode/AffixList/1", target_parent = 1005}
, 
[3202] = {delay = 0.2, id = 3202, info = 114782, step_type = 5, target_name = "StrengthPage/Page/OptimizPage/UpgadeNode/Slider", target_parent = 1005}
, 
[3203] = {delay = 0.2, id = 3203, info = 159870, step_type = 5, target_name = "StrengthPage/Page/OptimizPage/UpgadeNode/FailBar", target_parent = 1005}
, 
[3204] = {delay = 0.3, id = 3204, info = 280163, target_name = "StrengthPage/ToggleGroup/Tog_Dismantle", target_parent = 1005}
, 
[3205] = {delay = 0.3, id = 3205, info = 417680, info_pos = "2", step_type = 5, target_name = "ATHListNode", target_parent = 1005}
, 
[3300] = {delay = 0.2, id = 3300, info = 147426, target_name = "StrengthPage/ToggleGroup/Tog_refactor", target_parent = 1005}
, 
[3301] = {condition = 18, delay = 0.2, id = 3301, info = 314643, step_type = 5, target_name = "Frame/ATHDetailItem/AffixList", target_parent = 1007}
, 
[3302] = {delay = 0.3, id = 3302, info = 241640, step_type = 5, target_name = "Frame/ATHDetailItem/AffixList", target_parent = 1007}
, 
[3303] = {delay = 0.2, id = 3303, info = 2025, step_type = 5, target_name = "Frame/LeftArea/Scrollbar", target_parent = 1007}
, 
[3304] = {delay = 0.2, id = 3304, info = 39596, step_type = 5, target_name = "Frame/ATHDetailItem/Btn_Refactor", target_parent = 1007}
, 
[3400] = {condition = 1, delay = 1, id = 3400, info = 95511, op_refresh = true, target_name = "Right/Mask/PageList/Rect/Btn_openRightSide", target_parent = 1}
, 
[3401] = {delay = 0.3, id = 3401, info = 426865, target_name = "Right/Mask/PageList/Rect/FactorAndWarehouse/Btn_Factor", target_parent = 1}
, 
[3402] = {id = 3402, info = 218148, target_name = "Rooms/Factory_B_002", target_parent = "008_Factory_001", target_type = 2}
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
[3500] = {condition = 9, delay = 0.2, id = 3500, info = 426641, target_name = "TopButtonGroup/Btn_GoHome", target_parent = 2}
, 
[3501] = {condition = 1, delay = 1, id = 3501, info = 25282, op_refresh = true, target_name = "Left/Btn_Novice", target_parent = 1}
, 
[3502] = {delay = 0.8, id = 3502, info = 368658, step_type = 5, target_name = "CanvasAdd/TaskNode/Scroll/Rect", target_parent = 1600}
, 
[3503] = {delay = 0.4, id = 3503, info = 96250, step_type = 5, target_name = "CanvasAdd/TaskNode/Reward", target_parent = 1600}
, 
[3504] = {delay = 0.4, id = 3504, info = 72511, step_type = 5, target_name = "CanvasAdd/TitleInfo", target_parent = 1600}
, 
[3505] = {delay = 0.2, id = 3505, info = 25320, target_name = "Frame/Scroll/Rect/MAIN SYSTEM/List/1", target_parent = 3}
, 
[3600] = {condition = 4, id = 3600, info = 141132, step_type = 5, target_name = "Frame/Tog_Auto", target_parent = 204}
, 
[3601] = {delay = 0.4, id = 3601, info = 430404, step_type = 5, target_name = "Frame/Btn_SpeedUP", target_parent = 204}
, 
[3700] = {condition = 11, delay = 0.8, id = 3700, info = 502295, target_name = "Buttom/CampList/Btn_Title", target_parent = 80}
, 
[3701] = {delay = 0.4, id = 3701, info = 57282, step_type = 5, target_name = "Frame/Camp/List", target_parent = 83}
, 
[3702] = {delay = 0.4, id = 3702, info = 496198, info_pos = "2", step_type = 5, target_name = "Frame/BondEff/List", target_parent = 83}
, 
[3703] = {id = 3703, info = 335701, step_type = 5, target_name = "Frame/Camp/List", target_parent = 83}
, 
[3800] = {condition = 1, delay = 1, id = 3800, info = 55928, op_refresh = true, target_name = "Right/Mask/PageList/Rect/Btn_Exproation", target_parent = 1}
, 
[3801] = {delay = 1, id = 3801, info = 150166, target_name = "SectorRoot/UICanvas/InfoNode/1/InfoItem", target_parent = "002_Sector_001", target_type = 2}
, 
[3802] = {delay = 0.8, id = 3802, info = 164388, target_name = "return GuideUtil.LocationSectorStageItem(1101,true)", target_type = 3}
, 
[3803] = {delay = 0.6, id = 3803, info = 275945, target_name = "DetailNode/BtnGroup/Btn_ViewAvg", target_parent = 75}
, 
[3804] = {condition = 1, delay = 0.6, id = 3804, info = 136005, op_refresh = true, target_name = "Main/Right/PageTog/Tog_FuncPageItem2", target_parent = 1}
, 
[3900] = {condition = 9, id = 3900, info = 512173, target_name = "return GuideUtil.LocationSectorStageItem(1102)", target_type = 3}
, 
[3901] = {id = 3901, info = 518890, target_name = "DetailNode/BtnGroup/Btn_Battle", target_parent = 75}
, 
[3902] = {condition = 1, delay = 1, id = 3902, info = 55928, op_refresh = true, target_name = "Right/Mask/PageList/Rect/Btn_Exproation", target_parent = 1}
, 
[3903] = {delay = 1, id = 3903, info = 67530, target_name = "SectorRoot/UICanvas/InfoNode/1/InfoItem", target_parent = "002_Sector_001", target_type = 2}
, 
[4000] = {condition = 9, delay = 0.3, id = 4000, info = 65301, target_name = "SectorInfo/DiffBtn_normal", target_parent = 74}
, 
[4001] = {delay = 0.3, id = 4001, info = 111577, target_name = "SectorInfo/DiffcultListHolder/DiffBtn_infinity", target_parent = 74}
, 
[4002] = {delay = 0.6, id = 4002, info = 456148, info_pos = "2", step_type = 5, target_name = "DifficultList/UI_SectorLevelInfinityMap(Clone)/UIAdapter/ScrollRect", target_parent = 74}
, 
[4003] = {avg_name = "cpt00_tutorial_25", delay = 0, guide_skip = false, id = 4003, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[4100] = {avg_name = "cpt00_tutorial_22", condition = 3, 
condition_arg = {1051}
, delay = 0, guide_skip = false, id = 4100, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[4200] = {condition = 12, delay = 1, first_code = "GuideUtil.SectorForceFocus(23)", id = 4200, info = 254674, target_name = "SectorRoot/UICanvas/SectorDungeonRoot/Btn_WeeklyChallengeButton/InfoItem", target_parent = "002_Sector_001", target_type = 2}
, 
[4201] = {id = 4201, info = 136885, step_type = 5, target_name = "LevelNode/DailyNode", target_parent = 1950}
, 
[4202] = {delay = 0.4, id = 4202, info = 32040, step_type = 5, target_name = "Btn_WeeklyShop", target_parent = 1950}
, 
[4203] = {delay = 0.4, id = 4203, info = 112737, target_name = "LevelNode/DailyNode", target_parent = 1950}
, 
[4204] = {delay = 0.3, id = 4204, info = 44123, target_name = "DetailNode/BtnGroup/Btn_Battle", target_parent = 75}
, 
[4205] = {custom_size = __rt_4, id = 4205, info = 382706, target_name = "Formation(Clone)/Scene/BasePlatform1", target_parent = "002_Sector_001", target_type = 2}
, 
[4206] = {id = 4206, info = 162962, info_pos = "4", step_type = 5, target_name = "Right/HeroList/Rect", target_parent = 82}
, 
[4300] = {condition = 12, delay = 0.3, id = 4300, info = 320902, target_name = "Btn_StrategyOverview", target_parent = 76}
, 
[4301] = {delay = 0.3, id = 4301, info = 516893, step_type = 5, target_name = "StOList/Rect/Unlock/ChessLayout/3", target_parent = 1400}
, 
[4302] = {delay = 0.3, id = 4302, info = 192912, step_type = 5, target_name = "Side/Down", target_parent = 1400}
, 
[4303] = {delay = 0.3, id = 4303, info = 424416, step_type = 5, target_name = "Side/Down", target_parent = 1400}
, 
[4304] = {delay = 0.3, id = 4304, info = 362297, step_type = 5, target_name = "Side/SkillInfo", target_parent = 1400}
, 
[4305] = {delay = 0.3, id = 4305, info = 219478, target_name = "Side/Down/Consume/Btn_Upgrade", target_parent = 1400}
, 
[4400] = {condition = 1, delay = 0.6, id = 4400, info = 483912, op_refresh = true, target_name = "Right/Mask/PageList/Rect/Btn_Shop", target_parent = 1}
, 
[4401] = {after_code = "GuideUtil.SetGuideShopHeroActive(false)", avg_name = "cpt00_tutorial_23", clear_code = "GuideUtil.SetGuideShopHeroActive(true)", delay = 0, guide_skip = false, id = 4401, info_type = 0, step_type = 2, target_parent = 1800}
, 
[4500] = {avg_name = "cpt00_tutorial_24", condition = 9, delay = 0, guide_skip = false, id = 4500, info = 261934, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[4501] = {id = 4501, info = 60020, target_name = "TopButtonGroup/Btn_OpenNavigation", target_parent = 2}
, 
[4502] = {delay = 0.8, id = 4502, info = 96184, info_pos = "2", step_type = 5, target_name = "Go_NavigationParent/UI_NavigationBar/Frame/Scroll/Rect", target_parent = 2}
, 
[4503] = {delay = 0.3, id = 4503, info = 2457, target_name = "Go_NavigationParent/UI_NavigationBar/Frame/Scroll/Rect/MAIN SYSTEM/List/3", target_parent = 2}
, 
[4601] = {condition = 19, delay = 0.4, id = 4601, info = 391294, step_type = 5, target_name = "return GuideUtil.GetEpCuroomTarget()", target_type = 3}
, 
[4701] = {condition = 4, custom_code = "GuideUtil.StartBattleDeployClickGuide(100,0)", delay = 0, id = 4701, info = 412010, info_pos = "4", step_type = 3, target_type = 0, wait_target = false}
, 
[4702] = {delay = 0, id = 4702, info = 194506, step_type = 5, target_name = "BattleGirdInfoNode", target_parent = 212}
, 
[4801] = {condition = 3, delay = 0.3, id = 4801, info = 453432, target_name = "Frame/EventNode/ChoiceList/Rect/1/ItemNode", target_parent = 131}
, 
[4802] = {delay = 0.3, id = 4802, info = 58774, target_name = "Frame/ScrollRect/Rect/SupportList/SupportList/1/HeroHeadItem", target_parent = 135}
, 
[4803] = {delay = 0.4, id = 4803, info = 493135, step_type = 5, target_name = "Frame/ScrollRect/Rect/HeroList/CurrentList", target_parent = 135}
, 
[4901] = {condition = 20, id = 4901, info = 390090, info_pos = "2", step_type = 5, target_name = "Frame/RewardNode", target_parent = 141}
, 
[4902] = {delay = 0.3, guide_skip = false, id = 4902, info = 503191, step_type = 5, target_name = "Frame/RewardNode/RewardList/Scroll/Rect/RewardBagItem(Clone)/Selecttable", target_parent = 141}
, 
[4903] = {delay = 0.3, id = 4903, info = 123260, step_type = 5, target_name = "Frame/Btn_Close", target_parent = 141}
, 
[4904] = {delay = 0.3, id = 4904, info = 2003, step_type = 5, target_name = "Frame/Btn_Get", target_parent = 141}
, 
[5001] = {condition = 3, 
condition_arg = {1041}
, delay = 0.3, id = 5001, info = 294362, target_name = "Frame/ChipSuitNode/Brief/Scroll View/Viewport/List/4", target_parent = 101}
, 
[5002] = {delay = 0.3, id = 5002, info = 307143, step_type = 5, target_name = "Detail/Frame/SuitInfo", target_parent = 144}
, 
[5003] = {delay = 0.3, id = 5003, info = 271100, step_type = 5, target_name = "Detail/Frame/SuitInfo/Scroll/Rect", target_parent = 144}
, 
[5004] = {delay = 0.3, id = 5004, info = 233410, step_type = 5, target_name = "Detail/Frame/SuitInfo/ChipList", target_parent = 144}
, 
[5100] = {condition = 4, custom_code = "GuideUtil.StartBattleDeployClickGuide(100,1)", delay = 0, id = 5100, info = 461839, info_pos = "4", step_type = 3, target_type = 0, wait_target = false}
, 
[5200] = {condition = 23, delay = 0.3, id = 5200, info = 363466, info_pos = "2", step_type = 5, target_name = "FrameNode/UI_EpShopNode/StoreList/Rect", target_parent = 109}
, 
[5201] = {delay = 0.3, id = 5201, info = 488829, step_type = 5, target_name = "FrameNode/UI_EpShopNode/btn_Refresh", target_parent = 109}
, 
[5202] = {delay = 0.3, id = 5202, info = 258596, target_name = "FrameNode/UI_EpShopNode/TradeTypeTile/Btn_SellTypeItem", target_parent = 109}
, 
[5300] = {condition = 22, delay = 0.6, id = 5300, info = 285607, step_type = 5, target_name = "Frame/FailureNode/Suggest/SuggestBtn/Btn_GotoLevelUpItem", target_parent = 6}
, 
[5301] = {delay = 0.3, id = 5301, info = 294540, target_name = "Frame/FailureNode/Suggest/SuggestBtn/Btn_GotoLevelUpItem", target_parent = 6}
, 
[5302] = {delay = 0.8, id = 5302, info = 37314, target_name = "Frame/Mask/HeroList/Rect/1", target_parent = 300}
, 
[5303] = {delay = 0.4, id = 5303, info = 514235, step_type = 5, target_name = "Center/Level", target_parent = 301}
, 
[5304] = {delay = 0.3, id = 5304, info = 302518, step_type = 5, target_name = "Center/Btn_StarUp", target_parent = 301}
, 
[5400] = {condition = 11, 
condition_arg = {7}
, id = 5400, info = 36348, target_name = "NotEditorNode/DebuffSelect/Btn_Layer", target_parent = 80}
, 
[5500] = {condition = 3, id = 5500, info = 58509, target_name = "Frame/AutoModuleNode/Btn_AutoModule", target_parent = 101}
, 
[5501] = {id = 5501, info = 82667, step_type = 5, target_name = "Frame/AutoModuleNode/Btn_StartAuto", target_parent = 101}
, 
[5600] = {condition = 24, condition_arg = __rt_2, id = 5600, info = 157056, target_name = "return GuideUtil.GetHeroQuickLevelUpFmtPlat()", target_type = 3}
, 
[90101] = {condition = 16, delay = 2.5, id = 90101, info = 382313, op_refresh = true, step_type = 5, target_name = "Frame/RewardLayout/CCNode", target_parent = 4}
, 
[100001] = {avg_name = "cpt00_tutorial_01", delay = 0, guide_skip = false, id = 100001, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[100002] = {id = 100002, info = 241617, target_name = "Frame/Btn_BattleStart", target_parent = 204}
, 
[100101] = {avg_name = "cpt00_tutorial_02", delay = 0, guide_skip = false, id = 100101, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[100102] = {id = 100102, info = 502072, target_name = "PlayerSkillNode/1", target_parent = 203}
, 
[101101] = {id = 101101, info = 241617, target_name = "Frame/Btn_BattleStart", target_parent = 204}
, 
[101201] = {avg_name = "cpt00_tutorial_04", delay = 0, guide_skip = false, id = 101201, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[101202] = {id = 101202, info = 379652, target_name = "UltimateNode/HeroList/1005", target_parent = 203}
, 
[101301] = {avg_name = "cpt00_tutorial_03x", delay = 0, guide_skip = false, id = 101301, info_type = 0, step_type = 2, target_type = 0, wait_target = false}
, 
[101302] = {id = 101302, info = 24000, target_name = "PlayerSkillNode/2", target_parent = 203}
, 
[101401] = {id = 101401, info = 231073, info_pos = "2", step_type = 5, target_name = "DetailNode/HeroDetail", target_parent = 211}
, 
[140101] = {condition = 1, delay = 1.5, id = 140101, info = 41652, info_type = 0, op_refresh = true, target_name = "RotateWithMian/MainUI/Middle/Btn_Oasis", target_parent = 1}
, 
[140102] = {id = 140102, info = 360483, info_type = 0, target_name = "UINode/Btn_OpenSide", target_parent = 3}
, 
[140103] = {id = 140103, info = 132118, info_type = 0, target_name = "UINode/BuildingSidebar/BuildingList/Rect/1_2/1003", target_parent = 3}
, 
[140201] = {guide_skip = false, id = 140201, info = 444500, target_name = "Frame/ScrollRect/Rect/1", target_parent = 9}
, 
[140202] = {guide_skip = false, id = 140202, info = 174446, target_name = "SelectNode/Editor/Btn_Confirm", target_parent = 1500}
, 
[140203] = {condition = 1, delay = 1, guide_skip = false, id = 140203, info = 367790, target_name = "Right/Mask/PageList/Rect/Btn_Oasis", target_parent = 1}
, 
[140204] = {guide_skip = false, id = 140204, info = 130123, target_name = "Btn_Editor", target_parent = 1500}
, 
[140205] = {delay = 2, guide_skip = false, id = 140205, info = 22724, target_name = "ResNode/1003", target_parent = 1500}
, 
[150100] = {condition = 1, delay = 1.7, id = 150100, info = 103780, op_refresh = true, target_name = "Right/Mask/PageList/Rect/Btn_openRightSide", target_parent = 1}
, 
[150101] = {delay = 1.7, id = 150101, info = 103780, op_refresh = true, target_name = "Right/Mask/PageList/Rect/Btn_openRightSide", target_parent = 1}
, 
[150102] = {id = 150102, info = 414212, target_name = "Right/Mask/PageList/Rect/Btn_Lottery", target_parent = 1}
, 
[150103] = {after_code = "GuideUtil.SelectLotteryPool(1)", id = 150103, info = 467003, op_refresh = true, target_name = "Buttom/ButtonGroup/Btn_Once", target_parent = 13}
, 
[150104] = {id = 150104, info = 516282, target_name = "Frame/YesNoNode/ButtonYes", target_parent = 1200}
, 
[150105] = {after_code = "GuideUtil.ScrollLotteryPoolEnd()", condition = 17, delay = 0.4, id = 150105, info = 268718, target_name = "InfoScroll/Rect/2", target_parent = 13}
, 
[150106] = {delay = 0.2, id = 150106, info = 228134, op_refresh = true, target_name = "Buttom/ButtonGroup/Btn_Once", target_parent = 13}
, 
[150107] = {after_code = "GuideUtil.ScrollLotteryPoolEnd()", condition = 17, delay = 1.2, id = 150107, info = 197148, target_name = "InfoScroll/Rect/2", target_parent = 13}
, 
[150108] = {after_code = "GuideUtil.ScrollLotteryPoolEnd()", delay = 1, id = 150108, info = 213844, target_name = "InfoScroll/Rect/1", target_parent = 13}
, 
[150201] = {guide_skip = false, id = 150201, info = 249080, target_name = "InfoNode/Btn_LimitUp", target_parent = 302}
, 
[150301] = {condition = 1, delay = 0.8, id = 150301, info = 70853, op_refresh = true, target_name = "Right/Mask/PageList/Rect/Btn_HeroList", target_parent = 1}
, 
[150302] = {delay = 0.7, id = 150302, info = 396942, target_name = "return GuideUtil.GetHeroListHeroItem(1003,true,false)", target_parent = "300", target_type = 3}
, 
[150303] = {id = 150303, info = 455622, step_type = 5, target_name = "Center/Level", target_parent = 301}
, 
[150304] = {id = 150304, info = 521347, target_name = "Center/Level/Btn_QuickLevelUp", target_parent = 301}
, 
[150305] = {delay = 0.3, id = 150305, info = 176676, target_name = "InfoNode/Btn_StarUp", target_parent = 302}
, 
[150306] = {condition = 17, delay = 0.4, id = 150306, info = 499343, target_name = "TopButtonGroup/Btn_Back", target_parent = 2}
, 
[160101] = {condition = 1, delay = 1, id = 160101, info = 122976, op_refresh = true, target_name = "Right/Mask/PageList/Rect/Btn_Exproation", target_parent = 1}
, 
[160102] = {delay = 1, id = 160102, info = 161322, target_name = "SectorRoot/UICanvas/InfoNode/1/InfoItem", target_parent = "002_Sector_001", target_type = 2}
, 
[160103] = {id = 160103, info = 304552, target_name = "return GuideUtil.LocationSectorStageItem(1102)", target_type = 3}
, 
[160104] = {id = 160104, info = 406466, target_name = "DetailNode/BtnGroup/Btn_Battle", target_parent = 75}
, 
[160105] = {id = 160105, info = 380844, target_name = "NotEditorNode/Btn_Battle", target_parent = "002_Sector_001", target_type = 2}
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
[1001201] = {condition = 5, delay = 1, id = 1001201, info = 313690, target_name = "Frame/PropList/10206/UINEpChipDetail/Root/ItemHolder/UINBaseChipDetail/BtnHolder/Btn_Click", target_parent = 102}
, 
[1001202] = {delay = 0.3, id = 1001202, info = 378746, target_name = "Frame/PropList/10206/UINEpChipDetail/Root/ItemHolder/UINBaseChipDetail/BtnHolder/Btn_Click", target_parent = 102}
, 
[1001400] = {condition = 7, delay = 0.3, id = 1001400, info = 341787, step_type = 5, target_name = "Top/ChipList/ChipLoopList/Rect/EpChipItem(Clone)/UINChipItem", target_parent = 210}
, 
[1001401] = {delay = 1, id = 1001401, info = 179941, target_name = "Frame/TreasureNode/TreasureList/10247/UINEpChipDetail/Root/ItemHolder/UINBaseChipDetail/BtnHolder/Btn_Click", target_parent = 130}
, 
[1001402] = {delay = 0.3, id = 1001402, info = 443253, target_name = "Frame/TreasureNode/TreasureList/10247/UINEpChipDetail/Root/ItemHolder/UINBaseChipDetail/BtnHolder/Btn_Click", target_parent = 130}
, 
[1002201] = {condition = 1, delay = 1, id = 1002201, info = 140098, op_refresh = true, target_name = "RotateWithMian/MainUI/Middle/Btn_Exproation", target_parent = 1}
, 
[1002202] = {delay = 1.5, id = 1002202, info = 460856, target_name = "SectorRoot/UICanvas/ProgressNode/1_1", target_parent = "002_Sector_001", target_type = 2}
}
local __default_values = {after_code = "", avg_name = "", clear_code = "", complete_code = "", condition = 0, condition_arg = __rt_1, custom_code = "", custom_size = __rt_1, delay = 0.5, first_code = "", guide_skip = true, id = 100, info = "", info_pos = "", info_type = 1001, op_refresh = false, step_type = 1, target_name = "", target_parent = "", target_type = 1, wait_target = true}
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


local __rt_1 = {}
local __rt_2 = {501101, 501102}
local __rt_3 = {503101}
local __rt_4 = {511101}
local __rt_5 = {513101, 513102}
local __rt_6 = {514101}
local __rt_7 = {1004}
local __rt_8 = {1006}
local __rt_9 = {1008}
local __rt_10 = {10092}
local __rt_11 = {1047}
local __rt_12 = {1002}
local __rt_13 = {10164}
local __rt_14 = {10334, 10335}
local __rt_15 = {91, 10339, 10340}
local __rt_16 = {10250}
local __rt_17 = {10251}
local __rt_18 = {10254}
local __rt_19 = {10256, 10257, 10902}
local __rt_20 = {10634}
local __rt_21 = {10371}
local __rt_22 = {10373}
local __rt_23 = {10644}
local __rt_24 = {10640}
local __rt_25 = {10802, 10803, 10804}
local __rt_26 = {10876}
local __rt_27 = {10892}
local __rt_28 = {10865}
local __rt_29 = {10505, 10506}
local __rt_30 = {10504, 10507, 10508}
local __rt_31 = {100207, 100208}
local __rt_32 = {102503, 102505, 102506, 102507}
local __rt_33 = {104001, 104002}
local __rt_34 = {10170}
local __rt_35 = {10099}
local __rt_36 = {10101}
local __rt_37 = {10103}
local __rt_38 = {10274, 10853, 10854}
local __rt_39 = {10124, 10125}
local __rt_40 = {10263, 10264}
local __rt_41 = {10809, 10810, 10811, 10812}
local __rt_42 = {10263, 10264, 10501, 10502, 10503, 10867}
local __rt_43 = {10428, 10429, 10430, 10432, 102506}
local battle_skill = {
{hit_skill_type = 1, lua_script = "CommonAttackSkill.1_CommonAttack_1", skill_comat = ""}
; 
[501] = {
effect_id = {10081, 10082}
, hit_skill_type = 2, id = 501, lua_script = "CommonAttackSkill.501_EnemyRaiderAttack", skill_comat = ""}
, 
[502] = {
effect_id = {10088}
, hit_skill_type = 1, id = 502, lua_script = "CommonAttackSkill.502_EnemyPurgerNormalAttack", skill_comat = ""}
, 
[503] = {
effect_id = {10093}
, hit_skill_type = 2, id = 503, lua_script = "CommonAttackSkill.503_EnemyPatienceAttack", skill_comat = ""}
, 
[504] = {
effect_id = {10098}
, hit_skill_type = 3, id = 504, lua_script = "CommonAttackSkill.504_EnemyReverenceAttack", skill_comat = ""}
, 
[505] = {
effect_id = {10102}
, hit_skill_type = 3, id = 505, lua_script = "CommonAttackSkill.505_EnemyFaithAttack", skill_comat = ""}
, 
[506] = {
effect_id = {10107}
, hit_skill_type = 1, id = 506, lua_script = "CommonAttackSkill.506_EnemyRefactorAttack", skill_comat = ""}
, 
[507] = {
effect_id = {10114, 10115}
, hit_skill_type = 2, id = 507, lua_script = "CommonAttackSkill.507_EnemyDefenderAttack", skill_comat = ""}
, 
[508] = {
effect_id = {10121, 10122}
, hit_skill_type = 2, id = 508, lua_script = "CommonAttackSkill.508_EnemyfortitudeAttack", skill_comat = ""}
, 
[509] = {
effect_id = {10225, 10226, 10227, 10228, 10263, 10264}
, hit_skill_type = 2, id = 509, lua_script = "CommonAttackSkill.509_EnemyMaraAttack", skill_comat = ""}
, 
[510] = {
effect_id = {10231, 10232, 10233, 10234}
, hit_skill_type = 2, id = 510, lua_script = "CommonAttackSkill.510_EnemyMaraAttack-blue", skill_comat = ""}
, 
[511] = {
effect_id = {10214, 10215}
, hit_skill_type = 3, id = 511, lua_script = "CommonAttackSkill.511_EnemyProtectorAttack", skill_comat = ""}
, 
[512] = {
effect_id = {10218}
, hit_skill_type = 1, id = 512, lua_script = "CommonAttackSkill.512_EnemyTemperanceAttack", skill_comat = ""}
, 
[519] = {
effect_id = {10263, 10264, 10402, 10403, 10410}
, hit_skill_type = 1, id = 519, lua_script = "CommonAttackSkill.519_BeelneithAttack", skill_comat = ""}
, 
[520] = {
effect_id = {10493, 10494, 10509, 10821}
, hit_skill_type = 1, id = 520, lua_script = "CommonAttackSkill.520_GabrielAttack", skill_comat = ""}
, 
[521] = {hit_skill_type = 2, id = 521, lua_script = "CommonAttackSkill.521_HesperusAttack", skill_comat = ""}
, 
[522] = {
effect_id = {10425, 10426}
, hit_skill_type = 1, id = 522, lua_script = "CommonAttackSkill.522_HopeAttack", skill_comat = ""}
, 
[523] = {
effect_id = {10487, 10489, 10490}
, hit_skill_type = 1, id = 523, lua_script = "CommonAttackSkill.523_LoveAttack", skill_comat = ""}
, 
[524] = {
effect_id = {10435, 10436}
, hit_skill_type = 1, id = 524, lua_script = "CommonAttackSkill.524_DiligenceAttack", skill_comat = ""}
, 
[525] = {
effect_id = {10440, 10441}
, hit_skill_type = 3, id = 525, lua_script = "CommonAttackSkill.525_KindnessAttack", skill_comat = ""}
, 
[526] = {
effect_id = {10445, 10513}
, hit_skill_type = 2, id = 526, lua_script = "CommonAttackSkill.526_WisdomAttack", skill_comat = ""}
, 
[527] = {
effect_id = {10521}
, hit_skill_type = 1, id = 527, lua_script = "CommonAttackSkill.527_birdAttack", skill_comat = ""}
, 
[528] = {hit_skill_type = 1, id = 528, lua_script = "CommonAttackSkill.528_snakeAttack", skill_comat = ""}
, 
[529] = {
effect_id = {10567, 10568}
, hit_skill_type = 1, id = 529, lua_script = "CommonAttackSkill.529_twinerAttack", skill_comat = ""}
, 
[530] = {
effect_id = {10573, 10574}
, hit_skill_type = 2, id = 530, lua_script = "CommonAttackSkill.530_impactorAttack", skill_comat = ""}
, 
[531] = {
effect_id = {10589}
, hit_skill_type = 2, id = 531, lua_script = "CommonAttackSkill.531_patience_en_Attack", skill_comat = ""}
, 
[532] = {
effect_id = {10579}
, hit_skill_type = 2, id = 532, lua_script = "CommonAttackSkill.532_wisdom_en_Attack", skill_comat = ""}
, 
[533] = {
effect_id = {10683, 10684, 10796}
, hit_skill_type = 2, id = 533, lua_script = "CommonAttackSkill.533_FernDragonAttack", skill_comat = ""}
, 
[535] = {
effect_id = {10767, 10768, 10769}
, hit_skill_type = 1, id = 535, lua_script = "CommonAttackSkill.535_MercyAttack", skill_comat = ""}
, 
[536] = {
effect_id = {10775, 10776, 10777, 10780, 10784}
, hit_skill_type = 2, id = 536, lua_script = "CommonAttackSkill.536_ThrowerAttack", skill_comat = ""}
, 
[537] = {
effect_id = {10773}
, hit_skill_type = 1, id = 537, lua_script = "CommonAttackSkill.537_Mercy_effect_Attack", skill_comat = ""}
, 
[538] = {hit_skill_type = 1, id = 538, lua_script = "TowerDefenceSkill.CommonRoleCampSkill", skill_comat = ""}
, 
[539] = {
effect_id = {10263}
, hit_skill_type = 1, id = 539, lua_script = "TowerDefenceSkill.CommonMonsterCasterSkill", skill_comat = "150/100*power*1"}
, 
[540] = {hit_skill_type = 1, id = 540, lua_script = "TowerDefenceSkill.CommonTDMonsterAttackPassive", skill_comat = ""}
, 
[541] = {hit_skill_type = 1, id = 541, lua_script = "CommonAttackSkill.541_WillowPicAttack", skill_comat = ""}
, 
[5011] = {effect_id = __rt_2, id = 5011, lua_script = "CommanderSkill.5011_move", skill_comat = ""}
, 
[5012] = {effect_id = __rt_2, id = 5012, lua_script = "CommanderSkill.5012_move_A", skill_comat = ""}
, 
[5013] = {
effect_id = {501101, 501102, 501301}
, id = 5013, lua_script = "CommanderSkill.5013_move_B", skill_comat = ""}
, 
[5021] = {id = 5021, lua_script = "CommanderSkill.5021_eul", skill_comat = ""}
, 
[5022] = {id = 5022, lua_script = "CommanderSkill.5022_eul_A", skill_comat = ""}
, 
[5023] = {id = 5023, lua_script = "CommanderSkill.5023_eul_B", skill_comat = ""}
, 
[5027] = {id = 5027, lua_script = "CommanderSkill.5027_buff", skill_comat = ""}
, 
[5028] = {id = 5028, lua_script = "CommanderSkill.5028_buff", skill_comat = ""}
, 
[5031] = {effect_id = __rt_3, id = 5031, lua_script = "CommanderSkill.5031_resetSkillCd", skill_comat = ""}
, 
[5032] = {
effect_id = {503201}
, id = 5032, lua_script = "CommanderSkill.5032_resetSkillCd_A", skill_comat = ""}
, 
[5033] = {effect_id = __rt_3, id = 5033, lua_script = "CommanderSkill.5033_resetSkillCd_B", skill_comat = ""}
, 
[5111] = {effect_id = __rt_4, id = 5111, lua_script = "CommanderSkill.5111_hit", skill_comat = ""}
, 
[5112] = {
effect_id = {511201}
, id = 5112, lua_script = "CommanderSkill.5112_hit_A", skill_comat = ""}
, 
[5113] = {
effect_id = {511301}
, id = 5113, lua_script = "CommanderSkill.5113_hit_B", skill_comat = ""}
, 
[5121] = {
effect_id = {512101}
, id = 5121, lua_script = "CommanderSkill.5121_sign", skill_comat = ""}
, 
[5122] = {
effect_id = {512201}
, id = 5122, lua_script = "CommanderSkill.5122_sign_A", skill_comat = ""}
, 
[5123] = {
effect_id = {512301}
, id = 5123, lua_script = "CommanderSkill.5123_sign_B", skill_comat = ""}
, 
[5131] = {effect_id = __rt_5, id = 5131, lua_script = "CommanderSkill.5131_focusOnFiring", skill_comat = ""}
, 
[5132] = {id = 5132, lua_script = "CommanderSkill.5132_focusOnFiring_A", skill_comat = ""}
, 
[5133] = {id = 5133, lua_script = "CommanderSkill.5133_focusOnFiring_B", skill_comat = ""}
, 
[5141] = {effect_id = __rt_6, id = 5141, lua_script = "CommanderSkill.5141_aoeStun", skill_comat = ""}
, 
[5142] = {
effect_id = {514201}
, id = 5142, lua_script = "CommanderSkill.5142_aoeStun_A", skill_comat = ""}
, 
[5143] = {
effect_id = {514301, 514302}
, id = 5143, lua_script = "CommanderSkill.5143_aoeStun_B", skill_comat = ""}
, 
[6001] = {id = 6001, lua_script = "AlgorithmSkill.SuitSkill_6001", skill_comat = "0"}
, 
[6002] = {id = 6002, lua_script = "AlgorithmSkill.SuitSkill_6002", skill_comat = "0"}
, 
[6003] = {id = 6003, lua_script = "AlgorithmSkill.SuitSkill_6003", skill_comat = "0"}
, 
[6004] = {id = 6004, lua_script = "AlgorithmSkill.SuitSkill_6004", skill_comat = "0"}
, 
[6005] = {id = 6005, lua_script = "AlgorithmSkill.SuitSkill_6005", skill_comat = "0"}
, 
[6006] = {id = 6006, lua_script = "AlgorithmSkill.SuitSkill_6006", skill_comat = "0"}
, 
[6007] = {id = 6007, lua_script = "AlgorithmSkill.SuitSkill_6007", skill_comat = "0"}
, 
[6008] = {id = 6008, lua_script = "AlgorithmSkill.SuitSkill_6008", skill_comat = "0"}
, 
[6009] = {
effect_id = {10054}
, id = 6009, lua_script = "AlgorithmSkill.SuitSkill_6009", skill_comat = "0"}
, 
[6010] = {id = 6010, lua_script = "AlgorithmSkill.SuitSkill_6010", skill_comat = "0"}
, 
[7001] = {id = 7001, lua_script = "BuffSkill.7001_buff", skill_comat = ""}
, 
[7002] = {
effect_id = {10818}
, id = 7002, lua_script = "BuffSkill.7002_buff", skill_comat = ""}
, 
[7003] = {
effect_id = {100302}
, id = 7003, lua_script = "BuffSkill.7003_beelneith", skill_comat = ""}
, 
[7004] = {
effect_id = {10813}
, id = 7004, lua_script = "BuffSkill.7004_resurrection", skill_comat = ""}
, 
[7005] = {
effect_id = {10504, 10508}
, id = 7005, lua_script = "BuffSkill.7005_gridmuma", skill_comat = ""}
, 
[7006] = {
effect_id = {10495, 10496, 10497, 10498, 10821}
, id = 7006, lua_script = "BuffSkill.7006_gabrielmiss", skill_comat = ""}
, 
[7007] = {
effect_id = {10701}
, id = 7007, lua_script = "BuffSkill.7007_buff", skill_comat = ""}
, 
[9999] = {id = 9999, skill_comat = ""}
, 
[10001] = {id = 10001, lua_script = "FunctionSkill.10001_StrikeBack"}
, 
[10002] = {id = 10002, lua_script = "FunctionSkill.10002_ChargeCrit"}
, 
[10003] = {
effect_id = {10344}
, id = 10003, lua_script = "FunctionSkill.10003_AutotomyAttack"}
, 
[10004] = {id = 10004, lua_script = "FunctionSkill.10004_DataLink"}
, 
[10005] = {
effect_id = {1001, 1002}
, id = 10005, lua_script = "FunctionSkill.10005_BeHitStun"}
, 
[10006] = {effect_id = __rt_7, id = 10006, lua_script = "FunctionSkill.10006_AtkStunRecover"}
, 
[10007] = {effect_id = __rt_8, id = 10007, lua_script = "FunctionSkill.10007_DbHitPer5"}
, 
[10008] = {effect_id = __rt_8, id = 10008, lua_script = "FunctionSkill.10008_AoePer8"}
, 
[10009] = {effect_id = __rt_8, id = 10009, lua_script = "FunctionSkill.10009_StunExtraAtt"}
, 
[10010] = {effect_id = __rt_8, id = 10010, lua_script = "FunctionSkill.10010_ProbDbHit"}
, 
[10011] = {effect_id = __rt_8, id = 10011, lua_script = "FunctionSkill.10011_ProbAoe"}
, 
[10012] = {effect_id = __rt_9, id = 10012, lua_script = "FunctionSkill.10012_ProbRecover"}
, 
[10013] = {
effect_id = {1009}
, id = 10013, lua_script = "FunctionSkill.10013_Taunt"}
, 
[10014] = {effect_id = __rt_10, id = 10014, lua_script = "FunctionSkill.10014_CritRecover"}
, 
[10015] = {
effect_id = {10166, 10167, 10168}
, id = 10015, lua_script = "FunctionSkill.10015_Anger"}
, 
[10016] = {
effect_id = {10120}
, id = 10016, lua_script = "FunctionSkill.10016_hurtattack"}
, 
[10017] = {effect_id = __rt_8, id = 10017, lua_script = "FunctionSkill.10017_healattack"}
, 
[10018] = {effect_id = __rt_11, id = 10018, lua_script = "FunctionSkill.10018_ExlimitRecover"}
, 
[10019] = {id = 10019, lua_script = "FunctionSkill.10019_ProbStun"}
, 
[10020] = {id = 10020, lua_script = "FunctionSkill.10020_CritAttack"}
, 
[10021] = {effect_id = __rt_9, id = 10021, lua_script = "FunctionSkill.10021_RecoverPer8"}
, 
[10022] = {effect_id = __rt_9, id = 10022, lua_script = "FunctionSkill.10022_BeHitRecover"}
, 
[10023] = {effect_id = __rt_9, id = 10023, lua_script = "FunctionSkill.10023_BeStunRecover"}
, 
[10024] = {id = 10024, lua_script = "FunctionSkill.10024_HurtHealUp"}
, 
[10025] = {id = 10025, lua_script = "FunctionSkill.10025_HealAtkBuff"}
, 
[10026] = {id = 10026, lua_script = "FunctionSkill.10026_HpDef"}
, 
[10027] = {effect_id = __rt_7, id = 10027, lua_script = "FunctionSkill.10027_HealLink"}
, 
[10028] = {effect_id = __rt_12, id = 10028, lua_script = "FunctionSkill.10028_AoeBack"}
, 
[10046] = {
effect_id = {104}
, id = 10046, lua_script = "FunctionSkill.10046_RegionHealSummor"}
, 
[10060] = {id = 10060, lua_script = "FunctionSkill.10060_BuffRecover"}
, 
[10061] = {
effect_id = {10163}
, id = 10061, lua_script = "FunctionSkill.10061_HurtUpgrade"}
, 
[10062] = {id = 10062, lua_script = "FunctionSkill.10062_DamageSuckBlood"}
, 
[10063] = {id = 10063, lua_script = "FunctionSkill.10063_HealPowerUp"}
, 
[10064] = {id = 10064, lua_script = "FunctionSkill.10064_DeathHealPowerUp"}
, 
[10065] = {effect_id = __rt_12, id = 10065, lua_script = "FunctionSkill.10065_HurtDamage"}
, 
[10066] = {id = 10066, lua_script = "FunctionSkill.10066_BuffExtraAdd"}
, 
[10067] = {id = 10067, lua_script = "FunctionSkill.10067_HealPerSec"}
, 
[10068] = {id = 10068, lua_script = "FunctionSkill.10068_Powerup5s"}
, 
[10069] = {id = 10069, lua_script = "FunctionSkill.10069_BehealedPowerUp"}
, 
[10073] = {id = 10073, lua_script = "FunctionSkill.10073_AllSilence"}
, 
[10074] = {id = 10074, lua_script = "FunctionSkill.10074_DeathStanding"}
, 
[10075] = {id = 10075, lua_script = "FunctionSkill.10075_MaxHpDecrease"}
, 
[10076] = {id = 10076, lua_script = "FunctionSkill.10076_SilenceAttack", skill_comat = "8/180*power*para1"}
, 
[10077] = {id = 10077, lua_script = "FunctionSkill.10077_RegionDamageDecrease"}
, 
[10078] = {id = 10078, lua_script = "FunctionSkill.10078_DeathSheld"}
, 
[10079] = {id = 10079, lua_script = "FunctionSkill.10079_RegionHeal"}
, 
[10080] = {id = 10080, lua_script = "FunctionSkill.10080_ExtraAttack"}
, 
[10081] = {id = 10081, lua_script = "FunctionSkill.10081_DeathSilence"}
, 
[10082] = {id = 10082, lua_script = "FunctionSkill.10082_FirstDamageBack"}
, 
[10083] = {id = 10083, lua_script = "FunctionSkill.10083_FirstDebuffInvalid"}
, 
[10084] = {id = 10084, lua_script = "FunctionSkill.10084_Counterspell"}
, 
[10092] = {id = 10092, lua_script = "FunctionSkill.10114_CoolDownDecrease"}
, 
[10093] = {id = 10093, lua_script = "FunctionSkill.10115_DamageDecrease"}
, 
[10094] = {id = 10094, lua_script = "FunctionSkill.10116_DamageIncrease"}
, 
[10103] = {id = 10103, lua_script = "FunctionSkill.10114_CoolDownDecrease"}
, 
[10104] = {id = 10104, lua_script = "FunctionSkill.10115_DamageDecrease"}
, 
[10105] = {id = 10105, lua_script = "FunctionSkill.10116_DamageIncrease"}
, 
[10114] = {id = 10114, lua_script = "FunctionSkill.10114_CoolDownDecrease"}
, 
[10115] = {id = 10115, lua_script = "FunctionSkill.10115_DamageDecrease"}
, 
[10116] = {id = 10116, lua_script = "FunctionSkill.10116_DamageIncrease"}
, 
[10119] = {id = 10119, lua_script = "FunctionSkill.10119_AtkStunCrit"}
, 
[10120] = {
effect_id = {91}
, id = 10120, lua_script = "FunctionSkill.10120_SuckBlood"}
, 
[10121] = {id = 10121, lua_script = "FunctionSkill.10121_GeZCS"}
, 
[10122] = {effect_id = __rt_12, id = 10122, lua_script = "FunctionSkill.10122_MaxHpDamage"}
, 
[10123] = {
effect_id = {10171}
, id = 10123, lua_script = "FunctionSkill.10123_CritAdd"}
, 
[10124] = {effect_id = __rt_12, id = 10124, lua_script = "FunctionSkill.10124_BuffDamage"}
, 
[10125] = {id = 10125, lua_script = "FunctionSkill.10125_CommonAttackCd"}
, 
[10126] = {id = 10126, lua_script = "FunctionSkill.10126_Bozang"}
, 
[10127] = {id = 10127, lua_script = "FunctionSkill.10127_HealDefence"}
, 
[10128] = {effect_id = __rt_13, id = 10128, lua_script = "FunctionSkill.10128_CDAndSpeed"}
, 
[10129] = {
effect_id = {10172}
, id = 10129, lua_script = "FunctionSkill.10129_TargetCrit"}
, 
[10130] = {id = 10130, lua_script = "FunctionSkill.10130_DistanceSpeed"}
, 
[10131] = {id = 10131, lua_script = "FunctionSkill.10131_BuffSpeed"}
, 
[10132] = {id = 10132, lua_script = "FunctionSkill.10132_CommonAttackPower"}
, 
[10133] = {id = 10133, lua_script = "FunctionSkill.10133_DeathCD"}
, 
[10134] = {id = 10134, lua_script = "FunctionSkill.10134_DefencePower"}
, 
[10135] = {effect_id = __rt_10, id = 10135, lua_script = "FunctionSkill.10135_BuffHeal"}
, 
[10136] = {
effect_id = {10243, 10244}
, id = 10136, lua_script = "FunctionSkill.10136_RegionDefence"}
, 
[10137] = {
effect_id = {10245}
, id = 10137, lua_script = "FunctionSkill.10137_AttackDefence"}
, 
[10138] = {
effect_id = {10248}
, id = 10138, lua_script = "FunctionSkill.10138_DebuffTrueDamage"}
, 
[10139] = {id = 10139, lua_script = "FunctionSkill.10139_SkillSpeed"}
, 
[10140] = {id = 10140, lua_script = "FunctionSkill.10140_HpHeal"}
, 
[10141] = {id = 10141, lua_script = "FunctionSkill.10141_HPDamageBack"}
, 
[10142] = {effect_id = __rt_14, id = 10142, lua_script = "FunctionSkill.10142_HPEachOther"}
, 
[10143] = {effect_id = __rt_15, id = 10143, lua_script = "FunctionSkill.10143_StrongRound"}
, 
[10144] = {effect_id = __rt_16, id = 10144, lua_script = "FunctionSkill.10144_HurtAttack"}
, 
[10145] = {effect_id = __rt_17, id = 10145, lua_script = "FunctionSkill.10145_HurtSheld"}
, 
[10146] = {id = 10146, lua_script = "FunctionSkill.10146_NormalAttackUp"}
, 
[10147] = {
effect_id = {10252, 10253, 10254, 10336}
, id = 10147, lua_script = "FunctionSkill.10147_NormalAttakSuperUp"}
, 
[10148] = {id = 10148, lua_script = "FunctionSkill.10148_SkillPowerUp"}
, 
[10149] = {effect_id = __rt_18, id = 10149, lua_script = "FunctionSkill.10149_DodgeBullet"}
, 
[10150] = {id = 10150, lua_script = "FunctionSkill.10150_SkillDodge"}
, 
[10151] = {id = 10151, lua_script = "FunctionSkill.10151_DodgeCoolDown"}
, 
[10152] = {effect_id = __rt_19, id = 10152, lua_script = "FunctionSkill.10152_HealDamage"}
, 
[10153] = {id = 10153, lua_script = "FunctionSkill.10153_HealCdUpDown"}
, 
[10154] = {id = 10154, lua_script = "FunctionSkill.10154_HealPowerUp"}
, 
[10155] = {id = 10155, lua_script = "FunctionSkill.10155_DamageRevenge"}
, 
[10156] = {id = 10156, lua_script = "FunctionSkill.10156_PowerUpSpeedDown"}
, 
[10157] = {id = 10157, lua_script = "FunctionSkill.10157_HPCD"}
, 
[10158] = {
effect_id = {10258}
, id = 10158, lua_script = "FunctionSkill.10158_DamageChain"}
, 
[10159] = {id = 10159, lua_script = "FunctionSkill.10159_DamageDodge"}
, 
[10160] = {id = 10160, lua_script = "FunctionSkill.10160_MoveCoolDown"}
, 
[10161] = {id = 10161, lua_script = "FunctionSkill.10161_HealHealUp"}
, 
[10162] = {effect_id = __rt_16, id = 10162, lua_script = "FunctionSkill.10162_HurtAttack1"}
, 
[10164] = {id = 10164, lua_script = "FunctionSkill.10164_DeathCoolDown"}
, 
[10165] = {id = 10165, lua_script = "FunctionSkill.10165_DeathSheld", skill_comat = "8/180*power*para1"}
, 
[10166] = {id = 10166, lua_script = "FunctionSkill.10166_DeathAbilityDeliver", skill_comat = "8/180*power*para1"}
, 
[10167] = {
effect_id = {10866}
, id = 10167, lua_script = "FunctionSkill.10167_DeathBoom"}
, 
[10168] = {id = 10168, lua_script = "FunctionSkill.10168_LimitedAllocation"}
, 
[10169] = {
effect_id = {10556}
, id = 10169, lua_script = "FunctionSkill.10169_ObStun"}
, 
[10170] = {id = 10170, lua_script = "FunctionSkill.10170_ObDamageUp", skill_comat = "4/180*power*para1"}
, 
[10171] = {id = 10171, lua_script = "FunctionSkill.10171_ObAOEDestroy"}
, 
[10172] = {id = 10172, lua_script = "FunctionSkill.10172_ObDamageBack"}
, 
[10173] = {effect_id = __rt_20, id = 10173, lua_script = "FunctionSkill.10173_ObDefenceUp"}
, 
[10174] = {id = 10174, lua_script = "FunctionSkill.10174_ObAllDamage"}
, 
[10175] = {id = 10175, lua_script = "FunctionSkill.10175_sheildbreaker"}
, 
[10176] = {id = 10176, lua_script = "FunctionSkill.10176_BrokenStun"}
, 
[10177] = {effect_id = __rt_21, id = 10177, lua_script = "FunctionSkill.10177_Jinvsyuan"}
, 
[10178] = {effect_id = __rt_22, id = 10178, lua_script = "FunctionSkill.10178_Yuanvsjin"}
, 
[10179] = {id = 10179, lua_script = "FunctionSkill.10179_BrokenResetCd"}
, 
[10180] = {id = 10180, lua_script = "FunctionSkill.10180_BrokenRecover", skill_comat = "4/180*power*para1"}
, 
[10181] = {id = 10181, lua_script = "FunctionSkill.10181_SheildSpeed", skill_comat = "4/180*power*para1"}
, 
[10182] = {id = 10182, lua_script = "FunctionSkill.10182_ShieldChange"}
, 
[10183] = {id = 10183, lua_script = "FunctionSkill.10183_ShieldConDam"}
, 
[10184] = {id = 10184, lua_script = "FunctionSkill.10184_SheildAttackPowerup"}
, 
[10185] = {id = 10185, lua_script = "FunctionSkill.10185_ShieldRealDamage"}
, 
[10186] = {id = 10186, lua_script = "FunctionSkill.10186_ShieldDeathPowerup"}
, 
[10187] = {id = 10187, lua_script = "FunctionSkill.10187_JinPunch"}
, 
[10188] = {id = 10188, lua_script = "FunctionSkill.10188_SendWY", skill_comat = "8/180*power*para1"}
, 
[10189] = {id = 10189, lua_script = "FunctionSkill.10189_DeathWYSend"}
, 
[10190] = {effect_id = __rt_18, id = 10190, lua_script = "FunctionSkill.10190_EatDamage", skill_comat = "4/180*power*para1"}
, 
[10191] = {id = 10191, lua_script = "FunctionSkill.10191_EatPowerup", skill_comat = "4/180*power*para1"}
, 
[10192] = {id = 10192, lua_script = "FunctionSkill.10192_WYHealUp"}
, 
[10193] = {id = 10193, lua_script = "FunctionSkill.10193_ATKSilence"}
, 
[10194] = {id = 10194, lua_script = "FunctionSkill.10194_EatMissile", skill_comat = "8/180*power*para1"}
, 
[10195] = {id = 10195, lua_script = "FunctionSkill.10195_YouEatIEat"}
, 
[10196] = {id = 10196, lua_script = "FunctionSkill.10196_WYCrit"}
, 
[10197] = {id = 10197, lua_script = "FunctionSkill.10197_ServerAllyDisable"}
, 
[10198] = {id = 10198, lua_script = "FunctionSkill.10198_SeverExtraAttack", skill_comat = "4/180*power*para1"}
, 
[10199] = {effect_id = __rt_20, id = 10199, lua_script = "FunctionSkill.10199_ServerNoDamage"}
, 
[10200] = {id = 10200, lua_script = "FunctionSkill.10200_BlueDebuffDespel"}
, 
[10201] = {id = 10201, lua_script = "FunctionSkill.10201_BlueDefence", skill_comat = "4/180*power*para1"}
, 
[10202] = {
effect_id = {10504}
, id = 10202, lua_script = "FunctionSkill.10202_ServerDamageAttack"}
, 
[10203] = {id = 10203, lua_script = "FunctionSkill.10203_RedDestoryable"}
, 
[10204] = {id = 10204, lua_script = "FunctionSkill.10204_spotterRecover"}
, 
[10205] = {
effect_id = {10243}
, id = 10205, lua_script = "FunctionSkill.10205_nearbyDefence"}
, 
[10206] = {
effect_id = {134}
, id = 10206, lua_script = "FunctionSkill.10206_PlateletNecrosis"}
, 
[10207] = {
effect_id = {1049, 10753}
, id = 10207, lua_script = "FunctionSkill.10207_VulnusAmplify"}
, 
[10208] = {id = 10208, lua_script = "FunctionSkill.10208_BloodTrail"}
, 
[10209] = {
effect_id = {135}
, id = 10209, lua_script = "FunctionSkill.10209_immunityReduce"}
, 
[10210] = {id = 10210, lua_script = "FunctionSkill.10210_WeakSniper"}
, 
[10211] = {
effect_id = {1050}
, id = 10211, lua_script = "FunctionSkill.10211_DangerTarget"}
, 
[10212] = {id = 10212, lua_script = "FunctionSkill.10212_TargetStifle"}
, 
[10213] = {id = 10213, lua_script = "FunctionSkill.10213_SpectrumStifle"}
, 
[10214] = {id = 10214, lua_script = "FunctionSkill.10214_HealToCrit"}
, 
[10215] = {
effect_id = {1048}
, id = 10215, lua_script = "FunctionSkill.10215_CritHeal"}
, 
[10216] = {
effect_id = {10127}
, id = 10216, lua_script = "FunctionSkill.10216_AllDamage"}
, 
[10217] = {id = 10217, lua_script = "FunctionSkill.10217_AllHealDown"}
, 
[10218] = {effect_id = __rt_9, id = 10218, lua_script = "FunctionSkill.10218_DeathBlood"}
, 
[10219] = {effect_id = __rt_17, id = 10219, lua_script = "FunctionSkill.10219_SkillSheild"}
, 
[10220] = {id = 10220, lua_script = "FunctionSkill.10220_CritSuck"}
, 
[10221] = {id = 10221, lua_script = "FunctionSkill.10221_SkillSuck"}
, 
[10222] = {effect_id = __rt_23, id = 10222, lua_script = "FunctionSkill.10222_BloodShout"}
, 
[10223] = {effect_id = __rt_24, id = 10223, lua_script = "FunctionSkill.10223_DoubleShoot"}
, 
[10224] = {
effect_id = {10749, 10750, 10751, 10752}
, id = 10224, lua_script = "FunctionSkill.10224_AtkBuff"}
, 
[10225] = {
effect_id = {10754, 10755}
, id = 10225, lua_script = "FunctionSkill.10225_SkillJuji"}
, 
[10226] = {effect_id = __rt_13, id = 10226, lua_script = "FunctionSkill.10226_SkillCoolDown"}
, 
[10227] = {
effect_id = {10625}
, id = 10227, lua_script = "FunctionSkill.10227_DodgeUpup"}
, 
[10228] = {id = 10228, lua_script = "FunctionSkill.10228_PassiveBall"}
, 
[10229] = {id = 10229, lua_script = "FunctionSkill.10229_PassivePowerUp"}
, 
[10230] = {id = 10230, lua_script = "FunctionSkill.10230_PassiveSkillDamage"}
, 
[10231] = {
effect_id = {10643}
, id = 10231, lua_script = "FunctionSkill.10231_PassiveSheild"}
, 
[10232] = {effect_id = __rt_13, id = 10232, lua_script = "FunctionSkill.10232_DoctorCD"}
, 
[10233] = {
effect_id = {10632}
, id = 10233, lua_script = "FunctionSkill.10233_HealMoreGive"}
, 
[10234] = {effect_id = __rt_20, id = 10234, lua_script = "FunctionSkill.10234_HealBuff"}
, 
[10235] = {
effect_id = {10635}
, id = 10235, lua_script = "FunctionSkill.10235_HealBuffReborn"}
, 
[10236] = {id = 10236, lua_script = "FunctionSkill.10236_DoubleHeal"}
, 
[10237] = {id = 10237, lua_script = "FunctionSkill.10237_HealDefence"}
, 
[10238] = {id = 10238, lua_script = "FunctionSkill.10238_CritSuanli"}
, 
[10239] = {id = 10239, lua_script = "FunctionSkill.10239_JinCritSuanli"}
, 
[10240] = {id = 10240, lua_script = "FunctionSkill.10240_YuanCritExDam"}
, 
[10241] = {id = 10241, lua_script = "FunctionSkill.10241_GridCD", skill_comat = "4/180*power*para1"}
, 
[10242] = {id = 10242, lua_script = "FunctionSkill.10242_GridYishang", skill_comat = "4/180*power*para1"}
, 
[10243] = {id = 10243, lua_script = "FunctionSkill.10243_GridHealUp", skill_comat = "4/180*power*para1"}
, 
[10244] = {
effect_id = {10636}
, id = 10244, lua_script = "FunctionSkill.10244_GridOther", skill_comat = "4/180*power*para1"}
, 
[10245] = {
effect_id = {10638}
, id = 10245, lua_script = "FunctionSkill.10245_GridEnterDamage"}
, 
[10246] = {id = 10246, lua_script = "FunctionSkill.10246_skillCF"}
, 
[10247] = {
effect_id = {10785}
, id = 10247, lua_script = "FunctionSkill.10247_DamageRemove"}
, 
[10248] = {effect_id = __rt_20, id = 10248, lua_script = "FunctionSkill.10248_StartBuff"}
, 
[10249] = {id = 10249, lua_script = "FunctionSkill.10249_BuffSuanli"}
, 
[10250] = {
effect_id = {10634, 10787}
, id = 10250, lua_script = "FunctionSkill.10250_BuffCd"}
, 
[10251] = {id = 10251, lua_script = "FunctionSkill.10251_Sheildrecover"}
, 
[10252] = {id = 10252, lua_script = "FunctionSkill.10252_SkillHealnum"}
, 
[10253] = {effect_id = __rt_25, id = 10253, lua_script = "FunctionSkill.10253_DamageRecover"}
, 
[10254] = {effect_id = __rt_19, id = 10254, lua_script = "FunctionSkill.10254_DoctorDamage"}
, 
[10255] = {id = 10255, lua_script = "FunctionSkill.10255_AttackZS"}
, 
[10256] = {id = 10256, lua_script = "FunctionSkill.10256_ZSSuck"}
, 
[10257] = {id = 10257, lua_script = "FunctionSkill.10257_SZFireBall"}
, 
[10258] = {id = 10258, lua_script = "FunctionSkill.10258_ZSDamageDown"}
, 
[10259] = {id = 10259, lua_script = "FunctionSkill.10259_ZSRecover"}
, 
[10260] = {
effect_id = {10702, 10704}
, id = 10260, lua_script = "FunctionSkill.10260_fakeDance"}
, 
[10261] = {id = 10261, lua_script = "FunctionSkill.10261_maskCheat"}
, 
[10262] = {id = 10262, lua_script = "FunctionSkill.10262_TargetAtk"}
, 
[10263] = {
effect_id = {10735}
, id = 10263, lua_script = "FunctionSkill.10263_TargetCD"}
, 
[10264] = {
effect_id = {10880}
, id = 10264, lua_script = "FunctionSkill.10264_DeathTarget"}
, 
[10265] = {id = 10265, lua_script = "FunctionSkill.10265_DeathBlood"}
, 
[10266] = {effect_id = __rt_26, id = 10266, lua_script = "FunctionSkill.10266_ColdArrow"}
, 
[10267] = {effect_id = __rt_26, id = 10267, lua_script = "FunctionSkill.10267_ReturnCold"}
, 
[10268] = {id = 10268, lua_script = "FunctionSkill.10268_SplitArrow"}
, 
[10269] = {effect_id = __rt_26, id = 10269, lua_script = "FunctionSkill.10269_SkillCold"}
, 
[10270] = {effect_id = __rt_27, id = 10270, lua_script = "FunctionSkill.10270_TimeSuanli"}
, 
[10271] = {effect_id = __rt_27, id = 10271, lua_script = "FunctionSkill.10271_TimeGongji"}
, 
[10272] = {effect_id = __rt_27, id = 10272, lua_script = "FunctionSkill.10272_SkillJindu"}
, 
[10273] = {effect_id = __rt_27, id = 10273, lua_script = "FunctionSkill.10273_SKillXixue"}
, 
[10274] = {effect_id = __rt_13, id = 10274, lua_script = "FunctionSkill.10274_SkillCD"}
, 
[10275] = {id = 10275, lua_script = "FunctionSkill.10275_HealSheild"}
, 
[10276] = {id = 10276, lua_script = "FunctionSkill.10276_SheildHeal"}
, 
[10277] = {id = 10277, lua_script = "FunctionSkill.10277_AllSheild"}
, 
[10278] = {id = 10278, lua_script = "FunctionSkill.10278_MHPSheild"}
, 
[10279] = {id = 10279, lua_script = "FunctionSkill.10279_CritSpeed"}
, 
[10280] = {id = 10280, lua_script = "FunctionSkill.10280_YuanDamageDown"}
, 
[10281] = {id = 10281, lua_script = "FunctionSkill.10281_HPDefence"}
, 
[10282] = {
effect_id = {10905, 10908}
, id = 10282, lua_script = "FunctionSkill.10282_DefHuwei"}
, 
[10283] = {
effect_id = {10906, 10908}
, id = 10283, lua_script = "FunctionSkill.10283_DamageHuwei"}
, 
[10284] = {
effect_id = {10907}
, id = 10284, lua_script = "FunctionSkill.10284_HealHuwei"}
, 
[10285] = {effect_id = __rt_28, id = 10285, lua_script = "FunctionSkill.10285_DeathRecover"}
, 
[10286] = {id = 10286, lua_script = "FunctionSkill.10286_HPDamageDown"}
, 
[10287] = {id = 10287, lua_script = "FunctionSkill.10287_OpenShixue"}
, 
[10288] = {id = 10288, lua_script = "FunctionSkill.10288_SkillSpeed"}
, 
[10289] = {id = 10289, lua_script = "FunctionSkill.10289_SkillYishang"}
, 
[10290] = {id = 10290, lua_script = "FunctionSkill.10290_SkillSpeed"}
, 
[10291] = {effect_id = __rt_19, id = 10291, lua_script = "FunctionSkill.10291_TimeGuomin"}
, 
[10292] = {id = 10292, lua_script = "FunctionSkill.10292_FuyuSpeed"}
, 
[10293] = {id = 10293, lua_script = "FunctionSkill.10293_DeathFenlie"}
, 
[10294] = {id = 10294, lua_script = "FunctionSkill.10294_DeathHeal"}
, 
[10295] = {id = 10295, lua_script = "FunctionSkill.10295_ControlBack"}
, 
[15047] = {effect_id = __rt_13, id = 15047, lua_script = "FunctionSkill.10226_SkillCoolDown"}
, 
[17003] = {id = 17003, lua_script = "FunctionSkill.17003_crit", skill_comat = "(-42+4/180*(power-42))*para1"}
, 
[19999] = {id = 19999, lua_script = "19999_BattleLog"}
, 
[20001] = {id = 20001, lua_script = "FunctionSkill.20001_harmless"}
, 
[20002] = {id = 20002, lua_script = "FunctionSkill.20002_deathTrap"}
, 
[20003] = {id = 20003, lua_script = "FunctionSkill.20003_reflect"}
, 
[20004] = {effect_id = __rt_13, id = 20004, lua_script = "FunctionSkill.20004_reform"}
, 
[20005] = {id = 20005, lua_script = "FunctionSkill.20005_supercharge"}
, 
[20006] = {id = 20006, lua_script = "FunctionSkill.20006_DragonHunt"}
, 
[20007] = {id = 20007, lua_script = "FunctionSkill.20007_cheer"}
, 
[20008] = {id = 20008, lua_script = "FunctionSkill.20008_Misfortune"}
, 
[20009] = {id = 20009, lua_script = "FunctionSkill.20009_powerFirst"}
, 
[20010] = {id = 20010, lua_script = "FunctionSkill.20010_calPowerFirst"}
, 
[20011] = {id = 20011, lua_script = "FunctionSkill.20011_advancedDamage"}
, 
[20012] = {id = 20012, lua_script = "FunctionSkill.20012_sterility"}
, 
[20013] = {id = 20013, lua_script = "FunctionSkill.20013_saline"}
, 
[20014] = {id = 20014, lua_script = "FunctionSkill.20014_swamp"}
, 
[20015] = {id = 20015, lua_script = "FunctionSkill.20015_malaria"}
, 
[20016] = {effect_id = __rt_28, id = 20016, lua_script = "FunctionSkill.20016_rebirth"}
, 
[20017] = {id = 20017, lua_script = "FunctionSkill.20017_decay"}
, 
[20018] = {id = 20018, lua_script = "FunctionSkill.20018_retroreflection"}
, 
[20019] = {id = 20019, lua_script = "FunctionSkill.20019_noise"}
, 
[20020] = {id = 20020, lua_script = "FunctionSkill.20020_delusion"}
, 
[20021] = {effect_id = __rt_13, id = 20021, lua_script = "FunctionSkill.20021_phantom"}
, 
[20031] = {id = 20031, lua_script = "FunctionSkill.20031_Xinroot1"}
, 
[20032] = {effect_id = __rt_15, id = 20032, lua_script = "FunctionSkill.20032_Xinroot2"}
, 
[20033] = {id = 20033, lua_script = "FunctionSkill.20033_Xinroot3"}
, 
[20035] = {id = 20035, lua_script = "FunctionSkill.20035_Mararoot1"}
, 
[20036] = {id = 20036, lua_script = "FunctionSkill.20036_Mararoot2"}
, 
[20038] = {
effect_id = {10795}
, id = 20038, lua_script = "FunctionSkill.20038_Mararoot4"}
, 
[20039] = {id = 20039, lua_script = "FunctionSkill.20039_Mararoot5"}
, 
[20040] = {id = 20040, lua_script = "FunctionSkill.20040_Mararoot6"}
, 
[20043] = {id = 20043, lua_script = "FunctionSkill.20043_Beelneithroot1"}
, 
[20044] = {id = 20044, lua_script = "FunctionSkill.20044_Beelneithroot2"}
, 
[20045] = {id = 20045, lua_script = "FunctionSkill.20045_Beelneithroot3"}
, 
[20046] = {id = 20046, lua_script = "FunctionSkill.20046_Beelneithroot4"}
, 
[20047] = {id = 20047, lua_script = "FunctionSkill.20047_Beelneithroot5"}
, 
[20048] = {id = 20048, lua_script = "FunctionSkill.20048_Gabrielroot1"}
, 
[20050] = {id = 20050, lua_script = "FunctionSkill.20050_Gabrielroot3"}
, 
[20051] = {id = 20051, lua_script = "FunctionSkill.20051_Gabrielroot4"}
, 
[20052] = {id = 20052, lua_script = "FunctionSkill.20042_BeelneithCakeSum_Taunt"}
, 
[20057] = {id = 20057, lua_script = "FunctionSkill.20057_polyhedron"}
, 
[20058] = {id = 20058, lua_script = "FunctionSkill.20058_yzwailing"}
, 
[20059] = {id = 20059, lua_script = "FunctionSkill.20059_juezhanjisu"}
, 
[20060] = {id = 20060, lua_script = "FunctionSkill.20060_berserkr"}
, 
[20061] = {id = 20061, lua_script = "FunctionSkill.20061_lashing"}
, 
[20062] = {id = 20062, skill_comat = ""}
, 
[20063] = {id = 20063, skill_comat = ""}
, 
[20065] = {id = 20065, skill_comat = ""}
, 
[20067] = {id = 20067, lua_script = "FunctionSkill.20067_hotbattlefield"}
, 
[20080] = {id = 20080, lua_script = "FunctionSkill.bs_20080"}
, 
[20088] = {id = 20088, lua_script = "FunctionSkill.bs_20088"}
, 
[20095] = {id = 20095, lua_script = "FunctionSkill.20095_SimoSkill"}
, 
[20097] = {id = 20097, lua_script = "FunctionSkill.20097_rebirth"}
, 
[20107] = {id = 20107, lua_script = "FunctionSkill.20107_yazhi", skill_comat = ""}
, 
[20109] = {id = 20109, lua_script = "FunctionSkill.20109_Superpasika", skill_comat = ""}
, 
[20110] = {id = 20110, lua_script = "FunctionSkill.20110_XinshiDJS", skill_comat = ""}
, 
[30000] = {effect_id = __rt_11, id = 30000, lua_script = "FunctionSkill.30000_ShixueT"}
, 
[30001] = {id = 30001, lua_script = "FunctionSkill.30001_ShixueT2"}
, 
[30002] = {
effect_id = {10888}
, id = 30002, lua_script = "FunctionSkill.30002_FanshangT"}
, 
[30003] = {
effect_id = {10889, 10890}
, id = 30003, lua_script = "FunctionSkill.30003_FanshangT2"}
, 
[30004] = {id = 30004, lua_script = "FunctionSkill.30004_HudunT"}
, 
[30005] = {id = 30005, lua_script = "FunctionSkill.30005_HudunT2"}
, 
[30006] = {effect_id = __rt_23, id = 30006, lua_script = "FunctionSkill.30006_ShixueT"}
, 
[30007] = {id = 30007, lua_script = "FunctionSkill.30007_ShixueT2"}
, 
[30008] = {effect_id = __rt_18, id = 30008, lua_script = "FunctionSkill.30008_FeidanT"}
, 
[30009] = {id = 30009, lua_script = "FunctionSkill.30009_FeidanT2"}
, 
[30010] = {effect_id = __rt_24, id = 30010, lua_script = "FunctionSkill.30010_MaixueT"}
, 
[30011] = {effect_id = __rt_14, id = 30011, lua_script = "FunctionSkill.30011_MaixueT2"}
, 
[30012] = {id = 30012, lua_script = "FunctionSkill.30012_QiuT"}
, 
[30013] = {id = 30013, lua_script = "FunctionSkill.30013_QiuT2"}
, 
[30014] = {
effect_id = {10897}
, id = 30014, lua_script = "FunctionSkill.30014_FuyuT"}
, 
[30015] = {id = 30015, lua_script = "FunctionSkill.30015_FuyuT2"}
, 
[30016] = {id = 30016, lua_script = "FunctionSkill.30016_CDT"}
, 
[30017] = {id = 30017, lua_script = "FunctionSkill.30017_CDT2"}
, 
[30018] = {id = 30018, lua_script = "FunctionSkill.30018_BaojiT"}
, 
[30019] = {id = 30019, lua_script = "FunctionSkill.30019_BaojiT2"}
, 
[30020] = {id = 30020, lua_script = "FunctionSkill.30020_HuweiT"}
, 
[30021] = {id = 30021, lua_script = "FunctionSkill.30021_HuweiT2"}
, 
[30022] = {
effect_id = {10879, 10882}
, id = 30022, lua_script = "FunctionSkill.30022_ImmKill"}
, 
[30023] = {id = 30023, lua_script = "FunctionSkill.30023_KillBurn"}
, 
[30024] = {id = 30024, lua_script = "FunctionSkill.30024_ColdPowerUp"}
, 
[30025] = {
effect_id = {10875, 10883}
, id = 30025, lua_script = "FunctionSkill.30025_ColdBomb"}
, 
[30026] = {id = 30026, lua_script = "FunctionSkill.30026_LeifengT"}
, 
[30027] = {id = 30027, lua_script = "FunctionSkill.30027_LeifengT2"}
, 
[30028] = {id = 30028, lua_script = "FunctionSkill.30028_SheildT"}
, 
[30029] = {id = 30029, lua_script = "FunctionSkill.30029_SheildT2"}
, 
[30030] = {id = 30030, lua_script = "FunctionSkill.30030_ShixueT"}
, 
[30031] = {id = 30031, lua_script = "FunctionSkill.30031_ShixueT2"}
, 
[30032] = {id = 30032, lua_script = "FunctionSkill.30032_SheBaojiT"}
, 
[30033] = {id = 30033, lua_script = "FunctionSkill.30033_SheBaojiT2"}
, 
[30034] = {
effect_id = {10900, 10901}
, id = 30034, lua_script = "FunctionSkill.30034_YishangT"}
, 
[30035] = {id = 30035, lua_script = "FunctionSkill.30035_YishangT2"}
, 
[30036] = {id = 30036, lua_script = "FunctionSkill.30036_FumianT"}
, 
[30037] = {id = 30037, lua_script = "FunctionSkill.30037_FumianT2"}
, 
[30038] = {effect_id = __rt_18, id = 30038, lua_script = "FunctionSkill.30038_ShanbiT"}
, 
[30039] = {id = 30039, lua_script = "FunctionSkill.30039_ShanbiT2"}
, 
[30040] = {effect_id = __rt_25, id = 30040, lua_script = "FunctionSkill.30040_GuominT"}
, 
[30041] = {id = 30041, lua_script = "FunctionSkill.30041_GuominT2"}
, 
[30042] = {id = 30042, lua_script = "FunctionSkill.30042_LijieT"}
, 
[30043] = {id = 30043, lua_script = "FunctionSkill.30043_LijieT2"}
, 
[30044] = {id = 30044, lua_script = "FunctionSkill.30044_KongzhiT"}
, 
[30045] = {id = 30045, lua_script = "FunctionSkill.30045_KongzhiT2"}
, 
[30046] = {
effect_id = {10084}
, id = 30046, lua_script = "FunctionSkill.30046_fragile"}
, 
[50000] = {id = 50000, lua_script = "MonsterSkill.50000_GridCF"}
, 
[50001] = {id = 50001, lua_script = "MonsterSkill.50001_GridJJ"}
, 
[50002] = {effect_id = __rt_21, id = 50002, lua_script = "MonsterSkill.50002_GridYuancheng"}
, 
[50003] = {effect_id = __rt_22, id = 50003, lua_script = "MonsterSkill.50003_GridJinzhan"}
, 
[50004] = {
effect_id = {10481}
, id = 50004, lua_script = "MonsterSkill.50004_GridBuffSheild"}
, 
[50005] = {id = 50005, lua_script = "MonsterSkill.50005_ObDamageUp"}
, 
[50006] = {
effect_id = {10371, 10373}
, id = 50006, lua_script = "MonsterSkill.50006_SheildDamage"}
, 
[50007] = {id = 50007, lua_script = "MonsterSkill.50007_FakeYuanShield"}
, 
[50008] = {id = 50008, lua_script = "MonsterSkill.50008_FakeJinShield"}
, 
[50009] = {
effect_id = {10616}
, id = 50009, lua_script = "MonsterSkill.50009_NormalSheild"}
, 
[50010] = {id = 50010, lua_script = "MonsterSkill.50010_10225Skill"}
, 
[50011] = {
effect_id = {10628, 10630}
, id = 50011, lua_script = "MonsterSkill.50011_10228Skill"}
, 
[50012] = {
effect_id = {10642}
, id = 50012, lua_script = "MonsterSkill.50012_10231Skill"}
, 
[50013] = {id = 50013, lua_script = "MonsterSkill.50013_Shangye"}
, 
[50014] = {effect_id = __rt_21, id = 50014, lua_script = "MonsterSkill.50014_WYuanSheild"}
, 
[50015] = {effect_id = __rt_22, id = 50015, lua_script = "MonsterSkill.50015_WJinSheild"}
, 
[50016] = {id = 50016, lua_script = "MonsterSkill.50016_ATK1Hp"}
, 
[50017] = {id = 50017, lua_script = "MonsterSkill.50017_CDGridSkill"}
, 
[50210] = {id = 50210, lua_script = "CommanderSkill.5021_eul", skill_comat = ""}
, 
[50310] = {effect_id = __rt_3, id = 50310, lua_script = "CommanderSkill.5031_resetSkillCd", skill_comat = ""}
, 
[51110] = {effect_id = __rt_4, id = 51110, lua_script = "CommanderSkill.5111_hit", skill_comat = ""}
, 
[51310] = {effect_id = __rt_5, id = 51310, lua_script = "CommanderSkill.5131_focusOnFiring", skill_comat = ""}
, 
[51410] = {effect_id = __rt_6, id = 51410, lua_script = "CommanderSkill.5141_aoeStun", skill_comat = ""}
, 
[51411] = {effect_id = __rt_6, id = 51411, lua_script = "CommanderSkill.5141_aoeStun", skill_comat = ""}
, 
[60000] = {id = 60000, lua_script = "MonsterSkill.60000_Obstacle"}
, 
[60001] = {effect_id = __rt_29, id = 60001, lua_script = "MonsterSkill.60001_DeObstacle"}
, 
[60002] = {effect_id = __rt_30, id = 60002, lua_script = "MonsterSkill.60002_RedServer"}
, 
[60003] = {id = 60003, lua_script = "MonsterSkill.60003_BlueDespel"}
, 
[60004] = {id = 60004, lua_script = "MonsterSkill.60000_Obstacle"}
, 
[60005] = {effect_id = __rt_29, id = 60005, lua_script = "MonsterSkill.60001_DeObstacle"}
, 
[70000] = {id = 70000, lua_script = "MonsterSkill.70000_ProMiner"}
, 
[70001] = {id = 70001, lua_script = "MonsterSkill.70001_ProMilk"}
, 
[70002] = {id = 70002, lua_script = "MonsterSkill.70002_JinMine"}
, 
[70003] = {id = 70003, lua_script = "MonsterSkill.70003_YuanMine"}
, 
[70004] = {id = 70004, lua_script = "MonsterSkill.70004_MonsterATKPro"}
, 
[70005] = {id = 70005, lua_script = "TowerDefenceSkill.70005_TDPathMonster"}
, 
[70006] = {
effect_id = {10910}
, id = 70006, lua_script = "MonsterSkill.70006_MeiriBoss"}
, 
[70007] = {id = 70007, lua_script = "MonsterSkill.70007_MeiriMonster"}
, 
[100100] = {
effect_id = {100101}
, hit_skill_type = 1, id = 100100, lua_script = "CommonAttackSkill.100100_PersicariaAttack", skill_comat = "0.15*power+30"}
, 
[100101] = {
effect_id = {100103, 100104}
, id = 100101, lua_script = "RoleSkill.100101_PersicariaPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[100102] = {
effect_id = {100105, 100106, 100107}
, id = 100102, lua_script = "RoleSkill.100102_PersicariaSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[100103] = {
effect_id = {100109, 100110}
, id = 100103, lua_script = "RoleUltSkill.100103_PersicariaUlt", skill_comat = ""}
, 
[100200] = {
effect_id = {100201, 100202, 100203, 100204}
, hit_skill_type = 1, id = 100200, lua_script = "CommonAttackSkill.100200_AnnaAttack", skill_comat = ""}
, 
[100201] = {effect_id = __rt_31, id = 100201, lua_script = "RoleSkill.100201_AnnaPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[100202] = {effect_id = __rt_31, hit_skill_type = 1, id = 100202, lua_script = "RoleSkill.100202_AnnaSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[100203] = {
effect_id = {100210, 100213}
, id = 100203, lua_script = "RoleUltSkill.100203_AnnaInvasion", skill_comat = ""}
, 
[100300] = {
effect_id = {100301}
, hit_skill_type = 2, id = 100300, lua_script = "CommonAttackSkill.100300_SolAttack", skill_comat = ""}
, 
[100301] = {
effect_id = {100306}
, hit_skill_type = 1, id = 100301, lua_script = "RoleSkill.100301_SolPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[100302] = {
effect_id = {100304, 100305, 100307}
, hit_skill_type = 2, id = 100302, lua_script = "RoleSkill.100302_SolSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[100303] = {
effect_id = {10310, 10343}
, hit_skill_type = 2, id = 100303, lua_script = "RoleUltSkill.100303_SolFireUlt", skill_comat = ""}
, 
[100400] = {
effect_id = {100401}
, hit_skill_type = 2, id = 100400, lua_script = "CommonAttackSkill.100400_SimoAttack", skill_comat = ""}
, 
[100401] = {hit_skill_type = 2, id = 100401, lua_script = "RoleSkill.100401_SimoPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[100402] = {
effect_id = {100403}
, hit_skill_type = 2, id = 100402, lua_script = "RoleSkill.100402_SimoSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[100403] = {
effect_id = {100405, 100406}
, id = 100403, lua_script = "RoleUltSkill.100403_SimoUlt", skill_comat = ""}
, 
[100500] = {
effect_id = {100501, 100502}
, hit_skill_type = 3, id = 100500, lua_script = "CommonAttackSkill.100500_CroqueAttack", skill_comat = ""}
, 
[100501] = {id = 100501, lua_script = "RoleSkill.100501_CroquePassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[100502] = {
effect_id = {123, 100504, 100506, 100507, 100508, 100509, 100510, 100511, 100512, 100513, 100514, 100515}
, id = 100502, lua_script = "RoleSkill.100502_CroqueSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[100503] = {
effect_id = {100516}
, hit_skill_type = 3, id = 100503, lua_script = "RoleUltSkill.100503_Robot", skill_comat = ""}
, 
[100600] = {
effect_id = {100601, 100602, 100603, 100604}
, hit_skill_type = 1, id = 100600, lua_script = "CommonAttackSkill.100600_FresnelAttack", skill_comat = ""}
, 
[100601] = {
effect_id = {100606, 100607}
, hit_skill_type = 1, id = 100601, lua_script = "RoleSkill.100601_FresnelPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[100602] = {
effect_id = {100307, 100608, 100609, 100610}
, hit_skill_type = 1, id = 100602, lua_script = "RoleSkill.100602_FresnelSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[100603] = {
effect_id = {100611}
, hit_skill_type = 1, id = 100603, lua_script = "RoleUltSkill.100603_FresnelUlt", skill_comat = ""}
, 
[100700] = {
effect_id = {100701, 100702}
, hit_skill_type = 1, id = 100700, lua_script = "CommonAttackSkill.100700_ChelseaAttack", skill_comat = ""}
, 
[100701] = {hit_skill_type = 1, id = 100701, lua_script = "RoleSkill.100701_ChelseaPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[100702] = {
effect_id = {100704, 100705}
, hit_skill_type = 1, id = 100702, lua_script = "RoleSkill.100702_ChelseaSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[100703] = {
effect_id = {100706, 100707}
, hit_skill_type = 1, id = 100703, lua_script = "RoleUltSkill.100703_ChelseaUlt", skill_comat = ""}
, 
[100800] = {
effect_id = {100801}
, hit_skill_type = 1, id = 100800, lua_script = "CommonAttackSkill.100800_GinAttack", skill_comat = "0.15*power+30"}
, 
[100801] = {id = 100801, lua_script = "RoleSkill.100801_GinPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[100802] = {id = 100802, lua_script = "RoleSkill.100802_GinSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[100803] = {
effect_id = {100804, 100805}
, id = 100803, lua_script = "RoleUltSkill.100803_GinUlt", skill_comat = ""}
, 
[100900] = {
effect_id = {100901}
, hit_skill_type = 1, id = 100900, lua_script = "CommonAttackSkill.100900_MaiAttack", skill_comat = ""}
, 
[100901] = {id = 100901, lua_script = "RoleSkill.100901_MaiPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[100902] = {
effect_id = {100905, 100906, 100907}
, hit_skill_type = 1, id = 100902, lua_script = "RoleSkill.100902_MaiSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[100903] = {hit_skill_type = 1, id = 100903, lua_script = "RoleUltSkill.100903_MaiUlt", skill_comat = ""}
, 
[101000] = {
effect_id = {101001}
, hit_skill_type = 2, id = 101000, lua_script = "CommonAttackSkill.101000_EvelynAttack", skill_comat = ""}
, 
[101001] = {id = 101001, lua_script = "RoleSkill.101001_EvelynPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[101002] = {
effect_id = {101003}
, hit_skill_type = 2, id = 101002, lua_script = "RoleSkill.101002_EvelynSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[101003] = {
effect_id = {101006}
, id = 101003, lua_script = "RoleUltSkill.101003_EvelynUlt", skill_comat = ""}
, 
[101100] = {
effect_id = {101109, 101110}
, hit_skill_type = 2, id = 101100, lua_script = "CommonAttackSkill.101100_CamelliaAttack", skill_comat = ""}
, 
[101101] = {id = 101101, lua_script = "RoleSkill.101101_CamelliaPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[101102] = {
effect_id = {101104, 101106, 101108}
, hit_skill_type = 1, id = 101102, lua_script = "RoleSkill.101102_CamelliaSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[101103] = {hit_skill_type = 2, id = 101103, lua_script = "RoleUltSkill.101103_CamelliaUlt", skill_comat = ""}
, 
[101200] = {
effect_id = {101201, 101202}
, hit_skill_type = 1, id = 101200, lua_script = "CommonAttackSkill.101200_MaxAttack", skill_comat = ""}
, 
[101201] = {
effect_id = {101204}
, hit_skill_type = 1, id = 101201, lua_script = "RoleSkill.101201_MaxPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[101202] = {
effect_id = {101206, 101207, 101208, 101210}
, hit_skill_type = 1, id = 101202, lua_script = "RoleSkill.101202_MaxSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[101300] = {
effect_id = {101301, 101302}
, hit_skill_type = 1, id = 101300, lua_script = "CommonAttackSkill.101300_BettyAttack", skill_comat = ""}
, 
[101301] = {
effect_id = {101304}
, id = 101301, lua_script = "RoleSkill.101301_BettyPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[101302] = {id = 101302, lua_script = "RoleSkill.101302_BettySkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[101303] = {
effect_id = {101307}
, hit_skill_type = 2, id = 101303, lua_script = "RoleUltSkill.101303_BettyUlt", skill_comat = ""}
, 
[101400] = {
effect_id = {101401, 101402, 101408, 101409}
, hit_skill_type = 2, id = 101400, lua_script = "CommonAttackSkill.101400_ChocoAttack", skill_comat = "0.15*power+30"}
, 
[101401] = {
effect_id = {101404}
, id = 101401, lua_script = "RoleSkill.101401_ChocoPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[101402] = {
effect_id = {101405, 101407}
, id = 101402, lua_script = "RoleSkill.101402_ChocoSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[101403] = {
effect_id = {10859}
, id = 101403, lua_script = "RoleUltSkill.101403_ChocoUlt", skill_comat = ""}
, 
[101500] = {
effect_id = {101501, 101502}
, hit_skill_type = 1, id = 101500, lua_script = "CommonAttackSkill.101500_PanakeiaAttack", skill_comat = "0.15*power+30"}
, 
[101501] = {
effect_id = {101507, 101508, 101511}
, id = 101501, lua_script = "RoleSkill.101501_PanakeiaPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[101502] = {
effect_id = {101502, 101512, 101513}
, hit_skill_type = 1, id = 101502, lua_script = "RoleSkill.101502_PanakeiaSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[101503] = {id = 101503, lua_script = "RoleUltSkill.101503_PanakeiaUlt", skill_comat = ""}
, 
[101600] = {
effect_id = {101601}
, hit_skill_type = 1, id = 101600, lua_script = "CommonAttackSkill.101600_BanxsyAttack", skill_comat = ""}
, 
[101601] = {
effect_id = {101603}
, id = 101601, lua_script = "RoleSkill.101601_BanxsyPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[101602] = {
effect_id = {101604}
, hit_skill_type = 2, id = 101602, lua_script = "RoleSkill.101602_BanxsySkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[101603] = {id = 101603, lua_script = "RoleUltSkill.101603_BanxsyUlt", skill_comat = ""}
, 
[101700] = {
effect_id = {101706}
, hit_skill_type = 1, id = 101700, lua_script = "CommonAttackSkill.101700_AngelaAttack", skill_comat = ""}
, 
[101701] = {
effect_id = {101702}
, id = 101701, lua_script = "RoleSkill.101701_AngelaPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[101702] = {
effect_id = {101703, 101704, 101705}
, id = 101702, lua_script = "RoleSkill.101702_AngelaSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[101703] = {id = 101703, lua_script = "RoleUltSkill.101703_AngelaUlt", skill_comat = ""}
, 
[101800] = {
effect_id = {101801}
, hit_skill_type = 1, id = 101800, lua_script = "CommonAttackSkill.101800_FlorenceAttack", skill_comat = "0.15*power+30"}
, 
[101801] = {
effect_id = {101805}
, id = 101801, lua_script = "RoleSkill.101801_FlorencePassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[101802] = {
effect_id = {101807}
, id = 101802, lua_script = "RoleSkill.101802_FlorenceSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[101803] = {
effect_id = {101808}
, id = 101803, lua_script = "RoleUltSkill.101803_FlorenceUlt", skill_comat = ""}
, 
[101809] = {id = 101809, lua_script = "RoleSkill.101809_Florence_ex", skill_comat = ""}
, 
[101900] = {
effect_id = {10680, 10681}
, hit_skill_type = 2, id = 101900, lua_script = "CommonAttackSkill.101900_FernAttack", skill_comat = ""}
, 
[101901] = {
effect_id = {10686, 10687, 10699, 10700}
, id = 101901, lua_script = "RoleSkill.101901_FernPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[101902] = {
effect_id = {10688, 10690}
, hit_skill_type = 3, id = 101902, lua_script = "RoleSkill.101902_FernSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[101903] = {id = 101903, lua_script = "RoleUltSkill.101903_FernUlt", skill_comat = ""}
, 
[102000] = {
effect_id = {102001, 102002}
, hit_skill_type = 3, id = 102000, lua_script = "CommonAttackSkill.102000_YannyAttack", skill_comat = ""}
, 
[102001] = {id = 102001, lua_script = "RoleSkill.102001_YannyPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[102002] = {
effect_id = {102004}
, id = 102002, lua_script = "RoleSkill.102002_YannySkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[102003] = {id = 102003, lua_script = "RoleUltSkill.102003_YannyUlt", skill_comat = ""}
, 
[102009] = {id = 102009, lua_script = "RoleSkill.102009_YannyUltBuff", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[102100] = {
effect_id = {10265, 10266, 10268, 10269}
, hit_skill_type = 1, id = 102100, lua_script = "CommonAttackSkill.102100_GrooveAttack", skill_comat = ""}
, 
[102101] = {
effect_id = {10709}
, hit_skill_type = 1, id = 102101, lua_script = "RoleSkill.102101_GroovePassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[102102] = {
effect_id = {10271, 10272}
, id = 102102, lua_script = "RoleSkill.102102_GrooveSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[102200] = {
effect_id = {102204, 102205, 102206, 102207, 102208, 102209}
, hit_skill_type = 1, id = 102200, lua_script = "CommonAttackSkill.102200_AkiAttack", skill_comat = ""}
, 
[102201] = {id = 102201, lua_script = "RoleSkill.102201_AkiPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[102202] = {
effect_id = {102210, 102211}
, hit_skill_type = 2, id = 102202, lua_script = "RoleSkill.102202_AkiSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[102203] = {id = 102203, lua_script = "RoleUltSkill.102203_AkiUlt", skill_comat = ""}
, 
[102300] = {
effect_id = {102302, 102303}
, hit_skill_type = 2, id = 102300, lua_script = "CommonAttackSkill.102300_BoneeAttack", skill_comat = ""}
, 
[102301] = {id = 102301, lua_script = "RoleSkill.102301_BoneePassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[102302] = {
effect_id = {102304, 102305}
, id = 102302, lua_script = "RoleSkill.102302_BoneeSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[102400] = {
effect_id = {10736, 10738, 10740, 10741, 10742, 10743}
, hit_skill_type = 2, id = 102400, lua_script = "CommonAttackSkill.102400_EarhartAttack", skill_comat = ""}
, 
[102401] = {
effect_id = {10738}
, id = 102401, lua_script = "RoleSkill.102401_EarhartPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[102402] = {
effect_id = {10744, 10745}
, id = 102402, lua_script = "RoleSkill.102402_EarhartSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[102403] = {id = 102403, lua_script = "RoleUltSkill.102403_EarhartUlt", skill_comat = ""}
, 
[102500] = {effect_id = __rt_32, hit_skill_type = 1, id = 102500, lua_script = "CommonAttackSkill.102500_TwigsAttack", skill_comat = ""}
, 
[102501] = {id = 102501, lua_script = "RoleSkill.102501_TwigsPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[102502] = {effect_id = __rt_32, id = 102502, lua_script = "RoleSkill.102502_TwigsSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[102503] = {id = 102503, lua_script = "RoleUltSkill.102503_TwigsUlt", skill_comat = ""}
, 
[102600] = {
effect_id = {10719}
, hit_skill_type = 1, id = 102600, lua_script = "CommonAttackSkill.102600_NanakaAttack", skill_comat = "0.15*power+30"}
, 
[102601] = {
effect_id = {10725, 10726, 10856}
, id = 102601, lua_script = "RoleSkill.102601_NanakaPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[102602] = {
effect_id = {10724, 100802, 102604}
, id = 102602, lua_script = "RoleSkill.102602_NanakaSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[102603] = {
effect_id = {102601, 102602, 102603}
, id = 102603, lua_script = "RoleUltSkill.102603_NanakaUlt", skill_comat = ""}
, 
[102700] = {
effect_id = {10378, 10379}
, hit_skill_type = 3, id = 102700, lua_script = "CommonAttackSkill.102700_ZionAttack", skill_comat = ""}
, 
[102701] = {
effect_id = {10382}
, id = 102701, lua_script = "RoleSkill.102701_ZionPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[102702] = {
effect_id = {10383}
, id = 102702, lua_script = "RoleSkill.102702_ZionSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[102800] = {
effect_id = {10701, 10702, 10703, 10704, 10705}
, hit_skill_type = 1, id = 102800, lua_script = "CommonAttackSkill.102800_VeeAttack", skill_comat = "0.1*power"}
, 
[102801] = {id = 102801, lua_script = "RoleSkill.102801_VeePassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[102802] = {
effect_id = {10707}
, hit_skill_type = 1, id = 102802, lua_script = "RoleSkill.102802_VeeSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[102803] = {
effect_id = {10869, 10871}
, id = 102803, lua_script = "RoleUltSkill.102803_VeeUlt", skill_comat = ""}
, 
[102900] = {
effect_id = {102901, 102902}
, hit_skill_type = 1, id = 102900, lua_script = "CommonAttackSkill.102900_WillowAttack", skill_comat = ""}
, 
[102901] = {id = 102901, lua_script = "RoleSkill.102901_WillowPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[102902] = {
effect_id = {102903, 102904, 102905}
, hit_skill_type = 1, id = 102902, lua_script = "RoleSkill.102902_WillowSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[102903] = {id = 102903, lua_script = "RoleUltSkill.102903_WillowUlt", skill_comat = ""}
, 
[103000] = {
effect_id = {103001, 103003}
, hit_skill_type = 1, id = 103000, lua_script = "CommonAttackSkill.103000_KseniaAttack", skill_comat = ""}
, 
[103001] = {
effect_id = {103010}
, id = 103001, lua_script = "RoleSkill.103001_KseniaPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[103002] = {
effect_id = {103005, 103006, 103007}
, id = 103002, lua_script = "RoleSkill.103002_KseniaSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[103003] = {id = 103003, lua_script = "RoleUltSkill.103003_KseniaUlt", skill_comat = ""}
, 
[103100] = {
effect_id = {103107}
, hit_skill_type = 1, id = 103100, lua_script = "CommonAttackSkill.103100_ImhotepAttack", skill_comat = "0.05*power+30"}
, 
[103101] = {
effect_id = {103105}
, id = 103101, lua_script = "RoleSkill.103101_ImhotepPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[103102] = {
effect_id = {103103, 103104}
, hit_skill_type = 1, id = 103102, lua_script = "RoleSkill.103102_ImhotepSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[103103] = {id = 103103, lua_script = "RoleUltSkill.103103_ImhotepUlt", skill_comat = ""}
, 
[103200] = {
effect_id = {103201, 103203, 103204, 103207}
, hit_skill_type = 1, id = 103200, lua_script = "CommonAttackSkill.103200_OctogenAttack", skill_comat = ""}
, 
[103201] = {id = 103201, lua_script = "RoleSkill.103201_OctogenPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[103202] = {
effect_id = {103204, 103205}
, hit_skill_type = 1, id = 103202, lua_script = "RoleSkill.103202_OctogenSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[103203] = {hit_skill_type = 3, id = 103203, lua_script = "RoleUltSkill.103203_OctogenUlt", skill_comat = ""}
, 
[103300] = {
effect_id = {103301, 103308, 103309}
, hit_skill_type = 1, id = 103300, lua_script = "CommonAttackSkill.103300_RiseAttack", skill_comat = ""}
, 
[103301] = {id = 103301, lua_script = "RoleSkill.103301_RisePassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[103302] = {
effect_id = {103305}
, id = 103302, lua_script = "RoleSkill.103302_RiseSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[103303] = {id = 103303, lua_script = "RoleUltSkill.103303_RiseUlt", skill_comat = ""}
, 
[103400] = {
effect_id = {10453, 10798}
, hit_skill_type = 1, id = 103400, lua_script = "CommonAttackSkill.103400_AbigailAttack", skill_comat = ""}
, 
[103401] = {
effect_id = {10459}
, id = 103401, lua_script = "RoleSkill.103401_AbigailPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[103402] = {
effect_id = {10455}
, id = 103402, lua_script = "RoleSkill.103402_AbigailSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[103500] = {
effect_id = {10192, 10193, 10793, 10806}
, hit_skill_type = 2, id = 103500, lua_script = "CommonAttackSkill.103500_JessieAttack", skill_comat = "0.15*power+30"}
, 
[103501] = {
effect_id = {103501}
, id = 103501, lua_script = "RoleSkill.103501_JessiePassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[103502] = {
effect_id = {10198}
, id = 103502, lua_script = "RoleSkill.103502_JessieSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[103503] = {hit_skill_type = 1, id = 103503, lua_script = "RoleUltSkill.103503_JessieUlt", skill_comat = ""}
, 
[103508] = {id = 103508, lua_script = "RoleSkill.103508_Jessie_ex", skill_comat = ""}
, 
[103509] = {id = 103509, lua_script = "RoleSkill.103509_JessieUltPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[103600] = {
effect_id = {10179}
, hit_skill_type = 1, id = 103600, lua_script = "CommonAttackSkill.103600_LamAttack", skill_comat = ""}
, 
[103601] = {id = 103601, lua_script = "RoleSkill.103601_LamPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[103602] = {
effect_id = {10181, 10182, 10183, 10184}
, hit_skill_type = 2, id = 103602, lua_script = "RoleSkill.103602_LamSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[103603] = {hit_skill_type = 2, id = 103603, lua_script = "RoleUltSkill.103603_LamUlt", skill_comat = ""}
, 
[103700] = {
effect_id = {10325, 10327, 10328}
, hit_skill_type = 1, id = 103700, lua_script = "CommonAttackSkill.103700_HubbleAttack", skill_comat = ""}
, 
[103701] = {
effect_id = {10320, 10321, 10322, 10323, 10324}
, id = 103701, lua_script = "RoleSkill.103701_HubblePassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[103702] = {
effect_id = {10329, 10330, 10801}
, hit_skill_type = 1, id = 103702, lua_script = "RoleSkill.103702_HubbleSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[103703] = {
effect_id = {10293}
, hit_skill_type = 1, id = 103703, lua_script = "RoleUltSkill.103703_BlackHole", skill_comat = ""}
, 
[103800] = {
effect_id = {10386, 10387, 10796, 10805}
, hit_skill_type = 2, id = 103800, lua_script = "CommonAttackSkill.103800_SakuyaAttack", skill_comat = ""}
, 
[103801] = {
effect_id = {10800}
, id = 103801, lua_script = "RoleSkill.103801_SakuyaPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[103802] = {
effect_id = {10389}
, hit_skill_type = 2, id = 103802, lua_script = "RoleSkill.103802_SakuyaSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[103803] = {hit_skill_type = 2, id = 103803, lua_script = "RoleUltSkill.103803_SakuyaUlt", skill_comat = ""}
, 
[103900] = {
effect_id = {10462, 10463, 10464}
, hit_skill_type = 2, id = 103900, lua_script = "CommonAttackSkill.103900_CentaureissAttack", skill_comat = ""}
, 
[103901] = {
effect_id = {103904}
, id = 103901, lua_script = "RoleSkill.103901_CentaureissPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[103902] = {
effect_id = {10465, 10467, 10468, 10469, 10516, 10534, 10535, 103904}
, hit_skill_type = 2, id = 103902, lua_script = "RoleSkill.103902_CentaureissSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[103903] = {hit_skill_type = 2, id = 103903, lua_script = "RoleUltSkill.103903_CentaureissUlt", skill_comat = ""}
, 
[104000] = {effect_id = __rt_33, hit_skill_type = 1, id = 104000, lua_script = "CommonAttackSkill.104000_DusevnyjAttack", skill_comat = ""}
, 
[104001] = {id = 104001, lua_script = "RoleSkill.104001_DusevnyjPassive", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[104002] = {effect_id = __rt_33, hit_skill_type = 1, id = 104002, lua_script = "RoleSkill.104002_DusevnyjSkill", skill_comat = "(45*lv*lv+55*lv)/4"}
, 
[104003] = {id = 104003, lua_script = "RoleUltSkill.104003_DusevnyjUlt", skill_comat = ""}
, 
[105001] = {
effect_id = {10911}
, id = 105001, lua_script = "MonsterSkill.105001_gas", skill_comat = "(32+0*1)*power/100"}
, 
[200001] = {id = 200001, lua_script = "MonsterSkill.200001_Boss_mianyi", skill_comat = "60*lv*lv+20*lv"}
, 
[200101] = {id = 200101, lua_script = "MonsterSkill.200101_TJZ_ZhiZGS", skill_comat = "(18+1.125*1)*power/100"}
, 
[200102] = {
effect_id = {10084, 10085, 10864, 10867}
, hit_skill_type = 2, id = 200102, lua_script = "MonsterSkill.200102_TJZ_ZhiZXJ", skill_comat = "(20+3.75*1)*power/100"}
, 
[200103] = {id = 200103, lua_script = "MonsterSkill.200103_TJZ_SpeedUp", skill_comat = ""}
, 
[200201] = {id = 200201, lua_script = "MonsterSkill.200201_SQZ_ShenQSLM", skill_comat = "(0+0*1)*power/100"}
, 
[200202] = {hit_skill_type = 1, id = 200202, lua_script = "MonsterSkill.200202_SQZ_ShouMSS", skill_comat = "(22+0*1)*power/100"}
, 
[200203] = {effect_id = __rt_34, hit_skill_type = 1, id = 200203, lua_script = "MonsterSkill.200203_SQZ_PurgerAOE", skill_comat = "35/100*power*1"}
, 
[200204] = {effect_id = __rt_34, hit_skill_type = 1, id = 200204, lua_script = "MonsterSkill.200204_SQZ_FunctionMonster", skill_comat = "35/100*power*1"}
, 
[200205] = {id = 200205, lua_script = "MonsterSkill.200205_SQZ_CritUp", skill_comat = ""}
, 
[200301] = {id = 200301, lua_script = "MonsterSkill.200301_RN_GouSB", skill_comat = "(28+0*1)*power/100"}
, 
[200302] = {hit_skill_type = 1, id = 200302, lua_script = "MonsterSkill.200302_RN_HanWZXX", skill_comat = "(21+2.125*1)*power/100"}
, 
[200303] = {
effect_id = {10095}
, hit_skill_type = 1, id = 200303, lua_script = "MonsterSkill.200303_RN_GouDF", skill_comat = "(32+5.75*1)*power/100"}
, 
[200401] = {effect_id = __rt_35, hit_skill_type = 3, id = 200401, lua_script = "MonsterSkill.200401_Chong_PTGJ", skill_comat = "(37+11.75*1)*power/100"}
, 
[200402] = {id = 200402, lua_script = "MonsterSkill.200402_Chong_FN", skill_comat = "(20+0*1)*power/100"}
, 
[200403] = {effect_id = __rt_36, hit_skill_type = 2, id = 200403, lua_script = "MonsterSkill.200403_Chong_XZCZ", skill_comat = "(33+16.375*1)*power/100"}
, 
[200501] = {effect_id = __rt_37, hit_skill_type = 3, id = 200501, lua_script = "MonsterSkill.200501_Xin_XinDTXX", skill_comat = "(66+6.25*1)*power/100"}
, 
[200502] = {effect_id = __rt_38, id = 200502, lua_script = "MonsterSkill.200502_Xin_ShunSP", skill_comat = "(23+5.625*1)*power/100"}
, 
[200503] = {id = 200503, lua_script = "MonsterSkill.200503_Xin_ChaoJCF", skill_comat = "(44+8.125*1)*power/100"}
, 
[200601] = {id = 200601, lua_script = "MonsterSkill.200601_CGZ_RefactorZF", skill_comat = "(30+0*1)*power/100"}
, 
[200602] = {
effect_id = {10109, 10110, 10111, 10112}
, hit_skill_type = 1, id = 200602, lua_script = "MonsterSkill.200602_CGZ_RefactorSY", skill_comat = "(32+0*1)*power/100"}
, 
[200603] = {id = 200603, lua_script = "MonsterSkill.200603_CGZ_IntencityUp", skill_comat = ""}
, 
[200701] = {
effect_id = {10117, 10118}
, id = 200701, lua_script = "MonsterSkill.200701_HWZ_LianDAOE", skill_comat = "(22+2.625*1)*power/100"}
, 
[200702] = {id = 200702, lua_script = "MonsterSkill.200702_HWZ_IntencityUp", skill_comat = ""}
, 
[200801] = {
effect_id = {10608}
, id = 200801, lua_script = "MonsterSkill.200801_GY_JianYBY", skill_comat = "(22+0*1)*power/100"}
, 
[200802] = {effect_id = __rt_39, hit_skill_type = 2, id = 200802, lua_script = "MonsterSkill.200802_GY_AOEdamage", skill_comat = "(43+1.625*1)*power/100"}
, 
[200803] = {effect_id = __rt_39, hit_skill_type = 2, id = 200803, lua_script = "MonsterSkill.200802_GY_AOEdamage", skill_comat = "35/100*power*1"}
, 
[200901] = {hit_skill_type = 2, id = 200901, lua_script = "MonsterSkill.200901_MaraPassive1", skill_comat = "35/100*power*1"}
, 
[200902] = {
effect_id = {10229}
, id = 200902, lua_script = "MonsterSkill.200902_MaraPassive2", skill_comat = "35/100*power*1"}
, 
[200903] = {
effect_id = {10237, 10238, 10861, 10867}
, hit_skill_type = 3, id = 200903, lua_script = "MonsterSkill.200903_MaraSkill1", skill_comat = "35/100*power*1"}
, 
[201001] = {effect_id = __rt_40, hit_skill_type = 1, id = 201001, lua_script = "MonsterSkill.201001_MaraPassive3", skill_comat = "35/100*power*1"}
, 
[201002] = {
effect_id = {10235}
, id = 201002, lua_script = "MonsterSkill.201002_MaraPassive2-blue", skill_comat = "35/100*power*1"}
, 
[201003] = {
effect_id = {10241, 10242}
, hit_skill_type = 1, id = 201003, lua_script = "MonsterSkill.201003_MaraSkill2", skill_comat = "35/100*power*1"}
, 
[201101] = {id = 201101, lua_script = "MonsterSkill.201101_ShouHZ_Passive", skill_comat = "35/100*power*1"}
, 
[201102] = {
effect_id = {10217}
, id = 201102, lua_script = "MonsterSkill.201102_ShouHZ_Skill", skill_comat = "35/100*power*1"}
, 
[201103] = {id = 201103, lua_script = "MonsterSkill.201103_ShouHZ_DefUp", skill_comat = ""}
, 
[201201] = {id = 201201, lua_script = "MonsterSkill.201201_XZ_XieZJD", skill_comat = "(26+2.25*1)*power/100"}
, 
[201202] = {
effect_id = {10277, 10278, 10279, 10280}
, hit_skill_type = 1, id = 201202, lua_script = "MonsterSkill.201202_XZ_XieZDC", skill_comat = "(32+6.125*1)*power/100"}
, 
[201801] = {effect_id = __rt_40, id = 201801, lua_script = "MonsterSkill.201801_ZYZ_RefactorSummon", skill_comat = "150/100*power*1"}
, 
[201802] = {effect_id = __rt_40, id = 201802, lua_script = "MonsterSkill.201802_ZYZ_RefactorSummon", skill_comat = "150/100*power*1"}
, 
[201803] = {id = 201803, lua_script = "MonsterSkill.201803_Summonxiao", skill_comat = "150/100*power*1"}
, 
[201804] = {id = 201804, lua_script = "MonsterSkill.201804_Summonzhong", skill_comat = "150/100*power*1"}
, 
[201805] = {id = 201805, lua_script = "MonsterSkill.201805_Summonda", skill_comat = "150/100*power*1"}
, 
[201901] = {hit_skill_type = 2, id = 201901, lua_script = "MonsterSkill.201901_BeelneithPassive01", skill_comat = "35/100*power*1"}
, 
[201902] = {id = 201902, lua_script = "MonsterSkill.201902_BeelneithPassive02", skill_comat = "35/100*power*1"}
, 
[201903] = {hit_skill_type = 2, id = 201903, lua_script = "MonsterSkill.201903_BeelneithSkill", skill_comat = "35/100*power*1"}
, 
[201904] = {effect_id = __rt_41, id = 201904, lua_script = "MonsterSkill.201904_BeelneithPassive03", skill_comat = ""}
, 
[201905] = {hit_skill_type = 2, id = 201905, lua_script = "MonsterSkill.201905_BeelneithSkill", skill_comat = "35/100*power*1"}
, 
[201906] = {effect_id = __rt_41, id = 201906, lua_script = "MonsterSkill.201906_BeelneithPassive03", skill_comat = ""}
, 
[202001] = {hit_skill_type = 1, id = 202001, lua_script = "MonsterSkill.202001_GabrielPassive01", skill_comat = "35/100*power*1"}
, 
[202002] = {id = 202002, lua_script = "MonsterSkill.202002_GabrielPassive02", skill_comat = "35/100*power*1"}
, 
[202003] = {effect_id = __rt_42, hit_skill_type = 1, id = 202003, lua_script = "MonsterSkill.202003_GabrielSkill", skill_comat = "35/100*power*1"}
, 
[202004] = {
effect_id = {10758}
, hit_skill_type = 1, id = 202004, lua_script = "MonsterSkill.202004_GabrielSkill2", skill_comat = "35/100*power*1"}
, 
[202005] = {effect_id = __rt_42, hit_skill_type = 1, id = 202005, lua_script = "MonsterSkill.202003_GabrielSkill", skill_comat = "35/100*power*1"}
, 
[202101] = {id = 202101, lua_script = "MonsterSkill.202101_HesperusPassive01", skill_comat = "35/100*power*1"}
, 
[202102] = {id = 202102, lua_script = "MonsterSkill.202102_HesperusPassive02", skill_comat = "35/100*power*1"}
, 
[202103] = {id = 202103, lua_script = "MonsterSkill.202103_HesperusSkill", skill_comat = "35/100*power*1"}
, 
[202201] = {effect_id = __rt_43, id = 202201, lua_script = "MonsterSkill.202201_HopePassive01", skill_comat = "35/100*power*1"}
, 
[202202] = {
effect_id = {10433}
, hit_skill_type = 1, id = 202202, lua_script = "MonsterSkill.202202_HopePassive02", skill_comat = "35/100*power*1"}
, 
[202203] = {effect_id = __rt_43, hit_skill_type = 1, id = 202203, lua_script = "MonsterSkill.202203_HopeSkill", skill_comat = "35/100*power*1"}
, 
[202301] = {
effect_id = {10491}
, id = 202301, lua_script = "MonsterSkill.202301_LovePassive01", skill_comat = "35/100*power*1"}
, 
[202302] = {id = 202302, lua_script = "MonsterSkill.202302_LovePassive02", skill_comat = "35/100*power*1"}
, 
[202303] = {
effect_id = {10492}
, hit_skill_type = 1, id = 202303, lua_script = "MonsterSkill.202303_LoveSkill", skill_comat = "35/100*power*1"}
, 
[202401] = {id = 202401, lua_script = "MonsterSkill.202401_DiligencePassive01", skill_comat = "35/100*power*1"}
, 
[202402] = {
effect_id = {10438, 10439}
, hit_skill_type = 2, id = 202402, lua_script = "MonsterSkill.202402_DiligenceSkill", skill_comat = "35/100*power*1"}
, 
[202501] = {
effect_id = {1}
, id = 202501, lua_script = "MonsterSkill.202501_KindnessPassive", skill_comat = "35/100*power*1"}
, 
[202502] = {id = 202502, lua_script = "MonsterSkill.202502_KindnessSkill", skill_comat = "35/100*power*1"}
, 
[202601] = {hit_skill_type = 3, id = 202601, lua_script = "MonsterSkill.202601_WisdomPassive01", skill_comat = "35/100*power*1"}
, 
[202602] = {
effect_id = {10611}
, id = 202602, lua_script = "MonsterSkill.202602_WisdomPassive02", skill_comat = "35/100*power*1"}
, 
[202603] = {
effect_id = {10447, 10448, 10449, 10450}
, hit_skill_type = 3, id = 202603, lua_script = "MonsterSkill.202603_WisdomSkill", skill_comat = "35/100*power*1"}
, 
[202901] = {
effect_id = {10570}
, id = 202901, lua_script = "MonsterSkill.202901_TwinerSkill", skill_comat = "35/100*power*1"}
, 
[203001] = {
effect_id = {10577}
, id = 203001, lua_script = "MonsterSkill.203001_ImpactorSkill", skill_comat = "35/100*power*1"}
, 
[203101] = {
effect_id = {10594}
, id = 203101, lua_script = "MonsterSkill.203101_Patience_en_Passive", skill_comat = "35/100*power*1"}
, 
[203102] = {
effect_id = {10591}
, hit_skill_type = 1, id = 203102, lua_script = "MonsterSkill.203102_Patience_en_Skill", skill_comat = "35/100*power*1"}
, 
[203201] = {id = 203201, lua_script = "MonsterSkill.203201_Wisdom_en_Passive01", skill_comat = "35/100*power*1"}
, 
[203202] = {id = 203202, lua_script = "MonsterSkill.203202_Wisdom_en_Passive02", skill_comat = "35/100*power*1"}
, 
[203203] = {
effect_id = {10581, 10582, 10583, 10584}
, hit_skill_type = 3, id = 203203, lua_script = "MonsterSkill.203203_Wisdom_en_Skill", skill_comat = "35/100*power*1"}
, 
[203501] = {id = 203501, lua_script = "MonsterSkill.203501_MercyPassive", skill_comat = "35/100*power*1"}
, 
[203502] = {
effect_id = {10771, 10772}
, id = 203502, lua_script = "MonsterSkill.203502_MercySkill", skill_comat = "35/100*power*1"}
, 
[203601] = {hit_skill_type = 1, id = 203601, lua_script = "MonsterSkill.203601_ThrowenPassive", skill_comat = "35/100*power*1"}
, 
[203602] = {
effect_id = {10779, 100307}
, hit_skill_type = 1, id = 203602, lua_script = "MonsterSkill.203602_ThrowenSkill", skill_comat = "35/100*power*1"}
, 
[203603] = {id = 203603, lua_script = "MonsterSkill.203603_Throwen_PowUp", skill_comat = ""}
, 
[204001] = {
effect_id = {10909}
, id = 204001, lua_script = "MonsterSkill.204001_AiniakeSkill", skill_comat = ""}
, 
[300001] = {effect_id = __rt_37, id = 300001, lua_script = "MonsterSkill.300001_Xin_XinDTXX", skill_comat = "(66+6.25*1)*power/100"}
, 
[300002] = {effect_id = __rt_38, id = 300002, lua_script = "MonsterSkill.200502_Xin_ShunSP", skill_comat = "(23+5.625*1)*power/100"}
, 
[300003] = {id = 300003, lua_script = "MonsterSkill.300003_Xin_ChaoJCF", skill_comat = "(44+8.125*1)*power/100"}
, 
[300601] = {effect_id = __rt_30, id = 300601, lua_script = "MonsterSkill.300601_FuwuqiSkill"}
, 
[2004010] = {effect_id = __rt_35, hit_skill_type = 3, id = 2004010, lua_script = "MonsterSkill.2004010_Chong_PTGJ", skill_comat = "(37+11.75*1)*power/100"}
, 
[2004030] = {effect_id = __rt_36, hit_skill_type = 2, id = 2004030, lua_script = "MonsterSkill.2004030_Chong_XZCZ", skill_comat = "(33+16.375*1)*power/100"}
, 
[2019010] = {hit_skill_type = 2, id = 2019010, lua_script = "MonsterSkill.2019010_BeelneithPassive01", skill_comat = "35/100*power*1"}
, 
[2020010] = {hit_skill_type = 1, id = 2020010, lua_script = "MonsterSkill.2020010_GabrielPassive01", skill_comat = "35/100*power*1"}
}
local __default_values = {effect_id = __rt_1, hit_skill_type = 0, id = 1, lua_script = "", skill_comat = "20/180*power*para1"}
local base = {__index = __default_values}
for k,v in (_ENV.pairs)(battle_skill) do
  (_ENV.setmetatable)(v, base)
end
local __rawdata = {__basemetatable = base, 
skill_label_Dic = {
[10005] = {[11] = 1}
, 
[10006] = {[11] = 1}
, 
[10009] = {[11] = 1}
, 
[10013] = {[20] = 1}
, 
[10019] = {[11] = 1}
, 
[10023] = {[11] = 1}
, 
[10061] = {[46] = 1}
, 
[10066] = {[59] = 1}
, 
[10073] = {[3] = 1}
, 
[10076] = {[3] = 1}
, 
[10081] = {[3] = 1}
, 
[10119] = {[8] = 1}
, 
[10120] = {[46] = 1}
, 
[10135] = {[43] = 1}
, 
[10136] = {[24] = 1}
, 
[10142] = {[46] = 1}
, 
[10147] = {[36] = 1}
, 
[10149] = {[36] = 1}
, 
[10152] = {[63] = 1}
, 
[10157] = {[35] = 1}
, 
[10158] = {[46] = 1}
, 
[10167] = {[46] = 1}
, 
[10169] = {[11] = 1}
, 
[10176] = {[6] = 1, [11] = 1}
, 
[10179] = {[6] = 1}
, 
[10187] = {[16] = 1}
, 
[10190] = {[7] = 1, [36] = 1}
, 
[10191] = {[7] = 1}
, 
[10193] = {[11] = 1}
, 
[10194] = {[7] = 1}
, 
[10195] = {[7] = 1}
, 
[10200] = {[17] = 1}
, 
[10204] = {[24] = 1}
, 
[10206] = {1}
, 
[10207] = {1}
, 
[10208] = {1}
, 
[10209] = {[49] = 1}
, 
[10210] = {[49] = 1}
, 
[10212] = {[8] = 1}
, 
[10213] = {[8] = 1}
, 
[10218] = {[24] = 1}
, 
[10220] = {[35] = 1}
, 
[10221] = {1}
, 
[10222] = {1; [36] = 1}
, 
[10228] = {[36] = 1, [43] = 1}
, 
[10230] = {[43] = 1}
, 
[10234] = {[31] = 1}
, 
[10235] = {[31] = 1}
, 
[10240] = {[46] = 1}
, 
[10244] = {[36] = 1}
, 
[10247] = {[46] = 1}
, 
[10248] = {[31] = 1}
, 
[10249] = {[31] = 1}
, 
[10250] = {[31] = 1}
, 
[10251] = {[24] = 1}
, 
[10254] = {[63] = 1}
, 
[10264] = {[32] = 1}
, 
[10266] = {[59] = 1}
, 
[10267] = {[59] = 1}
, 
[10269] = {[59] = 1}
, 
[10275] = {[24] = 1}
, 
[10276] = {[24] = 1}
, 
[10277] = {[24] = 1}
, 
[10278] = {[24] = 1}
, 
[10287] = {[35] = 1}
, 
[10289] = {[49] = 1}
, 
[10291] = {[63] = 1}
, 
[10295] = {[3] = 1}
, 
[20020] = {[3] = 1}
, 
[30004] = {[24] = 1}
, 
[30005] = {[24] = 1}
, 
[30012] = {[36] = 1, [43] = 1}
, 
[30024] = {[59] = 1}
, 
[30025] = {[59] = 1}
, 
[30026] = {[60] = 1}
, 
[30027] = {[60] = 1}
, 
[30028] = {[24] = 1}
, 
[30029] = {[24] = 1}
, 
[30035] = {[49] = 1}
, 
[30041] = {[63] = 1}
, 
[60002] = {[11] = 1, [17] = 1}
, 
[100201] = {[11] = 1, [17] = 1}
, 
[100202] = {[17] = 1, [36] = 1}
, 
[100203] = {[11] = 1, [17] = 1}
, 
[100302] = {[19] = 1}
, 
[100303] = {[19] = 1, [46] = 1}
, 
[100401] = {[4] = 1}
, 
[100403] = {[4] = 1}
, 
[100501] = {[20] = 1}
, 
[100502] = {[20] = 1, [24] = 1, [41] = 1}
, 
[100503] = {[61] = 1}
, 
[100601] = {[4] = 1}
, 
[100602] = {[19] = 1}
, 
[100702] = {[11] = 1, [16] = 1}
, 
[100703] = {[59] = 1}
, 
[100801] = {[21] = 1}
, 
[100802] = {[41] = 1}
, 
[100803] = {[21] = 1}
, 
[100902] = {[5] = 1}
, 
[101001] = {[11] = 1, [16] = 1}
, 
[101002] = {[11] = 1}
, 
[101102] = {[12] = 1, [41] = 1}
, 
[101103] = {[62] = 1}
, 
[101201] = {[46] = 1}
, 
[101202] = {[11] = 1}
, 
[101302] = {[2] = 1, [41] = 1}
, 
[101303] = {1}
, 
[101502] = {[41] = 1}
, 
[101602] = {[42] = 1}
, 
[101801] = {[13] = 1}
, 
[101802] = {[44] = 1}
, 
[101902] = {[11] = 1}
, 
[102002] = {[64] = 1}
, 
[102003] = {[14] = 1}
, 
[102102] = {[41] = 1}
, 
[102301] = {[24] = 1}
, 
[102302] = {[24] = 1}
, 
[102402] = {[41] = 1}
, 
[102502] = {[41] = 1}
, 
[102602] = {[41] = 1}
, 
[102702] = {[24] = 1}
, 
[102801] = {[45] = 1, [48] = 1}
, 
[102901] = {[5] = 1}
, 
[102902] = {[5] = 1}
, 
[102903] = {[5] = 1, [20] = 1}
, 
[103002] = {[24] = 1}
, 
[103003] = {[24] = 1}
, 
[103103] = {[4] = 1}
, 
[103302] = {[41] = 1}
, 
[103303] = {[64] = 1}
, 
[103402] = {[41] = 1}
, 
[103501] = {[25] = 1}
, 
[103502] = {[34] = 1}
, 
[103702] = {[46] = 1}
, 
[103703] = {[11] = 1}
, 
[103801] = {1}
, 
[103802] = {1}
, 
[103803] = {1}
, 
[103901] = {[11] = 1}
, 
[103902] = {[11] = 1, [16] = 1, [41] = 1}
, 
[104002] = {[41] = 1}
, 
[200403] = {[11] = 1}
, 
[200901] = {[15] = 1}
, 
[200902] = {[29] = 1}
, 
[200903] = {[15] = 1}
, 
[201001] = {[52] = 1}
, 
[201002] = {[29] = 1}
, 
[201003] = {[52] = 1}
, 
[201201] = {[26] = 1}
, 
[201202] = {[26] = 1}
, 
[201901] = {[27] = 1}
, 
[201902] = {[27] = 1, [28] = 1}
, 
[201903] = {[27] = 1}
, 
[201905] = {[27] = 1}
, 
[202002] = {[51] = 1}
, 
[202003] = {[51] = 1}
, 
[202005] = {[51] = 1}
, 
[202103] = {[2] = 1}
, 
[202502] = {[53] = 1}
, 
[202901] = {[17] = 1}
, 
[203602] = {[36] = 1}
, 
[300601] = {[11] = 1, [17] = 1}
, 
[2004030] = {[11] = 1}
, 
[2019010] = {[27] = 1}
}
, 
skill_label_List = {
[10005] = {11}
, 
[10006] = {11}
, 
[10009] = {11}
, 
[10013] = {20}
, 
[10019] = {11}
, 
[10023] = {11}
, 
[10061] = {46}
, 
[10066] = {59}
, 
[10073] = {3}
, 
[10076] = {3}
, 
[10081] = {3}
, 
[10119] = {8}
, 
[10120] = {46}
, 
[10135] = {43}
, 
[10136] = {24}
, 
[10142] = {46}
, 
[10147] = {36}
, 
[10149] = {36}
, 
[10152] = {63}
, 
[10157] = {35}
, 
[10158] = {46}
, 
[10167] = {46}
, 
[10169] = {11}
, 
[10176] = {6, 11}
, 
[10179] = {6}
, 
[10187] = {16}
, 
[10190] = {7, 36}
, 
[10191] = {7}
, 
[10193] = {11}
, 
[10194] = {7}
, 
[10195] = {7}
, 
[10200] = {17}
, 
[10204] = {24}
, 
[10206] = {1}
, 
[10207] = {1}
, 
[10208] = {1}
, 
[10209] = {49}
, 
[10210] = {49}
, 
[10212] = {8}
, 
[10213] = {8}
, 
[10218] = {24}
, 
[10220] = {35}
, 
[10221] = {1}
, 
[10222] = {1, 36}
, 
[10228] = {43, 36}
, 
[10230] = {43}
, 
[10234] = {31}
, 
[10235] = {31}
, 
[10240] = {46}
, 
[10244] = {36}
, 
[10247] = {46}
, 
[10248] = {31}
, 
[10249] = {31}
, 
[10250] = {31}
, 
[10251] = {24}
, 
[10254] = {63}
, 
[10264] = {32}
, 
[10266] = {59}
, 
[10267] = {59}
, 
[10269] = {59}
, 
[10275] = {24}
, 
[10276] = {24}
, 
[10277] = {24}
, 
[10278] = {24}
, 
[10287] = {35}
, 
[10289] = {49}
, 
[10291] = {63}
, 
[10295] = {3}
, 
[20020] = {3}
, 
[30004] = {24}
, 
[30005] = {24}
, 
[30012] = {43, 36}
, 
[30024] = {59}
, 
[30025] = {59}
, 
[30026] = {60}
, 
[30027] = {60}
, 
[30028] = {24}
, 
[30029] = {24}
, 
[30035] = {49}
, 
[30041] = {63}
, 
[60002] = {17, 11}
, 
[100201] = {17, 11}
, 
[100202] = {17, 36}
, 
[100203] = {17, 11}
, 
[100302] = {19}
, 
[100303] = {19, 46}
, 
[100401] = {4}
, 
[100403] = {4}
, 
[100501] = {20}
, 
[100502] = {41, 24, 20}
, 
[100503] = {61}
, 
[100601] = {4}
, 
[100602] = {19}
, 
[100702] = {16, 11}
, 
[100703] = {59}
, 
[100801] = {21}
, 
[100802] = {41}
, 
[100803] = {21}
, 
[100902] = {5}
, 
[101001] = {16, 11}
, 
[101002] = {11}
, 
[101102] = {41, 12}
, 
[101103] = {62}
, 
[101201] = {46}
, 
[101202] = {11}
, 
[101302] = {41, 2}
, 
[101303] = {1}
, 
[101502] = {41}
, 
[101602] = {42}
, 
[101801] = {13}
, 
[101802] = {44}
, 
[101902] = {11}
, 
[102002] = {64}
, 
[102003] = {14}
, 
[102102] = {41}
, 
[102301] = {24}
, 
[102302] = {24}
, 
[102402] = {41}
, 
[102502] = {41}
, 
[102602] = {41}
, 
[102702] = {24}
, 
[102801] = {48, 45}
, 
[102901] = {5}
, 
[102902] = {5}
, 
[102903] = {5, 20}
, 
[103002] = {24}
, 
[103003] = {24}
, 
[103103] = {4}
, 
[103302] = {41}
, 
[103303] = {64}
, 
[103402] = {41}
, 
[103501] = {25}
, 
[103502] = {34}
, 
[103702] = {46}
, 
[103703] = {11}
, 
[103801] = {1}
, 
[103802] = {1}
, 
[103803] = {1}
, 
[103901] = {11}
, 
[103902] = {41, 16, 11}
, 
[104002] = {41}
, 
[200403] = {11}
, 
[200901] = {15}
, 
[200902] = {29}
, 
[200903] = {15}
, 
[201001] = {52}
, 
[201002] = {29}
, 
[201003] = {52}
, 
[201201] = {26}
, 
[201202] = {26}
, 
[201901] = {27}
, 
[201902] = {27, 28}
, 
[201903] = {27}
, 
[201905] = {27}
, 
[202002] = {51}
, 
[202003] = {51}
, 
[202005] = {51}
, 
[202103] = {2}
, 
[202502] = {53}
, 
[202901] = {17}
, 
[203602] = {36}
, 
[300601] = {17, 11}
, 
[2004030] = {11}
, 
[2019010] = {27}
}
}
;
(_ENV.setmetatable)(battle_skill, {__index = __rawdata})
return battle_skill


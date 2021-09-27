eSkillTriggerType = {AfterBattleStart = 1, SetHurt = 2, SetDeadHurt = 3, AfterHurt = 4, SetHeal = 5, AfterHeal = 6, BeforeAddBuff = 7, AfterAddBuff = 8, BeforeBuffDispel = 9, BuffDie = 10, AfterBuffRemove = 11, AfterBuffAddHitMaxTier = 12, RoleDie = 13, BeforePlaySkill = 14, AfterPlaySkill = 15, BeforeTargetSelect = 16, HurtResultStart = 17, HurtResultEnd = 18, HealResultStart = 19, HealResultEnd = 20, OnBreakSkill = 21, BeforeBattleEnd = 22, OnBattleEnd = 23, OnBreakShield = 24, OnAfterShieldHurt = 25, OnPlayerMpCostToTargetValue = 26, AfterSelfUltEffectEnd = 27, AfterSelfUltInTimeLineEnd = 28, AfterSelfUltOutTimeLineEnd = 29, AfterSelfUltSpecTimeLineEnd = 30, AfterSelfUltMovieEnd = 31, OnSelfUltMovieFadeOut = 32, StartSelfUltRoleAction = 33, OnSelfAttrChanged = 34, OnSelfAfterMove = 35, OnGridCreatedInBattle = 36, OnCallNextWaveTowerMonster = 37}
eTriggerSkillType = {None = 0, GridSkill = 1, RoleSkill = 2}
eSkillLuaTrigger = {OnDoodad = 1, OnChipSuitInvoke = 2}
eBattleEffectEvent = {Create = 0, Trigger = 1, Arrive = 2, Die = 3}
eBuffFeatureType = {NotMove = 1, Invinciable = 2, Silent = 3, Bewitch = 4, NotBeSelected = 5, NoDeath = 6, Stun = 7, Taunt = 8, CustomRepeated = 9, StopSkillCD = 10, StopCommonAttackCD = 11, KnockOff = 12, BeatBack = 13, Bleed = 14, CtrlImmunity = 15, Exiled = 16, AbadonDebuff = 17, HealRepeated = 18, AttackRealDmg = 19, DoubleAttack = 20, SplitShoot = 21, NotBeSelectedExceptSameBlong = 22, FocusOnFiring = 23, Rotate = 24, AbandonMove = 25, AbandonUltSkill = 26, DisActiveCollider = 27}
eBattleRoleBelong = {neutral = 0, player = 1, enemy = 2}
eMonsterCamp = {ePurger = 1, eEntropy = 2}
eBattleRoleType = {character = 1, skillCaster = 2, hideSummoner = 3, realSummoner = 4}
eBuffRemoveType = {Timeout = 1, Dispel = 2, Conflict = 3}
eBuffLifeEvent = {NewAdd = 1, OverlayAdd = 2, Overlay = 3, Remove = 4}
eBuffType = {Beneficial = 1, Debeneficial = 2}
eHeroAttrType = {Origin = 1, Base = 2, Ratio = 3, Extra = 4}
eHeroAttr = {hp = 1, maxHp = 2, pow = 3, def = 4, speed = 5, hit = 6, dodge = 7, moveSpeed = 8, crit = 9, critDamage = 10, lucky = 11, sunder = 12, true_damage = 13, resistance = 14, battleEnd_hp_regen = 15, attackRange = 16, life_steal = 17, spell_life_steal = 18, damage_increase = 19, injury_reduce = 20, heal = 21, treatment = 22, cd_reduce = 23, return_damage = 24, hp_regen = 25, skill_intensity = 26, magic_res = 27, magic_pen = 28, max_property_count = 28}
eHeroAttrPercent = 1000
eColliderInfluenceType = {None = 0, Enemy = 2, Player = 4, Neutral = 8, Skill = 16, All = 32}
eCamShakeLevel = {Light = 1, Strong = 2}
generalHurtConfig = {hit_formula = 9991, def_formula = 9996, basehurt_formula = 9993, minhurt_formula = 9994, crit_formula = 9992, crithur_ratio = 9995, correct_formula = 9989, lifesteal_formula = 1001, spell_lifesteal_formula = 1002, returndamage_formula = 1000, hurt_type = -1}
metaGeneralHurtConfig = {__index = generalHurtConfig}
generalHealConfig = {baseheal_formula = 0, heal_number = 0, crit_formula = 0, crithur_ratio = 0, correct_formula = 9990}
realDamageConfig = {hit_formula = 0, def_formula = 0, basehurt_formula = 9993, minhurt_formula = 9994, crit_formula = 0, crithur_ratio = 0, correct_formula = 9989, lifesteal_formula = 1001, spell_lifesteal_formula = 1002, returndamage_formula = 1000, hurt_type = 2}
metaRealDamageConfig = {__index = realDamageConfig}
eSkillCv = {UltSkill = 107}
eShieldType = {Normal = 0, LongRange = 1, NoRange = 2, Beelneith = 3}
eHitAuRecordHint = "hit_target_type"
eHitAuRoleType = {None = 0, Body = 1, Heavy = 2, Shield = 3}
eEffectGridType = {None = 0, positive = 1, negative = 2}
eSkillTag = {commonAttack = 0, normalSkill = 1, passiveSkill = 2, ultSkill = 3}
eHurtType = {None = -1, PhysicsDmg = 0, MagicDmg = 1, RealDmg = 2}
eBattleSkillLogicType = {Original = 0, Chip = 1, BattleBuff = 2, TempChip = 3, AthSuit = 4, ChipConsume = 5}
eSkillResultShapeType = {Target = 0, AllRole = 1, Block = 2, CellDist = 3}


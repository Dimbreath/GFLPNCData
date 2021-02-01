-- params : ...
-- function num : 0 , upvalues : _ENV
eSkillTriggerType = {AfterBattleStart = 1, SetHurt = 2, AfterHurt = 3, SetHeal = 4, AfterHeal = 5, BeforeAddBuff = 6, AfterAddBuff = 7, BeforeBuffDispel = 8, BuffDie = 9, RoleDie = 10, BeforePlaySkill = 11, AfterPlaySkill = 12, BeforeTargetSelect = 13, HurtResultStart = 14, HurtResultEnd = 15, HealResultStart = 16, HealResultEnd = 17, OnBreakSkill = 18, BeforeBattleEnd = 19, OnBattleEnd = 20, AfterSelfUltEffectEnd = 21, AfterSelfUltInTimeLineEnd = 22, AfterSelfUltOutTimeLineEnd = 23, AfterSelfUltMovieEnd = 24, OnSelfUltMovieFadeOut = 25, StartSelfUltRoleAction = 26, OnSelfAttrChanged = 27, OnSelfAfterMove = 28, OnGridCreatedInBattle = 29}
eSkillLuaTrigger = {OnDoodad = 1, OnSheldBroken = 2}
eBattleEffectEvent = {Create = 0, Trigger = 1, Arrive = 2, Die = 3}
eBuffFeatureType = {NotMove = 1, Invinciable = 2, Silent = 3, Bewitch = 4, NotBeSelected = 5, NoDeath = 6, Stun = 7, Taunt = 8, CustomRepeated = 9, StopSkillCD = 10, StopCommonAttackCD = 11, KnockOff = 12, BeatBack = 13, Bleed = 14, CtrlImmunity = 15, Exiled = 16}
eBattleRoleBelong = {neutral = 0, player = 1, enemy = 2}
eMonsterCamp = {ePurger = 1, eEntropy = 2}
eBattleRoleType = {character = 1, skillCaster = 2, hideSummoner = 3, realSummoner = 4}
eBuffRemoveType = {Timeout = 1, Dispel = 2, Conflict = 3}
eBuffLifeEvent = {NewAdd = 1, OverlayAdd = 2, Overlay = 3, Remove = 4}
eHeroAttrType = {Origin = 1, Base = 2, Ratio = 3, Extra = 4}
eHeroAttr = {hp = 1, maxHp = 2, pow = 3, def = 4, speed = 5, hit = 6, dodge = 7, moveSpeed = 8, crit = 9, critDamage = 10, lucky = 11, sunder = 12, true_damage = 13, resistance = 14, battleEnd_hp_regen = 15, attackRange = 16, life_steal = 17, spell_life_steal = 18, damage_increase = 19, injury_reduce = 20, heal = 21, treatment = 22, cd_reduce = 23, return_damage = 24, hp_regen = 25, skill_intensity = 26}
eHeroAttrPercent = 1000
eColliderInfluenceType = {None = 0, Enemy = 2, Player = 4, Neutral = 8, Skill = 16, All = 32}
eCamShakeLevel = {Light = 1, Strong = 2}
generalHurtConfig = {hit_formula = 9991, def_formula = 9996, basehurt_formula = 9993, minhurt_formula = 9994, crit_formula = 9992, crithur_ratio = 9995, correct_formula = 9989, lifesteal_formula = 1001, spell_lifesteal_formula = 1002, returndamage_formula = 1000}
generalHealConfig = {baseheal_formula = 0, heal_number = 0, crit_formula = 0, crithur_ratio = 0, correct_formula = 9990}
realDamageConfig = {hit_formula = 0, def_formula = 0, basehurt_formula = 9993, minhurt_formula = 9994, crit_formula = 0, crithur_ratio = 0, correct_formula = 9989, lifesteal_formula = 1001, spell_lifesteal_formula = 1002, returndamage_formula = 1000, isRealDmg = true}
eSkillCv = {UltSkill = 107}


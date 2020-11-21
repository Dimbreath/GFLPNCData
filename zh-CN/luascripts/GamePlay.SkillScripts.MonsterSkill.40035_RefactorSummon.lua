-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40035 = class("bs_40035", LuaSkillBase)
local base = LuaSkillBase
bs_40035.config = {
    smallMonsterId = {3, 4, 5},
    middleMonsterId = {6, 7, 8},
    bigMonsterId = {9, 10},
    buffId = 1033,
    effectId = 10264,
    effectId1 = 10263,
    startAnimID = 1002
}
bs_40035.ctor = function(self)
    -- function num : 0_0
end

bs_40035.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_40035_1", 1,
                    self.OnAfterBattleStart)
end

bs_40035.OnAfterBattleStart = function(self)
    -- function num : 0_2 , upvalues : _ENV
    self.damTimer = LuaSkillCtrl:StartTimer(nil, (self.arglist)[1],
                                            self.CallBack, self, -1,
                                            (self.arglist)[1])
    LuaSkillCtrl:CallBuff(self, self.caster, 1033, 1, 1000000) -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.caster).recordTable)["40035_SummonTime"] = 0
end

bs_40035.CallBack = function(self)
    -- function num : 0_3 , upvalues : _ENV
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
    if targetList.Count < 8 then
        local gridData = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
        if gridData == nil then return end
        self:CallCasterWait(18)
        local moveAttackTrigger = BindCallback(self, self.OnMoveAttackTrigger,
                                               self.caster, data, gridData)
        LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster,
                                               (self.config).startAnimID, 1, 18,
                                               moveAttackTrigger)
    end
end

bs_40035.OnMoveAttackTrigger = function(self, target, data, gridData)
    -- function num : 0_4 , upvalues : _ENV
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
    local cback = BindCallback(self, self.CallBack1, gridData.x, gridData.y)
    self.damTimer = LuaSkillCtrl:StartTimer(nil, 2, cback, nil, 0, 0)
end

bs_40035.CallBack1 = function(self, x, y)
    -- function num : 0_5 , upvalues : _ENV
    local target = LuaSkillCtrl:GetTargetWithGrid(x, y)
    LuaSkillCtrl:CallEffect(target, (self.config).effectId, self)
    if ((self.caster).recordTable)["40035_SummonTime"] < 10 then
        local summoner = LuaSkillCtrl:CreateSummoner(self,
                                                     ((self.config).smallMonsterId)[(math.random)(
                                                         1, 3)], x, y)
        summoner:SetAttr(eHeroAttr.maxHp, (self.caster).maxHp * 200 // 1000)
        summoner:SetAttr(eHeroAttr.pow, (self.caster).pow * 500 // 1000)
        summoner:SetAttr(eHeroAttr.speed, (self.caster).speed)
        summoner:SetAsRealEntity(true)
        local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    else
        do
            local summoner = LuaSkillCtrl:CreateSummoner(self,
                                                         ((self.config).middleMonsterId)[(math.random)(
                                                             1, 3)], x, y)
            summoner:SetAttr(eHeroAttr.maxHp, (self.caster).maxHp * 300 // 1000)
            summoner:SetAttr(eHeroAttr.pow, (self.caster).pow * 600 // 1000)
            summoner:SetAttr(eHeroAttr.speed, (self.caster).speed)
            summoner:SetAsRealEntity(true)
            do
                local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
                local damage = (self.caster).maxHp * (self.arglist)[2] // 1000
                LuaSkillCtrl:RemoveLife(damage, self, self.caster) -- DECOMPILER ERROR at PC122: Confused about usage of register: R5 in 'UnsetPending'
                ;
                ((self.caster).recordTable)["40035_SummonTime"] =
                    ((self.caster).recordTable)["40035_SummonTime"] + 1
            end
        end
    end
end

bs_40035.OnCasterDie = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnCasterDie)(self)
    if self.damTimer then
        (self.damTimer):Stop()
        self.damTimer = nil
    end
end

return bs_40035


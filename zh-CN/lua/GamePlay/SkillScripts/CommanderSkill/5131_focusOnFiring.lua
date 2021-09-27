local bs_5131 = class("bs_5131", LuaSkillBase)
local base = LuaSkillBase
bs_5131.config = {buffId = 513101, buffId_range = 513202, buffId_ex = 513201, effectId_line = 513102, effectId_target = 513101, selectTargetId = 2}
bs_5131.AbandonTakeFeature = {eBuffFeatureType.BeatBack}
bs_5131.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeTargetSelect, "bs_5131_1", 1, self.BeforeSelect)
  self:AddAfterBuffRemoveTrigger("bs_5131_4", 1, self.OnAfterBuffRemove, nil, nil, (self.config).buffId_ex)
  self:AddSetDeadHurtTrigger("bs_5132_2", 1, self.OnSetDeadHurt, nil, nil, nil, eBattleRoleBelong.enemy)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_5131_3", 1, self.BeforeBattleEnd)
  self.onFireRole = nil
end

bs_5131.BeforeSelect = function(self, cskill, sender, context)
  -- function num : 0_1
  if sender == self.caster and cskill == self.cskill and context.Id ~= (self.config).selectTargetId then
    self:ChangeNeutralBelong()
  end
end

bs_5131.ChangeNeutralBelong = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local readyType = ((CS.BattleFloorTile).BattleGridEfcType).ready
  if LuaSkillCtrl.IsInVerify then
    return 
  end
  local skillInputCtrl = ((LuaSkillCtrl.battleCtrl).PlayerController).battleSkillInputController
  if skillInputCtrl == nil then
    return 
  end
  local tileCtrl = skillInputCtrl.tileController
  if tileCtrl == nil then
    return 
  end
  local neutrals = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.neutral)
  if neutrals == nil or neutrals.Count <= 0 then
    return 
  end
  for i = 0, neutrals.Count - 1 do
    local neutralRole = neutrals[i]
    if not neutralRole.unableSelect and neutralRole.belongNum ~= eBattleRoleBelong.enemy then
      local tile = tileCtrl:GetFloorTile(neutralRole.curCoord)
      if tile ~= nil then
        tile:HighlightSelectEfc(readyType)
        skillInputCtrl:ShowRoleSelectUI(tile.Coord, readyType)
        ;
        (skillInputCtrl.waitSelectedRoleTiles):Add(tile)
        ;
        (skillInputCtrl.waitSelectRoles):Add(neutralRole)
        if not (skillInputCtrl.waitSelectRoleDict):ContainsKey(neutralRole) then
          (skillInputCtrl.waitSelectRoleDict):Add(neutralRole, tile)
        end
      end
    end
  end
end

bs_5131.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_3 , upvalues : _ENV
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

bs_5131.CallSelectExecute = function(self, role)
  -- function num : 0_4 , upvalues : _ENV
  if role == nil or role.hp <= 0 then
    return 
  end
  local targets = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectTargetId, 10)
  if targets == nil or targets.Count <= 0 then
    return 
  end
  LuaSkillCtrl:CallBuff(self, role, (self.config).buffId_ex, 1, (self.arglist)[1], true)
  for i = 0, targets.Count - 1 do
    local playerRole = (targets[i]).targetRole
    LuaSkillCtrl:CallEffect(role, (self.config).effectId_line, self, nil, playerRole)
    LuaSkillCtrl:CallBuff(self, playerRole, (self.config).buffId, 1, (self.arglist)[1], false, role)
    if playerRole.attackRange > 1 then
      LuaSkillCtrl:CallBuff(self, playerRole, (self.config).buffId_range, 1, (self.arglist)[1])
    end
  end
  self:RecoverRoleBelong()
  if role.belongNum == eBattleRoleBelong.neutral then
    local skillCollisionCtrl = (LuaSkillCtrl.battleCtrl).skillCollisionController
    if skillCollisionCtrl ~= nil then
      skillCollisionCtrl:RemoveCollider(role.collider, role.belong)
      ;
      (role.collider):Dispose()
      role.collider = nil
    end
    role._thisBelong = (CS.Belong).enemy
    self.onFireRole = role
  end
end

bs_5131.OnAfterBuffRemove = function(self, buffId, target, removeType)
  -- function num : 0_5
  self:RecoverRoleBelong()
end

bs_5131.OnSetDeadHurt = function(self, context)
  -- function num : 0_6
  if context.target == self.onFireRole then
    self:RecoverRoleBelong()
  end
end

bs_5131.BeforeBattleEnd = function(self)
  -- function num : 0_7
  self:RecoverRoleBelong()
end

bs_5131.LuaDispose = function(self)
  -- function num : 0_8 , upvalues : base
  (base.LuaDispose)(self)
  self:RecoverRoleBelong()
end

bs_5131.RecoverRoleBelong = function(self)
  -- function num : 0_9 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  if self.onFireRole ~= nil then
    (self.onFireRole)._thisBelong = (CS.Belong).neutral
    ;
    (self.onFireRole):InitSkillCollider()
    self.onFireRole = nil
  end
end

return bs_5131


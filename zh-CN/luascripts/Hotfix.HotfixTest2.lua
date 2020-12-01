-- params : ...
-- function num : 0 , upvalues : _ENV
local HotfixCameraCtrl = class("HotfixCameraController", HotfixBase)
local CameraController = CS.CameraController
local util = require("XLua.Common.xlua_util")
;
(xlua.private_accessible)(CS.CameraController)
local PlaySettlementCut = function(self, battleController, mvpRole)
  -- function num : 0_0 , upvalues : _ENV
  local m_playerTeam = battleController.PlayerTeamController
  local m_enemyTeam = battleController.EnemyTeamController
  local deadRole = (battleController.EnemyTeamController):GetBattleRole()
  local posDeadRole = ((battleController:GetGridData(deadRole.curCoord)).fixLogicPosition):ToVector3() + (Vector3.New)(0, 0.5, 0)
  local posMVPRole = ((mvpRole.lsObject).transform).position + self.m_mvpViewOffset
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self.m_dollyTrackViewEnd).position = posDeadRole
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self.m_dollyTrackViewMVP).position = posMVPRole
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self.m_dollyTrackViewMVP).rotation = ((mvpRole.lsObject).transform).rotation * (((CS.UnityEngine).Quaternion).AngleAxis)(-self.m_mvpViewAngleOffset, Vector3.up)
  m_playerTeam:SetAliceHeroUIInfo(false)
  ;
  (self.m_settlementDirector):Play()
  self.m_cameraCulling = true
  self:StartCoroutine(self:StarCharactersCulling(mvpRole, m_playerTeam.battleRoleList, m_enemyTeam.deadbattleCharacterList, (battleController.PropDropController).propsList, 3))
  warn("HOTFIX TEST:PlaySettlementCut")
end

local StarCharactersCulling = function(self, mvpRole, listBattleRole, listBattleEnemy, dropedItems, setDistance)
  -- function num : 0_1 , upvalues : _ENV, util
  warn("HOTFIX TEST:StarCharactersCulling")
  return (util.cs_generator)(function()
    -- function num : 0_1_0 , upvalues : self, _ENV, mvpRole, listBattleRole, listBattleEnemy, dropedItems, setDistance
    while self.m_cameraCulling do
      (coroutine.yield)(nil)
      self:CharactersCullingByViewPos(mvpRole, listBattleRole, listBattleEnemy, dropedItems, setDistance, 1.8, 1)
    end
  end
)
end

HotfixCameraCtrl.Register = function(self)
  -- function num : 0_2 , upvalues : CameraController, PlaySettlementCut, StarCharactersCulling
  self:RegisterHotfix(CameraController, "PlaySettlementCut", PlaySettlementCut)
  self:RegisterHotfix(CameraController, "StarCharactersCulling", StarCharactersCulling)
end

return HotfixCameraCtrl

-- params : ...
-- function num : 0 , upvalues : _ENV
local HotfixCameraCtrl = class("HotfixCameraController", HotfixBase)
local CameraController = CS.CameraController
local util = require("XLua.Common.xlua_util");
(xlua.private_accessible)(CS.CameraController)
local PlaySettlementCut = function(self, battleController, mvpRole)
    -- function num : 0_0 , upvalues : _ENV
    local m_playerTeam = battleController.PlayerTeamController
    local m_enemyTeam = battleController.EnemyTeamController
    local deadRole = (battleController.EnemyTeamController):GetBattleRole()
    local posDeadRole =
        ((battleController:GetGridData(deadRole.curCoord)).fixLogicPosition):ToVector3() +
            (Vector3.New)(0, 0.5, 0)
    local posMVPRole = ((mvpRole.lsObject).transform).position +
                           self.m_mvpViewOffset -- DECOMPILER ERROR at PC24: Confused about usage of register: R8 in 'UnsetPending'
    ;
    (self.m_dollyTrackViewEnd).position = posDeadRole -- DECOMPILER ERROR at PC26: Confused about usage of register: R8 in 'UnsetPending'
    ;
    (self.m_dollyTrackViewMVP).position = posMVPRole -- DECOMPILER ERROR at PC41: Confused about usage of register: R8 in 'UnsetPending'
    ;
    (self.m_dollyTrackViewMVP).rotation =
        ((mvpRole.lsObject).transform).rotation *
            (((CS.UnityEngine).Quaternion).AngleAxis)(
                -self.m_mvpViewAngleOffset, Vector3.up)
    m_playerTeam:SetAliceHeroUIInfo(false);
    (self.m_settlementDirector):Play()
    self.m_cameraCulling = true
    self:StartCoroutine(self:StarCharactersCulling(mvpRole,
                                                   m_playerTeam.battleRoleList,
                                                   m_enemyTeam.deadbattleCharacterList,
                                                   (battleController.PropDropController).propsList,
                                                   3))
    warn("HOTFIX TEST:PlaySettlementCut")
end

local StarCharactersCulling = function(self, mvpRole, listBattleRole,
                                       listBattleEnemy, dropedItems, setDistance)
    -- function num : 0_1 , upvalues : _ENV, util
    warn("HOTFIX TEST:StarCharactersCulling")
    return (util.cs_generator)(function()
        -- function num : 0_1_0 , upvalues : self, _ENV, mvpRole, listBattleRole, listBattleEnemy, dropedItems, setDistance
        while self.m_cameraCulling do
            (coroutine.yield)(nil)
            self:CharactersCullingByViewPos(mvpRole, listBattleRole,
                                            listBattleEnemy, dropedItems,
                                            setDistance, 1.8, 1)
        end
    end)
end

HotfixCameraCtrl.Register = function(self)
    -- function num : 0_2 , upvalues : CameraController, PlaySettlementCut, StarCharactersCulling
    self:RegisterHotfix(CameraController, "PlaySettlementCut", PlaySettlementCut)
    self:RegisterHotfix(CameraController, "StarCharactersCulling",
                        StarCharactersCulling)
end

return HotfixCameraCtrl


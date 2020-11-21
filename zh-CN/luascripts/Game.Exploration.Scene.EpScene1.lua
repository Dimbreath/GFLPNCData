-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Game.Exploration.Scene.EpSceneA")
local EpScene1 = class("EpSceneA", base)
local CS_CameraController = CS.CameraController
EpScene1.OnSceneLoadCompleted = function(self, onSceneLoadCompletedGeneral)
    -- function num : 0_0 , upvalues : base, _ENV, CS_CameraController
    (base.OnSceneLoadCompleted)(self, onSceneLoadCompletedGeneral)
    self.__ambienceAuBack = AudioManager:PlayAudioById(2000);
    (CS_CameraController.Instance):SetCamHeightChangeFunc(
        BindCallback(self, self.__OnCamHeightChange))
    self.__onBattleEnter = BindCallback(self, self.OnBattleEnter)
    MsgCenter:AddListener(eMsgEventId.OnEnterBattle, self.__onBattleEnter)
    self.__onBattleExit = BindCallback(self, self.OnBattleExit)
    MsgCenter:AddListener(eMsgEventId.OnExitBattle, self.__onBattleExit)
end

EpScene1.__OnCamHeightChange = function(self, heightRatio)
    -- function num : 0_1 , upvalues : _ENV
    AudioManager:SetSourceAisacControl(eAudioSourceType.SfxSource,
                                       "AisacControl_DistanceOfCameraLens",
                                       heightRatio)
end

EpScene1.OnBattleEnter = function(self)
    -- function num : 0_2 , upvalues : _ENV
    AudioManager:SetSourceAisacControl(eAudioSourceType.SfxSource,
                                       "AisacControl_IsInCombat", 1)
end

EpScene1.OnBattleExit = function(self)
    -- function num : 0_3 , upvalues : _ENV
    AudioManager:SetSourceAisacControl(eAudioSourceType.SfxSource,
                                       "AisacControl_IsInCombat", 0)
end

EpScene1.OnDelete = function(self)
    -- function num : 0_4 , upvalues : _ENV, CS_CameraController, base
    if self.__ambienceAuBack ~= nil then
        AudioManager:StopAudioByBack(self.__ambienceAuBack)
        self.__ambienceAuBack = nil
    end
    (CS_CameraController.Instance):SetCamHeightChangeFunc(nil)
    MsgCenter:RemoveListener(eMsgEventId.OnEnterBattle, self.__onBattleEnter)
    MsgCenter:RemoveListener(eMsgEventId.OnExitBattle, self.__onBattleExit);
    (base.OnDelete)(self)
end

return EpScene1


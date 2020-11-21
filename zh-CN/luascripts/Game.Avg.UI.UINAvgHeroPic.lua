-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAvgHeroPic = class("UINAvgHeroPic")
local eAvgImgPosType = require("Game.Avg.Enum.eAvgImgPosType")
local AvgImgTweenUntil = require("Game.Avg.AvgImgTweenUntil")
local CS_ResLoader = CS.ResLoader
local CS_DOTweenAnimation = ((CS.DG).Tweening).DOTweenAnimation
UINAvgHeroPic.InitAvgHeroPic = function(self, imgCfg, heroItemPrefab,
                                        tweenCompleteEvent)
    -- function num : 0_0 , upvalues : _ENV, CS_DOTweenAnimation
    self.imgId = imgCfg.imgId
    self.imgCfg = imgCfg
    self.tweenCompleteEvent = tweenCompleteEvent
    self.gameObject = heroItemPrefab:Instantiate()
    self.transform = (self.gameObject).transform
    self.ui = {};
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    local breathTweenList = ((self.ui).breatheRoot):GetComponents(
                                typeof(CS_DOTweenAnimation))
    local delay = (math.random)() * 2
    for i = 0, breathTweenList.Length - 1 do
        local dt = breathTweenList[i]
        dt.delay = delay
    end
    (self.gameObject):SetActive(true)
    self.immediateComplete = false
    self.tweenCfgList = {}
    self:LoadHeroPic()
end

UINAvgHeroPic.LoadHeroPic = function(self)
    -- function num : 0_1 , upvalues : CS_ResLoader, _ENV, AvgImgTweenUntil
    self.loadResComplete = false
    self.resloader = (CS_ResLoader.Create)()
    local path = PathConsts:GetCharacterBigImgPrefabPath((self.imgCfg).imgPath);
    (self.resloader):LoadABAssetAsync(path, function(prefab)
        -- function num : 0_1_0 , upvalues : self, _ENV, AvgImgTweenUntil
        local go = prefab:Instantiate((self.ui).breatheRoot)
        self.picGo = go
        local commonPicCtrl = go:FindComponent(
                                  eUnityComponentID.CommonPicController)
        commonPicCtrl:SetPosType("AvgHero") -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'
        ;
        (self.ui).rawImg = go:FindComponent(eUnityComponentID.RawImage)
        self:InitAvgHeroPicParam()
        self.loadResComplete = true
        for k, tweenCfg in ipairs(self.tweenCfgList) do
            (AvgImgTweenUntil.Tween)(self, tweenCfg)
        end
        self:PlayAvgImgTween()
    end)
end

UINAvgHeroPic.InitAvgHeroPicParam = function(self)
    -- function num : 0_2 , upvalues : eAvgImgPosType, _ENV
    local imgCfg = self.imgCfg
    local pos = nil
    if imgCfg.posId ~= nil then
        pos = eAvgImgPosType[imgCfg.posId]
    else
        if imgCfg.pos ~= nil then
            pos = (Vector3.New)((imgCfg.pos)[1], (imgCfg.pos)[2],
                                (imgCfg.pos)[3])
        else
            pos = Vector3.zero
        end
    end -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'
    
    (self.transform).localPosition = pos
    local rot = nil
    if imgCfg.rot == nil then
        rot = Vector3.zero
    else
        rot = (Vector3.New)((imgCfg.rot)[1], (imgCfg.rot)[2], (imgCfg.rot)[3])
    end -- DECOMPILER ERROR at PC44: Confused about usage of register: R4 in 'UnsetPending'
    
    (self.transform).localEulerAngles = rot
    local scale = nil
    if imgCfg.scale == nil then
        scale = Vector3.one
    else
        scale = (Vector3.New)((imgCfg.scale)[1], (imgCfg.scale)[2],
                              (imgCfg.scale)[3])
    end -- DECOMPILER ERROR at PC63: Confused about usage of register: R5 in 'UnsetPending'
    
    (self.transform).localScale = scale
    -- DECOMPILER ERROR at PC75: Confused about usage of register: R5 in 'UnsetPending'

    if not imgCfg.isDark or not Color.gray then
        ((self.ui).rawImg).color = Color.white
        if imgCfg.alpha ~= nil or not 1 then local alpha = imgCfg.alpha end
        local color = ((self.ui).rawImg).color
        color.a = alpha -- DECOMPILER ERROR at PC89: Confused about usage of register: R7 in 'UnsetPending'
        ;
        ((self.ui).rawImg).color = color
    end
end

UINAvgHeroPic.GetAvgImgOrder = function(self)
    -- function num : 0_3
    return (self.imgCfg).order or 0
end

UINAvgHeroPic.ChangeAvgImgOrder = function(self, order)
    -- function num : 0_4
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

    (self.imgCfg).order = order
end

UINAvgHeroPic.GetAvgImgType = function(self)
    -- function num : 0_5
    return (self.imgCfg).imgType
end

UINAvgHeroPic.PlayAvgImgTween = function(self)
    -- function num : 0_6
    if self.sequence ~= nil and self.loadResComplete then
        (self.sequence):AppendCallback(self:GetAvgImgTweenCompleteEvent());
        (self.sequence):Play()
        if self.immediateComplete then self:AvgImgTweenDoComplete() end
    end
end

UINAvgHeroPic.AddAvgImgTween = function(self, tweenCfg)
    -- function num : 0_7 , upvalues : AvgImgTweenUntil, _ENV
    if self.loadResComplete then
        (AvgImgTweenUntil.Tween)(self, tweenCfg)
    else

        (table.insert)(self.tweenCfgList, tweenCfg)
    end
end

UINAvgHeroPic.GetAvgImgSequence = function(self)
    -- function num : 0_8
    return self.sequence
end

UINAvgHeroPic.SetAvgImgSequence = function(self, sequence)
    -- function num : 0_9
    self.sequence = sequence
end

UINAvgHeroPic.GetAvgImgTweenCompleteEvent =
    function(self)
        -- function num : 0_10 , upvalues : _ENV
        if self.__onTweenComplete == nil then
            self.__onTweenComplete = BindCallback(self, self.OnTweenComplete)
        end
        return self.__onTweenComplete
    end

UINAvgHeroPic.OnTweenComplete = function(self)
    -- function num : 0_11
    self.sequence = nil
    self.tweenCfgList = {}
    if self.tweenCompleteEvent ~= nil then
        (self.tweenCompleteEvent)(self.imgId)
    end
end

UINAvgHeroPic.AvgImgTweenDoComplete = function(self)
    -- function num : 0_12
    if self.sequence ~= nil and (self.sequence):IsPlaying() then
        (self.sequence):Complete(true)
    else
        self.immediateComplete = true
    end
end

UINAvgHeroPic.Delete = function(self)
    -- function num : 0_13 , upvalues : _ENV
    if self.resloader ~= nil then
        (self.resloader):Put2Pool()
        self.resloader = nil
    end
    if self.sequence ~= nil then
        (self.sequence):Kill()
        self.sequence = nil
    end
    DestroyUnityObject(self.gameObject)
end

return UINAvgHeroPic


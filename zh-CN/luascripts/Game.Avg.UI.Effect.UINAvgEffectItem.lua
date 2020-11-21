-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAvgEffectItem = class("UINAvgEffectItem", UIBaseNode)
local base = UIBaseNode
local CS_PsStopBehavior = (CS.UnityEngine).ParticleSystemStopBehavior
UINAvgEffectItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINAvgEffectItem.InitAvgEffectItem = function(self, id, prefabName, resLoader,
                                              position, parent)
    -- function num : 0_1 , upvalues : _ENV
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

    if position == nil then
        (self.transform).localPosition = Vector3.zero
    else
        if #position ~= 3 then
            error("AvgEffect position config error")
            return
        end -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'
        
        (self.transform).localPosition =
            (Vector3.New)(position[1], position[2], position[3])
    end
    (self.transform):SetParent(parent)
    local path = PathConsts:GetEffectPath(prefabName)
    resLoader:LoadABAssetAsync(path, function(prefab)
        -- function num : 0_1_0 , upvalues : _ENV, self
        if IsNull(prefab) or self.__stop then return end
        local go = prefab:Instantiate(self.transform) -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'
        ;
        (self.ui).effect = go:FindComponent(eUnityComponentID.ParticleSystem)
        self:PlayAvgEffect()
    end)
end

UINAvgEffectItem.PlayAvgEffect = function(self)
    -- function num : 0_2 , upvalues : _ENV
    if IsNull((self.ui).effect) then return end
    self:Show();
    ((self.ui).effect):Play()
    self.__stop = false
end

UINAvgEffectItem.StopAvgEffect = function(self)
    -- function num : 0_3
    self:Hide()
    self.__stop = true
end

UINAvgEffectItem.OnDelete = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnDelete)(self)
end

return UINAvgEffectItem


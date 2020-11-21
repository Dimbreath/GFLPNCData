-- params : ...
-- function num : 0 , upvalues : _ENV
local SctResPillarEntity = class("SctResPillarEntity")
SctResPillarEntity.InitSctResPillar = function(self, gameObject, position, mat,
                                               uiResPillar)
    -- function num : 0_0 , upvalues : _ENV
    self.gameObject = gameObject
    self.transform = gameObject.transform
    self.uiResPillar = uiResPillar
    self.bind = {};
    (UIUtil.LuaUIBindingTable)(self.transform, self.bind) -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'
    ;
    (self.transform).position = position -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.bind).pillar).material = mat
    uiResPillar:InitUISctResPillar((self.bind).textNode)
end

SctResPillarEntity.UpdateResPillarProgress =
    function(self, progress)
        -- function num : 0_1
        local scale = (((self.bind).pillar).transform).localScale
        scale.y = progress -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'
        ;
        (((self.bind).pillar).transform).localScale = scale;
        (self.uiResPillar):UpdateUISctResPillar(progress)
    end

SctResPillarEntity.OnDelete = function(self)
    -- function num : 0_2
end

return SctResPillarEntity


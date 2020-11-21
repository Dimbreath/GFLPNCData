-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpBuffItem = class("UIEpBuffItem", UIBaseNode)
UIEpBuffItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIEpBuffItem.InitEpBuffItem = function(self, epBuff)
    -- function num : 0_1 , upvalues : _ENV
    local buffCfg = (ConfigData.exploration_buff)[epBuff.dataId]
    if buffCfg == nil then
        error("exploration buff cfg is null,id:" .. tostring(epBuff.dataId))
        return
    end
    self:InitEpBuffByCfg(epBuff, buffCfg)
end

UIEpBuffItem.InitEpBuffByCfg = function(self, epBuff, buffCfg)
    -- function num : 0_2 , upvalues : _ENV
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

    ((self.ui).img_Pic).sprite = CRH:GetSprite(buffCfg.icon,
                                               CommonAtlasType.ExplorationIcon)
    if epBuff.cnt > 0 then
        ((self.ui).buffCount):SetActive(true) -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).tex_buffCount).text = tostring(epBuff.cnt)
    else

        ((self.ui).buffCount):SetActive(false)
    end
end

return UIEpBuffItem


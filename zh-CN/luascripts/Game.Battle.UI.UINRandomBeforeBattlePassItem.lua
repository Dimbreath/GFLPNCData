-- params : ...
-- function num : 0 , upvalues : _ENV
local UINRandomBeforeBattlePassItem = class("UINRandomBeforeBattlePassItem",
                                            UIBaseNode)
local base = UIBaseNode
UINRandomBeforeBattlePassItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINRandomBeforeBattlePassItem.SetJudgeIcon =
    function(self, careerId)
        -- function num : 0_1 , upvalues : _ENV
        local careerCfg = (ConfigData.career)[careerId]
        if careerCfg == nil then
            error("careerCfg is nil, id:" .. careerId)
        end -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'
        
        ((self.ui).image_pass).sprite = CRH:GetSprite(careerCfg.icon,
                                                      CommonAtlasType.CareerCamp)
    end

UINRandomBeforeBattlePassItem.InitPassItem =
    function(self, isPass)
        -- function num : 0_2
        self.isPass = isPass
        if isPass then
            ((self.ui).obj_pass):SetActive(true);
            ((self.ui).obj_notPass):SetActive(false)
        else

            ((self.ui).obj_pass):SetActive(false);
            ((self.ui).obj_notPass):SetActive(true)
        end
    end

UINRandomBeforeBattlePassItem.LuckPass =
    function(self)
        -- function num : 0_3
        ((self.ui).text_luck):SetActive(true)
    end

UINRandomBeforeBattlePassItem.OnHide = function(self)
    -- function num : 0_4
    ((self.ui).obj_pass):SetActive(false);
    ((self.ui).obj_notPass):SetActive(true)
end

UINRandomBeforeBattlePassItem.OnDelete =
    function(self)
        -- function num : 0_5 , upvalues : base
        (base.OnDelete)(self)
    end

return UINRandomBeforeBattlePassItem


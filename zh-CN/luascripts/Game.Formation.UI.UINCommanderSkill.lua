-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCommanderSkill = class("UINCommanderSkill", UIBaseNode)
local base = UIBaseNode
UINCommanderSkill.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINCommanderSkill.InitCommanderSkill =
    function(self, treeId, skillId, resloader)
        -- function num : 0_1 , upvalues : _ENV
        local playerSkillData =
            ((((PlayerDataCenter.CommanderSkillModualData).CommanderSkillTreeDataDic)[treeId]).commanderSkillDataDic)[skillId]
        if playerSkillData == nil then
            error("can\'t read playerSkillDic with id" .. skillId)
            return
        end
        resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath(
                                       "CommanderSkillIcons"),
                                   function(spriteAtlas)
            -- function num : 0_1_0 , upvalues : self, playerSkillData
            if spriteAtlas == nil then return end -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'
            
            ((self.ui).img_SkillIcon).sprite =
                spriteAtlas:GetSprite(playerSkillData:GetIcon())
        end)
    end

UINCommanderSkill.OnDelete = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnDelete)(self)
end

return UINCommanderSkill


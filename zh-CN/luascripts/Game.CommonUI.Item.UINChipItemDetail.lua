-- params : ...
-- function num : 0 , upvalues : _ENV
local UINChipItemDetail = class("UINChipItemDetail", UIBaseNode)
local base = UIBaseNode
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local CS_ResLoader = CS.ResLoader
local CS_GameData_Ins = (CS.GameData).instance
UINChipItemDetail.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (((self.ui).img_HeroIcon).gameObject):SetActive(false);
    ((self.ui).adaptHero):SetActive(false)
end

UINChipItemDetail.InitChipDetail = function(self, chipData)
    -- function num : 0_1 , upvalues : UINChipItem, _ENV, CS_GameData_Ins
    self.chipData = chipData -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).name).text = chipData:GetName()
    local chipCfg = chipData:GetChipCfg()
    local count = chipData:GetCount()
    local chipItem = (UINChipItem.New)()
    chipItem:Init((self.ui).chipItem)
    chipItem:InitChipItem(chipData)
    self:__UpdateAdaptText(chipData)
    local content = ""
    for k, atrId in ipairs(chipCfg.attribute_id) do
        local attibuteCfg = (ConfigData.attribute)[atrId]
        if attibuteCfg == nil then
            error("Can\'t find attibuteCfg, id = " .. tostring(atrId))
        else
            local atrName = (LanguageUtil.GetLocaleText)(attibuteCfg.name)
            local isRatio = attibuteCfg.num_type == 2
            local value = (chipCfg.attribute_initial)[k] +
                              ((chipCfg.level_increase)[k] or 0) * (count - 1)
            if value ~= 0 then
                if not isRatio or not tostring(FormatNum(value / 10)) .. "%" then
                    local valueStr = tostring(value)
                end
                content = content .. atrName .. "+" .. valueStr .. ";\n"
            end
        end
    end
    if (string.IsNullOrEmpty)(content) then content = "无" end -- DECOMPILER ERROR at PC92: Confused about usage of register: R6 in 'UnsetPending'
    
    ((self.ui).tex_Attri).text = content
    local holdCount = 0
    local dynPlayer = ExplorationManager:GetDynPlayer()
    if dynPlayer ~= nil then
        holdCount = dynPlayer:GetChipCount(chipData.dataId)
    end
    -- DECOMPILER ERROR at PC115: Confused about usage of register: R8 in 'UnsetPending'

    if holdCount ~= 0 or not "" then
        ((self.ui).hold).text = "已持有 x " .. tostring(holdCount)
        -- DECOMPILER ERROR at PC122: Confused about usage of register: R8 in 'UnsetPending'

        if #chipCfg.skill_list == 0 then
            ((self.ui).tex_Skill).text = "无" -- DECOMPILER ERROR at PC125: Confused about usage of register: R8 in 'UnsetPending'
            ;
            ((self.ui).description).text = "无"
        else
            local skillId = (chipCfg.skill_list)[1]
            local skillCfg = (CS_GameData_Ins.listBattleSkillDatas):GetDataById(
                                 skillId)
            if skillCfg == nil then
                error("Can\'t find skillCfg, id = " .. tostring(skillId))
            end -- DECOMPILER ERROR at PC145: Confused about usage of register: R10 in 'UnsetPending'
            
            ((self.ui).tex_Skill).text = skillCfg.Name -- DECOMPILER ERROR at PC151: Confused about usage of register: R10 in 'UnsetPending'
            ;
            ((self.ui).description).text = skillCfg:GetLevelDescribe(count)
        end
        -- DECOMPILER ERROR: 12 unprocessed JMP targets
    end
end

UINChipItemDetail.__UpdateAdaptText = function(self, chipData)
    -- function num : 0_2 , upvalues : ChipEnum, _ENV
    local chipCfg = chipData:GetChipCfg()
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

    if chipData:IsCopyItem() then
        (((self.ui).tex_Adapt).text).text = chipData:GetHeroName()
    else
        if chipCfg.influence == (ChipEnum.eChipInfluenceType).AllHero then
            ((self.ui).tex_Adapt):SetIndex(2)
        else
            if chipCfg.influence == (ChipEnum.eChipInfluenceType).Career then
                local careerCfg = (ConfigData.career)[chipCfg.arg]
                if careerCfg == nil then
                    error(
                        (string.format)("chip(%d) influence error", chipCfg.id))
                end -- DECOMPILER ERROR at PC49: Confused about usage of register: R4 in 'UnsetPending'
                
                (((self.ui).tex_Adapt).text).text =
                    (LanguageUtil.GetLocaleText)(careerCfg.name)
            else
                do
                    if chipCfg.influence == (ChipEnum.eChipInfluenceType).Camp then
                        local campCfg = (ConfigData.camp)[chipCfg.arg]
                        if campCfg == nil then
                            error((string.format)("chip(%d) influence error",
                                                  chipCfg.id))
                        end -- DECOMPILER ERROR at PC76: Confused about usage of register: R4 in 'UnsetPending'
                        
                        (((self.ui).tex_Adapt).text).text =
                            (LanguageUtil.GetLocaleText)(campCfg.name)
                    else
                        do
                            if chipCfg.influence ==
                                (ChipEnum.eChipInfluenceType).Row then
                                if chipCfg.arg == 1 then
                                    ((self.ui).tex_Adapt):SetIndex(0)
                                else
                                    if chipCfg.arg == 2 then
                                        ((self.ui).tex_Adapt):SetIndex(1)
                                    else
                                        error(
                                            (string.format)(
                                                "Unsupported chip(%d) arg:%d",
                                                chipCfg.id, chipCfg.arg))
                                    end
                                end
                            else
                                if chipCfg.influence ==
                                    (ChipEnum.eChipInfluenceType).HeroId then
                                    local heroCfg =
                                        (ConfigData.hero_data)[chipCfg.arg]
                                    if heroCfg == nil then
                                        error(
                                            (string.format)(
                                                "chip(%d) influence error",
                                                chipCfg.id))
                                    end -- DECOMPILER ERROR at PC135: Confused about usage of register: R4 in 'UnsetPending'
                                    
                                    (((self.ui).tex_Adapt).text).text =
                                        (LanguageUtil.GetLocaleText)(
                                            heroCfg.name)
                                else
                                    do
                                        error(
                                            "找不到tex_Adapt 芯片适配类型")
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

UINChipItemDetail.UpdateAdaptHero = function(self, heroList, contain)
    -- function num : 0_3 , upvalues : CS_ResLoader, _ENV
    if heroList == nil then return end
    if self.resLoader == nil then self.resLoader = (CS_ResLoader.Create)() end
    ((self.ui).adaptHero):SetActive(true)
    self:__HideAllHeroIcon()
    local heroCount = 1
    for k, hero in ipairs(heroList) do
        if not contain or hero:ContainChip(self.chipData) then
            local heroImg = self:__GetHeroIconRawImg(heroCount)
            local texture = (self.resLoader):LoadABAsset(
                                PathConsts:GetCharacterPicPath(hero:GetResName()))
            heroImg.texture = texture
            heroCount = heroCount + 1
        end
    end
end

UINChipItemDetail.__HideAllHeroIcon = function(self)
    -- function num : 0_4 , upvalues : _ENV
    if self.__heroIconList == nil then return end
    for k, v in ipairs(self.__heroIconList) do
        v.texture = nil;
        (v.gameObject):SetActive(false)
    end
end

UINChipItemDetail.__GetHeroIconRawImg = function(self, index)
    -- function num : 0_5 , upvalues : _ENV
    if self.__heroIconList == nil then self.__heroIconList = {} end
    if index <= #self.__heroIconList then
        local icon = (self.__heroIconList)[index];
        (icon.gameObject):SetActive(true)
        return icon
    else
        do
            local icon = ((self.ui).img_HeroIcon):Instantiate();
            (icon.gameObject):SetActive(true);
            (table.insert)(self.__heroIconList, icon)
            do return icon end
        end
    end
end

UINChipItemDetail.OnDelete = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnDelete)(self)
    if self.resLoader ~= nil then
        (self.resLoader):Put2Pool()
        self.resLoader = nil
    end
end

return UINChipItemDetail


-- params : ...
-- function num : 0 , upvalues : _ENV
local LocalizeManager = class("LocalizeManager")
local cs_LanguageGlobal = CS.LanguageGlobal
local uiCfg = require("UIConfig.LocalozeCfg")
LocalizeManager.ctor = function(self)
    -- function num : 0_0
end

LocalizeManager.SetUILocalizeConfig = function(self, rootTF)
    -- function num : 0_1 , upvalues : _ENV, cs_LanguageGlobal, uiCfg
    self.curLanguage = (string.sub)(tostring(cs_LanguageGlobal.language), 1, 5)
    if self.curLanguage then return end
    local requirePath = (uiCfg[self.curLanguage])[rootTF.name]
    if requirePath == nil then return end
    local cfg = (require(requirePath))
    local targetTF = nil
    for path, cfgData in pairs(cfg) do
        targetTF = rootTF:Find(path)
        if targetTF ~= nil then
            targetTF.position = cfgData.position
            targetTF.localScale = cfgData.scale
            targetTF.sizeDelta = cfgData.sizeDelta
            local exText = targetTF:GetComponent(typeof(CS.ExText))
            do
                local tableCount = (table.count)(cfgData)
                if (exText ~= nil and tableCount > 3) or tableCount < 11 then
                    exText.fontSize = cfgData.fontSize
                    exText.lineSpacing = cfgData.lineSpacing
                    exText.alignment = cfgData.alignment
                    exText.resizeTextForBestFit = cfgData.bestFit
                    exText.resizeTextMinSize = cfgData.minSize
                    exText.resizeTextMaxSize = cfgData.maxSize
                    exText.isDecor = cfgData.isDecor
                end
                -- DECOMPILER ERROR at PC70: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC70: LeaveBlock: unexpected jumping out IF_STMT

            end
        end
    end -- DECOMPILER ERROR at PC74: Confused about usage of register: R5 in 'UnsetPending'
    
    (package.loaded)[requirePath] = nil
    requirePath = ""
    cfg = nil
end

return LocalizeManager


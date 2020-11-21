-- params : ...
-- function num : 0 , upvalues : _ENV
local HeroAttrChecker = class("HeroAttrChecker")
HeroAttrChecker.ctor = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self:__ClearCheckHeroAttriTimer()
    self.__waitForCheckHeroAttri = {}
    self.__onCheckPlayerHeroAttri = BindCallback(self,
                                                 self.__CheckPlayerHeroAttri)
end

HeroAttrChecker.DirtyPlayerHeroAttri = function(self, heroId, attriId,
                                                attriValue)
    -- function num : 0_1 , upvalues : _ENV
    local heroAttriDic = (self.__waitForCheckHeroAttri)[heroId]
    if heroAttriDic == nil then
        heroAttriDic = {} -- DECOMPILER ERROR at PC7: Confused about usage of register: R5 in 'UnsetPending'
        ;
        (self.__waitForCheckHeroAttri)[heroId] = heroAttriDic
    end
    heroAttriDic[attriId] = attriValue
    if self.__checkHeroAttriTimer == nil then
        self.__checkHeroAttriTimer = (TimerManager:GetTimer(1,
                                                            self.__StartCheckPlayerHeroAttri,
                                                            self, true, true)):Start()
    end
end

HeroAttrChecker.__StartCheckPlayerHeroAttri =
    function(self)
        -- function num : 0_2 , upvalues : _ENV
        self.__checkHeroAttriTimer = nil
        local heroDic = {}
        for heroId, v in pairs(self.__waitForCheckHeroAttri) do
            heroDic[heroId] = true
        end
        local debugNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Debug)
        debugNetCtrl:CS_HERO_Debug_Attr(heroDic, self.__onCheckPlayerHeroAttri)
    end

HeroAttrChecker.__CheckPlayerHeroAttri =
    function(self, msg)
        -- function num : 0_3 , upvalues : _ENV
        for heroId, attrDic in pairs(msg.data) do
            local clientAttrDic = (self.__waitForCheckHeroAttri)[heroId]
            if clientAttrDic ~= nil then
                for attriId, attriValue in pairs(clientAttrDic) do
                    local serverValue = (attrDic.data)[attriId] or 0
                    if serverValue ~= attriValue then
                        local msg = (string.format)(
                                        "[Dev]角色属性不同， heroId:%s, AttrID:%s, client:%s, server:%s",
                                        heroId, attriId, attriValue, serverValue)
                        local heroCfg = (ConfigData.hero_data)[heroId]
                        local camp = heroCfg.camp
                        local categoryValueDic =
                            (PlayerDataCenter.playerBonus):GetCtgrCampBuff(camp,
                                                                           attriId)
                        for uid, value in pairs(categoryValueDic) do
                            local module = uid >> 32
                            local id = uid & CommonUtil.UInt32Max
                            msg = msg ..
                                      (string.format)(
                                          "\n企业加成：module:%s, id:%s, value:%s",
                                          module, id, value)
                        end
                        local career = heroCfg.career
                        local categoryValueDic =
                            (PlayerDataCenter.playerBonus):GetCtgrCareerBuff(
                                career, attriId)
                        for uid, value in pairs(categoryValueDic) do
                            local module = uid >> 32
                            local id = uid & CommonUtil.UInt32Max
                            msg = msg ..
                                      (string.format)(
                                          "\n职业加成：module:%s, id:%s, value:%s",
                                          module, id, value)
                        end
                        local categoryValueDic =
                            (PlayerDataCenter.playerBonus):GetCtgrAllHeroBuff(
                                attriId)
                        for uid, value in pairs(categoryValueDic) do
                            local module = uid >> 32
                            local id = uid & CommonUtil.UInt32Max
                            msg = msg ..
                                      (string.format)(
                                          "\n所有角色加成：module:%s, id:%s, value:%s",
                                          module, id, value)
                        end
                        warn(msg)
                    end
                end
            end
        end
        self.__waitForCheckHeroAttri = {}
        self:__ClearCheckHeroAttriTimer()
    end

HeroAttrChecker.__ClearCheckHeroAttriTimer =
    function(self)
        -- function num : 0_4
        if self.__checkHeroAttriTimer ~= nil then
            (self.__checkHeroAttriTimer):Stop()
            self.__checkHeroAttriTimer = nil
        end
    end

return HeroAttrChecker


-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthReplaceHero = class("UIAthReplaceHero", UIBaseWindow)
local base = UIBaseWindow
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
UIAthReplaceHero.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self,
                               self.__OnClickConfirm);
    (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, self.__OnClickCancel)
end

UIAthReplaceHero.InitAthReplaceHero = function(self, heroId, replaceHeroId,
                                               confirmFunc, resLoader)
    -- function num : 0_1 , upvalues : UINHeroHeadItem, _ENV
    self.confirmFunc = confirmFunc
    local beforItem = (UINHeroHeadItem.New)()
    beforItem:Init((self.ui).beforHeadItem)
    local beforHeroData = (PlayerDataCenter.heroDic)[replaceHeroId]
    beforItem:InitHeroHeadItem(beforHeroData, resLoader)
    self.beforItem = beforItem
    local afterItem = (UINHeroHeadItem.New)()
    afterItem:Init((self.ui).afterHeadItem)
    local afterHeroData = (PlayerDataCenter.heroDic)[heroId]
    afterItem:InitHeroHeadItem(afterHeroData, resLoader)
    self.afterItem = afterItem
end

UIAthReplaceHero.__OnClickConfirm = function(self)
    -- function num : 0_2
    if self.confirmFunc ~= nil then (self.confirmFunc)() end
    self:Delete()
end

UIAthReplaceHero.__OnClickCancel = function(self)
    -- function num : 0_3
    self:Delete()
end

UIAthReplaceHero.OnDelete = function(self)
    -- function num : 0_4 , upvalues : base
    (self.beforItem):Delete();
    (self.afterItem):Delete();
    (base.OnDelete)(self)
end

return UIAthReplaceHero


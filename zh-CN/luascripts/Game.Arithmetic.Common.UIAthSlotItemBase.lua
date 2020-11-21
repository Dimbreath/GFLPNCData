-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthSlotItemBase = class("UIAthSlotItemBase", UIBaseNode)
local base = UIBaseNode
local UIAthItem = require("Game.Arithmetic.Common.UIAthItemBase")
UIAthSlotItemBase.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UIAthItem
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    ((self.ui).img_ATH):SetActive(false)
    self:InitAthItemPool(UIAthItem)
end

UIAthSlotItemBase.InitAthItemPool = function(self, UIAthItemClass)
    -- function num : 0_1 , upvalues : _ENV
    self.athPool = (UIItemPool.New)(UIAthItemClass, (self.ui).img_ATH)
end

UIAthSlotItemBase.InitAthSlotItem = function(self, slotId, space, heroId)
    -- function num : 0_2 , upvalues : _ENV
    self.heroId = heroId
    self.slotId = slotId
    self.space = space;
    ((self.ui).tex_ATHType):SetIndex(0, tostring(slotId))
    local athDataList = (PlayerDataCenter.allAthData):GetHeroAthList(heroId,
                                                                     slotId)
    local usedSpace = 0
    for k, athData in ipairs(athDataList) do
        usedSpace = usedSpace + athData.size
    end
    do
        if usedSpace >= space or not #athDataList + 1 then
            local imgCount = #athDataList
        end
        local totalHeight = ((((self.ui).athContent).transform).rect).height -
                                (((self.ui).athContent).padding).vertical -
                                ((self.ui).athContent).spacing * (imgCount - 1);
        (self.athPool):HideAll()
        if usedSpace < space then
            local athItem = (self.athPool):GetOne()
            local height = totalHeight * (1 - (usedSpace) / space)
            athItem:InitAthItem((self.ui).unusedColor, height,
                                space - (usedSpace), nil)
        end
        do
            for k, athData in ipairs(athDataList) do
                local athItem = (self.athPool):GetOne()
                local height = athData.size / space * totalHeight
                athItem:InitAthItem(athData:GetColor(), height, athData.size,
                                    athData)
            end
            self:__InitRedDotEvent(heroId, slotId)
        end
    end
end

UIAthSlotItemBase.__InitRedDotEvent = function(self, heroId, slotId)
    -- function num : 0_3 , upvalues : _ENV
    local ok, AthSlotNode = RedDotController:GetRedDotNode(
                                RedDotStaticTypeId.Main,
                                RedDotStaticTypeId.HeroWindow, heroId, slotId)
    if not ok then return end
    ((self.ui).redDot):SetActive(AthSlotNode:GetRedDotCount() > 0)
    if self.__onRedDotChanged == nil then
        self.__onRedDotChanged = function(node)
            -- function num : 0_3_0 , upvalues : self
            ((self.ui).redDot):SetActive(node:GetRedDotCount() > 0)
            -- DECOMPILER ERROR: 1 unprocessed JMP targets
        end

    end
    RedDotController:RemoveListener(AthSlotNode.nodePath, self.__onRedDotChanged)
    RedDotController:AddListener(AthSlotNode.nodePath, self.__onRedDotChanged)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIAthSlotItemBase.OnDelete = function(self)
    -- function num : 0_4 , upvalues : _ENV, base
    local ok, AthSlotNode = RedDotController:GetRedDotNode(
                                RedDotStaticTypeId.Main,
                                RedDotStaticTypeId.HeroWindow, self.heroId,
                                self.slotId)
    if ok then
        RedDotController:RemoveListener(AthSlotNode.nodePath,
                                        self.__onRedDotChanged)
    end
    (self.athPool):DeleteAll();
    (base.OnDelete)(self)
end

return UIAthSlotItemBase


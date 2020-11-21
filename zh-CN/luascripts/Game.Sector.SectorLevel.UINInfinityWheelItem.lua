-- params : ...
-- function num : 0 , upvalues : _ENV
local UINInfinityWheelItem = class("UINInfinityWheelItem", UIBaseNode)
local base = UIBaseNode
local changeStep = 90
UINInfinityWheelItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self.textItemList = {};
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (((self.ui).tex_0).gameObject):SetActive(false)
    self:__CreateTextList()
    self:SetArrowActive(false)
end

UINInfinityWheelItem.InitWheel = function(self, listCount, viewSizeY,
                                          elementSizeY)
    -- function num : 0_1
    self.lastDegree = 0
    self.listCount = listCount
    if not viewSizeY then viewSizeY = 1080 end
    if not elementSizeY then elementSizeY = 207 end
    self.unitDegree = (listCount - viewSizeY / elementSizeY) * 30
    self.offsetValue = (viewSizeY / elementSizeY // 2 - 2) * 10
    self:RoteWheel(0)
    self:WriteNums(0)
end

UINInfinityWheelItem.RoteWheel = function(self, value)
    -- function num : 0_2 , upvalues : _ENV, changeStep
    local degree = value * self.unitDegree -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).obj_Outer).rotation = (Quaternion.Euler)(0, 0, -degree) -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).obj_Inside).rotation = (Quaternion.Euler)(0, 0, degree)
    local num = ((degree / 30 + 1) * 10 + self.offsetValue) * 1000 * 9.8 /
                    1000000
    num = GetPreciseDecimalStr(num, 3) -- DECOMPILER ERROR at PC38: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).tex_MPa).text = tostring(num)
    if changeStep < (math.abs)(degree - self.lastDegree) then
        local offsetIndex = degree // 30
        self:WriteNums(offsetIndex)
        self.lastDegree = degree
    end
end

UINInfinityWheelItem.__CreateTextList = function(self)
    -- function num : 0_3 , upvalues : _ENV
    local textItem = nil
    for i = 1, 12 do
        local text =
            ((((self.ui).tex_0).gameObject):Instantiate()):GetComponent(
                typeof(((CS.UnityEngine).UI).Text));
        (text.gameObject):SetActive(true)
        local z = (i - 1) * -30;
        (text.transform):Rotate((Vector3.New)(0, 0, z)) -- DECOMPILER ERROR at PC34: Confused about usage of register: R8 in 'UnsetPending'
        ;
        (self.textItemList)[i] = text
    end
end

UINInfinityWheelItem.WriteNums = function(self, offsetIndex)
    -- function num : 0_4 , upvalues : _ENV
    local offsetValue = offsetIndex * 10 + self.offsetValue
    do
        if offsetIndex < 0 then
            local offest = (math.fmod)(offsetIndex, 12)
            offsetIndex = offest + 12
        end
        for i = offsetIndex + 1, offsetIndex + 12 do
            local index = (math.fmod)(i, 12)
            if index == 0 then index = 12 end
            local textItem = (self.textItemList)[index]
            local count = i - (offsetIndex)
            if count <= 6 then
                textItem.text = tostring(FormatNum(count * 10 + offsetValue))
            else
                textItem.text = tostring(
                                    FormatNum((12 - count) * -10 + offsetValue))
            end
        end
    end
end

UINInfinityWheelItem.SetArrowActive = function(self, active)
    -- function num : 0_5
    (((((self.ui).tex_MPa).transform).parent).gameObject):SetActive(active)
end

UINInfinityWheelItem.OnDelete = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnDelete)(self)
end

return UINInfinityWheelItem


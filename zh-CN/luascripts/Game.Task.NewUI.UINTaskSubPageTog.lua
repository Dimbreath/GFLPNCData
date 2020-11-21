-- params : ...
-- function num : 0 , upvalues : _ENV
local UINTaskSubPageTog = class("UINTaskSubPageTog", UIBaseNode)
UINTaskSubPageTog.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self.id = nil;
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddValueChangedListener)((self.ui).tog_subPageTog, self,
                                     self.OnValueChage)
end

UINTaskSubPageTog.InitSubPageTog = function(self, id, name, taskDatas,
                                            OnSelectPage)
    -- function num : 0_1
    self.id = id
    self.OnSelectPage = OnSelectPage -- DECOMPILER ERROR at PC4: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.ui).tex_Name).text = name
    self:SetMissionCount(taskDatas)
end

UINTaskSubPageTog.SetMissionCount = function(self, taskDatas)
    -- function num : 0_2 , upvalues : _ENV
    local totalNum = (table.count)(taskDatas)
    local finishedNum = 0
    for _, taskData in pairs(taskDatas) do
        if taskData.isPicked then finishedNum = finishedNum + 1 end
    end
    if finishedNum < 10 then
        ((self.ui).tex_CompleteNum):SetIndex(0, "0", tostring(finishedNum))
    else

        ((self.ui).tex_CompleteNum):SetIndex(0, "", tostring(finishedNum))
    end
    if totalNum < 10 then
        ((self.ui).tex_TotalNum):SetIndex(0, "0", tostring(totalNum))
    else

        ((self.ui).tex_TotalNum):SetIndex(0, "", tostring(totalNum))
    end
end

UINTaskSubPageTog.OnValueChage = function(self, bool)
    -- function num : 0_3
    if bool then
        ((self.ui).img_Buttom):SetIndex(1)
        if self.OnSelectPage ~= nil then (self.OnSelectPage)(self.id) end
    else

        ((self.ui).img_Buttom):SetIndex(0)
    end
end

UINTaskSubPageTog.SetRedDotActive = function(self, bool)
    -- function num : 0_4
    ((self.ui).obj_RedDot):SetActive(bool)
end

return UINTaskSubPageTog


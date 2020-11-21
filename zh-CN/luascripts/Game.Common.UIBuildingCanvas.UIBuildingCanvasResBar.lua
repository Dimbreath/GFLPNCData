-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBuildingCanvasResBar = class("UIBuildingCanvasResBar", UIBaseNode)
local base = UIBaseNode
UIBuildingCanvasResBar.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIBuildingCanvasResBar.UpdateResBar = function(self, resData)
    -- function num : 0_1 , upvalues : _ENV
    ((self.ui).text):SetIndex(0, resData.name, tostring(resData.count)) -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).progressFill).fillAmount = resData.progress
end

UIBuildingCanvasResBar.OnDelete = function(self)
    -- function num : 0_2 , upvalues : _ENV, base
    if not IsNull(self.fillTween) then (self.fillTween):Kill() end
    (base.OnDelete)(self)
end

return UIBuildingCanvasResBar


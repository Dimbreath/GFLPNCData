-- params : ...
-- function num : 0 , upvalues : _ENV
local battle_grid = {
{info = 38560, name = 212779, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_ReduceCD"}
, 
{grid_skill = "gs_2", icon = "ICON_Grid002", id = 2, info = 426462, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Ridicule"}
, 
{grid_skill = "gs_3", icon = "ICON_Grid003", id = 3, name = 105182, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Yueqian"}
, 
{grid_skill = "gs_4", icon = "ICON_Grid004", id = 4, info = 521695, name = 50384}
}
local __default_values = {grid_skill = "gs_1", icon = "ICON_Grid001", id = 1, info = 16832, name = 103404, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Aim"}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(battle_grid) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(battle_grid, {__index = __rawdata})
return battle_grid


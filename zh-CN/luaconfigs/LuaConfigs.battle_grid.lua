-- params : ...
-- function num : 0 , upvalues : _ENV
local battle_grid = {
{info = 165154, name = 212779, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_ReduceCD"}
, 
{grid_skill = "gs_2", icon = "ICON_Grid002", id = 2, info = 99807, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Ridicule"}
, 
{grid_skill = "gs_3", icon = "ICON_Grid003", id = 3, info = 33598, name = 105182, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Yueqian"}
, 
{grid_skill = "gs_4", icon = "ICON_Grid004", id = 4, info = 378639, name = 50384}
, 
{grid_skill = "gs_5", icon = "ICON_Grid005", id = 5, info = 424033, name = 107985, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Smash"}
, 
{grid_skill = "gs_6", icon = "ICON_Grid006", id = 6, info = 419215, name = 463468, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_ArcherDefense"}
, 
{grid_skill = "gs_7", icon = "ICON_Grid007", id = 7, info = 282572, name = 60227, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_warriorDefense"}
, 
{grid_skill = "gs_8", icon = "ICON_Grid008", id = 8, info = 359024, name = 401630, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/NewgroundFX/FXP_Strongblow/FXP_Strongblow"}
, 
{grid_skill = "gs_9", icon = "ICON_Grid009", id = 9, info = 513638, name = 369332, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/NewgroundFX/FXP_kuaigong/FXP_kuaigong"}
, 
{grid_skill = "gs_10", icon = "ICON_Grid010", id = 10, info = 61077, name = 430291, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Wangyouye"}
, 
{grid_skill = "gs_11", icon = "ICON_Grid011", id = 11, name = 26593, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/NewgroundFX/FXP_Weiwangyoucao/FXP_Weiwangyoucao"}
, 
{grid_skill = "gs_12", icon = "ICON_Grid012", id = 12, info = 440586, name = 253480, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/NewgroundFX/FXP_Seduce/FXP_Seduce"}
, 
{grid_skill = "gs_13", icon = "ICON_Grid013", id = 13, info = 68868, name = 317646, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/NewgroundFX/FXP_Shield/FXP_Shield"}
, 
{grid_skill = "gs_14", icon = "ICON_Grid014", id = 14, info = 350486, name = 161689, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/NewgroundFX/FXP_bati/FXP_Bati"}
, 
{grid_skill = "gs_15", icon = "ICON_Grid015", id = 15, info = 191502, name = 326857, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_ShanghuaGrid"}
}
local __default_values = {grid_skill = "gs_1", icon = "ICON_Grid001", id = 1, info = 129305, name = 103404, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Aim"}
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


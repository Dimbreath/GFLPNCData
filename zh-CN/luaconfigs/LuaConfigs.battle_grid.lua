-- params : ...
-- function num : 0 , upvalues : _ENV
local battle_grid = {
{icon = "ICON_Grid001", info = 327695, name = 212779, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_ReduceCD"}
, 
{grid_skill = "gs_2", icon = "ICON_Grid002", id = 2, info = 183886, name = 103404, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Ridicule"}
, 
{grid_skill = "gs_3", icon = "ICON_Grid003", id = 3, info = 503455, name = 105182, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Yueqian"}
, 
{grid_skill = "gs_4", icon = "ICON_Grid004", id = 4, info = 209209, name = 50384, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Aim"}
, 
{grid_skill = "gs_5", icon = "ICON_Grid005", id = 5, info = 155239, name = 107985, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Smash"}
, 
{grid_skill = "gs_6", icon = "ICON_Grid006", id = 6, info = 95095, name = 382658, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_ArcherDefense"}
, 
{grid_skill = "gs_7", icon = "ICON_Grid007", id = 7, info = 438124, name = 503705, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_warriorDefense"}
, 
{grid_skill = "gs_8", icon = "ICON_Grid008", id = 8, info = 43366, name = 401630, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/NewgroundFX/FXP_Strongblow/FXP_Strongblow"}
, 
{grid_skill = "gs_9", icon = "ICON_Grid009", id = 9, info = 206310, name = 369332, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/NewgroundFX/FXP_kuaigong/FXP_kuaigong"}
, 
{grid_skill = "gs_10", icon = "ICON_Grid010", id = 10, info = 8160, name = 430291, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Wangyouye"}
, 
{grid_skill = "gs_11", icon = "ICON_Grid011", id = 11, info = 288268, name = 26593, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/NewgroundFX/FXP_Weiwangyoucao/FXP_Weiwangyoucao"}
, 
{grid_skill = "gs_12", icon = "ICON_Grid012", id = 12, info = 404487, name = 253480, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/NewgroundFX/FXP_Seduce/FXP_Seduce"}
, 
{grid_skill = "gs_13", icon = "ICON_Grid013", id = 13, info = 320517, name = 317646, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/NewgroundFX/FXP_Shield/FXP_Shield"}
, 
{grid_skill = "gs_14", icon = "ICON_Grid014", id = 14, name = 161689, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/NewgroundFX/FXP_bati/FXP_Bati"}
, 
{grid_skill = "gs_15", icon = "ICON_Grid015", id = 15, info = 345851, name = 326857, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_ShanghuaGrid", type = 2}
, 
{grid_skill = "gs_16", icon = "ICON_Grid016", id = 16, info = 25828, name = 371887, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Suichuan"}
, 
{grid_skill = "gs_17", icon = "ICON_Grid017", id = 17, info = 348566, name = 463468, src_name = "FX/LatticeEffect/ArcherGrid-low/FXP_ArcherGrid-low"}
, 
{grid_skill = "gs_18", icon = "ICON_Grid018", id = 18, info = 167307, name = 60227, src_name = "FX/LatticeEffect/BarrierGrid-low/FXP_BarrierGrid-low"}
, 
{grid_skill = "gs_19", icon = "ICON_Grid019", id = 19, info = 442179, name = 90407, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Liebian"}
, 
{grid_skill = "gs_20", icon = "ICON_Grid020", id = 20, info = 46879, name = 53605, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Huiguang"}
, 
{grid_skill = "gs_21", icon = "ICON_Grid021", id = 21, info = 48457, name = 390409, src_name = "FX/LatticeEffect/DataGrid/FXP_DataGrid"}
, 
{grid_skill = "gs_22", id = 22, info = 367196, type = 2}
, 
{grid_skill = "gs_23", id = 23, info = 283949, type = 2}
; 
[100] = {grid_skill = "gs_100", icon = "ICON_Grid100", id = 100, info = 374479, name = 105892, src_name = "FX/LatticeEffect/xiuqi/FXP_xiuqiGrid"}
, 
[101] = {grid_skill = "gs_101", icon = "ICON_Grid101", id = 101, info = 272701, name = 266548, src_name = "FX/LatticeEffect/tilizengyi/FXP_tilizengyiGrid"}
, 
[102] = {effect_info = 15908, grid_skill = "gs_102", icon = "ICON_Grid102", id = 102, info = 128168, name = 150175, src_name = "FX/LatticeEffect/tegongyuzhi/FXP_tegongyuzhiGrid"}
, 
[103] = {grid_skill = "gs_103", icon = "ICON_Grid103", id = 103, info = 82830, name = 104468, src_name = "FX/LatticeEffect/xielizhiliao/FXP_xielizhiliaoGrid"}
, 
[104] = {grid_skill = "gs_104", icon = "ICON_Grid104", id = 104, info = 502197, name = 366393, src_name = "FX/LatticeEffect/xielipaoji/FXP_xielipaojiGrid"}
, 
[105] = {grid_skill = "gs_105", icon = "ICON_Grid105", id = 105, info = 462771, name = 82113, src_name = "FX/LatticeEffect/xieliguwu/FXP_xieliguwuGrid"}
, 
[106] = {grid_skill = "gs_106", icon = "ICON_Grid106", id = 106, info = 23395, name = 325777, src_name = "FX/LatticeEffect/daijiajiaohuan/FXP_daijiajiaohuanGrid"}
, 
[107] = {grid_skill = "gs_107", icon = "ICON_Grid107", id = 107, info = 459201, name = 244480, src_name = "FX/LatticeEffect/xielifangyu/FXP_xilifangyuGrid"}
, 
[108] = {grid_skill = "gs_108", icon = "ICON_Grid108", id = 108, info = 404479, name = 444744, src_name = "FX/LatticeEffect/changwaijuji/FXP_changwaijujiGrid"}
}
local __default_values = {effect_info = "", grid_skill = "gs_1", icon = "ICON_Grid022", id = 1, info = 119819, name = 70210, src_name = "FX/LatticeEffect/LightningGrid/Fxp_LightningGrid", type = 1}
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


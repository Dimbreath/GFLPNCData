local grid_creation = {
{}
, 
{id = 2, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Ridicule"}
, 
{id = 3, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Yueqian"}
, 
{id = 4, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Aim"}
, 
{id = 5, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Smash"}
, 
{id = 6, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_ArcherDefense"}
, 
{id = 7, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_warriorDefense"}
, 
{id = 8, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/NewgroundFX/FXP_Strongblow/FXP_Strongblow"}
, 
{id = 9, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/NewgroundFX/FXP_kuaigong/FXP_kuaigong"}
, 
{id = 10, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Wangyouye"}
, 
{id = 11, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/NewgroundFX/FXP_Weiwangyoucao/FXP_Weiwangyoucao"}
, 
{id = 12, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/NewgroundFX/FXP_Seduce/FXP_Seduce"}
, 
{id = 13, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/NewgroundFX/FXP_Shield/FXP_Shield"}
, 
{id = 14, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/NewgroundFX/FXP_bati/FXP_Bati"}
, 
{id = 15, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_ShanghuaGrid"}
, 
{id = 16, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Suichuan"}
, 
{id = 17, src_name = "FX/LatticeEffect/ArcherGrid-low/FXP_ArcherGrid-low"}
, 
{id = 18, src_name = "FX/LatticeEffect/BarrierGrid-low/FXP_BarrierGrid-low"}
, 
{id = 19, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Liebian"}
, 
{id = 20, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Huiguang"}
, 
{id = 21, src_name = "FX/LatticeEffect/DataGrid/FXP_DataGrid"}
, 
{id = 22, src_name = "FX/LatticeEffect/LightningGrid/Fxp_LightningGrid"}
, 
{id = 23, src_name = "FX/LatticeEffect/LightningGrid/Fxp_LightningGrid"}
, 
{id = 24, src_name = "FX/Obstacle/stone_obstacles/stone_obstacles"}
, 
{id = 25}
, 
{id = 26, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_ShanghuaGrid"}
, 
{id = 27, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_Suichuan"}
; 
[100] = {id = 100, src_name = "FX/LatticeEffect/xiuqi/FXP_xiuqiGrid"}
, 
[101] = {id = 101, src_name = "FX/LatticeEffect/tilizengyi/FXP_tilizengyiGrid"}
, 
[102] = {id = 102, src_name = "FX/LatticeEffect/tegongyuzhi/FXP_tegongyuzhiGrid"}
, 
[103] = {id = 103, src_name = "FX/LatticeEffect/xielizhiliao/FXP_xielizhiliaoGrid"}
, 
[104] = {id = 104, src_name = "FX/LatticeEffect/xielipaoji/FXP_xielipaojiGrid"}
, 
[105] = {id = 105, src_name = "FX/LatticeEffect/xieliguwu/FXP_xieliguwuGrid"}
, 
[106] = {id = 106, src_name = "FX/LatticeEffect/daijiajiaohuan/FXP_daijiajiaohuanGrid"}
, 
[107] = {id = 107, src_name = "FX/LatticeEffect/xielifangyu/FXP_xilifangyuGrid"}
, 
[108] = {id = 108, src_name = "FX/LatticeEffect/changwaijuji/FXP_changwaijujiGrid"}
, 
[200] = {id = 200, src_name = "FX/Obstacle/Fence_obstacles/fence_obstacles"}
}
local __default_values = {id = 1, src_name = "FX/Common/FX_UI/FXP_LatticeEffect/FXP_ReduceCD"}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(grid_creation) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(grid_creation, {__index = __rawdata})
return grid_creation


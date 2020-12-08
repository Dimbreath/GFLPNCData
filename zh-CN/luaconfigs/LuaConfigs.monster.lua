-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {5, 8}
local __rt_2 = {1}
local __rt_3 = {10}
local __rt_4 = {4}
local __rt_5 = {511, 40009, 40010}
local __rt_6 = {9, 4}
local __rt_7 = {2, 3}
local __rt_8 = {7}
local __rt_9 = {8, 2}
local __rt_10 = {500}
local __rt_11 = {12, 6}
local __rt_12 = {12, 4}
local __rt_13 = {}
local monster = {
[20000] = {career = 1, 
enemy_skill = {508, 40020}
, intensity = 2, monster_tag = __rt_1, src_id = 2008}
, 
[20001] = {career = 1, 
enemy_skill = {508, 40020, 40000}
, id = 20001, info = 421258, intensity = 2, monster_tag = __rt_1, src_id = 2008}
, 
[20002] = {career = 1, 
enemy_skill = {504, 40003, 40004, 40022}
, id = 20002, info = 488094, intensity = 3, 
monster_tag = {2, 5, 8}
, name = 335946, src_id = 2005}
, 
[20003] = {career = 1, 
enemy_skill = {510, 40027}
, id = 20003, info = 7919, monster_tag = __rt_2, move_spd = 200, name = 28620, src_id = 2011}
, 
[20004] = {career = 2, 
enemy_skill = {509, 40007}
, id = 20004, info = 301484, monster_tag = __rt_3, move_spd = 50, name = 522987, range = 3, src_id = 2002}
, 
[20005] = {
enemy_skill = {506, 40021}
, id = 20005, info = 74326, monster_tag = __rt_4, move_spd = 150, name = 43724, src_id = 2007}
, 
[20006] = {career = 1, 
enemy_skill = {510, 40027, 40028}
, id = 20006, info = 58161, monster_tag = __rt_2, move_spd = 200, name = 368858, src_id = 2016}
, 
[20007] = {career = 2, 
enemy_skill = {501, 40007, 40006}
, id = 20007, info = 840, 
monster_tag = {6}
, name = 251695, range = 3, src_id = 2002}
, 
[20008] = {camp = 3, career = 2, enemy_skill = __rt_5, id = 20008, info = 44055, intensity = 2, monster_tag = __rt_6, name = 269303, range = 3, src_id = 2012}
, 
[20009] = {camp = 3, career = 2, enemy_skill = __rt_5, id = 20009, info = 474186, intensity = 2, monster_tag = __rt_6, name = 269303, range = 3, src_id = 2012}
, 
[20010] = {
enemy_skill = {506, 40021, 40012}
, id = 20010, info = 172702, monster_tag = __rt_4, move_spd = 150, name = 272858, src_id = 2015}
, 
[20011] = {
enemy_skill = {503, 40013, 40014, 40015}
, id = 20011, info = 95134, intensity = 3, 
monster_tag = {2, 9, 4}
, move_spd = 200, name = 146640, src_id = 2004}
, 
[20012] = {career = 4, 
enemy_skill = {502, 40016}
, id = 20012, info = 451925, intensity = 2, monster_tag = __rt_7, move_spd = 200, name = 397185}
, 
[20013] = {career = 4, 
enemy_skill = {502, 40016, 40018}
, id = 20013, info = 95641, intensity = 2, monster_tag = __rt_7, move_spd = 200, name = 397185}
, 
[20014] = {career = 4, 
enemy_skill = {500, 40019}
, id = 20014, info = 48053, monster_tag = __rt_7, move_spd = 200, name = 105666, src_id = 2001}
, 
[20015] = {career = 4, 
enemy_skill = {500, 40017, 40019}
, id = 20015, info = 56680, monster_tag = __rt_7, move_spd = 200, name = 124780, src_id = 2013}
, 
[20016] = {career = 5, 
enemy_skill = {505, 40024}
, id = 20016, info = 140524, monster_tag = __rt_8, move_spd = 200, name = 431524, range = 5, src_id = 2006}
, 
[20017] = {career = 5, 
enemy_skill = {505, 40023, 40024}
, id = 20017, info = 243719, monster_tag = __rt_8, move_spd = 200, name = 434466, range = 5, src_id = 2017}
, 
[20018] = {career = 4, 
enemy_skill = {502, 40016, 40018, 40021}
, id = 20018, info = 451925, intensity = 4, monster_tag = __rt_7, move_spd = 200, name = 285033}
, 
[20019] = {
enemy_skill = {506}
, id = 20019, info = 170294, monster_tag = __rt_3, move_spd = 150, name = 43724, src_id = 2007}
, 
[20020] = {career = 1, 
enemy_skill = {508, 40020, 40025}
, id = 20020, intensity = 4, monster_tag = __rt_1, src_id = 2008}
, 
[20021] = {career = 2, 
enemy_skill = {509, 40007, 40026}
, id = 20021, info = 408605, monster_tag = __rt_9, name = 251695, range = 3, src_id = 2014}
, 
[20022] = {career = 1, id = 20022, info = 281033, monster_tag = __rt_3, move_spd = 200, name = 28620, src_id = 2011}
, 
[20023] = {camp = 3, career = 2, id = 20023, info = 44055, intensity = 2, monster_tag = __rt_3, name = 269303, range = 3, src_id = 2012}
, 
[20024] = {career = 4, 
enemy_skill = {502}
, id = 20024, info = 451925, intensity = 2, monster_tag = __rt_3, move_spd = 200, name = 397185}
, 
[20025] = {career = 4, id = 20025, info = 173571, monster_tag = __rt_3, move_spd = 200, name = 105666, src_id = 2001}
, 
[20026] = {career = 1, 
enemy_skill = {508}
, id = 20026, intensity = 2, monster_tag = __rt_3, src_id = 2008}
, 
[20027] = {
enemy_skill = {506, 40012}
, id = 20027, info = 170294, monster_tag = __rt_4, move_spd = 150, name = 43724, src_id = 2007}
, 
[20028] = {
enemy_skill = {512, 40029, 40030, 40031}
, id = 20028, info = 74560, intensity = 4, monster_tag = __rt_11, move_spd = 150, name = 139436, src_id = 2009}
, 
[20029] = {
enemy_skill = {513, 40029, 40034, 40032, 40031}
, id = 20029, info = 506745, intensity = 4, monster_tag = __rt_11, move_spd = 150, name = 345371, src_id = 2010}
, 
[20030] = {
enemy_skill = {513, 40029, 40034, 40032, 40033}
, id = 20030, info = 314397, intensity = 4, monster_tag = __rt_12, move_spd = 150, name = 155250, src_id = 2010}
, 
[20031] = {
enemy_skill = {512, 40032, 40033}
, id = 20031, info = 302435, intensity = 4, monster_tag = __rt_12, move_spd = 150, name = 482270, src_id = 2010}
, 
[20032] = {
enemy_skill = {40035}
, id = 20032, info = 467586, intensity = 2, 
monster_tag = {11}
, move_spd = 150, name = 379096, src_id = 2018}
, 
[20033] = {career = 4, 
enemy_skill = {514, 201901, 201902, 201903}
, id = 20033, info = 24116, intensity = 4, move_spd = 120, name = 445870, src_id = 2019}
, 
[20034] = {career = 2, 
enemy_skill = {515, 202001, 202002, 202003}
, id = 20034, info = 194294, intensity = 4, move_spd = 80, name = 20386, range = 10, src_id = 2020}
, 
[20035] = {
enemy_skill = {516, 202101, 202102, 202103}
, id = 20035, info = 480582, intensity = 4, name = 116192, src_id = 2021}
, 
[20036] = {career = 4, 
enemy_skill = {517, 202201, 202202, 202203}
, id = 20036, info = 422318, intensity = 3, name = 186977, src_id = 2022}
, 
[20037] = {career = 5, 
enemy_skill = {518, 202301, 202302, 202303}
, id = 20037, info = 34732, intensity = 3, move_spd = 80, name = 115752, range = 2, src_id = 2023}
, 
[20038] = {
enemy_skill = {519, 202401, 202402}
, id = 20038, info = 437188, intensity = 2, move_spd = 80, name = 100537, src_id = 2024}
, 
[20039] = {
enemy_skill = {520, 202501, 202502}
, id = 20039, info = 166096, intensity = 2, move_spd = 60, name = 201005, src_id = 2025}
, 
[20040] = {career = 2, 
enemy_skill = {521, 202601, 202602, 202603}
, id = 20040, info = 128640, intensity = 3, move_spd = 60, name = 100975, range = 5, src_id = 2026}
, 
[99999] = {career = 2, 
enemy_skill = {509, 40039}
, id = 99999, info = 408605, monster_tag = __rt_9, name = 503272, range = 5, src_id = 2014}
}
local __default_values = {camp = 1, career = 3, enemy_skill = __rt_10, id = 20000, info = 164695, intensity = 1, monster_tag = __rt_13, move_spd = 100, name = 343529, range = 1, src_id = 2003}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(monster) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(monster, {__index = __rawdata})
return monster


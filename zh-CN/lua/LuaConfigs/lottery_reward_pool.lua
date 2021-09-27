local __rt_1 = {}
local __rt_2 = {4}
local __rt_3 = {1002}
local __rt_4 = {3}
local __rt_5 = {5}
local __rt_6 = {2110}
local __rt_7 = {1112}
local __rt_8 = {2106}
local __rt_9 = {3106}
local __rt_10 = {4103}
local __rt_11 = {5103}
local lottery_reward_pool = {
[101] = {
[8] = {id = 8, item_reward = 2008, type = 101}
, 
[10] = {item_reward = 2010, type = 101}
, 
[21] = {id = 21, item_reward = 2016, type = 101}
, 
[27] = {id = 27, item_reward = 2018, type = 101}
, 
[36] = {id = 36, item_reward = 2028, type = 101}
, 
[39] = {id = 39, item_reward = 2025, type = 101}
, 
[40] = {id = 40, item_reward = 2026, type = 101}
, 
[49] = {id = 49, item_reward = 2037, type = 101}
, 
[51] = {id = 51, item_reward = 2039, type = 101}
}
, 
[102] = {
[2] = {id = 2, item_reward = 2002, type = 102}
, 
[6] = {id = 6, item_reward = 2006, type = 102}
, 
[12] = {id = 12, item_reward = 2011, type = 102}
, 
[16] = {id = 16, item_reward = 2013, type = 102}
, 
[20] = {id = 20, item_reward = 2015, type = 102}
, 
[23] = {id = 23, item_reward = 2017, type = 102}
, 
[31] = {id = 31, item_reward = 2019, type = 102}
, 
[38] = {id = 38, item_reward = 2024, type = 102}
, 
[42] = {id = 42, item_reward = 2030, type = 102}
, 
[43] = {id = 43, item_reward = 2031, type = 102}
, 
[44] = {id = 44, item_reward = 2032, type = 102}
, 
[45] = {id = 45, item_reward = 2033, type = 102}
, 
[50] = {id = 50, item_reward = 2038, type = 102}
, 
[52] = {id = 52, item_reward = 2040, type = 102}
}
, 
[103] = {
[4] = {id = 4, item_reward = 2004, type = 103}
, 
[7] = {id = 7, item_reward = 2007, type = 103}
, 
[9] = {id = 9, type = 103}
, 
[13] = {id = 13, item_reward = 2012, type = 103}
, 
[17] = {id = 17, item_reward = 2014, type = 103}
, 
[34] = {id = 34, item_reward = 2020, type = 103}
, 
[35] = {id = 35, item_reward = 2021, type = 103}
, 
[37] = {id = 37, item_reward = 2023, type = 103}
, 
[41] = {id = 41, item_reward = 2027, type = 103}
, 
[46] = {id = 46, item_reward = 2034, type = 103}
, 
[47] = {id = 47, item_reward = 2035, type = 103}
, 
[48] = {id = 48, item_reward = 2036, type = 103}
}
, 
[201] = {
{id = 1, type = 201}
, 
{id = 2, item_reward = 2023, type = 201}
, 
{id = 3, item_reward = 2035, type = 201}
, 
{id = 4, item_reward = 2031, pre_condition = __rt_2, pre_para1 = __rt_3, pre_para2 = __rt_4, type = 201}
, 
{id = 5, item_reward = 2013, pre_condition = __rt_2, pre_para1 = __rt_3, pre_para2 = __rt_4, type = 201}
, 
{id = 6, item_reward = 2017, pre_condition = __rt_2, pre_para1 = __rt_3, pre_para2 = __rt_2, type = 201}
, 
{id = 7, item_reward = 2024, pre_condition = __rt_2, pre_para1 = __rt_3, pre_para2 = __rt_2, type = 201}
, 
{id = 8, item_reward = 2016, pre_condition = __rt_2, pre_para1 = __rt_3, pre_para2 = __rt_5, type = 201}
, 
{id = 9, item_reward = 2008, pre_condition = __rt_2, pre_para1 = __rt_3, pre_para2 = __rt_5, type = 201}
}
, 
[202] = {
[10] = {item_reward = 1006}
, 
[11] = {id = 11, item_reward = 1006}
, 
[12] = {id = 12, item_reward = 1006}
, 
[13] = {id = 13, item_reward = 1006}
, 
[84] = {id = 84, item_reward = 2502}
, 
[85] = {id = 85, item_reward = 2503}
, 
[86] = {id = 86, item_reward = 2504}
, 
[87] = {id = 87, item_reward = 2505}
, 
[88] = {id = 88, item_reward = 2506}
, 
[89] = {id = 89, item_reward = 2507}
, 
[90] = {id = 90, item_reward = 2508}
, 
[91] = {id = 91, item_reward = 2509}
, 
[92] = {id = 92, item_reward = 2510}
, 
[93] = {id = 93, item_reward = 2511}
, 
[94] = {id = 94, item_reward = 2512}
, 
[95] = {id = 95, item_reward = 2513}
, 
[96] = {id = 96, item_reward = 2514}
, 
[97] = {id = 97, item_reward = 2515}
, 
[98] = {id = 98, item_reward = 2516}
, 
[99] = {id = 99, item_reward = 2517}
, 
[100] = {id = 100, item_reward = 2518}
, 
[101] = {id = 101, item_reward = 2519}
, 
[102] = {id = 102, item_reward = 2520}
, 
[103] = {id = 103, item_reward = 2521}
, 
[104] = {id = 104, item_reward = 2523}
, 
[105] = {id = 105, item_reward = 2524}
, 
[106] = {id = 106, item_reward = 2525}
, 
[107] = {id = 107, item_reward = 2526}
, 
[108] = {id = 108, item_reward = 2527}
, 
[109] = {id = 109, item_reward = 2528}
, 
[110] = {id = 110, item_reward = 2529}
, 
[111] = {id = 111, item_reward = 2530}
, 
[112] = {id = 112, item_reward = 2531}
, 
[113] = {id = 113, item_reward = 2532}
, 
[114] = {id = 114, item_reward = 2533}
, 
[115] = {id = 115, item_reward = 2534}
, 
[116] = {id = 116, item_reward = 2535}
, 
[117] = {id = 117, item_reward = 2536}
, 
[118] = {id = 118, item_reward = 2537}
, 
[119] = {id = 119, item_reward = 2538}
, 
[120] = {id = 120, item_reward = 2539}
, 
[121] = {id = 121, item_reward = 2540}
}
, 
[203] = {
[14] = {id = 14, item_reward = 5001, type = 203}
, 
[15] = {id = 15, item_reward = 5001, pre_condition = __rt_4, 
pre_para1 = {2101}
, type = 203}
, 
[16] = {id = 16, item_reward = 5002, pre_condition = __rt_4, 
pre_para1 = {3101}
, type = 203}
, 
[17] = {id = 17, item_reward = 5002, pre_condition = __rt_4, 
pre_para1 = {3105}
, type = 203}
, 
[18] = {id = 18, item_reward = 5002, pre_condition = __rt_4, 
pre_para1 = {3110}
, type = 203}
, 
[19] = {id = 19, item_reward = 5007, pre_condition = __rt_4, 
pre_para1 = {4101}
, type = 203}
, 
[20] = {id = 20, item_reward = 1101, pre_condition = __rt_4, pre_para1 = __rt_6, type = 203}
, 
[21] = {id = 21, item_reward = 1102, pre_condition = __rt_4, pre_para1 = __rt_6, type = 203}
, 
[22] = {id = 22, item_reward = 1103, pre_condition = __rt_4, pre_para1 = __rt_6, type = 203}
, 
[23] = {id = 23, item_reward = 1107, pre_condition = __rt_4, pre_para1 = __rt_6, type = 203}
, 
[24] = {id = 24, item_reward = 1108, pre_condition = __rt_4, pre_para1 = __rt_6, type = 203}
, 
[25] = {id = 25, item_reward = 1109, pre_condition = __rt_4, pre_para1 = __rt_6, type = 203}
, 
[26] = {id = 26, item_reward = 1113, pre_condition = __rt_4, pre_para1 = __rt_6, type = 203}
, 
[27] = {id = 27, item_reward = 1114, pre_condition = __rt_4, pre_para1 = __rt_6, type = 203}
, 
[28] = {id = 28, item_reward = 1115, pre_condition = __rt_4, pre_para1 = __rt_6, type = 203}
, 
[29] = {id = 29, item_reward = 3100, type = 203}
, 
[30] = {id = 30, item_reward = 3101, type = 203}
, 
[31] = {id = 31, item_reward = 3102, type = 203}
, 
[32] = {id = 32, item_reward = 3103, type = 203}
, 
[33] = {id = 33, item_reward = 3104, type = 203}
, 
[34] = {id = 34, item_reward = 3105, type = 203}
, 
[35] = {id = 35, item_reward = 3106, type = 203}
, 
[36] = {id = 36, item_reward = 3107, type = 203}
, 
[37] = {id = 37, item_reward = 3108, type = 203}
, 
[38] = {id = 38, item_reward = 3109, type = 203}
, 
[39] = {id = 39, item_reward = 3110, type = 203}
, 
[40] = {id = 40, item_reward = 3111, type = 203}
, 
[41] = {id = 41, item_reward = 3112, type = 203}
, 
[42] = {id = 42, item_reward = 3113, type = 203}
, 
[43] = {id = 43, item_reward = 3114, type = 203}
, 
[44] = {id = 44, item_reward = 3115, type = 203}
, 
[45] = {id = 45, item_reward = 3116, type = 203}
, 
[46] = {id = 46, item_reward = 3117, type = 203}
, 
[47] = {id = 47, item_reward = 3118, type = 203}
, 
[48] = {id = 48, item_reward = 3119, type = 203}
, 
[49] = {id = 49, item_reward = 3120, type = 203}
, 
[50] = {id = 50, item_reward = 3121, type = 203}
, 
[51] = {id = 51, item_reward = 3122, type = 203}
, 
[52] = {id = 52, item_reward = 3123, type = 203}
}
, 
[204] = {
[53] = {id = 53, item_reward = 1801, type = 204}
, 
[54] = {id = 54, item_reward = 1802, type = 204}
, 
[55] = {id = 55, item_reward = 1803, type = 204}
, 
[56] = {id = 56, item_reward = 1804, type = 204}
, 
[57] = {id = 57, item_reward = 1805, type = 204}
, 
[58] = {id = 58, item_reward = 1806, pre_condition = __rt_4, pre_para1 = __rt_7, type = 204}
, 
[59] = {id = 59, item_reward = 1807, pre_condition = __rt_4, pre_para1 = __rt_7, type = 204}
, 
[60] = {id = 60, item_reward = 1808, pre_condition = __rt_4, pre_para1 = __rt_7, type = 204}
, 
[61] = {id = 61, item_reward = 1809, pre_condition = __rt_4, pre_para1 = __rt_7, type = 204}
, 
[62] = {id = 62, item_reward = 1810, pre_condition = __rt_4, pre_para1 = __rt_7, type = 204}
, 
[63] = {id = 63, item_reward = 1811, pre_condition = __rt_4, pre_para1 = __rt_8, type = 204}
, 
[64] = {id = 64, item_reward = 1812, pre_condition = __rt_4, pre_para1 = __rt_8, type = 204}
, 
[65] = {id = 65, item_reward = 1813, pre_condition = __rt_4, pre_para1 = __rt_8, type = 204}
, 
[66] = {id = 66, item_reward = 1814, pre_condition = __rt_4, pre_para1 = __rt_8, type = 204}
, 
[67] = {id = 67, item_reward = 1815, pre_condition = __rt_4, pre_para1 = __rt_8, type = 204}
, 
[68] = {id = 68, item_reward = 1816, pre_condition = __rt_4, pre_para1 = __rt_9, type = 204}
, 
[69] = {id = 69, item_reward = 1817, pre_condition = __rt_4, pre_para1 = __rt_9, type = 204}
, 
[70] = {id = 70, item_reward = 1818, pre_condition = __rt_4, pre_para1 = __rt_9, type = 204}
, 
[71] = {id = 71, item_reward = 1819, pre_condition = __rt_4, pre_para1 = __rt_9, type = 204}
, 
[72] = {id = 72, item_reward = 1820, pre_condition = __rt_4, pre_para1 = __rt_9, type = 204}
, 
[73] = {id = 73, item_reward = 1821, pre_condition = __rt_4, pre_para1 = __rt_10, type = 204}
, 
[74] = {id = 74, item_reward = 1822, pre_condition = __rt_4, pre_para1 = __rt_10, type = 204}
, 
[75] = {id = 75, item_reward = 1823, pre_condition = __rt_4, pre_para1 = __rt_10, type = 204}
, 
[76] = {id = 76, item_reward = 1824, pre_condition = __rt_4, pre_para1 = __rt_10, type = 204}
, 
[77] = {id = 77, item_reward = 1825, pre_condition = __rt_4, pre_para1 = __rt_10, type = 204}
, 
[78] = {id = 78, item_reward = 1821, pre_condition = __rt_4, pre_para1 = __rt_11, type = 204}
, 
[79] = {id = 79, item_reward = 1822, pre_condition = __rt_4, pre_para1 = __rt_11, type = 204}
, 
[80] = {id = 80, item_reward = 1823, pre_condition = __rt_4, pre_para1 = __rt_11, type = 204}
, 
[81] = {id = 81, item_reward = 1824, pre_condition = __rt_4, pre_para1 = __rt_11, type = 204}
, 
[82] = {id = 82, item_reward = 1825, pre_condition = __rt_4, pre_para1 = __rt_11, type = 204}
, 
[83] = {id = 83, item_reward = 2501, type = 204}
}
, 
[401] = {
[6] = {id = 6, item_reward = 2010, type = 401}
, 
[12] = {id = 12, item_reward = 2016, type = 401}
, 
[14] = {id = 14, item_reward = 2018, type = 401}
, 
[20] = {id = 20, item_reward = 2025, type = 401}
, 
[21] = {id = 21, item_reward = 2026, type = 401}
, 
[23] = {id = 23, item_reward = 2028, type = 401}
, 
[31] = {id = 31, item_reward = 2037, type = 401}
, 
[33] = {id = 33, item_reward = 2039, type = 401}
}
, 
[402] = {
{id = 1, item_reward = 2002, type = 402}
; 
[3] = {id = 3, item_reward = 2006, type = 402}
, 
[7] = {id = 7, item_reward = 2011, type = 402}
, 
[9] = {id = 9, item_reward = 2013, type = 402}
, 
[11] = {id = 11, item_reward = 2015, type = 402}
, 
[13] = {id = 13, item_reward = 2017, type = 402}
, 
[15] = {id = 15, item_reward = 2019, type = 402}
, 
[19] = {id = 19, item_reward = 2024, type = 402}
, 
[24] = {id = 24, item_reward = 2030, type = 402}
, 
[25] = {id = 25, item_reward = 2031, type = 402}
, 
[26] = {id = 26, item_reward = 2032, type = 402}
, 
[27] = {id = 27, item_reward = 2033, type = 402}
, 
[32] = {id = 32, item_reward = 2038, type = 402}
, 
[34] = {id = 34, item_reward = 2040, type = 402}
}
, 
[403] = {
[2] = {id = 2, item_reward = 2004, type = 403}
, 
[4] = {id = 4, item_reward = 2007, type = 403}
, 
[5] = {id = 5, type = 403}
, 
[8] = {id = 8, item_reward = 2012, type = 403}
, 
[10] = {item_reward = 2014, type = 403}
, 
[16] = {id = 16, item_reward = 2020, type = 403}
, 
[17] = {id = 17, item_reward = 2021, type = 403}
, 
[18] = {id = 18, item_reward = 2023, type = 403}
, 
[22] = {id = 22, item_reward = 2027, type = 403}
, 
[28] = {id = 28, item_reward = 2034, type = 403}
, 
[29] = {id = 29, item_reward = 2035, type = 403}
, 
[30] = {id = 30, item_reward = 2036, type = 403}
}
, 
[501] = {
[5] = {id = 5, item_reward = 2008, type = 501}
, 
[7] = {id = 7, item_reward = 2010, type = 501}
, 
[13] = {id = 13, item_reward = 2016, type = 501}
, 
[15] = {id = 15, item_reward = 2018, type = 501}
, 
[21] = {id = 21, item_reward = 2025, type = 501}
, 
[22] = {id = 22, item_reward = 2026, type = 501}
, 
[24] = {id = 24, item_reward = 2028, type = 501}
, 
[32] = {id = 32, item_reward = 2037, type = 501}
, 
[34] = {id = 34, item_reward = 2039, type = 501}
}
, 
[502] = {
{id = 1, item_reward = 2002, type = 502}
; 
[3] = {id = 3, item_reward = 2006, type = 502}
, 
[8] = {id = 8, item_reward = 2011, type = 502}
, 
[10] = {item_reward = 2013, type = 502}
, 
[12] = {id = 12, item_reward = 2015, type = 502}
, 
[14] = {id = 14, item_reward = 2017, type = 502}
, 
[16] = {id = 16, item_reward = 2019, type = 502}
, 
[20] = {id = 20, item_reward = 2024, type = 502}
, 
[25] = {id = 25, item_reward = 2030, type = 502}
, 
[26] = {id = 26, item_reward = 2031, type = 502}
, 
[27] = {id = 27, item_reward = 2032, type = 502}
, 
[28] = {id = 28, item_reward = 2033, type = 502}
, 
[33] = {id = 33, item_reward = 2038, type = 502}
, 
[35] = {id = 35, item_reward = 2040, type = 502}
}
, 
[503] = {
[2] = {id = 2, item_reward = 2004, type = 503}
, 
[4] = {id = 4, item_reward = 2007, type = 503}
, 
[6] = {id = 6, type = 503}
, 
[9] = {id = 9, item_reward = 2012, type = 503}
, 
[11] = {id = 11, item_reward = 2014, type = 503}
, 
[17] = {id = 17, item_reward = 2020, type = 503}
, 
[18] = {id = 18, item_reward = 2021, type = 503}
, 
[19] = {id = 19, item_reward = 2023, type = 503}
, 
[23] = {id = 23, item_reward = 2027, type = 503}
, 
[29] = {id = 29, item_reward = 2034, type = 503}
, 
[30] = {id = 30, item_reward = 2035, type = 503}
, 
[31] = {id = 31, item_reward = 2036, type = 503}
}
, 
[601] = {
[5] = {id = 5, item_reward = 2008, type = 601}
, 
[7] = {id = 7, item_reward = 2010, type = 601}
, 
[14] = {id = 14, item_reward = 2018, type = 601}
, 
[18] = {id = 18, item_reward = 2022, type = 601}
, 
[21] = {id = 21, item_reward = 2025, type = 601}
, 
[22] = {id = 22, item_reward = 2026, type = 601}
, 
[24] = {id = 24, item_reward = 2028, type = 601}
, 
[33] = {id = 33, item_reward = 2039, type = 601}
}
, 
[602] = {
{id = 1, item_reward = 2002, type = 602}
; 
[3] = {id = 3, item_reward = 2006, type = 602}
, 
[8] = {id = 8, item_reward = 2011, type = 602}
, 
[10] = {item_reward = 2013, type = 602}
, 
[12] = {id = 12, item_reward = 2015, type = 602}
, 
[13] = {id = 13, item_reward = 2017, type = 602}
, 
[15] = {id = 15, item_reward = 2019, type = 602}
, 
[20] = {id = 20, item_reward = 2024, type = 602}
, 
[25] = {id = 25, item_reward = 2030, type = 602}
, 
[26] = {id = 26, item_reward = 2031, type = 602}
, 
[27] = {id = 27, item_reward = 2032, type = 602}
, 
[28] = {id = 28, item_reward = 2033, type = 602}
, 
[32] = {id = 32, item_reward = 2038, type = 602}
, 
[34] = {id = 34, item_reward = 2040, type = 602}
}
, 
[603] = {
[2] = {id = 2, item_reward = 2004, type = 603}
, 
[4] = {id = 4, item_reward = 2007, type = 603}
, 
[6] = {id = 6, type = 603}
, 
[9] = {id = 9, item_reward = 2012, type = 603}
, 
[11] = {id = 11, item_reward = 2014, type = 603}
, 
[16] = {id = 16, item_reward = 2020, type = 603}
, 
[17] = {id = 17, item_reward = 2021, type = 603}
, 
[19] = {id = 19, item_reward = 2023, type = 603}
, 
[23] = {id = 23, item_reward = 2027, type = 603}
, 
[29] = {id = 29, item_reward = 2034, type = 603}
, 
[30] = {id = 30, item_reward = 2035, type = 603}
, 
[31] = {id = 31, item_reward = 2036, type = 603}
}
}
local __default_values = {id = 10, item_reward = 2009, pre_condition = __rt_1, pre_para1 = __rt_1, pre_para2 = __rt_1, type = 202}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in (_ENV.pairs)(lottery_reward_pool) do
  for k1,v1 in (_ENV.pairs)(v) do
    (_ENV.setmetatable)(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
;
(_ENV.setmetatable)(lottery_reward_pool, {__index = __rawdata})
return lottery_reward_pool


-- params : ...
-- function num : 0 , upvalues : _ENV
local attr_combat = {
[101] = {formula = "(tab[2]*1+tab[3]*24+tab[4]*43+tab[5]*38+tab[6]*0+tab[7]*34+tab[9]*31+tab[10]*25+tab[11]*0+tab[12]*43+tab[13]*0+tab[14]*43+tab[15]*1+tab[16]*0+tab[26]*24+tab[17]*17+tab[18]*17+tab[19]*64+tab[20]*64+tab[21]*43+tab[22]*43+tab[23]*34+tab[24]*43+tab[25]*77)*20//100-3350", id = 101}
, 
[102] = {formula = "(tab[2]*1+tab[3]*24+tab[4]*43+tab[5]*38+tab[6]*0+tab[7]*34+tab[9]*31+tab[10]*25+tab[11]*0+tab[12]*43+tab[13]*0+tab[14]*43+tab[15]*1+tab[16]*0+tab[26]*24+tab[17]*17+tab[18]*17+tab[19]*64+tab[20]*64+tab[21]*43+tab[22]*43+tab[23]*34+tab[24]*43+tab[25]*77+tab[202]*15+tab[203]*15+tab[204]*15+tab[212]*15+tab[226]*15)*2//10", id = 102}
, 
[103] = {formula = "((tab[2]*1+tab[3]*24+tab[4]*43+tab[5]*38+tab[6]*0+tab[7]*34+tab[9]*31+tab[10]*25+tab[11]*0+tab[12]*43+tab[13]*0+tab[14]*43+tab[15]*1+tab[16]*0+tab[26]*24+tab[17]*17+tab[18]*17+tab[19]*64+tab[20]*64+tab[21]*43+tab[22]*43+tab[23]*34+tab[24]*43+tab[25]*77)*20//100-3350)*math.min(1,2*tab[1]/tab[2])", id = 103}
, 
[104] = {formula = "tab.power//10", id = 104}
, 
[105] = {formula = "tab.lv>10 and (1+((tab.lv-10)/10+4.5)*0.8) or (tab.lv>1 and ( 1+((tab.lv-1)*1-((tab.lv-0)*(tab.lv-1)*0.05))*0.8) or ( 1+(tab.lv-1)*0.9 ) )", id = 105}
, 
[106] = {id = 106}
, 
[107] = {id = 107}
, 
[108] = {formula = "((tab[2]*1+tab[3]*24+tab[4]*43+tab[5]*38+tab[6]*0+tab[7]*34+tab[9]*31+tab[10]*25+tab[11]*0+tab[12]*43+tab[13]*0+tab[15]*1+tab[16]*0+tab[26]*24+tab[17]*17+tab[18]*17+tab[19]*4+tab[20]*4+tab[21]*43+tab[22]*43+tab[23]*34+tab[24]*43+tab[25]*77)*20//100-3350)*math.min(1,2*tab[1]/tab[2])", id = 108}
, 
[1000] = {}
}
local __default_values = {formula = "", id = 1000}
local base = {__index = __default_values}
for k,v in pairs(attr_combat) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(attr_combat, {__index = __rawdata})
return attr_combat


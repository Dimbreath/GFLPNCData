-- params : ...
-- function num : 0 , upvalues : _ENV
local attr_combat = {
[101] = {formula = "(tab[2]*1+tab[3]*21+tab[4]*39+tab[5]*62+tab[6]*0+tab[7]*31+tab[9]*25+tab[10]*20+tab[11]*0+tab[12]*39+tab[13]*0+tab[15]*1+tab[16]*0+tab[26]*21)*20//100-3300"}
, 
[102] = {formula = "(tab[2]*1+tab[3]*8+tab[4]*12+tab[5]*35+tab[6]*0+tab[7]*14+tab[8]*0+tab[9]*14+tab[10]*11+tab[11]*0+tab[12]*12+tab[13]*0+tab[14]*17+tab[15]*1+tab[16]*0+tab[26]*8+tab[202]*6+tab[203]*6+tab[204]*4+tab[212]*4+tab[226]*6)*2//10", id = 102}
, 
[103] = {formula = "((tab[2]*1+tab[3]*21+tab[4]*39+tab[5]*62+tab[6]*0+tab[7]*31+tab[9]*25+tab[10]*20+tab[11]*0+tab[12]*39+tab[13]*0+tab[15]*1+tab[16]*0+tab[26]*21)*20//100-3300)*math.min(1,2*tab[1]/tab[2])", id = 103}
, 
[104] = {formula = "tab.power//10", id = 104}
, 
[105] = {formula = "tab.lv>10 and (1+((tab.lv-10)/10+4.5)*0.8) or (tab.lv>1 and ( 1+((tab.lv-1)*1-((tab.lv-0)*(tab.lv-1)*0.05))*0.8) or ( 1+(tab.lv-1)*0.9 ) )", id = 105}
, 
[106] = {id = 106}
, 
[107] = {id = 107}
}
local __default_values = {formula = "", id = 101}
local base = {__index = __default_values}
for k,v in pairs(attr_combat) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(attr_combat, {__index = __rawdata})
return attr_combat


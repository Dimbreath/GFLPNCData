-- params : ...
-- function num : 0 , upvalues : _ENV
local attr_combat = {
[101] = {formula = "(atr[2]*1+atr[3]*8+atr[4]*12+atr[5]*35+atr[6]*0+atr[7]*14+atr[8]*0+atr[9]*14+atr[10]*11+atr[11]*0+atr[12]*12+atr[13]*0+atr[14]*17+atr[15]*1+atr[16]*0+atr[26]*8)*2//10-1750"}
, 
[102] = {formula = "(atr[2]*1+atr[3]*8+atr[4]*12+atr[5]*35+atr[6]*0+atr[7]*14+atr[8]*0+atr[9]*14+atr[10]*11+atr[11]*0+atr[12]*12+atr[13]*0+atr[14]*17+atr[15]*1+atr[16]*0+atr[202]*6+atr[203]*6+atr[204]*4+atr[212]*4)*2//10", id = 102}
, 
[103] = {id = 103}
}
local __default_values = {formula = "((atr[2]*1+atr[3]*8+atr[4]*12+atr[5]*35+atr[6]*0+atr[7]*14+atr[8]*0+atr[9]*14+atr[10]*11+atr[11]*0+atr[12]*12+atr[13]*0+atr[14]*17+atr[15]*1+atr[16]*0+atr[26]*8)*2//10-1750)*math.min(1,2*atr[1]/atr[2])", id = 101}
local base = {__index = __default_values}
for k,v in pairs(attr_combat) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(attr_combat, {__index = __rawdata})
return attr_combat


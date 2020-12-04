-- params : ...
-- function num : 0 , upvalues : _ENV
local isOpenHotfix = ((CS.GlobalRegister).IsOpenHotfix)()
require("Hotfix.HotfixBase")
HotfixMain = {
hotmod = {}
}
local modules = {"Hotfix.Hotfix_BattleSkillCasterEntity"}
local Start = function()
  -- function num : 0_0 , upvalues : isOpenHotfix, _ENV, modules
  if not isOpenHotfix then
    return 
  end
  print("HotfixMain start...")
  for _,v in ipairs(modules) do
    local hotfix_class = reimport(v)
    local hotfix_inst = (hotfix_class.New)()
    hotfix_inst:Register()
    ;
    (table.insert)(HotfixMain.hotmod, hotfix_inst)
  end
end

local Stop = function()
  -- function num : 0_1 , upvalues : isOpenHotfix, _ENV
  if not isOpenHotfix then
    return 
  end
  print("HotfixMain stop...")
  for _,v in ipairs(HotfixMain.hotmod) do
    if v ~= nil then
      v:UnRegister()
    end
  end
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  HotfixMain.hotmod = {}
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

HotfixMain.modules = modules
-- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

HotfixMain.Start = Start
-- DECOMPILER ERROR at PC21: Confused about usage of register: R4 in 'UnsetPending'

HotfixMain.Stop = Stop
return HotfixMain


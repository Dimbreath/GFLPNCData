-- params : ...
-- function num : 0 , upvalues : _ENV
HotfixBase = class("HotfixBase")
local util = nil
-- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

HotfixBase.ctor = function(self)
    -- function num : 0_0
    self.hotfixList = {}
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

HotfixBase.Register = function(self)
    -- function num : 0_1
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

HotfixBase.RegisterHotfix = function(self, cs_type, cs_func, fix_func,
                                     retain_old)
    -- function num : 0_2 , upvalues : util, _ENV
    if not retain_old then retain_old = false end
    if retain_old then
        if not util then
            util = require("XLua.Common.util");
            (util.hotfix_ex)(cs_type, cs_func, fix_func);
            (xlua.hotfix)(cs_type, cs_func, fix_func)
            local hotfix = {}
            hotfix.cs_type = cs_type
            hotfix.cs_func = cs_func;
            (table.insert)(self.hotfixList, hotfix)
        end
    end
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

HotfixBase.UnRegister = function(self)
    -- function num : 0_3 , upvalues : _ENV
    for _, v in ipairs(self.hotfixList) do
        (xlua.hotfix)(v.cs_type, v.cs_func, nil)
    end
    self.hotfixList = {}
end


-- params : ...
-- function num : 0 , upvalues : _ENV
UIUtil = {}
local cst_LuaBinding = typeof(((CS.XLua).Binding).LuaBinding)
local Stack = require("Framework.Lib.Stack")
-- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.AddButtonListener = function(btn, tbl, callback)
    -- function num : 0_0 , upvalues : _ENV
    local onClick = BindCallback(tbl, callback);
    (btn.onClick):AddListener(onClick)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.AddButtonListenerWithArg = function(btn, tbl, callback, ...)
    -- function num : 0_1 , upvalues : _ENV
    local onClick = BindCallback(tbl, callback, ...);
    (btn.onClick):AddListener(onClick)
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.AddValueChangedListener = function(obj, tbl, callback, ...)
    -- function num : 0_2 , upvalues : _ENV
    local valueChange = BindCallback(tbl, callback, ...);
    (obj.onValueChanged):AddListener(valueChange)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.LuaUIBindingTable = function(obj, tab)
    -- function num : 0_3 , upvalues : cst_LuaBinding, _ENV
    if tab == nil then return end
    local uibinding = obj:GetComponent(cst_LuaBinding)
    if IsNull(uibinding) then return end
    local vars = (uibinding.variables).Variables
    for i = 0, vars.Count - 1 do
        local value = (vars[i]):GetValue()
        if (vars[i]).VariableTypeInt == 11 then
            local valueTab = {}
            tab[(vars[i]).Name] = valueTab
            for i = 0, value.Length - 1 do
                (table.insert)(valueTab, (value[i]):GetValue())
            end
        else
            do
                do
                    tab[(vars[i]).Name] = value
                    -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_STMT

                end
            end
        end
    end
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.backStack = (Stack.New)()
-- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.CreateTopBtnGroup = function(go, tab, backFunc, isNotPushStack)
    -- function num : 0_4 , upvalues : _ENV
    if not isNotPushStack then
        (UIUtil.backStack):Push(BindCallback(tab, backFunc))
    end
    local UINTopBtnGroup = require("Game.Common.UINTopBtnGroup")
    local topGroup = (UINTopBtnGroup.New)()
    topGroup:Init(go)
    topGroup:SetBackClickAction(BindCallback(tab, backFunc))
    return topGroup
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.OnClickBack = function()
    -- function num : 0_5 , upvalues : _ENV
    local cb = (UIUtil.backStack):Pop()
    if cb ~= nil and cb(false) == false then (UIUtil.backStack):Push(cb) end
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.ReturnHome = function()
    -- function num : 0_6 , upvalues : _ENV
    local loopCount = 0
    while not (UIUtil.backStack):Empty() do
        if loopCount > 100 then
            error("返回栈溢出")
            return
        end
        loopCount = loopCount + 1
        local cb = (UIUtil.backStack):Pop()
        if cb == nil or cb(true) == false then
            (UIUtil.backStack):Push(cb)
        end
    end
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.Push2BackStack = function(...)
    -- function num : 0_7 , upvalues : _ENV
    local params = SafePack(...)
    assert(params.n >= 1, "error params count!")
    if type(params[1]) == "table" and type(params[2]) == "function" then
        (UIUtil.backStack):Push(BindCallback(params[1], params[2]))
    elseif type(params[1]) == "function" then
        (UIUtil.backStack):Push(params[1])
    end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.PopFromBackStack = function(...)
    -- function num : 0_8 , upvalues : _ENV
    (UIUtil.backStack):Pop()
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.PeekBackStack = function()
    -- function num : 0_9 , upvalues : _ENV
    return (UIUtil.backStack):Peek()
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.ClearTopHome = function()
    -- function num : 0_10 , upvalues : _ENV
    (UIUtil.backStack):Clear()
end


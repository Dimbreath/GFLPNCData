-- params : ...
-- function num : 0 , upvalues : _ENV
local string = require("string")
local table = require("table")
if not unpack then local unpack = table.unpack end
local base = _G
local _M = {}
if module then ltn12 = _M end
local filter, source, sink, pump = {}, {}, {}, {}
_M.filter = filter
_M.source = source
_M.sink = sink
_M.pump = pump
if not unpack then local unpack = table.unpack end
local select = base.select
_M.BLOCKSIZE = 2048
_M._VERSION = "LTN12 1.0.3"
filter.cycle = function(low, ctx, extra)
    -- function num : 0_0 , upvalues : base
    (base.assert)(low)
    return function(chunk)
        -- function num : 0_0_0 , upvalues : ctx, low, extra
        local ret = nil
        ret = low(ctx, chunk, extra)
        return ret
    end

end

filter.chain = function(...)
    -- function num : 0_1 , upvalues : base
    local arg = {...}
    local n = (base.select)("#", ...)
    local top, index = 1, 1
    local retry = ""
    return function(chunk)
        -- function num : 0_1_0 , upvalues : retry, index, top, arg, n, base
        retry = not chunk or retry
        while 1 do
            while 1 do
                while 1 do
                    while 1 do
                        while 1 do
                            while 1 do
                                while 1 do
                                    if index == top then
                                        chunk = (arg[index])(chunk)
                                        if chunk == "" or top == n then
                                            do
                                                return chunk
                                            end
                                            -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                            -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_STMT

                                            -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                            -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_STMT

                                        end
                                    end
                                end
                                if chunk then
                                    index = index + 1
                                    -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                    -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_STMT

                                end
                            end
                            top = top + 1
                            index = top
                        end
                        chunk = (arg[index])(chunk or "")
                        if chunk == "" then
                            index = index - 1
                            chunk = retry
                            -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out IF_STMT

                        end
                    end
                    if chunk then
                        if index == n then
                            do return chunk end
                            -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_STMT

                        end
                    end
                end
                index = index + 1
            end
            (base.error)("filter returned inappropriate nil")
        end
    end

end

local empty = function()
    -- function num : 0_2
    return nil
end

source.empty = function()
    -- function num : 0_3 , upvalues : empty
    return empty
end

source.error = function(err)
    -- function num : 0_4
    return function()
        -- function num : 0_4_0 , upvalues : err
        return nil, err
    end

end

source.file = function(handle, io_err)
    -- function num : 0_5 , upvalues : _M, source
    if handle then
        return function()
            -- function num : 0_5_0 , upvalues : handle, _M
            local chunk = handle:read(_M.BLOCKSIZE)
            if not chunk then handle:close() end
            return chunk
        end

    else
        return (source.error)(io_err or "unable to open file")
    end
end

source.simplify = function(src)
    -- function num : 0_6 , upvalues : base
    (base.assert)(src)
    return function()
        -- function num : 0_6_0 , upvalues : src
        local chunk, err_or_new = src()
        src = err_or_new or src
        if not chunk then
            return nil, err_or_new
        else
            return chunk
        end
    end

end

source.string = function(s)
    -- function num : 0_7 , upvalues : string, _M, source
    if s then
        local i = 1
        do
            return function()
                -- function num : 0_7_0 , upvalues : string, s, i, _M
                local chunk = (string.sub)(s, i, i + _M.BLOCKSIZE - 1)
                i = i + _M.BLOCKSIZE
                if chunk ~= "" then
                    return chunk
                else
                    return nil
                end
            end

        end
    else
        do do return (source.empty)() end end
    end
end

source.rewind = function(src)
    -- function num : 0_8 , upvalues : base, table
    (base.assert)(src)
    local t = {}
    return function(chunk)
        -- function num : 0_8_0 , upvalues : table, t, src
        if not chunk then
            chunk = (table.remove)(t)
            if not chunk then
                return src()
            else
                return chunk
            end
        else

            (table.insert)(t, chunk)
        end
    end

end

source.chain = function(src, f, ...)
    -- function num : 0_9 , upvalues : filter, base
    if ... then f = (filter.chain)(f, ...) end
    (base.assert)(not src or f)
    local last_in, last_out = "", ""
    local state = "feeding"
    local err = nil
    return function()
        -- function num : 0_9_0 , upvalues : last_out, base, state, last_in, err, src, f
        if not last_out then (base.error)("source is empty!", 2) end
        while 1 do
            while 1 do
                while 1 do
                    while 1 do
                        while 1 do
                            while 1 do
                                while 1 do
                                    while 1 do
                                        if state == "feeding" then
                                            last_in = src()
                                            if err then
                                                return nil, err
                                            end
                                            last_out = f(last_in)
                                            if not last_out then
                                                if last_in then
                                                    (base.error)(
                                                        "filter returned inappropriate nil")
                                                    -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                    -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out IF_STMT

                                                    -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                    -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out IF_STMT

                                                    -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                    -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out IF_STMT

                                                end
                                            end
                                        end
                                    end
                                    return nil
                                end
                                if last_out ~= "" then
                                    state = "eating"
                                    if last_in then
                                        last_in = ""
                                    end
                                    return last_out
                                end
                            end
                            last_out = f(last_in)
                            if last_out == "" then
                                if last_in == "" then
                                    state = "feeding"
                                    -- DECOMPILER ERROR at PC62: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                    -- DECOMPILER ERROR at PC62: LeaveBlock: unexpected jumping out IF_STMT

                                    -- DECOMPILER ERROR at PC62: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                    -- DECOMPILER ERROR at PC62: LeaveBlock: unexpected jumping out IF_STMT

                                end
                            end
                        end
                        (base.error)("filter returned \"\"")
                    end
                    if not last_out then
                        if last_in then
                            (base.error)("filter returned inappropriate nil")
                            -- DECOMPILER ERROR at PC76: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC76: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC76: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC76: LeaveBlock: unexpected jumping out IF_STMT

                        end
                    end
                end
                return nil
            end
            return last_out
        end
    end

end

source.cat = function(...)
    -- function num : 0_10 , upvalues : table
    local arg = {...}
    local src = (table.remove)(arg, 1)
    return function()
        -- function num : 0_10_0 , upvalues : src, table, arg
        while src do
            local chunk, err = src()
            if chunk then return chunk end
            if err then return nil, err end
            src = (table.remove)(arg, 1)
        end
    end

end

sink.table = function(t)
    -- function num : 0_11 , upvalues : table
    if not t then t = {} end
    local f = function(chunk, err)
        -- function num : 0_11_0 , upvalues : table, t
        if chunk then (table.insert)(t, chunk) end
        return 1
    end

    return f, t
end

sink.simplify = function(snk)
    -- function num : 0_12 , upvalues : base
    (base.assert)(snk)
    return function(chunk, err)
        -- function num : 0_12_0 , upvalues : snk
        local ret, err_or_new = snk(chunk, err)
        if not ret then return nil, err_or_new end
        snk = err_or_new or snk
        return 1
    end

end

sink.file = function(handle, io_err)
    -- function num : 0_13 , upvalues : sink
    if handle then
        return function(chunk, err)
            -- function num : 0_13_0 , upvalues : handle
            if not chunk then
                handle:close()
                return 1
            else
                return handle:write(chunk)
            end
        end

    else
        return (sink.error)(io_err or "unable to open file")
    end
end

local null = function()
    -- function num : 0_14
    return 1
end

sink.null = function()
    -- function num : 0_15 , upvalues : null
    return null
end

sink.error = function(err)
    -- function num : 0_16
    return function()
        -- function num : 0_16_0 , upvalues : err
        return nil, err
    end

end

sink.chain = function(f, snk, ...)
    -- function num : 0_17 , upvalues : table, filter, unpack, base
    do
        if ... then
            local args = {f, snk, ...}
            snk = (table.remove)(args, #args)
            f = (filter.chain)(unpack(args))
        end
        (base.assert)(not f or snk)
        return function(chunk, err)
            -- function num : 0_17_0 , upvalues : f, snk
            if chunk ~= "" then
                local filtered = f(chunk)
                local done = not chunk or ""
                while 1 do
                    local ret, snkerr = snk(filtered, err)
                    if not ret then return nil, snkerr end
                    if filtered == done then return 1 end
                    filtered = f(done)
                end
            else
                do do return 1 end end
            end
        end

    end
end

pump.step = function(src, snk)
    -- function num : 0_18
    local chunk, src_err = src()
    local ret, snk_err = snk(chunk, src_err)
    if chunk and ret then
        return 1
    else
        return nil, src_err or snk_err
    end
end

pump.all = function(src, snk, step)
    -- function num : 0_19 , upvalues : base, pump

    (base.assert)(not src or snk)
    if not step then step = pump.step end
    while 1 do
        while 1 do
            local ret, err = step(src, snk)
            if not ret then
                if err then
                    do return nil, err end
                    -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_STMT

                end
            end
        end
        return 1
    end
end

return _M


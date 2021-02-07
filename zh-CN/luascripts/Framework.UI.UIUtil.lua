-- params : ...
-- function num : 0 , upvalues : _ENV
UIUtil = {}
local cst_LuaBinding = typeof(((CS.XLua).Binding).LuaBinding)
local Stack = require("Framework.Lib.Stack")
-- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.AddButtonListener = function(btn, tbl, callback)
  -- function num : 0_0 , upvalues : _ENV
  local onClick = BindCallback(tbl, callback)
  ;
  (btn.onClick):AddListener(onClick)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.AddButtonListenerWithArg = function(btn, tbl, callback, ...)
  -- function num : 0_1 , upvalues : _ENV
  local onClick = BindCallback(tbl, callback, ...)
  ;
  (btn.onClick):AddListener(onClick)
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.AddValueChangedListener = function(obj, tbl, callback, ...)
  -- function num : 0_2 , upvalues : _ENV
  local valueChange = BindCallback(tbl, callback, ...)
  ;
  (obj.onValueChanged):AddListener(valueChange)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.LuaUIBindingTable = function(obj, tab)
  -- function num : 0_3 , upvalues : cst_LuaBinding, _ENV
  if tab == nil then
    return 
  end
  local uibinding = obj:GetComponent(cst_LuaBinding)
  if IsNull(uibinding) then
    return 
  end
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

UIUtil.topTypeList = {}
-- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.SetTopStatus = function(tab, backFunc, resIds, infoFunc, resAddCallbackDic)
  -- function num : 0_4 , upvalues : _ENV
  local data = {}
  data.backAction = (UIUtil.BindFunc)(tab, backFunc)
  if infoFunc ~= nil then
    data.infoAction = (UIUtil.BindFunc)(tab, infoFunc)
  end
  data.resIds = resIds
  data.resAddCallbackDic = resAddCallbackDic
  ;
  (UIUtil.backStack):Push(data.backAction)
  ;
  (table.insert)(UIUtil.topTypeList, data)
  UIManager:ShowWindowAsync(UIWindowTypeID.TopStatus, function(win)
    -- function num : 0_4_0 , upvalues : _ENV
    if win ~= nil then
      local lastIndex = #UIUtil.topTypeList
      local lastData = (UIUtil.topTypeList)[lastIndex]
      if lastData ~= nil then
        win:RefreshTopStatusUI(lastData)
      end
      ;
      (win.transform):SetAsLastSibling()
    end
  end
)
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.RefreshTopResId = function(ids, isSetNoBackData)
  -- function num : 0_5 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.TopStatus, function(win)
    -- function num : 0_5_0 , upvalues : ids, _ENV, isSetNoBackData
    if win ~= nil then
      win:SetTopStatusResIds(ids)
    end
    local lastIndex = #UIUtil.topTypeList
    local lastData = (UIUtil.topTypeList)[lastIndex]
    if isSetNoBackData and lastIndex == 0 and lastData == nil then
      lastData = {}
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (UIUtil.topTypeList)[lastIndex] = lastData
    end
    if lastData ~= nil then
      lastData.resIds = ids
    end
  end
)
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.HideTopStatus = function()
  -- function num : 0_6 , upvalues : _ENV
  UIManager:HideWindow(UIWindowTypeID.TopStatus)
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.ReShowTopStatus = function()
  -- function num : 0_7 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if window ~= nil and not window.active then
    window:Show()
  end
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.OnClickBack = function()
  -- function num : 0_8 , upvalues : _ENV
  local cb = (UIUtil.backStack):Pop()
  local index = 1
  local delIndex = 0
  for i = 1, #UIUtil.topTypeList do
    if cb == ((UIUtil.topTypeList)[i]).backAction then
      index = i - 1
      delIndex = i
      break
    end
  end
  do
    if cb ~= nil then
      if cb(false) == false then
        (UIUtil.backStack):Push(cb)
      else
        if delIndex > 0 then
          (table.remove)(UIUtil.topTypeList, delIndex)
        end
      end
    end
    local lastData = (UIUtil.topTypeList)[index]
    do
      if lastData ~= nil then
        local topStatus = UIManager:GetWindow(UIWindowTypeID.TopStatus)
        if topStatus ~= nil then
          topStatus:RefreshTopStatusUI(lastData)
        end
      end
      if (UIUtil.backStack):Empty() then
        UIManager:HideWindow(UIWindowTypeID.TopStatus)
        -- DECOMPILER ERROR at PC71: Confused about usage of register: R4 in 'UnsetPending'

        UIUtil.topTypeList = {}
      end
    end
  end
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.ReturnHome = function()
  -- function num : 0_9 , upvalues : _ENV
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
  do
    if (UIUtil.backStack):Empty() then
      UIManager:HideWindow(UIWindowTypeID.TopStatus)
      -- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

      UIUtil.topTypeList = {}
    end
  end
end

-- DECOMPILER ERROR at PC50: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.BindFunc = function(...)
  -- function num : 0_10 , upvalues : _ENV
  local action = nil
  local params = SafePack(...)
  assert(params.n >= 1, "error params count!")
  if type(params[1]) == "table" and type(params[2]) == "function" then
    action = BindCallback(params[1], params[2])
  elseif type(params[1]) == "function" then
    action = params[1]
  end
  do return action end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC53: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.Push2BackStack = function(...)
  -- function num : 0_11 , upvalues : _ENV
  local action = (UIUtil.BindFunc)(...)
  ;
  (UIUtil.backStack):Push(action)
  local data = {}
  data.backAction = action
  ;
  (table.insert)(UIUtil.topTypeList, data)
end

-- DECOMPILER ERROR at PC56: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.PopFromBackStack = function()
  -- function num : 0_12 , upvalues : _ENV
  local cb = (UIUtil.backStack):Pop()
  local index = 1
  local delIndex = 0
  for i = 1, #UIUtil.topTypeList do
    if cb == ((UIUtil.topTypeList)[i]).backAction then
      index = i - 1
      delIndex = i
      break
    end
  end
  do
    if delIndex > 0 then
      (table.remove)(UIUtil.topTypeList, delIndex)
    end
    local lastData = (UIUtil.topTypeList)[index]
    do
      if lastData ~= nil then
        local topStatus = UIManager:GetWindow(UIWindowTypeID.TopStatus)
        if topStatus ~= nil then
          topStatus:RefreshTopStatusUI(lastData)
        end
      end
      if (UIUtil.backStack):Empty() and (UIUtil.topTypeList)[0] == nil then
        UIManager:HideWindow(UIWindowTypeID.TopStatus)
        -- DECOMPILER ERROR at PC63: Confused about usage of register: R4 in 'UnsetPending'

        UIUtil.topTypeList = {}
      end
    end
  end
end

-- DECOMPILER ERROR at PC59: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.PeekBackStack = function()
  -- function num : 0_13 , upvalues : _ENV
  return (UIUtil.backStack):Peek()
end

-- DECOMPILER ERROR at PC62: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.ClearTopHome = function()
  -- function num : 0_14 , upvalues : _ENV
  (UIUtil.backStack):Clear()
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  UIUtil.topTypeList = {}
end

-- DECOMPILER ERROR at PC65: Confused about usage of register: R2 in 'UnsetPending'

UIUtil.LoadABAssetAsyncAndSetTexture = function(resLoader, path, rawImageGo)
  -- function num : 0_15 , upvalues : _ENV
  rawImageGo.enabled = false
  resLoader:LoadABAssetAsync(path, function(texture)
    -- function num : 0_15_0 , upvalues : _ENV, rawImageGo
    if IsNull(rawImageGo.transform) then
      return 
    end
    rawImageGo.texture = texture
    rawImageGo.enabled = true
  end
)
end



-- params : ...
-- function num : 0 , upvalues : _ENV
UIUtil = {}
local cst_LuaBinding = typeof(((CS.XLua).Binding).LuaBinding)
;
(require("Framework.Lib.Stack"))
local Stack = nil
local _cacheResIds = nil
local _cacheIsSetNoBackData = false
-- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

UIUtil.AddButtonListener = function(btn, tbl, callback)
  -- function num : 0_0 , upvalues : _ENV
  local onClick = BindCallback(tbl, callback)
  ;
  (btn.onClick):AddListener(onClick)
end

-- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

UIUtil.AddButtonListenerWithArg = function(btn, tbl, callback, ...)
  -- function num : 0_1 , upvalues : _ENV
  local onClick = BindCallback(tbl, callback, ...)
  ;
  (btn.onClick):AddListener(onClick)
end

-- DECOMPILER ERROR at PC21: Confused about usage of register: R4 in 'UnsetPending'

UIUtil.AddValueChangedListener = function(obj, tbl, callback, ...)
  -- function num : 0_2 , upvalues : _ENV
  local valueChange = BindCallback(tbl, callback, ...)
  ;
  (obj.onValueChanged):AddListener(valueChange)
end

-- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

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

-- DECOMPILER ERROR at PC27: Confused about usage of register: R4 in 'UnsetPending'

UIUtil.BindFunc = function(...)
  -- function num : 0_4 , upvalues : _ENV
  return BindCallback(...)
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R4 in 'UnsetPending'

UIUtil.backStack = (Stack.New)()
-- DECOMPILER ERROR at PC34: Confused about usage of register: R4 in 'UnsetPending'

UIUtil.SetTopStatus = function(tab, backFunc, resIds, infoFunc, resAddCallbackDic, hideTopStatus)
  -- function num : 0_5 , upvalues : _ENV
  local data = {}
  if backFunc ~= nil then
    data.backAction = (UIUtil.BindFunc)(tab, backFunc)
  end
  if infoFunc ~= nil then
    data.infoAction = (UIUtil.BindFunc)(tab, infoFunc)
  end
  data.resAddCallbackDic = resAddCallbackDic
  if tab ~= nil and tab.GetUIWindowTypeId ~= nil then
    data.winypeID = tab:GetUIWindowTypeId()
  else
    print("开发用 这个返回键没有UiType")
  end
  data.hideTopStatus = hideTopStatus
  data.resIds = resIds
  ;
  (UIUtil.backStack):Push(data)
  UIManager:ShowWindowAsync(UIWindowTypeID.TopStatus, function(win)
    -- function num : 0_5_0 , upvalues : data, hideTopStatus, _ENV
    if win ~= nil then
      win:RefreshTopStatusUI(data)
      ;
      (win.transform):SetAsFirstSibling()
      if hideTopStatus then
        (UIUtil.HideTopStatus)()
      end
    end
  end
)
  return data
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R4 in 'UnsetPending'

UIUtil.RefreshTopResId = function(resIds, isSetNoBackData)
  -- function num : 0_6 , upvalues : _ENV
  local data = (UIUtil.backStack):Peek()
  if isSetNoBackData and data == nil then
    data = {}
    data.resIds = resIds
    ;
    (UIUtil.backStack):Push(data)
  end
  if data ~= nil then
    data.resIds = resIds
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.TopStatus, function(win)
    -- function num : 0_6_0 , upvalues : data
    if win ~= nil then
      win:SetTopStatusResIds(data.resIds)
    end
  end
)
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R4 in 'UnsetPending'

UIUtil.HideTopStatus = function()
  -- function num : 0_7 , upvalues : _ENV
  UIManager:HideWindow(UIWindowTypeID.TopStatus)
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R4 in 'UnsetPending'

UIUtil.ReShowTopStatus = function()
  -- function num : 0_8 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if window ~= nil and not window.active then
    window:Show()
  end
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R4 in 'UnsetPending'

UIUtil.OnClickBack = function()
  -- function num : 0_9 , upvalues : _ENV
  local data = (UIUtil.backStack):Pop()
  local cb = data.backAction
  if cb ~= nil and cb(false) == false then
    (UIUtil.backStack):Push(data)
  end
  local lastData = (UIUtil.backStack):Peek()
  do
    if lastData ~= nil then
      local topStatus = UIManager:GetWindow(UIWindowTypeID.TopStatus)
      if topStatus ~= nil then
        topStatus:RefreshTopStatusUI(lastData)
        if lastData.hideTopStatus then
          topStatus:Hide()
        else
          topStatus:Show()
        end
      end
    end
    if (UIUtil.backStack):Empty() then
      UIManager:HideWindow(UIWindowTypeID.TopStatus)
    end
  end
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R4 in 'UnsetPending'

UIUtil.ReturnHome = function()
  -- function num : 0_10 , upvalues : _ENV
  local loopCount = 0
  while not (UIUtil.backStack):Empty() do
    if loopCount > 100 then
      error("返回栈溢出")
      return 
    end
    loopCount = loopCount + 1
    local data = (UIUtil.backStack):Pop()
    local cb = data.backAction
    if cb ~= nil and cb(true) == false then
      (UIUtil.backStack):Push(data)
    end
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R3 in 'UnsetPending'

    if UIUtil.isRunningJump then
      UIUtil.isRunningJump = nil
      break
    end
  end
  do
    if (UIUtil.backStack):Empty() then
      UIManager:HideWindow(UIWindowTypeID.TopStatus)
    end
  end
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R4 in 'UnsetPending'

UIUtil.CheckIsHaveSpecialMarker = function(winypeID)
  -- function num : 0_11 , upvalues : _ENV
  if winypeID == nil then
    return false
  end
  for deepIndex = (UIUtil.backStack):Count(), (UIUtil.backStack).bottom, -1 do
    if (((UIUtil.backStack).data)[deepIndex]).winypeID == winypeID then
      return true, deepIndex
    end
  end
  return false
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R4 in 'UnsetPending'

UIUtil.ReturnUntil2Marker = function(winypeID, isInclude)
  -- function num : 0_12 , upvalues : _ENV
  local haveMarker = (UIUtil.CheckIsHaveSpecialMarker)(winypeID)
  if not haveMarker then
    return 
  end
  local loopCount = 0
  local pickNext = false
  local PutBackData = function(data)
    -- function num : 0_12_0 , upvalues : _ENV
    (UIUtil.backStack):Push(data)
    local topStatus = UIManager:GetWindow(UIWindowTypeID.TopStatus)
    if topStatus ~= nil then
      topStatus:RefreshTopStatusUI(data)
      if data.hideTopStatus then
        topStatus:Hide()
      else
        topStatus:Show()
      end
    end
  end

  while not (UIUtil.backStack):Empty() do
    if loopCount > 100 then
      error("返回栈溢出")
      return 
    end
    loopCount = loopCount + 1
    local data = (UIUtil.backStack):Pop()
    if data.winypeID == winypeID then
      if isInclude then
        pickNext = true
      else
        PutBackData(data)
        return 
      end
    else
      if pickNext then
        PutBackData(data)
        return 
      end
    end
    local backAction = data.backAction
    if backAction == nil or backAction(false) == false then
      (UIUtil.backStack):Push(data)
    end
  end
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R4 in 'UnsetPending'

UIUtil.Push2BackStack = function(...)
  -- function num : 0_13 , upvalues : _ENV
  local tab = select(1, ...)
  local data = {}
  data.backAction = (UIUtil.BindFunc)(...)
  local frontData = (UIUtil.backStack):Peek()
  if frontData ~= nil then
    data.resIds = frontData.resIds
    data.resAddCallbackDic = frontData.resAddCallbackDic
  end
  if tab ~= nil and tab.GetUIWindowTypeId ~= nil then
    data.winypeID = tab:GetUIWindowTypeId()
  else
    print("开发用 这个返回键没有UiType")
  end
  ;
  (UIUtil.backStack):Push(data)
  return data
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R4 in 'UnsetPending'

UIUtil.PopFromBackStack = function()
  -- function num : 0_14 , upvalues : _ENV
  local data = (UIUtil.backStack):Pop()
  local lastData = (UIUtil.backStack):Peek()
  do
    if lastData ~= nil then
      local topStatus = UIManager:GetWindow(UIWindowTypeID.TopStatus)
      if topStatus ~= nil then
        topStatus:RefreshTopStatusUI(lastData)
        if lastData.hideTopStatus then
          topStatus:Hide()
        else
          topStatus:Show()
        end
      end
    end
    if (UIUtil.backStack):Empty() then
      UIManager:HideWindow(UIWindowTypeID.TopStatus)
    end
  end
end

-- DECOMPILER ERROR at PC64: Confused about usage of register: R4 in 'UnsetPending'

UIUtil.PeekBackStack = function()
  -- function num : 0_15 , upvalues : _ENV
  return (UIUtil.backStack):Peek()
end

-- DECOMPILER ERROR at PC67: Confused about usage of register: R4 in 'UnsetPending'

UIUtil.ClearTopHome = function()
  -- function num : 0_16 , upvalues : _ENV
  (UIUtil.backStack):Clear()
end

-- DECOMPILER ERROR at PC70: Confused about usage of register: R4 in 'UnsetPending'

UIUtil.__coverDic = {}
local _ShowCover = function(coverData)
  -- function num : 0_17 , upvalues : _ENV
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(SafeUnpack(coverData.argTable))
end

-- DECOMPILER ERROR at PC74: Confused about usage of register: R5 in 'UnsetPending'

UIUtil.AddOneCover = function(fromWhere, argTable)
  -- function num : 0_18 , upvalues : _ENV, _ShowCover
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if UIUtil.__coverDic == nil then
    UIUtil.__coverDic = {}
  end
  if argTable == nil then
    argTable = SafePack(nil, nil, nil, Color.clear, false)
  end
  local coverData = {fromWhere = fromWhere, argTable = argTable}
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (UIUtil.__coverDic)[fromWhere] = coverData
  _ShowCover(coverData)
end

-- DECOMPILER ERROR at PC77: Confused about usage of register: R5 in 'UnsetPending'

UIUtil.CloseOneCover = function(fromWhere)
  -- function num : 0_19 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  if UIUtil.__coverDic ~= nil and (UIUtil.__coverDic)[fromWhere] ~= nil then
    (UIUtil.__coverDic)[fromWhere] = nil
  end
  if UIUtil.__coverDic == nil or (table.count)(UIUtil.__coverDic) <= 0 then
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  end
end

-- DECOMPILER ERROR at PC80: Confused about usage of register: R5 in 'UnsetPending'

UIUtil.CloseAllCover = function()
  -- function num : 0_20 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  UIUtil.__coverDic = {}
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
end

-- DECOMPILER ERROR at PC83: Confused about usage of register: R5 in 'UnsetPending'

UIUtil.LoadABAssetAsyncAndSetTexture = function(resLoader, path, rawImageGo)
  -- function num : 0_21 , upvalues : _ENV
  rawImageGo.enabled = false
  resLoader:LoadABAssetAsync(path, function(texture)
    -- function num : 0_21_0 , upvalues : _ENV, rawImageGo
    if IsNull(rawImageGo.transform) then
      return 
    end
    rawImageGo.texture = texture
    rawImageGo.enabled = true
  end
)
end

-- DECOMPILER ERROR at PC86: Confused about usage of register: R5 in 'UnsetPending'

UIUtil.ScrollRectLocation = function(scroll, item, isForceUpdateCanvases)
  -- function num : 0_22 , upvalues : _ENV
  if IsNull(scroll) == nil or IsNull(item) == nil then
    error("scroll is NULL or item is NULL")
    return 
  end
  if not (item.transform):IsChildOf(scroll.transform) then
    error("Item not Child Of scroll")
    return 
  end
  if isForceUpdateCanvases then
    (((CS.UnityEngine).Canvas).ForceUpdateCanvases)()
  end
  if scroll.horizontal then
    local targetWidth = ((item.transform).localPosition).x + ((item.transform).rect).width * (1 - ((item.transform).pivot).x)
    local scrollWidth = ((scroll.transform).rect).width
    local rectWidth = (((scroll.content).transform).rect).width
    if targetWidth <= scrollWidth or rectWidth <= scrollWidth then
      scroll.horizontalNormalizedPosition = 0
    else
      local diffX = targetWidth - scrollWidth
      local ratio = diffX / (rectWidth - scrollWidth)
      scroll.horizontalNormalizedPosition = ratio
    end
  end
  do
    if scroll.vertical then
      local targetHeight = -(((item.transform).localPosition).y - ((item.transform).rect).height * ((item.transform).pivot).y)
      local scrollHeight = ((scroll.transform).rect).height
      local rectHeight = (((scroll.content).transform).rect).height
      if targetHeight <= scrollHeight or rectHeight <= scrollHeight then
        scroll.verticalNormalizedPosition = 1
      else
        local diffY = targetHeight - scrollHeight
        local ratio = 1 - diffY / (rectHeight - scrollHeight)
        scroll.verticalNormalizedPosition = ratio
      end
    end
  end
end



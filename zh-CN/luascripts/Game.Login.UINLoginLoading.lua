-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLoginLoading = class("UINLoginLoading", UIBaseNode)
local base = UIBaseNode
UINLoginLoading.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.onProgressRefresh = BindCallback(self, self.RefreshSceneProgress)
  self.sizeDelta = ((self.ui).img_process).sizeDelta
end

UINLoginLoading.InitLoginLoading = function(self)
  -- function num : 0_1 , upvalues : _ENV
  MsgCenter:AddListener(eMsgEventId.OnSceneLoadingProgress, self.onProgressRefresh)
  ;
  ((self.ui).tex_Value_author):SetIndex(0, PlayerDataCenter.playerName)
end

UINLoginLoading.RefreshSceneProgress = function(self, value)
  -- function num : 0_2 , upvalues : _ENV
  local p = value * 100
  ;
  ((self.ui).tex_Bar):SetIndex(0, tostring((Mathf.Ceil)(p)))
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_process).sizeDelta = (Vector2.New)((self.sizeDelta).x * value, (self.sizeDelta).y)
  self:UpdateDecorativeInfo(p)
end

UINLoginLoading.UpdateDecorativeInfo = function(self, loadingPercent)
  -- function num : 0_3
  if loadingPercent <= 10 then
    ((self.ui).texinfo_Value_basicSim):SetIndex(1)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_Value_basicSim).color = (self.ui).color_process
    ;
    ((self.ui).texinfo_Value_oasisSys):SetIndex(1)
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_Value_oasisSys).color = (self.ui).color_process
    self:UpdateLoadingRate(0, 0)
  else
    if loadingPercent <= 55 then
      ((self.ui).texinfo_Value_basicSim):SetIndex(1)
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).tex_Value_basicSim).color = (self.ui).color_process
      ;
      ((self.ui).texinfo_Value_oasisSys):SetIndex(1)
      -- DECOMPILER ERROR at PC48: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).tex_Value_oasisSys).color = (self.ui).color_process
      self:UpdateLoadingRate(1 - (55 - loadingPercent) / 45, 0)
    else
      ;
      ((self.ui).texinfo_Value_basicSim):SetIndex(2)
      -- DECOMPILER ERROR at PC65: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).tex_Value_basicSim).color = (self.ui).color_solid
      ;
      ((self.ui).texinfo_Value_oasisSys):SetIndex(1)
      -- DECOMPILER ERROR at PC75: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).tex_Value_oasisSys).color = (self.ui).color_process
      self:UpdateLoadingRate(1, 1 - (100 - loadingPercent) / 45)
    end
  end
end

UINLoginLoading.UpdateLoadingRate = function(self, fit1, fit2)
  -- function num : 0_4 , upvalues : _ENV
  local length = #(self.ui).tex_Arry_basicSim
  local taotalValue = (math.ceil)(100 * length * fit1)
  for i = 1, length do
    local text = ((self.ui).tex_Arry_basicSim)[i]
    text.text = tostring((math.min)(taotalValue, 100)) .. "%"
    taotalValue = (math.max)(taotalValue - 100, 0)
  end
  length = #(self.ui).tex_Arry_oasisSys
  taotalValue = (math.ceil)(100 * length * fit2)
  for i = 1, length do
    local text = ((self.ui).tex_Arry_oasisSys)[i]
    text.text = tostring((math.min)(taotalValue, 100)) .. "%"
    taotalValue = (math.max)(taotalValue - 100, 0)
  end
end

UINLoginLoading.OnDelete = function(self)
  -- function num : 0_5 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnSceneLoadingProgress, self.onProgressRefresh)
  ;
  (base.OnDelete)(self)
end

return UINLoginLoading


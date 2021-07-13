-- params : ...
-- function num : 0 , upvalues : _ENV
local UIPeriodicDebuffSelect = class("UIPeriodicDebuffSelect", UIBaseWindow)
local base = UIBaseWindow
local UINPeriodicDebuff = require("Game.PeriodicChallenge.UI.UINPeriodicDebuff")
UIPeriodicDebuffSelect.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINPeriodicDebuff
  (UIUtil.AddButtonListener)((self.ui).btn_ClearAll, self, self.OnClickClear)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnClickConfirm)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_SelectAll, self, self.OnAllSelectValueChange)
  ;
  (UIUtil.SetTopStatus)(self, self.Delete)
  self.buffItemPool = (UIItemPool.New)(UINPeriodicDebuff, (self.ui).obj_debuffSelectItem)
  ;
  ((self.ui).obj_debuffSelectItem):SetActive(false)
  self.resloader = ((CS.ResLoader).Create)()
  self.permillageLayer = 0
end

UIPeriodicDebuffSelect.InitDebuffSelect = function(self, buffIdDic, wcData, confirmFunc, selectedBuffIds, closeCallback)
  -- function num : 0_1 , upvalues : _ENV
  self.buffIdDic = buffIdDic
  self.wcData = wcData
  self.closeCallback = closeCallback
  self.selectedBuffIds = {}
  if selectedBuffIds ~= nil then
    (table.merge)(self.selectedBuffIds, selectedBuffIds)
  end
  self.confirmFunc = confirmFunc
  ;
  (self.buffItemPool):HideAll()
  local list = {}
  for buffId,permillage in pairs(self.buffIdDic) do
    (table.insert)(list, {buffId = buffId, permillage = permillage})
  end
  ;
  (table.sort)(list, function(a, b)
    -- function num : 0_1_0
    if a.permillage >= b.permillage then
      do return a.permillage == b.permillage end
      do return a.buffId < b.buffId end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
)
  for i,v in ipairs(list) do
    local item = (self.buffItemPool):GetOne(true)
    ;
    ((item.gameObject).transform):SetParent(((self.ui).obj_rect).transform)
    ;
    (item.gameObject):SetActive(true)
    item:InitDebuffItem(v.buffId, v.permillage, BindCallback(self, self.OnItemValueChange), (table.contain)(self.selectedBuffIds, v.buffId), self.resloader)
  end
  -- DECOMPILER ERROR at PC77: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Intro).text = ConfigData:GetTipContent(TipContent.WeeklyDebuffIntro)
  self.isCallTogFunc = true
  self:SetToggleState()
  self:Refresh()
end

UIPeriodicDebuffSelect.Refresh = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local permillageAll = 0
  for _,buffId in ipairs(self.selectedBuffIds) do
    permillageAll = permillageAll + (self.buffIdDic)[buffId]
  end
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Gain).text = tostring((Mathf.Floor)((permillageAll) / 10)) .. "%"
  local layer = (Mathf.Floor)((permillageAll) / 100)
  ;
  ((self.ui).tex_Layer):SetIndex(0, tostring(layer))
  self.permillageLayer = layer
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_EnemyPower).text = tostring((math.floor)((self.wcData).baseRecommandPower * (1 + layer * (self.wcData).weeklyRecommandPowerEffectRate)))
end

UIPeriodicDebuffSelect.SetToggleState = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local isOn = (table.count)(self.buffIdDic) == #self.selectedBuffIds
  if ((self.ui).tog_SelectAll).isOn ~= isOn then
    self.isCallTogFunc = false
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tog_SelectAll).isOn = isOn
    self.isCallTogFunc = true
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIPeriodicDebuffSelect.OnClickClear = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self.selectedBuffIds = {}
  for i,v in ipairs((self.buffItemPool).listItem) do
    v:ChangeState(false, false)
  end
  self:SetToggleState()
  self:Refresh()
end

UIPeriodicDebuffSelect.OnClickConfirm = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.confirmFunc ~= nil then
    (self.confirmFunc)(self.selectedBuffIds)
  end
  if self.closeCallback ~= nil then
    (self.closeCallback)(self.permillageLayer)
  end
  ;
  (UIUtil.OnClickBack)()
end

UIPeriodicDebuffSelect.OnAllSelectValueChange = function(self, flag)
  -- function num : 0_6 , upvalues : _ENV
  if self.isCallTogFunc then
    for i,v in ipairs((self.buffItemPool).listItem) do
      v:ChangeState(flag, false)
    end
    self.selectedBuffIds = {}
    if flag then
      for k,v in pairs(self.buffIdDic) do
        (table.insert)(self.selectedBuffIds, k)
      end
    end
    do
      self:Refresh()
    end
  end
end

UIPeriodicDebuffSelect.OnItemValueChange = function(self, buffItemData, flag)
  -- function num : 0_7 , upvalues : _ENV
  if flag and not (table.contain)(self.selectedBuffIds, buffItemData.id) then
    (table.insert)(self.selectedBuffIds, buffItemData.id)
  else
    if not flag and (table.contain)(self.selectedBuffIds, buffItemData.id) then
      (table.removebyvalue)(self.selectedBuffIds, buffItemData.id)
    end
  end
  self:SetToggleState()
  self:Refresh()
end

UIPeriodicDebuffSelect.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIPeriodicDebuffSelect


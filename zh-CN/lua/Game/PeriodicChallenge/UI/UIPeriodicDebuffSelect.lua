local UIPeriodicDebuffSelect = class("UIPeriodicDebuffSelect", UIBaseWindow)
local base = UIBaseWindow
local UINPeriodicDebuff = require("Game.PeriodicChallenge.UI.UINPeriodicDebuff")
UIPeriodicDebuffSelect.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINPeriodicDebuff
  (UIUtil.AddButtonListener)((self.ui).btn_ClearAll, self, self.OnClickClear)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnClickConfirm)
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
  self.selectBuffIdDic = {}
  if selectedBuffIds ~= nil then
    for _,buffId in ipairs(selectedBuffIds) do
      -- DECOMPILER ERROR at PC16: Confused about usage of register: R11 in 'UnsetPending'

      if (self.buffIdDic)[buffId] ~= nil then
        (self.selectBuffIdDic)[buffId] = true
      end
    end
  end
  do
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
    self.permillageItemUpDic = {}
    self.permillageItemDownDic = {}
    for i,v in ipairs(list) do
      local item = (self.buffItemPool):GetOne(true)
      ;
      ((item.gameObject).transform):SetParent(((self.ui).obj_rect).transform)
      ;
      (item.gameObject):SetActive(true)
      item:InitDebuffItem(v.buffId, v.permillage, BindCallback(self, self.OnItemValueChange), (table.contain)(self.selectBuffIdDic, v.buffId), self.resloader)
      -- DECOMPILER ERROR at PC87: Confused about usage of register: R13 in 'UnsetPending'

      if ((self.wcData).assistBuffId)[v.buffId] ~= nil then
        (self.permillageItemUpDic)[v.buffId] = item
      else
        -- DECOMPILER ERROR at PC91: Confused about usage of register: R13 in 'UnsetPending'

        ;
        (self.permillageItemDownDic)[v.buffId] = item
      end
    end
    -- DECOMPILER ERROR at PC101: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).tex_Intro).text = ConfigData:GetTipContent(TipContent.WeeklyDebuffIntro)
    self.isCallTogFunc = true
    self:Refresh()
    ;
    (((self.ui).tog_SelectAll).gameObject):SetActive(false)
  end
end

UIPeriodicDebuffSelect.Refresh = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local permillageAll = 0
  for buffId,_ in pairs(self.selectBuffIdDic) do
    permillageAll = permillageAll + (self.buffIdDic)[buffId]
  end
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Gain).text = tostring((Mathf.Floor)((permillageAll) / 10)) .. "%"
  local layer = (Mathf.Floor)((permillageAll) / 100)
  if layer <= 0 or not layer then
    layer = 0
  end
  ;
  ((self.ui).tex_Layer):SetIndex(0, tostring(layer))
  self.permillageLayer = layer
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_EnemyPower).text = tostring((math.floor)((self.wcData).baseRecommandPower * (1 + layer * (self.wcData).weeklyRecommandPowerEffectRate)))
  local isHaveUpBuff = false
  for buffId,_ in pairs(self.selectBuffIdDic) do
    if (self.permillageItemUpDic)[buffId] ~= nil then
      isHaveUpBuff = true
      break
    end
  end
  do
    for _,item in ipairs((self.buffItemPool).listItem) do
      local selected = (self.selectBuffIdDic)[item.buffId] ~= nil
      local isForbid = (not selected and isHaveUpBuff)
      item:ChangeState(selected, isForbid)
    end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

UIPeriodicDebuffSelect.OnClickClear = function(self)
  -- function num : 0_3
  self.selectBuffIdDic = {}
  self:Refresh()
end

UIPeriodicDebuffSelect.OnClickConfirm = function(self)
  -- function num : 0_4 , upvalues : _ENV
  do
    if self.confirmFunc ~= nil then
      local selectedBuffIds = {}
      for buffId,_ in pairs(self.selectBuffIdDic) do
        (table.insert)(selectedBuffIds, buffId)
      end
      ;
      (self.confirmFunc)(selectedBuffIds)
    end
    if self.closeCallback ~= nil then
      (self.closeCallback)(self.permillageLayer)
    end
    ;
    (UIUtil.OnClickBack)()
  end
end

UIPeriodicDebuffSelect.OnItemValueChange = function(self, buffId, flag)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  if flag then
    (self.selectBuffIdDic)[buffId] = true
    local removeAntithesisBuffFunc = function(checkBuffDic)
    -- function num : 0_5_0 , upvalues : _ENV, self
    for id,_ in pairs(self.selectBuffIdDic) do
      -- DECOMPILER ERROR at PC8: Confused about usage of register: R6 in 'UnsetPending'

      if checkBuffDic[id] ~= nil then
        (self.selectBuffIdDic)[id] = nil
      end
    end
  end

    if (self.permillageItemUpDic)[buffId] then
      removeAntithesisBuffFunc(self.permillageItemDownDic)
    end
    if (self.permillageItemDownDic)[buffId] then
      removeAntithesisBuffFunc(self.permillageItemUpDic)
    end
  else
    do
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self.selectBuffIdDic)[buffId] = nil
      self:Refresh()
    end
  end
end

UIPeriodicDebuffSelect.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIPeriodicDebuffSelect


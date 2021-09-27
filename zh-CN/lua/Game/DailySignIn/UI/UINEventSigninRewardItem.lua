local UINEventSigninRewardItem = class("UINEventSigninRewardItem", UIBaseNode)
local base = UIBaseNode
UINEventSigninRewardItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.dateNum = nil
  self.clickEvent = nil
  self.isPicked = false
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_dailyItem, self, self.OnClick)
end

UINEventSigninRewardItem.InitSigninRewardItem = function(self, dateNum, clickEvent)
  -- function num : 0_1 , upvalues : _ENV
  self.dateNum = dateNum
  self.clickEvent = clickEvent
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  if dateNum < 10 then
    ((self.ui).tex_date).text = "0" .. tostring(dateNum)
  else
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_date).text = tostring(dateNum)
  end
  local itemIds, itemNums = (PlayerDataCenter.dailySignInData):GetSingInRewardByDayNum(dateNum)
  if itemIds == nil then
    error("not config " .. dateNum .. "\'s daily sing in reward")
    ;
    (((self.ui).img_itemIcon).gameObject):SetActive(false)
    ;
    (((self.ui).tex_count).gameObject):SetActive(false)
    return 
  end
  self.itemCfg = (ConfigData.item)[itemIds[1]]
  if self.itemCfg == nil then
    error("can\'t read itemCfg with id:" .. tostring(itemIds[1]))
  else
    -- DECOMPILER ERROR at PC67: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).img_itemIcon).sprite = CRH:GetSpriteByItemConfig(self.itemCfg)
  end
  local num = itemNums[1]
  -- DECOMPILER ERROR at PC76: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_count).text = tostring("x" .. num)
end

UINEventSigninRewardItem.SetIsReceived = function(self, bool)
  -- function num : 0_2
  ((self.ui).obj_Received):SetActive(bool)
  self.isPicked = bool
end

UINEventSigninRewardItem.SetCurDayMArker = function(self)
  -- function num : 0_3
end

UINEventSigninRewardItem.LoadAndPlayFx = function(self, resloader, xRotate, uiItemScaleRate, callback)
  -- function num : 0_4 , upvalues : _ENV
  local path = ItemEffPatch[(self.itemCfg).quality]
  if self._isInitedFx then
    (self._particleSystem):Play()
    TimerManager:StopTimer(self.wait4RewardTimerId)
    self.wait4RewardTimerId = TimerManager:StartTimer(1.5, function()
    -- function num : 0_4_0 , upvalues : self, callback
    self.wait4RewardTimerId = nil
    if callback ~= nil then
      callback()
    end
  end
, self, true, nil, nil)
  end
  resloader:LoadABAssetAsync(path, function(prefab)
    -- function num : 0_4_1 , upvalues : _ENV, self, uiItemScaleRate, xRotate, callback
    if IsNull(prefab) or self.__stop then
      return 
    end
    local go = prefab:Instantiate(self.transform)
    local particleSystem = go:GetComponentInChildren(typeof((CS.UnityEngine).ParticleSystem))
    local usIParticle = go:GetComponentInChildren(typeof(((CS.Coffee).UIExtensions).UIParticle))
    particleSystem:Stop()
    do
      local scaleRate = (uiItemScaleRate ~= nil or uiItemScaleRate) and 1.5
      usIParticle.scale = ((self.transform).sizeDelta).x * scaleRate
      -- DECOMPILER ERROR at PC51: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (go.transform).sizeDelta = (self.transform).sizeDelta
      -- DECOMPILER ERROR at PC59: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (go.transform).localScale = (Vector3.New)(1.5, 1.2, 1)
      ;
      (go.transform):Rotate((Vector3.New)(xRotate or 0, 0, 0))
      particleSystem:Play()
      if self.wait4RewardTimerId == nil then
        self.wait4RewardTimerId = TimerManager:StartTimer(1.5, function()
      -- function num : 0_4_1_0 , upvalues : self, callback
      self.wait4RewardTimerId = nil
      if callback ~= nil then
        callback()
      end
    end
, self, true, nil, nil)
      end
      self._isInitedFx = true
      self._particleSystem = particleSystem
      -- DECOMPILER ERROR: 6 unprocessed JMP targets
    end
  end
)
end

UINEventSigninRewardItem.OnClick = function(self)
  -- function num : 0_5
  if self.clickEvent ~= nil then
    (self.clickEvent)(self)
  end
end

UINEventSigninRewardItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : _ENV, base
  TimerManager:StopTimer(self.wait4RewardTimerId)
  ;
  (base.OnDelete)(self)
end

return UINEventSigninRewardItem


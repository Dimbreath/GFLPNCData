-- params : ...
-- function num : 0 , upvalues : _ENV
local UINEventNoviceSign = class("UINEventNoviceSign", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local TaskEnum = require("Game.Task.TaskEnum")
UINEventNoviceSign.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Click, self, self.OnClickNoviceSignReceive)
  self.baseItem = (UINBaseItem.New)()
  ;
  (self.baseItem):Init((self.ui).obj_BaseItem)
end

UINEventNoviceSign.InitNoviceSignItem = function(self, data, awardCfg, resloader)
  -- function num : 0_1 , upvalues : _ENV
  self.data = data
  self.awardCfg = awardCfg
  self.resloader = resloader
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  if (self.awardCfg).day < 10 then
    ((self.ui).tex_date).text = "0" .. tostring((self.awardCfg).day)
  else
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_date).text = tostring((self.awardCfg).day)
  end
  ;
  ((self.ui).img_dayBG):SetIndex((self.awardCfg).rare and 1 or 0)
  local awardId = ((self.awardCfg).awardIds)[1]
  local awardCount = ((self.awardCfg).awardCounts)[1]
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Count).text = "x" .. tostring(awardCount)
  local itemCfg = (ConfigData.item)[awardId]
  self.itemCfg = itemCfg
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_ItemName).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
  ;
  (self.baseItem):SetNotNeedAnyJump(true)
  ;
  (self.baseItem):InitBaseItem(itemCfg)
  self:RefreshNoviceSignItem()
end

UINEventNoviceSign.RefreshNoviceSignItem = function(self)
  -- function num : 0_2 , upvalues : TaskEnum, _ENV
  local state = (self.data):GetReceiveState((self.awardCfg).day)
  ;
  (((self.ui).btn_Click).gameObject):SetActive(state == (TaskEnum.eTaskState).Completed)
  ;
  ((self.ui).obj_Received):SetActive(state == (TaskEnum.eTaskState).Picked)
  if state == (TaskEnum.eTaskState).Completed then
    if self.isFxInited then
      return 
    end
    local path = ItemEffPatch[(self.itemCfg).quality]
    ;
    (self.resloader):LoadABAssetAsync(path, function(prefab)
    -- function num : 0_2_0 , upvalues : self, _ENV
    self.isFxInited = true
    if IsNull(prefab) or self.__stop then
      return 
    end
    local go = prefab:Instantiate((self.baseItem).transform)
    local particleSystem = go:GetComponentInChildren(typeof((CS.UnityEngine).ParticleSystem))
    local usIParticle = go:GetComponentInChildren(typeof(((CS.Coffee).UIExtensions).UIParticle))
    particleSystem:Stop()
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (go.transform).sizeDelta = ((self.baseItem).transform).sizeDelta
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (go.transform).localScale = ((self.baseItem).transform).localScale
    particleSystem:Play()
    if self.wait4RewardTimer == nil then
      self.wait4RewardTimer = (TimerManager:GetTimer(1.5, function()
      -- function num : 0_2_0_0 , upvalues : self, _ENV, go
      self.wait4RewardTimer = nil
      DestroyUnityObject(go)
      ;
      (self.resloader):LoadABAssetAsync(ItemEffPatch.loop, function(prefab)
        -- function num : 0_2_0_0_0 , upvalues : self, _ENV
        local go = prefab:Instantiate((self.baseItem).transform)
        local particleSystem = go:GetComponentInChildren(typeof((CS.UnityEngine).ParticleSystem))
        local usIParticle = go:GetComponentInChildren(typeof(((CS.Coffee).UIExtensions).UIParticle))
        -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (go.transform).sizeDelta = ((self.baseItem).transform).sizeDelta
        -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (go.transform).localScale = ((self.baseItem).transform).localScale
        particleSystem:Play()
        self.fxGo = go
      end
)
    end
, self, true, nil, nil)):Start()
    end
  end
)
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UINEventNoviceSign.OnClickNoviceSignReceive = function(self)
  -- function num : 0_3 , upvalues : TaskEnum, _ENV
  if (self.data):GetReceiveState((self.awardCfg).day) == (TaskEnum.eTaskState).Completed then
    (NetworkManager:GetNetwork(NetworkTypeID.EventNoviceSign)):CS_SIGNACTIVITY_Pick((self.data).id, function()
    -- function num : 0_3_0 , upvalues : self, _ENV
    self:RefreshNoviceSignItem()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      -- function num : 0_3_0_0 , upvalues : self
      if window ~= nil then
        window:InitRewardsItem((self.awardCfg).awardIds, (self.awardCfg).awardCounts)
      end
    end
)
    if self.wait4RewardTimer ~= nil then
      (self.wait4RewardTimer):Stop()
      self.wait4RewardTimer = nil
    end
    if self.fxGo ~= nil then
      DestroyUnityObject(self.fxGo)
    end
  end
)
  end
end

UINEventNoviceSign.OnDelete = function(self)
  -- function num : 0_4
  if self.wait4RewardTimer ~= nil then
    (self.wait4RewardTimer):Stop()
    self.wait4RewardTimer = nil
  end
end

return UINEventNoviceSign


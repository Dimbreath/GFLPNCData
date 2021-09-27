local UINEventNoviceSignItem = class("UINEventNoviceSignItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local TaskEnum = require("Game.Task.TaskEnum")
UINEventNoviceSignItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.LuaBindings = {}
  ;
  (UIUtil.LuaUIBindingTable)(((self.ui).obj_BaseWithCount).transform, self.LuaBindings)
  self.baseItem = (UINBaseItem.New)()
  ;
  (self.baseItem):Init((self.LuaBindings).uINBaseItem)
end

UINEventNoviceSignItem.InitNoviceSignItemsItem = function(self, data, awardCfg, awardId, awardCount, resloader)
  -- function num : 0_1 , upvalues : _ENV
  self.data = data
  self.awardCfg = awardCfg
  self.awardId = awardId
  self.awardCount = awardCount
  self.resloader = resloader
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.LuaBindings).tex_TotalCount).text = "x" .. tostring(self.awardCount)
  local itemCfg = (ConfigData.item)[self.awardId]
  self.itemCfg = itemCfg
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.LuaBindings).tex_ItemName).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
  ;
  (self.baseItem):SetNotNeedAnyJump(true)
  ;
  (self.baseItem):InitBaseItem(itemCfg)
  self:RefreshNoviceSignItemsItem()
end

UINEventNoviceSignItem.RefreshNoviceSignItemsItem = function(self)
  -- function num : 0_2 , upvalues : TaskEnum, _ENV
  local state = (self.data):GetReceiveState((self.awardCfg).day)
  if state == (TaskEnum.eTaskState).Picked then
    (self.baseItem):CloseGreatRewardLoopFx()
  else
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
    self.wait4RewardTimerId = TimerManager:StartTimer(1.5, function()
      -- function num : 0_2_0_0 , upvalues : self, _ENV, go
      self.wait4RewardTimerId = nil
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
, self, true, nil, nil)
  end
)
    end
  end
end

UINEventNoviceSignItem.hasClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  TimerManager:StopTimer(self.wait4RewardTimerId)
  if self.fxGo ~= nil then
    DestroyUnityObject(self.fxGo)
  end
  ;
  (self.baseItem):CloseGreatRewardLoopFx()
end

UINEventNoviceSignItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : _ENV, base
  TimerManager:StopTimer(self.wait4RewardTimerId)
  ;
  (base.OnDelete)(self)
end

return UINEventNoviceSignItem


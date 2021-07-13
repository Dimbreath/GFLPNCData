-- params : ...
-- function num : 0 , upvalues : _ENV
local UINBaseItemWithCount = class("UINBaseItemWithCount", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
UINBaseItemWithCount.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.baseItem = (UINBaseItem.New)()
  ;
  (self.baseItem):Init((self.ui).uINBaseItem)
end

UINBaseItemWithCount.InitItemWithCount = function(self, itemCfg, count, clickEvent, wareHouseNum, clickExtrEvent)
  -- function num : 0_1 , upvalues : _ENV
  if (self.ui).obj_Empty ~= nil then
    if itemCfg == nil then
      ((self.ui).obj_Empty):SetActive(true)
      ;
      (self.baseItem):Hide()
      return 
    else
      ;
      ((self.ui).obj_Empty):SetActive(false)
      ;
      (self.baseItem):Show()
    end
  end
  self.itemCfg = itemCfg
  ;
  (self.baseItem):InitBaseItem(itemCfg, clickEvent, clickExtrEvent)
  self:SetNum(count, nil, wareHouseNum)
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R6 in 'UnsetPending'

  if (self.ui).tex_ItemName ~= nil then
    ((self.ui).tex_ItemName).text = tostring((LanguageUtil.GetLocaleText)(itemCfg.name))
  end
end

UINBaseItemWithCount.SetNum = function(self, count, notAutoHide, wareHouseNum)
  -- function num : 0_2 , upvalues : _ENV
  if count == nil and not notAutoHide and not IsNull((self.ui).count) then
    ((self.ui).count):SetActive(false)
  end
  if wareHouseNum ~= nil then
    ((self.ui).count):SetActive(true)
    if count <= wareHouseNum then
      ((self.ui).tex_TotalCount):SetIndex(1, tostring(wareHouseNum), tostring(count))
    else
      ;
      ((self.ui).tex_TotalCount):SetIndex(2, tostring(wareHouseNum), tostring(count))
    end
  else
    ;
    ((self.ui).count):SetActive(true)
    if ((self.ui).tex_TotalCount).SetIndex ~= nil then
      ((self.ui).tex_TotalCount):SetIndex(0, tostring(count))
    else
      -- DECOMPILER ERROR at PC73: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tex_TotalCount).text = tostring(count)
    end
  end
end

UINBaseItemWithCount.SetFade = function(self, value)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).Fade).alpha = value
end

UINBaseItemWithCount.GetFade = function(self)
  -- function num : 0_4
  return (self.ui).Fade
end

UINBaseItemWithCount.SetNotNeedAnyJump = function(self, bool)
  -- function num : 0_5
  (self.baseItem):SetNotNeedAnyJump(bool)
end

UINBaseItemWithCount.LoadGetRewardFx = function(self, resloader, xRotate, uiItemScaleRate)
  -- function num : 0_6 , upvalues : _ENV
  local path = ItemEffPatch[(self.itemCfg).quality]
  resloader:LoadABAssetAsync(path, function(prefab)
    -- function num : 0_6_0 , upvalues : _ENV, self, uiItemScaleRate, xRotate
    if IsNull(prefab) or self.__stop or self.baseItem == nil or IsNull((self.baseItem).transform) then
      return 
    end
    local go = prefab:Instantiate((self.baseItem).transform)
    local particleSystem = go:GetComponentInChildren(typeof((CS.UnityEngine).ParticleSystem))
    local usIParticle = go:GetComponentInChildren(typeof(((CS.Coffee).UIExtensions).UIParticle))
    particleSystem:Stop()
    do
      local scaleRate = (uiItemScaleRate ~= nil or uiItemScaleRate) and 1.5
      usIParticle.scale = (((self.baseItem).transform).sizeDelta).x * scaleRate
      -- DECOMPILER ERROR at PC63: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (go.transform).sizeDelta = ((self.baseItem).transform).sizeDelta
      -- DECOMPILER ERROR at PC68: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (go.transform).localScale = ((self.baseItem).transform).localScale
      ;
      (go.transform):Rotate((Vector3.New)(xRotate or 0, 0, 0))
      particleSystem:Play()
      -- DECOMPILER ERROR: 5 unprocessed JMP targets
    end
  end
)
end

UINBaseItemWithCount.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (self.baseItem):Delete()
  ;
  (base.OnDelete)(self)
end

return UINBaseItemWithCount


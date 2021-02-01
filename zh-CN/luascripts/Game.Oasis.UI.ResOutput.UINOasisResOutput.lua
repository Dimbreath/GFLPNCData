-- params : ...
-- function num : 0 , upvalues : _ENV
local UINOasisResOutput = class("UINOasisResOutput", UIBaseNode)
local base = UIBaseNode
local UINOasisResItem = require("Game.Oasis.UI.ResOutput.UINOasisResItem")
UINOasisResOutput.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINOasisResItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).uI_OasisBuildOutput):SetActive(false)
  self.resItemPool = (UIItemPool.New)(UINOasisResItem, (self.ui).uI_OasisBuildOutput)
  self.resItemDic = {}
  self.mainCam = UIManager:GetMainCamera()
end

UINOasisResOutput.InitOasisResOutput = function(self)
  -- function num : 0_1
end

UINOasisResOutput.TryCreateOasisResItem = function(self, id, itemId)
  -- function num : 0_2
  if (self.resItemDic)[id] ~= nil then
    return 
  end
  local resItem = (self.resItemPool):GetOne()
  resItem:InitOasisResItem(itemId, id, self.mainCam)
  resItem:PlayOasisResItemShowTween()
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.resItemDic)[id] = resItem
end

UINOasisResOutput.UpdateOasisResPos = function(self, id, position)
  -- function num : 0_3 , upvalues : _ENV
  local resItem = (self.resItemDic)[id]
  if resItem ~= nil then
    resItem:RefreshOasisResItemPos(position)
    if IsNull(self.mainCam) then
      return 
    end
    local distance = (Vector3.Distance)(position, ((self.mainCam).transform).position)
    local t = 1 - (distance - ((self.ui).distanceRange).x) / (((self.ui).distanceRange).y - ((self.ui).distanceRange).x)
    local scale = (Mathf.Lerp)(((self.ui).scaleRange).x, ((self.ui).scaleRange).y, t)
    resItem:RefreshOasisResItemScale(scale)
  end
end

UINOasisResOutput.UpdateOasisResData = function(self, id, resTabSort)
  -- function num : 0_4
  local resItem = (self.resItemDic)[id]
  local resData = resTabSort[1]
  if resItem ~= nil and resData ~= nil then
    if resData.countMax ~= 0 or not 0 then
      local progress = resData.count / resData.countMax
    end
    resItem:RefreshOasisResItemState(progress)
  end
end

UINOasisResOutput.ShowOasisResUIItem = function(self, id, show)
  -- function num : 0_5
  local resItem = (self.resItemDic)[id]
  if resItem ~= nil then
    if show then
      resItem:Show()
      resItem:PlayOasisResItemShowTween()
    else
      resItem:Hide()
    end
  end
end

UINOasisResOutput.OnShow = function(self)
  -- function num : 0_6 , upvalues : _ENV
  for k,resItem in pairs(self.resItemDic) do
    resItem:PlayOasisResItemShowTween()
  end
end

UINOasisResOutput.RecycleOasisResItem = function(self, id)
  -- function num : 0_7
  local resItem = (self.resItemDic)[id]
  if resItem ~= nil then
    (self.resItemPool):HideOne(resItem)
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.resItemDic)[id] = nil
  end
end

UINOasisResOutput.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  (self.resItemPool):DeleteAll()
  self.resItemDic = {}
  ;
  (base.OnDelete)(self)
end

return UINOasisResOutput


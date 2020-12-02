-- params : ...
-- function num : 0 , upvalues : _ENV
local UITipsCacheItem = class("UISideTipsItem", UIBaseNode)
local base = UIBaseNode
local CS_DOTweenAnimation = ((CS.DG).Tweening).DOTweenAnimation
UITipsCacheItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, CS_DOTweenAnimation
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  local tweenList = (self.gameObject):GetComponents(typeof(CS_DOTweenAnimation))
  for i = 0, tweenList.Length - 1 do
    local dt = tweenList[i]
    if dt.id == "ItemMove" then
      self.Ani_tipsItem = dt
    end
  end
  if IsNull(self.Ani_tipsItem) then
    error("Con\'t find DOTweenAnimation By ID:ItemMove")
    return 
  end
  self.__onMoveTweenComplete = BindCallback(self, self.__OnMoveTweenComplete)
  ;
  ((self.Ani_tipsItem).onComplete):AddListener(self.__onMoveTweenComplete)
end

UITipsCacheItem.InitTipsCacheItem = function(self, content)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_Content).text = content
end

UITipsCacheItem.SetCompleteAction = function(self, Action)
  -- function num : 0_2
  self.completeAction = Action
end

UITipsCacheItem.__OnMoveTweenComplete = function(self)
  -- function num : 0_3
  if self.completeAction ~= nil then
    (self.completeAction)(true)
  end
end

UITipsCacheItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UITipsCacheItem


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

UITipsCacheItem.InitTipsCacheData = function(self, tipsData)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).obj_efficiency):SetActive(false)
  ;
  ((self.ui).obj_normal):SetActive(false)
  local content = tipsData.content
  if tipsData.type == eMessageSideType.normal or tipsData.type == nil then
    ((self.ui).obj_normal):SetActive(true)
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Content).text = content
  else
    if tipsData.type == eMessageSideType.efficiency then
      ((self.ui).obj_efficiency):SetActive(true)
      local class = type(content)
      do
        if class == "number" then
          local color = Color.white
          if content > 0 then
            color = (self.ui).col_orange
            content = "+" .. tostring(content)
          else
            color = (self.ui).col_red
            content = tostring(content)
          end
          -- DECOMPILER ERROR at PC63: Confused about usage of register: R5 in 'UnsetPending'

          ;
          ((self.ui).tex_EfficiencyNum).color = color
        end
        -- DECOMPILER ERROR at PC66: Confused about usage of register: R4 in 'UnsetPending'

        ;
        ((self.ui).tex_EfficiencyNum).text = content
      end
    end
  end
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


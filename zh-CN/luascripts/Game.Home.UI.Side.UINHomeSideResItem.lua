-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHomeSideResItem = class("UINHomeSideResItem", UIBaseNode)
local base = UIBaseNode
local cs_DOTween = ((CS.DG).Tweening).DOTween
UINHomeSideResItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.isCollecting = false
  self.itemId = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINHomeSideResItem.Updatenfo = function(self, data)
  -- function num : 0_1 , upvalues : _ENV
  if self.isCollecting then
    return 
  end
  do
    if self.itemId ~= data.id then
      local itemCfg = (ConfigData.item)[data.id]
      if itemCfg == nil then
        error("Can\'t Find ItemCfg By ID:" .. data.id)
        return 
      end
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.ui).img_Icon).sprite = CRH:GetSprite(itemCfg.small_icon)
      self.itemId = data.id
    end
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_Period).fillAmount = data.progress
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_Rate).fillAmount = data.count / data.countMax
  end
end

UINHomeSideResItem.PlayCollect = function(self)
  -- function num : 0_2 , upvalues : cs_DOTween
  if self.isCollecting then
    return 
  end
  self.isCollecting = true
  local sequence = (cs_DOTween.Sequence)()
  sequence:Append(((self.ui).img_Rate):DOFillAmount(0, ((self.ui).img_Rate).fillAmount * 2))
  sequence:AppendCallback(function()
    -- function num : 0_2_0 , upvalues : self
    self.isCollecting = false
  end
)
end

UINHomeSideResItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINHomeSideResItem


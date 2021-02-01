-- params : ...
-- function num : 0 , upvalues : _ENV
local UIFmtEvaluationItem = class("UIFmtEvaluationItem", UIBaseNode)
local base = UIBaseNode
UIFmtEvaluationItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIFmtEvaluationItem.UpdateItemDisplay = function(self, careerId, isAdvantage, textColor, bgColor)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R5 in 'UnsetPending'

  ((self.ui).itemBg).color = bgColor
  local careerCfg = (ConfigData.career)[careerId]
  if careerCfg == nil then
    error("找不到角色的职业配置，配置id:" .. tostring(careerId))
    return 
  end
  local index = isAdvantage and 1 or 0
  ;
  ((self.ui).text):SetIndex(index, (LanguageUtil.GetLocaleText)(careerCfg.name))
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (((self.ui).text).text).color = textColor
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).icon).sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).icon).color = textColor
end

UIFmtEvaluationItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UIFmtEvaluationItem


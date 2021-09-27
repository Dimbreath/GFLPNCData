local UIFmtEvaluationItem = class("UIFmtEvaluationItem", UIBaseNode)
local base = UIBaseNode
UIFmtEvaluationItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  if not IsNull((self.ui).btn_PressItem) then
    (((self.ui).btn_PressItem).onPress):AddListener(BindCallback(self, self.__OnEvaluationPress))
    ;
    (((self.ui).btn_PressItem).onPressUp):AddListener(BindCallback(self, self.__OnEvaluationPressUp))
  end
end

UIFmtEvaluationItem.UpdateItemDisplay = function(self, advTypeId, isAdvantage, textColor, eColorType)
  -- function num : 0_1 , upvalues : _ENV
  self.advTypeId = advTypeId
  self.isAdvantage = isAdvantage
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

  if not IsNull((self.ui).btn_evaluationItem) then
    ((self.ui).btn_evaluationItem).enabled = isAdvantage
  end
  ;
  ((self.ui).itemBg):SetIndex(eColorType)
  local desStr = nil
  if advTypeId < 100 then
    local careerCfg = (ConfigData.career)[advTypeId]
    if careerCfg == nil then
      error("找不到角色的职业配置，配置id:" .. tostring(advTypeId))
      return 
    end
    desStr = (LanguageUtil.GetLocaleText)(careerCfg.name)
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).icon).sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
  else
    do
      if advTypeId == 100 then
        desStr = ConfigData:GetTipContent(903)
        -- DECOMPILER ERROR at PC65: Confused about usage of register: R6 in 'UnsetPending'

        ;
        ((self.ui).icon).sprite = CRH:GetSprite(((ConfigData.chip_mark)[2]).icon, CommonAtlasType.ExplorationIcon)
      else
        if advTypeId == 101 then
          desStr = ConfigData:GetTipContent(904)
          -- DECOMPILER ERROR at PC85: Confused about usage of register: R6 in 'UnsetPending'

          ;
          ((self.ui).icon).sprite = CRH:GetSprite(((ConfigData.chip_mark)[1]).icon, CommonAtlasType.ExplorationIcon)
        end
      end
      local index = isAdvantage and 1 or 0
      ;
      ((self.ui).text):SetIndex(index, desStr)
      -- DECOMPILER ERROR at PC101: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (((self.ui).text).text).color = textColor
      -- DECOMPILER ERROR at PC104: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self.ui).icon).color = textColor
    end
  end
end

UIFmtEvaluationItem.SetEvaluationItemClickAct = function(self, pressAct, pressUpAct)
  -- function num : 0_2
  self.pressAct = pressAct
  self.pressUpAct = pressUpAct
end

UIFmtEvaluationItem.__OnEvaluationPress = function(self)
  -- function num : 0_3
  if self.pressAct ~= nil then
    (self.pressAct)(self.transform, self.advTypeId, self.isAdvantage)
  end
end

UIFmtEvaluationItem.__OnEvaluationPressUp = function(self)
  -- function num : 0_4
  if self.pressUpAct ~= nil then
    (self.pressUpAct)()
  end
end

UIFmtEvaluationItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UIFmtEvaluationItem


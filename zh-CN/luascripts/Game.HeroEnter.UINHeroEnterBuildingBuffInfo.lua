-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroEnterBuildingBuffInfo = class("UINHeroEnterBuildingBuffInfo", UIBaseNode)
local base = UIBaseNode
local valueFuncTable = {[eLogicType.ResourceLimit] = function(heroScoreRate, newHreoScoreRate, theSelf)
  -- function num : 0_0 , upvalues : _ENV
  local itemName = (LanguageUtil.GetLocaleText)(((ConfigData.item)[((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]]).name)
  ;
  ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.ResourceLimit, itemName)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((theSelf.ui).tex_OldNum).text = tostring((math.floor)(((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID] * heroScoreRate))
  if newHreoScoreRate then
    ((theSelf.ui).image):SetActive(true)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((theSelf.ui).tex_NewNum).text = tostring((math.floor)(((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID] * newHreoScoreRate))
  else
    ;
    ((theSelf.ui).image):SetActive(false)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
  end
end
, [eLogicType.ResourceOutput] = function(heroScoreRate, newHreoScoreRate, theSelf)
  -- function num : 0_1 , upvalues : _ENV
  local itemName = (LanguageUtil.GetLocaleText)(((ConfigData.item)[((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]]).name)
  ;
  ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.ResourceOutput, itemName)
  local speed = ((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID] * 36
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((theSelf.ui).tex_OldNum).text = tostring((math.floor)(speed * heroScoreRate))
  if newHreoScoreRate then
    ((theSelf.ui).image):SetActive(true)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((theSelf.ui).tex_NewNum).text = tostring((math.floor)(speed * newHreoScoreRate))
  else
    ;
    ((theSelf.ui).image):SetActive(false)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
  end
end
, [eLogicType.CampBuff] = function(heroScoreRate, newHreoScoreRate, theSelf)
  -- function num : 0_2 , upvalues : _ENV
  local campName = (LanguageUtil.GetLocaleText)(((ConfigData.camp)[((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]]).name)
  ;
  ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.CampBuff, campName)
  local attrName = (LanguageUtil.GetLocaleText)(((ConfigData.attribute)[((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID]]).name)
  local attrValue = ((theSelf.levelBuffCfg).buff_para3)[theSelf.buffCfhID]
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((theSelf.ui).tex_OldNum).text = attrName .. "+" .. (math.floor)(attrValue * heroScoreRate)
  if newHreoScoreRate then
    ((theSelf.ui).image):SetActive(true)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((theSelf.ui).tex_NewNum).text = attrName .. "+" .. (math.floor)(attrValue * newHreoScoreRate)
  else
    ;
    ((theSelf.ui).image):SetActive(false)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
  end
end
, [eLogicType.CareerBuff] = function(heroScoreRate, newHreoScoreRate, theSelf)
  -- function num : 0_3 , upvalues : _ENV
  local careerName = (LanguageUtil.GetLocaleText)(((ConfigData.career)[((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]]).name)
  ;
  ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.CareerBuff, careerName)
  local attrName = (LanguageUtil.GetLocaleText)(((ConfigData.attribute)[((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID]]).name)
  local attrValue = ((theSelf.levelBuffCfg).buff_para3)[theSelf.buffCfhID]
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((theSelf.ui).tex_OldNum).text = attrName .. "+" .. (math.floor)(attrValue * heroScoreRate)
  if newHreoScoreRate then
    ((theSelf.ui).image):SetActive(true)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((theSelf.ui).tex_NewNum).text = attrName .. "+" .. (math.floor)(attrValue * newHreoScoreRate)
  else
    ;
    ((theSelf.ui).image):SetActive(false)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
  end
end
, [eLogicType.FactoryPipelie] = function(heroScoreRate, newHreoScoreRate, theSelf)
  -- function num : 0_4 , upvalues : _ENV
  ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.FactoryPipelie)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((theSelf.ui).tex_OldNum).text = tostring((math.floor)(((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID] * heroScoreRate))
  if newHreoScoreRate then
    ((theSelf.ui).image):SetActive(true)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((theSelf.ui).tex_NewNum).text = tostring((math.floor)(((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID] * newHreoScoreRate))
  else
    ;
    ((theSelf.ui).image):SetActive(false)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
  end
end
, [eLogicType.GlobalExpCeiling] = function(heroScoreRate, newHreoScoreRate, theSelf)
  -- function num : 0_5 , upvalues : _ENV
  ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.GlobalExpCeiling)
  local expLimt = ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((theSelf.ui).tex_OldNum).text = tostring((math.floor)(expLimt * heroScoreRate))
  if newHreoScoreRate then
    ((theSelf.ui).image):SetActive(true)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((theSelf.ui).tex_NewNum).text = tostring((math.floor)(expLimt * newHreoScoreRate))
  else
    ;
    ((theSelf.ui).image):SetActive(false)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
  end
end
, [eLogicType.StaminaCeiling] = function(heroScoreRate, newHreoScoreRate, theSelf)
  -- function num : 0_6 , upvalues : _ENV
  ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.StaminaCeiling)
  local staminaLimt = ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((theSelf.ui).tex_OldNum).text = tostring((math.floor)(staminaLimt * heroScoreRate))
  if newHreoScoreRate then
    ((theSelf.ui).image):SetActive(true)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((theSelf.ui).tex_NewNum).text = tostring((math.floor)(staminaLimt * newHreoScoreRate))
  else
    ;
    ((theSelf.ui).image):SetActive(false)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
  end
end
, [eLogicType.StaminaOutput] = function(heroScoreRate, newHreoScoreRate, theSelf)
  -- function num : 0_7 , upvalues : _ENV
  ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.StaminaOutput)
  local speed = ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID] * 0.036
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((theSelf.ui).tex_OldNum).text = tostring((math.floor)(speed * heroScoreRate))
  if newHreoScoreRate then
    ((theSelf.ui).image):SetActive(true)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((theSelf.ui).tex_NewNum).text = tostring((math.floor)(speed * newHreoScoreRate))
  else
    ;
    ((theSelf.ui).image):SetActive(false)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
  end
end
, [eLogicType.ResOutputEfficiency] = function(heroScoreRate, newHreoScoreRate, theSelf)
  -- function num : 0_8 , upvalues : _ENV
  local itemName = nil
  if ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID] == 0 then
    itemName = "全部道具"
  else
    local itemCfg = (ConfigData.item)[((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]]
    if itemCfg == nil then
      itemName = "未知道具"
    else
      itemName = (LanguageUtil.GetLocaleText)(itemCfg.name)
    end
  end
  do
    ;
    ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.ResOutputEfficiency, itemName)
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((theSelf.ui).tex_OldNum).text = GetPreciseDecimalStr(((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID] / 10 * heroScoreRate, 2) .. "%"
    if newHreoScoreRate then
      ((theSelf.ui).image):SetActive(true)
      ;
      (((theSelf.ui).tex_NewNum).gameObject):SetActive(true)
      -- DECOMPILER ERROR at PC72: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((theSelf.ui).tex_NewNum).text = GetPreciseDecimalStr(((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID] / 10 * newHreoScoreRate, 2) .. "%"
    else
      ;
      ((theSelf.ui).image):SetActive(false)
      ;
      (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
    end
  end
end
, [eLogicType.BuildQueue] = function(heroScoreRate, newHreoScoreRate, theSelf)
  -- function num : 0_9 , upvalues : _ENV
  local listPlace = ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]
  if listPlace == 1 then
    ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.BuildQueue)
  else
    ;
    ((theSelf.ui).tex_AttriName):SetIndex(16)
  end
  local listNum = ((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID]
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((theSelf.ui).tex_OldNum).text = tostring((math.floor)(listNum * heroScoreRate))
  if newHreoScoreRate then
    ((theSelf.ui).image):SetActive(true)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((theSelf.ui).tex_NewNum).text = tostring((math.floor)(listNum * newHreoScoreRate))
  else
    ;
    ((theSelf.ui).image):SetActive(false)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
  end
end
, [eLogicType.BuildSpeed] = function(heroScoreRate, newHreoScoreRate, theSelf)
  -- function num : 0_10 , upvalues : _ENV
  ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.BuildSpeed)
  local speed = ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((theSelf.ui).tex_OldNum).text = GetPreciseDecimalStr(speed / 10 * heroScoreRate, 2) .. "%"
  if newHreoScoreRate then
    ((theSelf.ui).image):SetActive(true)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((theSelf.ui).tex_NewNum).text = GetPreciseDecimalStr(speed / 10 * newHreoScoreRate, 2) .. "%"
  else
    ;
    ((theSelf.ui).image):SetActive(false)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
  end
end
, [eLogicType.GlobalExpRatio] = function(heroScoreRate, newHreoScoreRate, theSelf)
  -- function num : 0_11 , upvalues : _ENV
  ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.GlobalExpRatio)
  local rate = ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((theSelf.ui).tex_OldNum).text = GetPreciseDecimalStr(rate / 10 * heroScoreRate, 2) .. "%"
  if newHreoScoreRate then
    ((theSelf.ui).image):SetActive(true)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((theSelf.ui).tex_NewNum).text = GetPreciseDecimalStr(rate / 10 * newHreoScoreRate, 2) .. "%"
  else
    ;
    ((theSelf.ui).image):SetActive(false)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
  end
end
, [eLogicType.AllHeroBuff] = function(heroScoreRate, newHreoScoreRate, theSelf)
  -- function num : 0_12 , upvalues : _ENV
  ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.AllHeroBuff)
  local attrName = (LanguageUtil.GetLocaleText)(((ConfigData.attribute)[((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]]).name)
  local attrValue = ((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID]
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((theSelf.ui).tex_OldNum).text = attrName .. "+" .. (math.floor)(attrValue * heroScoreRate, 1)
  if newHreoScoreRate then
    ((theSelf.ui).image):SetActive(true)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC55: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((theSelf.ui).tex_NewNum).text = attrName .. "+" .. (math.floor)(attrValue * newHreoScoreRate, 1)
  else
    ;
    ((theSelf.ui).image):SetActive(false)
    ;
    (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
  end
end
}
UINHeroEnterBuildingBuffInfo.OnInit = function(self)
  -- function num : 0_13 , upvalues : _ENV
  self.levelBuffCfg = nil
  self.buffCfhID = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).image):SetActive(false)
  ;
  (((self.ui).tex_NewNum).gameObject):SetActive(false)
end

UINHeroEnterBuildingBuffInfo.InitBuff = function(self, levelBuffCfg, buffCfhID)
  -- function num : 0_14
  self.levelBuffCfg = levelBuffCfg
  self.buffCfhID = buffCfhID
end

UINHeroEnterBuildingBuffInfo.SetValue = function(self, heroScoreRate, newHreoScoreRate)
  -- function num : 0_15 , upvalues : valueFuncTable
  local logic = ((self.levelBuffCfg).buff_logic)[self.buffCfhID]
  ;
  (valueFuncTable[logic])(heroScoreRate, newHreoScoreRate, self)
end

UINHeroEnterBuildingBuffInfo.OnDelete = function(self)
  -- function num : 0_16 , upvalues : base
  (base.OnDelete)(self)
end

return UINHeroEnterBuildingBuffInfo

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroEnterBuildingBuffInfo = class("UINHeroEnterBuildingBuffInfo",
                                           UIBaseNode)
local base = UIBaseNode
local valueFuncTable = {
    [eLogicType.ResourceLimit] = function(heroScoreRate, newHreoScoreRate,
                                          theSelf)
        -- function num : 0_0 , upvalues : _ENV
        local itemName = (LanguageUtil.GetLocaleText)(
                             ((ConfigData.item)[((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]]).name);
        ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.ResourceLimit, itemName) -- DECOMPILER ERROR at PC30: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((theSelf.ui).tex_OldNum).text =
            tostring((math.floor)(
                         ((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID] *
                             heroScoreRate))
        if newHreoScoreRate then
            ((theSelf.ui).image):SetActive(true);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(true) -- DECOMPILER ERROR at PC56: Confused about usage of register: R4 in 'UnsetPending'
            ;
            ((theSelf.ui).tex_NewNum).text =
                tostring((math.floor)(
                             ((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID] *
                                 newHreoScoreRate))
        else

            ((theSelf.ui).image):SetActive(false);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
        end
    end,
    [eLogicType.ResourceOutput] = function(heroScoreRate, newHreoScoreRate,
                                           theSelf)
        -- function num : 0_1 , upvalues : _ENV
        local itemName = (LanguageUtil.GetLocaleText)(
                             ((ConfigData.item)[((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]]).name);
        ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.ResourceOutput,
                                              itemName)
        local speed = ((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID] *
                          36 -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'
        ;
        ((theSelf.ui).tex_OldNum).text =
            tostring((math.floor)(speed * heroScoreRate))
        if newHreoScoreRate then
            ((theSelf.ui).image):SetActive(true);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(true) -- DECOMPILER ERROR at PC53: Confused about usage of register: R5 in 'UnsetPending'
            ;
            ((theSelf.ui).tex_NewNum).text =
                tostring((math.floor)(speed * newHreoScoreRate))
        else

            ((theSelf.ui).image):SetActive(false);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
        end
    end,
    [eLogicType.CampBuff] = function(heroScoreRate, newHreoScoreRate, theSelf)
        -- function num : 0_2 , upvalues : _ENV
        local campName = (LanguageUtil.GetLocaleText)(
                             ((ConfigData.camp)[((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]]).name);
        ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.CampBuff, campName)
        local attrName = (LanguageUtil.GetLocaleText)(
                             ((ConfigData.attribute)[((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID]]).name)
        local attrValue = ((theSelf.levelBuffCfg).buff_para3)[theSelf.buffCfhID] -- DECOMPILER ERROR at PC42: Confused about usage of register: R6 in 'UnsetPending'
        ;
        ((theSelf.ui).tex_OldNum).text =
            attrName .. "+" .. (math.floor)(attrValue * heroScoreRate)
        if newHreoScoreRate then
            ((theSelf.ui).image):SetActive(true);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(true) -- DECOMPILER ERROR at PC65: Confused about usage of register: R6 in 'UnsetPending'
            ;
            ((theSelf.ui).tex_NewNum).text =
                attrName .. "+" .. (math.floor)(attrValue * newHreoScoreRate)
        else

            ((theSelf.ui).image):SetActive(false);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
        end
    end,
    [eLogicType.CareerBuff] = function(heroScoreRate, newHreoScoreRate, theSelf)
        -- function num : 0_3 , upvalues : _ENV
        local careerName = (LanguageUtil.GetLocaleText)(
                               ((ConfigData.career)[((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]]).name);
        ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.CareerBuff, careerName)
        local attrName = (LanguageUtil.GetLocaleText)(
                             ((ConfigData.attribute)[((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID]]).name)
        local attrValue = ((theSelf.levelBuffCfg).buff_para3)[theSelf.buffCfhID] -- DECOMPILER ERROR at PC42: Confused about usage of register: R6 in 'UnsetPending'
        ;
        ((theSelf.ui).tex_OldNum).text =
            attrName .. "+" .. (math.floor)(attrValue * heroScoreRate)
        if newHreoScoreRate then
            ((theSelf.ui).image):SetActive(true);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(true) -- DECOMPILER ERROR at PC65: Confused about usage of register: R6 in 'UnsetPending'
            ;
            ((theSelf.ui).tex_NewNum).text =
                attrName .. "+" .. (math.floor)(attrValue * newHreoScoreRate)
        else

            ((theSelf.ui).image):SetActive(false);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
        end
    end,
    [eLogicType.FactoryPipelie] = function(heroScoreRate, newHreoScoreRate,
                                           theSelf)
        -- function num : 0_4 , upvalues : _ENV
        ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.FactoryPipelie) -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((theSelf.ui).tex_OldNum).text =
            tostring((math.floor)(
                         ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID] *
                             heroScoreRate))
        if newHreoScoreRate then
            ((theSelf.ui).image):SetActive(true);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(true) -- DECOMPILER ERROR at PC44: Confused about usage of register: R3 in 'UnsetPending'
            ;
            ((theSelf.ui).tex_NewNum).text =
                tostring((math.floor)(
                             ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID] *
                                 newHreoScoreRate))
        else

            ((theSelf.ui).image):SetActive(false);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
        end
    end,
    [eLogicType.GlobalExpCeiling] = function(heroScoreRate, newHreoScoreRate,
                                             theSelf)
        -- function num : 0_5 , upvalues : _ENV
        ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.GlobalExpCeiling)
        local expLimt = ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID] -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((theSelf.ui).tex_OldNum).text =
            tostring((math.floor)(expLimt * heroScoreRate))
        if newHreoScoreRate then
            ((theSelf.ui).image):SetActive(true);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(true) -- DECOMPILER ERROR at PC40: Confused about usage of register: R4 in 'UnsetPending'
            ;
            ((theSelf.ui).tex_NewNum).text =
                tostring((math.floor)(expLimt * newHreoScoreRate))
        else

            ((theSelf.ui).image):SetActive(false);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
        end
    end,
    [eLogicType.StaminaCeiling] = function(heroScoreRate, newHreoScoreRate,
                                           theSelf)
        -- function num : 0_6 , upvalues : _ENV
        ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.StaminaCeiling)
        local staminaLimt =
            ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID] -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((theSelf.ui).tex_OldNum).text =
            tostring((math.floor)(staminaLimt * heroScoreRate))
        if newHreoScoreRate then
            ((theSelf.ui).image):SetActive(true);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(true) -- DECOMPILER ERROR at PC40: Confused about usage of register: R4 in 'UnsetPending'
            ;
            ((theSelf.ui).tex_NewNum).text =
                tostring((math.floor)(staminaLimt * newHreoScoreRate))
        else

            ((theSelf.ui).image):SetActive(false);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
        end
    end,
    [eLogicType.StaminaOutput] = function(heroScoreRate, newHreoScoreRate,
                                          theSelf)
        -- function num : 0_7 , upvalues : _ENV
        ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.StaminaOutput)
        local speed = ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID] *
                          0.036 -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((theSelf.ui).tex_OldNum).text =
            tostring((math.floor)(speed * heroScoreRate))
        if newHreoScoreRate then
            ((theSelf.ui).image):SetActive(true);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(true) -- DECOMPILER ERROR at PC41: Confused about usage of register: R4 in 'UnsetPending'
            ;
            ((theSelf.ui).tex_NewNum).text =
                tostring((math.floor)(speed * newHreoScoreRate))
        else

            ((theSelf.ui).image):SetActive(false);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
        end
    end,
    [eLogicType.ResOutputEfficiency] = function(heroScoreRate, newHreoScoreRate,
                                                theSelf)
        -- function num : 0_8 , upvalues : _ENV
        local itemName = nil
        if ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID] == 0 then
            itemName = "全部道具"
        else
            local itemCfg =
                (ConfigData.item)[((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]]
            if itemCfg == nil then
                itemName = "未知道具"
            else
                itemName = (LanguageUtil.GetLocaleText)(itemCfg.name)
            end
        end
        do

            ((theSelf.ui).tex_AttriName):SetIndex(
                eLogicType.ResOutputEfficiency, itemName) -- DECOMPILER ERROR at PC45: Confused about usage of register: R4 in 'UnsetPending'
            ;
            ((theSelf.ui).tex_OldNum).text =
                GetPreciseDecimalStr(
                    ((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID] / 10 *
                        heroScoreRate, 2) .. "%"
            if newHreoScoreRate then
                ((theSelf.ui).image):SetActive(true);
                (((theSelf.ui).tex_NewNum).gameObject):SetActive(true) -- DECOMPILER ERROR at PC72: Confused about usage of register: R4 in 'UnsetPending'
                ;
                ((theSelf.ui).tex_NewNum).text =
                    GetPreciseDecimalStr(
                        ((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID] /
                            10 * newHreoScoreRate, 2) .. "%"
            else

                ((theSelf.ui).image):SetActive(false);
                (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
            end
        end
    end,
    [eLogicType.BuildQueue] = function(heroScoreRate, newHreoScoreRate, theSelf)
        -- function num : 0_9 , upvalues : _ENV
        local listPlace = ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]
        if listPlace == 1 then
            ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.BuildQueue)
        else

            ((theSelf.ui).tex_AttriName):SetIndex(16)
        end
        local listNum = ((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID] -- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'
        ;
        ((theSelf.ui).tex_OldNum).text =
            tostring((math.floor)(listNum * heroScoreRate))
        if newHreoScoreRate then
            ((theSelf.ui).image):SetActive(true);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(true) -- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'
            ;
            ((theSelf.ui).tex_NewNum).text =
                tostring((math.floor)(listNum * newHreoScoreRate))
        else

            ((theSelf.ui).image):SetActive(false);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
        end
    end,
    [eLogicType.BuildSpeed] = function(heroScoreRate, newHreoScoreRate, theSelf)
        -- function num : 0_10 , upvalues : _ENV
        ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.BuildSpeed)
        local speed = ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID] -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((theSelf.ui).tex_OldNum).text =
            GetPreciseDecimalStr(speed / 10 * heroScoreRate, 2) .. "%"
        if newHreoScoreRate then
            ((theSelf.ui).image):SetActive(true);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(true) -- DECOMPILER ERROR at PC42: Confused about usage of register: R4 in 'UnsetPending'
            ;
            ((theSelf.ui).tex_NewNum).text =
                GetPreciseDecimalStr(speed / 10 * newHreoScoreRate, 2) .. "%"
        else

            ((theSelf.ui).image):SetActive(false);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
        end
    end,
    [eLogicType.GlobalExpRatio] = function(heroScoreRate, newHreoScoreRate,
                                           theSelf)
        -- function num : 0_11 , upvalues : _ENV
        ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.GlobalExpRatio)
        local rate = ((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID] -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((theSelf.ui).tex_OldNum).text =
            GetPreciseDecimalStr(rate / 10 * heroScoreRate, 2) .. "%"
        if newHreoScoreRate then
            ((theSelf.ui).image):SetActive(true);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(true) -- DECOMPILER ERROR at PC42: Confused about usage of register: R4 in 'UnsetPending'
            ;
            ((theSelf.ui).tex_NewNum).text =
                GetPreciseDecimalStr(rate / 10 * newHreoScoreRate, 2) .. "%"
        else

            ((theSelf.ui).image):SetActive(false);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
        end
    end,
    [eLogicType.AllHeroBuff] = function(heroScoreRate, newHreoScoreRate, theSelf)
        -- function num : 0_12 , upvalues : _ENV
        ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.AllHeroBuff)
        local attrName = (LanguageUtil.GetLocaleText)(
                             ((ConfigData.attribute)[((theSelf.levelBuffCfg).buff_para1)[theSelf.buffCfhID]]).name)
        local attrValue = ((theSelf.levelBuffCfg).buff_para2)[theSelf.buffCfhID] -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'
        ;
        ((theSelf.ui).tex_OldNum).text =
            attrName .. "+" .. (math.floor)(attrValue * heroScoreRate, 1)
        if newHreoScoreRate then
            ((theSelf.ui).image):SetActive(true);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(true) -- DECOMPILER ERROR at PC55: Confused about usage of register: R5 in 'UnsetPending'
            ;
            ((theSelf.ui).tex_NewNum).text =
                attrName .. "+" .. (math.floor)(attrValue * newHreoScoreRate, 1)
        else

            ((theSelf.ui).image):SetActive(false);
            (((theSelf.ui).tex_NewNum).gameObject):SetActive(false)
        end
    end
}
UINHeroEnterBuildingBuffInfo.OnInit = function(self)
    -- function num : 0_13 , upvalues : _ENV
    self.levelBuffCfg = nil
    self.buffCfhID = nil;
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    ((self.ui).image):SetActive(false);
    (((self.ui).tex_NewNum).gameObject):SetActive(false)
end

UINHeroEnterBuildingBuffInfo.InitBuff = function(self, levelBuffCfg, buffCfhID)
    -- function num : 0_14
    self.levelBuffCfg = levelBuffCfg
    self.buffCfhID = buffCfhID
end

UINHeroEnterBuildingBuffInfo.SetValue = function(self, heroScoreRate,
                                                 newHreoScoreRate)
    -- function num : 0_15 , upvalues : valueFuncTable
    local logic = ((self.levelBuffCfg).buff_logic)[self.buffCfhID];
    (valueFuncTable[logic])(heroScoreRate, newHreoScoreRate, self)
end

UINHeroEnterBuildingBuffInfo.OnDelete = function(self)
    -- function num : 0_16 , upvalues : base
    (base.OnDelete)(self)
end

return UINHeroEnterBuildingBuffInfo


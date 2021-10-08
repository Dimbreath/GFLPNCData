local UINPeriodicDebuff = class("UINPeriodicDebuff", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
UINPeriodicDebuff.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).debuffSelectItem, self, self.OnClickBuffItem)
end

UINPeriodicDebuff.InitDebuffItem = function(self, buffId, permillage, selectFunc, isSelected, resloader)
  -- function num : 0_1 , upvalues : _ENV
  self.buffId = buffId
  self.permillage = permillage
  self.selectFunc = selectFunc
  local buffCfg = (ConfigData.exploration_buff)[self.buffId]
  if buffCfg == nil then
    error("不存在的 buff, id is " .. tostring(self.buffId))
    return 
  end
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite(buffCfg.icon, CommonAtlasType.ExplorationIcon)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Desc).text = (LanguageUtil.GetLocaleText)(buffCfg.describe)
  self.buffType = buffCfg.buff_type
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Permillage).text = tostring((Mathf.Floor)(permillage / 10)) .. "%"
  self:ChangeState(isSelected, false)
end

UINPeriodicDebuff.ChangeState = function(self, isSelected, isForbid)
  -- function num : 0_2
  self.isSelected = isSelected
  self.isForbid = isForbid
  if self.isForbid then
    ((self.ui).img_Select):SetIndex(4)
  else
    if not self.isSelected then
      ((self.ui).img_Select):SetIndex(0)
    else
      if self.permillage < 0 then
        ((self.ui).img_Select):SetIndex(3)
      else
        if self.permillage > 0 then
          ((self.ui).img_Select):SetIndex(1)
        else
          ;
          ((self.ui).img_Select):SetIndex(2)
        end
      end
    end
  end
end

UINPeriodicDebuff.OnClickBuffItem = function(self)
  -- function num : 0_3 , upvalues : cs_MessageCommon, _ENV
  if self.isForbid then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(908))
    return 
  end
  if self.selectFunc ~= nil then
    (self.selectFunc)(self.buffId, not self.isSelected)
  end
end

return UINPeriodicDebuff


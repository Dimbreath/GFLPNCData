-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDungeonInfoChipDetailAttr = class("UINDungeonInfoChipDetailAttr", UIBaseNode)
local base = UIBaseNode
UINDungeonInfoChipDetailAttr.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINDungeonInfoChipDetailAttr.InitAttrItem = function(self, attrId, value)
  -- function num : 0_1 , upvalues : _ENV
  local attrCfg = (ConfigData.attribute)[attrId]
  if attrCfg == nil or attrCfg.name == nil then
    error("Can\'t get attr config/name with ID:" .. attrId)
    return 
  end
  local name = (LanguageUtil.GetLocaleText)(attrCfg.name)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Tag).text = name
  local isRatio = attrCfg.num_type == 2
  if not isRatio or not tostring(FormatNum(value / 10)) .. "%" then
    local valueStr = tostring(value)
  end
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Num).text = valueStr
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINDungeonInfoChipDetailAttr.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINDungeonInfoChipDetailAttr


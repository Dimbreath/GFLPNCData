-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFosterButtomNode = class("UINFosterButtomNode", UIBaseNode)
local base = UIBaseNode
UINFosterButtomNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINFosterButtomNode.RefreshAndShowLockedInfo = function(self, fosterCfg)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).obj_upgradeDetail):SetActive(false)
  ;
  ((self.ui).obj_currentEffect):SetActive(true)
  ;
  ((self.ui).txt_effectTip):SetIndex(0)
  local des = (LanguageUtil.GetLocaleText)((fosterCfg[1]).describe)
  for index,attrID in ipairs((fosterCfg[1]).attributeIds) do
    local value = ((fosterCfg[1]).attributeNums)[index]
    des = (string.gsub)(des, "{" .. tostring(index - 1) .. "}", tostring(value))
  end
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).txt_currentEffect).text = des
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_SkillName).text = (LanguageUtil.GetLocaleText)((fosterCfg[1]).name)
end

UINFosterButtomNode.RefreshAndShowInfo = function(self, fosterCfg, nowLevel)
  -- function num : 0_2 , upvalues : _ENV
  ((self.ui).obj_upgradeDetail):SetActive(true)
  ;
  ((self.ui).obj_currentEffect):SetActive(false)
  local cfg = fosterCfg[nowLevel]
  local nextCfg = fosterCfg[nowLevel + 1]
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_SkillName).text = (LanguageUtil.GetLocaleText)(cfg.name)
  local currDes = (LanguageUtil.GetLocaleText)(cfg.describe)
  for index,attrID in ipairs(cfg.attributeIds) do
    local value = (cfg.attributeNums)[index]
    currDes = (string.gsub)(currDes, "{" .. tostring(index - 1) .. "}", tostring(value))
  end
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_CurrSkill).text = currDes
  local nextDes = (LanguageUtil.GetLocaleText)(nextCfg.describe)
  for index,attrID in ipairs(nextCfg.attributeIds) do
    local value = (nextCfg.attributeNums)[index]
    nextDes = (string.gsub)(nextDes, "{" .. tostring(index - 1) .. "}", "<color=#FF8400>" .. tostring(value) .. "</color>")
  end
  -- DECOMPILER ERROR at PC80: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_NextSkill).text = nextDes
end

UINFosterButtomNode.RefreshAndShowMaxLevelInfo = function(self, fosterCfg, nowLevel)
  -- function num : 0_3 , upvalues : _ENV
  ((self.ui).obj_upgradeDetail):SetActive(false)
  ;
  ((self.ui).obj_currentEffect):SetActive(true)
  local cfg = fosterCfg[nowLevel]
  ;
  ((self.ui).txt_effectTip):SetIndex(1)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_SkillName).text = (LanguageUtil.GetLocaleText)(cfg.name) .. " MAX"
  local des = (LanguageUtil.GetLocaleText)(cfg.describe)
  for index,attrID in ipairs(cfg.attributeIds) do
    local value = (cfg.attributeNums)[index]
    des = (string.gsub)(des, "{" .. tostring(index - 1) .. "}", tostring(value))
  end
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).txt_currentEffect).text = des
end

UINFosterButtomNode.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINFosterButtomNode


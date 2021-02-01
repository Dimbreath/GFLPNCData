-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthRfctAffixItem = class("UINAthRfctAffixItem", UIBaseNode)
local base = UIBaseNode
local ArthmeticEnum = require("Game.Arithmetic.ArthmeticEnum")
UINAthRfctAffixItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self._OnClickRoot)
end

UINAthRfctAffixItem.InitAthRfctAffix = function(self, index, affixElem, clickFunc, parent, withoutLock)
  -- function num : 0_1
  self.index = index
  self.clickFunc = clickFunc
  ;
  (self.transform):SetParent(parent)
  self:RefreshAthRfctAffixItem(affixElem, withoutLock)
end

UINAthRfctAffixItem.RefreshAthRfctAffixItem = function(self, affixElem, withoutLock)
  -- function num : 0_2 , upvalues : _ENV, ArthmeticEnum
  local affixcfg = (ConfigData.ath_affix_pool)[affixElem.id]
  if affixcfg == nil then
    error("Cant\'t find ath_affix_pool, id = " .. tostring(affixElem.id))
    return 
  end
  self.affixcfg = affixcfg
  local name, valueStr, icon = ConfigData:GetAttribute((self.affixcfg).affix_para, affixElem.value)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite(icon)
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).color = (ArthmeticEnum.AthQualityColor)[affixElem.quality]
  local unlockOpt = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_optimize)
  if (ConfigData.ath_affix_lv).maxAffixLevel > affixElem.level then
    do
      local isMaxLevel = not unlockOpt
      if isMaxLevel then
        ((self.ui).tex_Num):SetIndex(1, valueStr)
      else
        ((self.ui).tex_Num):SetIndex(0, valueStr, tostring(affixElem.level))
      end
      -- DECOMPILER ERROR at PC71: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (((self.ui).tex_Num).text).text = valueStr
      if withoutLock then
        ((self.ui).lock):SetActive(false)
        ;
        ((self.ui).unLock):SetActive(false)
      else
        ((self.ui).lock):SetActive(affixElem.lock)
        ;
        ((self.ui).unLock):SetActive(not affixElem.lock)
      end
      -- DECOMPILER ERROR: 6 unprocessed JMP targets
    end
  end
end

UINAthRfctAffixItem._OnClickRoot = function(self)
  -- function num : 0_3
  if self.clickFunc ~= nil then
    (self.clickFunc)(self.index)
  end
end

UINAthRfctAffixItem.GetAffixAnimaNode = function(self)
  -- function num : 0_4
  return (self.ui).ani_node
end

UINAthRfctAffixItem.GetAffixCanvasGroup = function(self)
  -- function num : 0_5
  return (self.ui).canvasGroup
end

UINAthRfctAffixItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthRfctAffixItem


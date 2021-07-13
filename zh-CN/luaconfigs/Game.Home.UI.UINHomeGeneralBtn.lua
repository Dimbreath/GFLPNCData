-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHomeGeneralBtn = class("UINHomeGeneralBtn", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
UINHomeGeneralBtn.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.isUnlock = false
  self.isHaveRedDot = false
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINHomeGeneralBtn.RefeshUnlockInfo = function(self, isUnlock, unlockDes)
  -- function num : 0_1 , upvalues : _ENV
  self.isUnlock = isUnlock
  self.unlockDes = unlockDes
  if (self.ui).lock ~= nil then
    ((self.ui).lock):SetActive(not isUnlock)
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

  if not isUnlock and (self.ui).tex_Condition ~= nil and unlockDes ~= nil then
    ((self.ui).tex_Condition).text = unlockDes
  end
  self:RefreshRedDot(self.__lastNum, self.__lastIsBlue)
  if (self.ui).infoArray ~= nil then
    for _,go in ipairs((self.ui).infoArray) do
      go:SetActive(isUnlock)
    end
  end
end

UINHomeGeneralBtn.RefreshRedDot = function(self, num, isBlue)
  -- function num : 0_2 , upvalues : _ENV
  self.__lastNum = num
  self.__lastIsBlue = isBlue
  self.isHaveRedDot = num or 0 > 0
  if not IsNull((self.ui).obj_RedDot) and self.isUnlock and self.isHaveRedDot then
    ((self.ui).obj_RedDot):SetActive(not isBlue)
    if not IsNull((self.ui).obj_redDotWithCount) then
      if self.isUnlock and self.isHaveRedDot then
        local isHave = not isBlue
      end
      ;
      ((self.ui).obj_redDotWithCount):SetActive(isHave)
      if not num then
        local num = not isHave or 0
      end
      -- DECOMPILER ERROR at PC57: Confused about usage of register: R5 in 'UnsetPending'

      if num > 1 then
        ((self.ui).tex_Count).text = tostring(num)
        ;
        (((self.ui).tex_Count).gameObject):SetActive(true)
        ;
        ((self.ui).redDotWithCount):SetIndex(1)
      else
        (((self.ui).tex_Count).gameObject):SetActive(false)
        ;
        ((self.ui).redDotWithCount):SetIndex(0)
      end
    end
    ;
    ((self.ui).blueDot):SetActive(IsNull((self.ui).blueDot) or not self.isUnlock or not self.isHaveRedDot or isBlue)
    -- DECOMPILER ERROR: 9 unprocessed JMP targets
  end
end

UINHomeGeneralBtn.GetRedDotFunc = function(self)
  -- function num : 0_3 , upvalues : _ENV
  return BindCallback(self, self.RefreshRedDot)
end

UINHomeGeneralBtn.ShowUnlockDes = function(self)
  -- function num : 0_4 , upvalues : cs_MessageCommon
  if self.unlockDes ~= nil then
    (cs_MessageCommon.ShowMessageTips)(self.unlockDes)
  end
end

UINHomeGeneralBtn.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINHomeGeneralBtn


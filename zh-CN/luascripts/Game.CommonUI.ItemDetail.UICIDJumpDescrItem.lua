-- params : ...
-- function num : 0 , upvalues : _ENV
local UICIDJumpDescrItem = class("UICIDJumpDescrItem", UIBaseNode)
local base = UIBaseNode
UICIDJumpDescrItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Goto, self, self.OnBtnGotoClick)
end

UICIDJumpDescrItem.InitCIDJumpDescrItem = function(self, jumpData)
  -- function num : 0_1 , upvalues : _ENV
  self.id = jumpData.jumpId
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_DropInfo).text = tostring((LanguageUtil.GetLocaleText)((jumpData.cfg).content))
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)
  local isUnlock = funcUnLockCrtl:ValidateUnlock((jumpData.cfg).sys_open_id)
  ;
  ((self.ui).obj_Lock):SetActive(not isUnlock)
  ;
  (((self.ui).btn_Goto).gameObject):SetActive(isUnlock)
end

UICIDJumpDescrItem.SetJumpCallback = function(self, callback)
  -- function num : 0_2
  self.jumpCallback = callback
end

UICIDJumpDescrItem.OnBtnGotoClick = function(self)
  -- function num : 0_3
  if self.jumpCallback ~= nil then
    (self.jumpCallback)(self.id)
  end
end

return UICIDJumpDescrItem


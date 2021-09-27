local UIHeadScroll = class("UIHeadScroll", UIBaseNode)
local base = UIBaseNode
UIHeadScroll.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIHeadScroll.ReFreshData = function(self, dataListLen)
  -- function num : 0_1
  if dataListLen > 0 then
    (self.gameObject):SetActive(true)
    ;
    (((self.ui).img_Empty).gameObject):SetActive(false)
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).scro_List).totalCount = dataListLen
    ;
    ((self.ui).scro_List):RefillCells(0)
    ;
    (((self.ui).scrollbar).gameObject):SetActive(true)
  else
    ;
    (((self.ui).scrollbar).gameObject):SetActive(false)
    ;
    (self.gameObject):SetActive(false)
    ;
    (((self.ui).img_Empty).gameObject):SetActive(true)
  end
end

UIHeadScroll.OnDelte = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UIHeadScroll


-- params : ...
-- function num : 0 , upvalues : _ENV
local UICommonItemDetail = class("UICommonItemDetail", UIBaseNode)
local base = UIBaseNode
local UICommonItem = require("Game.CommonUI.Item.UICommonItem")
local JumpManager = require("Game.Jump.JumpManager")
UICommonItemDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (((self.ui).btn_jumpButton).gameObject):SetActive(false)
end

UICommonItemDetail.InitCommonItemDetail = function(self, itemCfg)
  -- function num : 0_1 , upvalues : _ENV, UICommonItem, JumpManager
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).text_itemName).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).text_itemDes).text = (LanguageUtil.GetLocaleText)(itemCfg.describe)
  local item = (UICommonItem.New)()
  item:Init((self.ui).commonItem)
  item:InitItem(itemCfg)
  item:SetClickable(false)
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R3 in 'UnsetPending'

  if itemCfg.achieve_des ~= nil and itemCfg.achieve_des ~= "" then
    ((self.ui).text_approachTex).text = (LanguageUtil.GetLocaleText)(itemCfg.achieve_des)
  else
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).text_approachTex).text = ConfigData:GetTipContent(TipContent.CommonItemDetailNoDesc)
  end
  if itemCfg.jump_id ~= nil and itemCfg.jump_id ~= 0 and self.canJump then
    (((self.ui).btn_jumpButton).gameObject):SetActive(true)
    ;
    (((self.ui).btn_jumpButton).onClick):RemoveAllListeners()
    ;
    (UIUtil.AddButtonListener)((self.ui).btn_jumpButton, self, function()
    -- function num : 0_1_0 , upvalues : JumpManager, itemCfg, self
    JumpManager:Jump(itemCfg.jump_id)
    if self.jumpCallback ~= nil then
      self:jumpCallback()
    end
    if self.parentWindowType ~= nil then
      JumpManager:CloseWin(self.parentWindowType)
    end
  end
)
  else
    ;
    (((self.ui).btn_jumpButton).gameObject):SetActive(false)
  end
end

UICommonItemDetail.SetJumpCallback = function(self, callback)
  -- function num : 0_2
  self.jumpCallback = callback
end

UICommonItemDetail.ParentWindowType = function(self, type)
  -- function num : 0_3
  self.parentWindowType = type
end

UICommonItemDetail.SetJumpable = function(self, canJump)
  -- function num : 0_4
  self.canJump = canJump
end

return UICommonItemDetail


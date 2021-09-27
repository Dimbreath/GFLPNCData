local UICIDJumpDescrItem = class("UICIDJumpDescrItem", UIBaseNode)
local base = UIBaseNode
local JumpManager = require("Game.Jump.JumpManager")
local JumpStrBuilder = require("Game.Jump.JumpStrBuilder")
local lockColor = (Color.New)(0.1098039, 0.1098039, 0.1098039, 0.8)
local normalColor = (Color.New)(0.1098039, 0.1098039, 0.1098039, 1)
UICIDJumpDescrItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Goto, self, self.OnBtnGotoClick)
end

UICIDJumpDescrItem.InitCIDJumpDescrItem = function(self, jumpCfg, jumpId, arg)
  -- function num : 0_1 , upvalues : JumpStrBuilder, _ENV, JumpManager, lockColor, normalColor
  local jumpDes = (JumpStrBuilder.GetDes)(jumpId, arg, (LanguageUtil.GetLocaleText)(jumpCfg.content))
  ;
  ((self.ui).texInfo_DropInfo):SetIndex(0, jumpDes)
  ;
  ((self.ui).tex_btnName):SetIndex(0)
  local isUnlock = (FunctionUnlockMgr:ValidateUnlock(jumpCfg.sys_open_id))
  local isJumpUnlock, unlcokNotice = nil, nil
  if isUnlock then
    isJumpUnlock = ((JumpManager.ValidateFuncArray)[jumpId])(arg, true)
    isUnlock = isJumpUnlock
  end
  ;
  ((self.ui).obj_Lock):SetActive(not isUnlock)
  ;
  (((self.ui).tex_UnlockInfo).gameObject):SetActive(not isUnlock)
  if not isUnlock then
    if isJumpUnlock == false then
      if unlcokNotice == nil then
        (((self.ui).tex_UnlockInfo).gameObject):SetActive(false)
      else
        ;
        (((self.ui).tex_UnlockInfo).gameObject):SetActive(true)
        -- DECOMPILER ERROR at PC66: Confused about usage of register: R8 in 'UnsetPending'

        ;
        ((self.ui).tex_UnlockInfo).text = unlcokNotice
      end
    else
      ;
      (((self.ui).tex_UnlockInfo).gameObject):SetActive(true)
      -- DECOMPILER ERROR at PC81: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((self.ui).tex_UnlockInfo).text = FunctionUnlockMgr:GetFuncUnlockDecription(jumpCfg.sys_open_id, true)
    end
    -- DECOMPILER ERROR at PC85: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.ui).tex_DropInfo).color = lockColor
  else
    -- DECOMPILER ERROR at PC90: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.ui).tex_DropInfo).color = normalColor
  end
  ;
  (((self.ui).btn_Goto).gameObject):SetActive(isUnlock)
  self:SetJumpCallback(function()
    -- function num : 0_1_0 , upvalues : JumpManager, jumpId, arg, _ENV
    local couldJump = JumpManager:ValidateJump(jumpId, arg)
    if couldJump then
      JumpManager:Jump(jumpId, function(jumpCallback)
      -- function num : 0_1_0_0 , upvalues : _ENV
      local win = UIManager:GetWindow(UIWindowTypeID.GlobalItemDetail)
      if win ~= nil then
        win:OnBtnReturnClick()
      end
      if jumpCallback ~= nil then
        jumpCallback()
      end
    end
, nil, arg)
    end
  end
)
end

UICIDJumpDescrItem.InitCIDJumpDescrItem4Factory = function(self, targetOrderData)
  -- function num : 0_2 , upvalues : _ENV
  local roomIndex = targetOrderData:GetOrderRoomIndex()
  local roomName = (LanguageUtil.GetLocaleText)(((ConfigData.factory)[roomIndex]).name)
  ;
  ((self.ui).texInfo_DropInfo):SetIndex(1, roomName)
  ;
  ((self.ui).tex_btnName):SetIndex(1)
end

UICIDJumpDescrItem.InitJump2Buy = function(self)
  -- function num : 0_3
  ((self.ui).texInfo_DropInfo):SetIndex(2)
  ;
  ((self.ui).tex_btnName):SetIndex(2)
end

UICIDJumpDescrItem.InitUseGift = function(self)
  -- function num : 0_4
  ((self.ui).texInfo_DropInfo):SetIndex(3)
  ;
  ((self.ui).tex_btnName):SetIndex(3)
end

UICIDJumpDescrItem.SetJumpCallback = function(self, callback)
  -- function num : 0_5
  self.jumpCallback = callback
end

UICIDJumpDescrItem.OnBtnGotoClick = function(self)
  -- function num : 0_6
  if self.jumpCallback ~= nil then
    (self.jumpCallback)(self.id)
    return 
  end
end

return UICIDJumpDescrItem


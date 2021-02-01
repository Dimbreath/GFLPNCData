-- params : ...
-- function num : 0 , upvalues : _ENV
local UICIDJumpDescrItem = class("UICIDJumpDescrItem", UIBaseNode)
local base = UIBaseNode
local JumpManager = require("Game.Jump.JumpManager")
local JumpStrBuilder = require("Game.Jump.JumpStrBuilder")
UICIDJumpDescrItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Goto, self, self.OnBtnGotoClick)
end

UICIDJumpDescrItem.InitCIDJumpDescrItem = function(self, jumpCfg, jumpId, arg)
  -- function num : 0_1 , upvalues : JumpStrBuilder, _ENV, JumpManager
  local jumpDes = (JumpStrBuilder.GetDes)(jumpId, arg, (LanguageUtil.GetLocaleText)(jumpCfg.content))
  ;
  ((self.ui).tex_DropInfo):SetIndex(0, jumpDes)
  ;
  ((self.ui).tex_btnName):SetIndex(0)
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(jumpCfg.sys_open_id)
  ;
  ((self.ui).obj_Lock):SetActive(not isUnlock)
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
      ;
      (UIUtil.ReturnHome)()
      local Home = UIManager:GetWindow(UIWindowTypeID.Home)
      if Home == nil then
        local back2HomeMsgFunc = nil
        do
          back2HomeMsgFunc = function()
        -- function num : 0_1_0_0_0 , upvalues : jumpCallback, _ENV, back2HomeMsgFunc
        if jumpCallback ~= nil then
          jumpCallback()
        end
        MsgCenter:RemoveListener(eMsgEventId.OnOpenHomeUI, back2HomeMsgFunc)
      end

          MsgCenter:AddListener(eMsgEventId.OnOpenHomeUI, back2HomeMsgFunc)
        end
      else
        do
          if jumpCallback ~= nil then
            jumpCallback()
          end
        end
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
  ((self.ui).tex_DropInfo):SetIndex(1, roomName)
  ;
  ((self.ui).tex_btnName):SetIndex(1)
end

UICIDJumpDescrItem.InitJump2Buy = function(self)
  -- function num : 0_3
  ((self.ui).tex_DropInfo):SetIndex(2)
  ;
  ((self.ui).tex_btnName):SetIndex(2)
end

UICIDJumpDescrItem.SetJumpCallback = function(self, callback)
  -- function num : 0_4
  self.jumpCallback = callback
end

UICIDJumpDescrItem.OnBtnGotoClick = function(self)
  -- function num : 0_5
  if self.jumpCallback ~= nil then
    (self.jumpCallback)(self.id)
    return 
  end
end

return UICIDJumpDescrItem


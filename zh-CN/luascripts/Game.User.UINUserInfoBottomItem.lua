-- params : ...
-- function num : 0 , upvalues : _ENV
local UINUserInfoBottomItem = class("UINUserInfoBottomItem", UIBaseNode)
local base = UIBaseNode
UINUserInfoBottomItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self._RefreshValue = BindCallback(self, self.RefreshValue)
end

UINUserInfoBottomItem.InitUserInfoBottomItem = function(self, index, getvalueFunc, msgId)
  -- function num : 0_1 , upvalues : _ENV
  self.getvalueFunc = getvalueFunc
  ;
  ((self.ui).tex_Tile):SetIndex(index - 1)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Content).text = getvalueFunc()
  if self.msgId == nil and msgId ~= nil then
    self.msgId = msgId
    MsgCenter:AddListener(msgId, self._RefreshValue)
  else
    if self.msgId ~= nil and self.msgId ~= msgId then
      MsgCenter:RemoveListener(self.msgId, self._RefreshValue)
      self.msgId = msgId
      if msgId ~= nil then
        MsgCenter:AddListener(msgId, self._RefreshValue)
      end
    end
  end
end

UINUserInfoBottomItem.RefreshValue = function(self)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).tex_Content).text = (self.getvalueFunc)()
end

UINUserInfoBottomItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : _ENV, base
  if self.msgId then
    MsgCenter:RemoveListener(self.msgId, self._RefreshValue)
  end
  ;
  (base.OnDelete)(self)
end

return UINUserInfoBottomItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINUserInfoBottomItem = class("UINUserInfoBottomItem", UIBaseNode)
local base = UIBaseNode
UINUserInfoBottomItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self._RefreshValue = BindCallback(self, self.RefreshValue)
end

UINUserInfoBottomItem.InitUserInfoBottomItem =
    function(self, index, getvalueFunc, msgId)
        -- function num : 0_1 , upvalues : _ENV
        self.getvalueFunc = getvalueFunc;
        ((self.ui).tex_Tile):SetIndex(index - 1) -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((self.ui).tex_Content).text = getvalueFunc()
        if self.msgId == nil and msgId ~= nil then
            self.msgId = msgId
            MsgCenter:AddListener(msgId, self._RefreshValue)
        else
            if self.msgId ~= nil and self.msgId ~= msgId then
                MsgCenter:RemoveListener(self.msgId, self._RefreshValue)
                self.msgId = msgId
                if msgId ~= nil then
                    MsgCenter:AddListener(msgId, self._RefreshValue)
                end
            end
        end
    end

UINUserInfoBottomItem.RefreshValue = function(self)
    -- function num : 0_2
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

    ((self.ui).tex_Content).text = (self.getvalueFunc)()
end

UINUserInfoBottomItem.OnDelete = function(self)
    -- function num : 0_3 , upvalues : _ENV, base
    if self.msgId then
        MsgCenter:RemoveListener(self.msgId, self._RefreshValue)
    end
    (base.OnDelete)(self)
end

return UINUserInfoBottomItem


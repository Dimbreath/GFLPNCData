-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthEfccOneKeyFiltItem = class("UINAthEfccOneKeyFiltItem", UIBaseNode)
local base = UIBaseNode
UINAthEfccOneKeyFiltItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_kindItem, self, self.__OnKindItemClick)
  self.select = false
  self:SetSelectUIActive()
end

UINAthEfccOneKeyFiltItem.InitAthEfccOneKeyFiltItem = function(self, index, onSelectFunc, select)
  -- function num : 0_1
  self.index = index
  self.onSelectFunc = onSelectFunc
  self.select = select
  ;
  ((self.ui).tex_KindName):SetIndex(index)
  self:SetSelectUIActive()
end

UINAthEfccOneKeyFiltItem.__OnKindItemClick = function(self)
  -- function num : 0_2
  self.select = not self.select
  self:SetSelectUIActive()
  if self.onSelectFunc ~= nil then
    (self.onSelectFunc)(self.index, self.select)
  end
end

UINAthEfccOneKeyFiltItem.SetSelectUIActive = function(self)
  -- function num : 0_3 , upvalues : _ENV
  ((self.ui).obj_OnSelect):SetActive(self.select)
  if not self.select or not Color.black then
    local selColor = Color.white
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).tex_KindName).text).color = selColor
end

UINAthEfccOneKeyFiltItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthEfccOneKeyFiltItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthEfccOneKeyFiltItem = class("UINAthEfccOneKeyFiltItem", UIBaseNode)
local base = UIBaseNode
UINAthEfccOneKeyFiltItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_kindItem, self,
                               self.__OnKindItemClick)
    self.select = false
    self:SetSelectUIActive()
end

UINAthEfccOneKeyFiltItem.InitAthEfccOneKeyFiltItem =
    function(self, index, onSelectFunc, select)
        -- function num : 0_1
        self.index = index
        self.onSelectFunc = onSelectFunc
        self.select = select;
        ((self.ui).tex_KindName):SetIndex(index)
        self:SetSelectUIActive()
    end

UINAthEfccOneKeyFiltItem.__OnKindItemClick =
    function(self)
        -- function num : 0_2
        self.select = not self.select
        self:SetSelectUIActive()
        if self.onSelectFunc ~= nil then
            (self.onSelectFunc)(self.index, self.select)
        end
    end

UINAthEfccOneKeyFiltItem.SetSelectUIActive =
    function(self)
        -- function num : 0_3 , upvalues : _ENV
        ((self.ui).obj_OnSelect):SetActive(self.select)
        if not self.select or not Color.black then
            local selColor = Color.white
        end -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'
        
        (((self.ui).tex_KindName).text).color = selColor
    end

UINAthEfccOneKeyFiltItem.OnDelete = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnDelete)(self)
end

return UINAthEfccOneKeyFiltItem


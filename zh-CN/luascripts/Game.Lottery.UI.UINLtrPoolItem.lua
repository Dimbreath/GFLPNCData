-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLtrPoolItem = class("UINLtrPoolItem", UIBaseNode)
local base = UIBaseNode
UINLtrPoolItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_root, self, self.__OnClickRoot)
end

UINLtrPoolItem.InitLtrPoolItem = function(self, index, poolCfg, resLoader, clickFunc)
  -- function num : 0_1 , upvalues : _ENV
  self:SetLtrPoolItemIndex(index)
  self.poolCfg = poolCfg
  self.clickFunc = clickFunc
  self.poolId = poolCfg.lottery_id
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.gameObject).name = tostring(self.poolId)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(poolCfg.name)
  local iconPath = PathConsts:GetLotteryPicPath("PoolIcon/" .. poolCfg.name_path)
  resLoader:LoadABAssetAsync(iconPath, function(texture)
    -- function num : 0_1_0 , upvalues : self
    if texture == nil then
      return 
    end
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).rawImg).texture = texture
  end
)
end

UINLtrPoolItem.SetLtrPoolItemIndex = function(self, index)
  -- function num : 0_2
  self.index = index
end

UINLtrPoolItem.__OnClickRoot = function(self)
  -- function num : 0_3
  if self.clickFunc ~= nil then
    (self.clickFunc)(self)
  end
end

UINLtrPoolItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINLtrPoolItem


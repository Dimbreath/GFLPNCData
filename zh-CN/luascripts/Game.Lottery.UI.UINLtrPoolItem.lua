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
  self.index = index
  self.poolCfg = poolCfg
  self.clickFunc = clickFunc
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.gameObject).name = tostring(index)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

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

UINLtrPoolItem.__OnClickRoot = function(self)
  -- function num : 0_2
  if self.clickFunc ~= nil then
    (self.clickFunc)(self)
  end
end

UINLtrPoolItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINLtrPoolItem


local UINLtrPoolItem = class("UINLtrPoolItem", UIBaseNode)
local base = UIBaseNode
UINLtrPoolItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_root, self, self.__OnClickRoot)
end

UINLtrPoolItem.InitLtrPoolItem = function(self, index, ltrPoolData, resLoader, clickFunc)
  -- function num : 0_1 , upvalues : _ENV
  self:SetLtrPoolItemIndex(index)
  self.ltrPoolData = ltrPoolData
  local poolCfg = ltrPoolData.ltrCfg
  self.poolCfg = poolCfg
  self.clickFunc = clickFunc
  self.poolId = poolCfg.lottery_id
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.gameObject).name = tostring(self.poolId)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R6 in 'UnsetPending'

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
  local navTag = ltrPoolData:GetLotteryDataNavTag()
  local tagName, index = ltrPoolData:GetTagNameAndIconIndex()
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R10 in 'UnsetPending'

  ;
  ((self.ui).tex_State).text = tagName
  ;
  ((self.ui).img_State):SetIndex(index)
  if ltrPoolData:IsLtrPoolLimitTime() then
    ((self.ui).obj_State):SetActive(true)
  else
    if navTag ~= 0 then
      ((self.ui).obj_State):SetActive(true)
    else
      ;
      ((self.ui).obj_State):SetActive(false)
    end
  end
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


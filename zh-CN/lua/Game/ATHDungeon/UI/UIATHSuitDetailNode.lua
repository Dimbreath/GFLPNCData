local UIATHSuitDetailNode = class("UIATHSuitDetailNode", UIBaseNode)
local base = UIBaseNode
local UIATHSuitDetailNodeSuitItem = require("Game.ATHDungeon.UI.UIATHSuitDetailNodeSuitItem")
UIATHSuitDetailNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIATHSuitDetailNodeSuitItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.SuitItemPool = (UIItemPool.New)(UIATHSuitDetailNodeSuitItem, (self.ui).tex_Effect)
  ;
  ((self.ui).tex_Effect):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).obj_SuitEffectBg, self, self.OnClicKClose)
end

UIATHSuitDetailNode.InitSuitDetailNode = function(self, suitId, resLoader)
  -- function num : 0_1 , upvalues : _ENV
  self.suitId = suitId
  self.resLoader = resLoader
  local suitParamCfg = ((ConfigData.ath_suit).suitParamDic)[self.suitId]
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  if suitParamCfg ~= nil then
    ((self.ui).tex_SuitName).text = (LanguageUtil.GetLocaleText)(suitParamCfg.name)
    ;
    (self.resLoader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath("AthSuitIcon"), function(spriteAtlas)
    -- function num : 0_1_0 , upvalues : self, suitParamCfg
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_SuitIcon).sprite = spriteAtlas:GetSprite(suitParamCfg.icon)
  end
)
  end
  ;
  (self.SuitItemPool):HideAll()
  for _,cfg in pairs((ConfigData.ath_suit)[self.suitId]) do
    local item = (self.SuitItemPool):GetOne()
    item:InitSuitItemInfo(cfg)
  end
end

UIATHSuitDetailNode.SetCoulClickThroughGos = function(self, list)
  -- function num : 0_2 , upvalues : _ENV
  local goList = {}
  for key,value in pairs(list) do
    (table.insert)(goList, value.gameObject)
  end
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).obj_SuitEffectBg).m_throughTargets = goList
end

UIATHSuitDetailNode.OnClicKClose = function(self)
  -- function num : 0_3
  self:Hide()
end

UIATHSuitDetailNode.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UIATHSuitDetailNode


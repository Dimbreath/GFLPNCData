-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroSkin = class("UINHeroSkin", UIBaseNode)
local base = UIBaseNode
local UINHeroSkinTag = require("Game.Skin.UI.UINHeroSkinTag")
UINHeroSkin.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroSkinTag
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).tagItem):SetActive(false)
  self.tagPool = (UIItemPool.New)(UINHeroSkinTag, (self.ui).tagItem)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_skinPreviewItem, self, self.OnClickSkinItem)
end

UINHeroSkin.InitSkinItem = function(self, heroId, skinCfg, resLoader, clickFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.heroCfg = (ConfigData.hero_data)[heroId]
  self.skinCfg = skinCfg
  self.clickFunc = clickFunc
  self.beginDragFunc = beginDragFunc
  self.dragingFunc = dragingFunc
  self.endDragFunc = endDragFunc
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  self.resModelCfg = skinCtr:GetResModel(heroId, skinCfg ~= nil and skinCfg.id or nil)
  ;
  (self.tagPool):HideAll()
  self.haveModel = false
  self.haveLive2D = false
  if (self.skinCfg).src_id_model == nil or #(self.skinCfg).src_id_model <= 0 then
    self.haveModel = self.skinCfg == nil
    do
      local resPath = PathConsts:GetCharacterLive2DPath((self.skinCfg).src_id_pic)
      self.haveLive2D = ((CS.ResManager).Instance):ContainsAsset(resPath)
      do
        local resPath = PathConsts:GetCharacterLive2DPath((self.resModelCfg).src_id_pic)
        self.haveLive2D = ((CS.ResManager).Instance):ContainsAsset(resPath)
        do
          if self.haveModel then
            local item = (self.tagPool):GetOne(true)
            item:InitTag(0)
            ;
            (item.gameObject):SetActive(true)
            ;
            (item.transform):SetParent(((self.ui).tagLayout).transform)
          end
          do
            if self.haveLive2D then
              local item = (self.tagPool):GetOne(true)
              item:InitTag(1)
              ;
              (item.gameObject):SetActive(true)
              ;
              (item.transform):SetParent(((self.ui).tagLayout).transform)
            end
            local picResPath = PathConsts:GetCharacterPicPath((self.resModelCfg).src_id_pic)
            resLoader:LoadABAssetAsync(picResPath, function(texture)
    -- function num : 0_1_0 , upvalues : _ENV, self
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    if not IsNull((self.ui).img_Skin) then
      ((self.ui).img_Skin).texture = texture
    end
  end
)
            -- DECOMPILER ERROR at PC139: Confused about usage of register: R7 in 'UnsetPending'

            if self.skinCfg == nil or not (LanguageUtil.GetLocaleText)((self.skinCfg).name) then
              ((self.ui).tex_HeroName).text = (LanguageUtil.GetLocaleText)((self.heroCfg).skin_name)
              if self.skinCfg == nil or not (self.skinCfg).theme then
                local skinTheme = (ConfigData.skinTheme)[(ConfigData.game_config).defaultSkinThemId]
                -- DECOMPILER ERROR at PC164: Confused about usage of register: R8 in 'UnsetPending'

                ;
                ((self.ui).tex_SkinName).text = skinTheme ~= nil and (LanguageUtil.GetLocaleText)(skinTheme.name) or ""
                local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
                if self.skinCfg ~= nil and skinCtr:CheckSourceValid((self.skinCfg).id) and (self.skinCfg).condition == proto_csmsg_SystemFunctionID.SystemFunctionID_Store then
                  local shopDic = (ControllerManager:GetController(ControllerTypeId.Shop)).shopDataDic
                  local shopGoodsData = nil
                  for i,v in ipairs((self.skinCfg).condition_para) do
                    if shopDic[v] ~= nil then
                      shopGoodsData = (shopDic[v]):GetShopGoodDataByItemId((self.skinCfg).id)
                    end
                  end
                  if shopGoodsData == nil then
                    do
                      self.shopGoodsData = shopGoodsData
                      self:Refresh()
                      -- DECOMPILER ERROR: 15 unprocessed JMP targets
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

UINHeroSkin.Refresh = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.skinCfg ~= nil and not (PlayerDataCenter.skinData):IsHaveSkin((self.skinCfg).id) and self.shopGoodsData ~= nil then
    ((self.ui).obj_Price):SetActive(true)
    local priceItem = (ConfigData.item)[(self.shopGoodsData).currencyId]
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_Price).sprite = CRH:GetSprite(priceItem.small_icon)
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_Price).text = tostring((self.shopGoodsData).newCurrencyNum)
  else
    do
      ;
      ((self.ui).obj_Price):SetActive(false)
    end
  end
end

UINHeroSkin.SetSelectState = function(self, flag)
  -- function num : 0_3 , upvalues : _ENV
  (((self.ui).img_Quailty).gameObject):SetActive(flag)
  ;
  ((self.ui).maskBlack):SetActive(not flag)
  for i,v in ipairs((self.tagPool).listItem) do
    v:SetSelectState(flag)
  end
end

UINHeroSkin.OnClickSkinItem = function(self)
  -- function num : 0_4
  if self.clickFunc ~= nil then
    (self.clickFunc)(self)
  end
end

return UINHeroSkin


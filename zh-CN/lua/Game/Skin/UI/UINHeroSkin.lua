local UINHeroSkin = class("UINHeroSkin", UIBaseNode)
local base = UIBaseNode
local UINHeroSkinTag = require("Game.Skin.UI.UINHeroSkinTag")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
UINHeroSkin.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroSkinTag
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).tagItem):SetActive(false)
  self.tagPool = (UIItemPool.New)(UINHeroSkinTag, (self.ui).tagItem)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_skinPreviewItem, self, self.OnClickSkinItem)
end

UINHeroSkin.InitSkinItem = function(self, heroId, skinCfg, resLoader, clickFunc, outDataFunc)
  -- function num : 0_1 , upvalues : _ENV, HeroCubismInteration
  self.heroCfg = (ConfigData.hero_data)[heroId]
  self.skinCfg = skinCfg
  self.shopGoodsData = nil
  self.clickFunc = clickFunc
  self.outDataFunc = outDataFunc
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  self.resModelCfg = skinCtr:GetResModel(heroId, skinCfg ~= nil and skinCfg.id or nil)
  ;
  (self.tagPool):HideAll()
  self.haveModel = false
  self.haveLive2D = false
  if (self.skinCfg).src_id_model == nil or #(self.skinCfg).src_id_model <= 0 then
    self.haveModel = self.skinCfg == nil
    local resPath = PathConsts:GetCharacterLive2DPath((self.skinCfg).src_id_pic)
    self.haveLive2D = ((CS.ResManager).Instance):ContainsAsset(resPath)
    if self.haveLive2D then
      do
        self.haveLive2D = not (HeroCubismInteration.JudgeL2DLocked)((self.skinCfg).id)
        local resPath = PathConsts:GetCharacterLive2DPath((self.resModelCfg).src_id_pic)
        self.haveLive2D = ((CS.ResManager).Instance):ContainsAsset(resPath)
        if self.haveLive2D then
          do
            self.haveLive2D = not (HeroCubismInteration.JudgeL2DLocked)((self.resModelCfg).id)
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
                ;
                (((self.ui).img_Skin).gameObject):SetActive(false)
                local picResPath = PathConsts:GetCharacterPicPath((self.resModelCfg).src_id_pic)
                resLoader:LoadABAssetAsync(picResPath, function(texture)
    -- function num : 0_1_0 , upvalues : _ENV, self
    if not IsNull((self.ui).img_Skin) then
      (((self.ui).img_Skin).gameObject):SetActive(true)
      -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((self.ui).img_Skin).texture = texture
    end
  end
)
                -- DECOMPILER ERROR at PC159: Confused about usage of register: R8 in 'UnsetPending'

                if self.skinCfg == nil or not (LanguageUtil.GetLocaleText)((self.skinCfg).name) then
                  ((self.ui).tex_HeroName).text = (LanguageUtil.GetLocaleText)((self.heroCfg).skin_name)
                  if self.skinCfg == nil or not (self.skinCfg).theme then
                    local skinTheme = (ConfigData.skinTheme)[(ConfigData.game_config).defaultSkinThemId]
                    -- DECOMPILER ERROR at PC184: Confused about usage of register: R9 in 'UnsetPending'

                    ;
                    ((self.ui).tex_SkinName).text = skinTheme ~= nil and (LanguageUtil.GetLocaleText)(skinTheme.name) or ""
                    local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
                    if self.skinCfg ~= nil and skinCtr:CheckSourceValid((self.skinCfg).id) then
                      local shopGoodsData = nil
                      if (self.skinCfg).condition == proto_csmsg_SystemFunctionID.SystemFunctionID_Store then
                        local shopDic = (ControllerManager:GetController(ControllerTypeId.Shop)).shopDataDic
                        for i,v in ipairs((self.skinCfg).condition_para) do
                          if shopDic[v] ~= nil then
                            shopGoodsData = (shopDic[v]):GetShopGoodDataByItemId((self.skinCfg).id)
                          end
                        end
                      end
                      if shopGoodsData ~= nil or shopGoodsData ~= nil then
                        local hasTime, inTime = shopGoodsData:GetStillTime()
                        if not hasTime or inTime then
                          self.shopGoodsData = shopGoodsData
                        end
                      end
                    end
                    self:Refresh()
                    -- DECOMPILER ERROR: 18 unprocessed JMP targets
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
      self:OnTimerCutDownStart()
    end
  end
end

UINHeroSkin.OnTimerCutDownStart = function(self)
  -- function num : 0_3 , upvalues : _ENV
  ((self.ui).time):SetActive(false)
  if self.cutDownTimer ~= nil then
    TimerManager:StopTimer(self.cutDownTimer)
    self.cutDownTimer = nil
  end
  if self.shopGoodsData == nil then
    return 
  end
  if (self.shopGoodsData).isSoldOut then
    return 
  end
  local hasTime = (self.shopGoodsData):GetStillTime()
  if not hasTime then
    return 
  end
  ;
  ((self.ui).time):SetActive(true)
  self.cutDownTimer = TimerManager:StartTimer(1, self.OnTimerCutDown, self)
  self:OnTimerCutDown()
end

UINHeroSkin.OnTimerCutDown = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.shopGoodsData == nil then
    self:OnTimerCutDownFinish()
    return 
  end
  local hasTime, inTime, startTime, endTime = (self.shopGoodsData):GetStillTime()
  if not hasTime or not inTime then
    self:OnTimerCutDownFinish()
    return 
  end
  local remaindTime = endTime - PlayerDataCenter.timestamp
  local d, h, m, s = TimestampToTimeInter(remaindTime, false, true)
  if d > 0 then
    ((self.ui).text_time):SetIndex(0, tostring(d), tostring(h))
    return 
  end
  if h > 0 then
    ((self.ui).text_time):SetIndex(1, tostring(h), tostring(m))
    return 
  end
  if s > 0 then
    m = m + 1
  end
  ;
  ((self.ui).text_time):SetIndex(2, tostring(m))
end

UINHeroSkin.OnTimerCutDownFinish = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((self.ui).time):SetActive(false)
  if self.cutDownTimer ~= nil then
    TimerManager:StopTimer(self.cutDownTimer)
    self.cutDownTimer = nil
  end
  self.shopGoodsData = nil
  if self.outDataFunc ~= nil then
    (self.outDataFunc)()
  end
end

UINHeroSkin.SetSelectState = function(self, flag)
  -- function num : 0_6 , upvalues : _ENV
  (((self.ui).img_Quailty).gameObject):SetActive(flag)
  ;
  ((self.ui).maskBlack):SetActive(not flag)
  for i,v in ipairs((self.tagPool).listItem) do
    v:SetSelectState(flag)
  end
end

UINHeroSkin.OnClickSkinItem = function(self)
  -- function num : 0_7
  if self.clickFunc ~= nil then
    (self.clickFunc)(self)
  end
end

UINHeroSkin.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV, base
  if self.cutDownTimer ~= nil then
    TimerManager:StopTimer(self.cutDownTimer)
    self.cutDownTimer = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINHeroSkin


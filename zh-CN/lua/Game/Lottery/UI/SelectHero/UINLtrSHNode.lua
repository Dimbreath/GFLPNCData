local UINLtrSHNode = class("UINLtrSHNode", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
local cs_DoTween = ((CS.DG).Tweening).DOTween
local cs_Ease = ((CS.DG).Tweening).Ease
UINLtrSHNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self._OnClickClose)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self._OnClickConfirm)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, self._OnClickClose)
  self:_InitSwithTween()
end

UINLtrSHNode.InitLtrSHNode = function(self, itemId, curHeroCfg, ltrCfg, ltrCtrl)
  -- function num : 0_1 , upvalues : _ENV, UINHeroHeadItem
  self.itemId = itemId
  self.curHeroCfg = curHeroCfg
  self.ltrCfg = ltrCfg
  self.ltrCtrl = ltrCtrl
  ;
  (self.showSeq):Rewind()
  ;
  (UIUtil.SetTopStatus)(self, self.Hide, {1001, 1002})
  local window = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if window ~= nil then
    window:SetTopButtonGroup(false)
  end
  self.heroItem = UINHeroHeadItem:New()
  ;
  (self.heroItem):Init((self.ui).obj_heroHeadItem)
  self:ReFreshLtrSHUI()
end

UINLtrSHNode.ReFreshLtrSHUI = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self.heroItem):InitHeroHeadItemWithId((self.curHeroCfg).id)
  local rankCfg = (ConfigData.hero_rank)[(self.curHeroCfg).rank]
  if rankCfg == nil then
    error("Can\'t find rankCfg, id = " .. tostring((self.curHeroCfg).rank))
  end
  self:__RefreshStar(rankCfg.star)
  local name = (LanguageUtil.GetLocaleText)((self.curHeroCfg).name)
  local costNum = (self.ltrCfg).costNum4
  local itemCount = PlayerDataCenter:GetItemCount((self.ltrCfg).costId4)
  local info = (string.format)(ConfigData:GetTipContent(311), costNum, name)
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Title).text = ConfigData:GetTipContent(310)
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = name
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Info).text = info
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_PtFrom).text = itemCount
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_PtTo).text = itemCount - costNum
end

UINLtrSHNode.__RefreshStar = function(self, heroStar)
  -- function num : 0_3
  local half = heroStar % 2
  local rankImgIndex = (heroStar - half) / 2 - 1
  if rankImgIndex >= 0 then
    (((self.ui).img_Star).gameObject):SetActive(true)
    ;
    ((self.ui).img_Star):SetIndex(rankImgIndex)
    local vec = ((((self.ui).img_Star).image).rectTransform).sizeDelta
    vec.x = (((((self.ui).img_Star).image).sprite).rect).width
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((((self.ui).img_Star).image).rectTransform).sizeDelta = vec
  else
    do
      ;
      (((self.ui).img_Star).gameObject):SetActive(false)
      ;
      (((self.ui).img_Half).gameObject):SetActive(half == 1)
      -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end
  end
end

UINLtrSHNode._OnClickConfirm = function(self)
  -- function num : 0_4
  (self.ltrCtrl):LtrFreeSelect(self.itemId)
  self:_OnClickClose()
end

UINLtrSHNode.BindCloseFun = function(self, closeFun)
  -- function num : 0_5
  self.__closeFun = closeFun
end

UINLtrSHNode._InitSwithTween = function(self)
  -- function num : 0_6 , upvalues : cs_DoTween, cs_Ease
  self:_KillTween()
  local sequence = (cs_DoTween.Sequence)()
  sequence:SetEase(cs_Ease.InQuad)
  sequence:SetAutoKill(false)
  sequence:Pause()
  self.showSeq = sequence
end

UINLtrSHNode._KillTween = function(self)
  -- function num : 0_7
  if self.showSeq ~= nil then
    (self.showSeq):Kill(true)
    self.showSeq = nil
  end
end

UINLtrSHNode._OnClickClose = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if window ~= nil then
    window:SetTopButtonGroup(true)
  end
  ;
  (UIUtil.OnClickBack)()
  if self.__closeFun ~= nil then
    (self.__closeFun)()
  end
end

UINLtrSHNode.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  self:_KillTween()
  ;
  (base.OnDelete)(self)
end

return UINLtrSHNode


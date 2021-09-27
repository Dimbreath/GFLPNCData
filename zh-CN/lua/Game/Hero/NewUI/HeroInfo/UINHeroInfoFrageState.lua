local UINHeroInfoFrageState = class("UINHeroInfoFrageState", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local JumpManager = require("Game.Jump.JumpManager")
UINHeroInfoFrageState.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Unlock, self, self.__OnClickUnlock)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_buttom, self, self.__OnClickFragDescribe)
end

UINHeroInfoFrageState.RefreshFrageState = function(self, heroData, resloader)
  -- function num : 0_1 , upvalues : _ENV, JumpManager
  self.heroData = heroData
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_Pic).texture = resloader:LoadABAsset(PathConsts:GetCharacterPicPath(heroData:GetResPicName()))
  local couldMerge, curFrage, mergeNeedFrage = (self.heroData):GetIsCouldMerge()
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R6 in 'UnsetPending'

  if couldMerge then
    ((self.ui).img_btn_Unlock).color = (self.ui).color_orange
    ;
    ((self.ui).tex_ChipCount):SetIndex(0, tostring(curFrage), tostring(mergeNeedFrage))
  else
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).img_btn_Unlock).color = (self.ui).color_gray
    ;
    ((self.ui).tex_ChipCount):SetIndex(1, tostring(curFrage), tostring(mergeNeedFrage))
  end
  self.couldMerge = couldMerge
  JumpManager.couldUseItemJump = true
end

UINHeroInfoFrageState.__OnClickUnlock = function(self)
  -- function num : 0_2 , upvalues : cs_MessageCommon, _ENV
  if not self.couldMerge then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Frag_MergeFrageInsufficient))
    return 
  end
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.Hero)):CS_HERO_MERGE((self.heroData).fragId, function()
    -- function num : 0_2_0 , upvalues : _ENV, self
    (UIUtil.OnClickBack)()
    UIManager:ShowWindowAsync(UIWindowTypeID.GetHero, function(window)
      -- function num : 0_2_0_0 , upvalues : _ENV, self
      if window == nil then
        return 
      end
      window:SetCustomVoiceType(eVoiceType.GAIN)
      window:InitGetHeroList({(self.heroData).dataId}, true, true, {true}, function()
        -- function num : 0_2_0_0_0 , upvalues : _ENV, self
        local win = UIManager:GetWindow(UIWindowTypeID.HeroList)
        if win == nil then
          return nil
        end
        local heroData = (PlayerDataCenter.heroDic)[(self.heroData).dataId]
        win:Roll2Hero(heroData.dataId)
        win:OnSelHeroItemClick(heroData)
      end
, true)
    end
)
  end
)
end

UINHeroInfoFrageState.__OnClickFragDescribe = function(self)
  -- function num : 0_3 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(window)
    -- function num : 0_3_0 , upvalues : _ENV, self
    if window == nil then
      return 
    end
    window:InitCommonItemDetail((ConfigData.item)[(self.heroData).fragId])
  end
)
end

UINHeroInfoFrageState.OnDelete = function(self)
  -- function num : 0_4 , upvalues : JumpManager, base
  JumpManager.couldUseItemJump = false
  ;
  (base.OnDelete)(self)
end

return UINHeroInfoFrageState


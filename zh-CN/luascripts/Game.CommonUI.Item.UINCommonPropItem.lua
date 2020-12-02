-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCommonPropItem = class("UINCommonPropItem", UIBaseNode)
local base = UIBaseNode
UINCommonPropItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).commonPropItem, self, self.OnPropItemClicked)
end

UINCommonPropItem.InitPropItem = function(self, resloader, itemCfg, itemCount)
  -- function num : 0_1 , upvalues : _ENV
  self.itemCfg = itemCfg
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_PropName).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
  ;
  ((self.ui).propNum):SetActive(itemCount == nil and itemCount ~= nil)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'

  if itemCount ~= nil then
    ((self.ui).tex_PropNumber).text = tostring(itemCount)
  end
  local action_type = itemCfg.action_type
  if action_type == eItemActionType.HeroCard or action_type == eItemActionType.HeroCardFrag then
    local heroId = (itemCfg.arg)[1]
    ;
    ((self.ui).propItem):SetActive(false)
    ;
    ((self.ui).heroItem):SetActive(true)
    ;
    ((self.ui).img_Frag):SetActive(action_type == eItemActionType.HeroCardFrag)
    local heroCfg = (ConfigData.hero_data)[heroId]
    if heroCfg == nil then
      return 
    end
    local heroResCfg = (ConfigData.resource_model)[heroCfg.src_id]
    if heroResCfg ~= nil then
      resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(heroResCfg.res_Name), function(texture)
    -- function num : 0_1_0 , upvalues : _ENV, self, itemCfg
    if IsNull(self.transform) then
      return 
    end
    if self.itemCfg ~= itemCfg then
      return 
    end
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_HeroPic).texture = texture
  end
)
    end
  else
    -- DECOMPILER ERROR at PC79: Confused about usage of register: R5 in 'UnsetPending'

    ((self.ui).img_HeroPic).texture = nil
    ;
    ((self.ui).propItem):SetActive(true)
    ;
    ((self.ui).heroItem):SetActive(false)
    -- DECOMPILER ERROR at PC96: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).img_ItemPic).sprite = CRH:GetSprite(itemCfg.icon)
  end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

UINCommonPropItem.BindClickedEvent = function(self, action)
  -- function num : 0_2
  self.onClickEvent = action
end

UINCommonPropItem.OnPropItemClicked = function(self)
  -- function num : 0_3
  if self.onClickEvent ~= nil then
    (self.onClickEvent)(self)
  end
end

UINCommonPropItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINCommonPropItem


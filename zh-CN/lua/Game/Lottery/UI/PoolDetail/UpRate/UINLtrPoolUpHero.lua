local UINLtrPoolUpHero = class("UINLtrPoolUpHero", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
UINLtrPoolUpHero.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self._OnClickRoot)
end

UINLtrPoolUpHero.InitLtrPoolUpHero = function(self, rewardData, resLoader)
  -- function num : 0_1 , upvalues : _ENV
  local resCfg = (ConfigData.resource_model)[(rewardData.heroCfg).src_id]
  if resCfg == nil then
    error("resource model Cfg is null,id:" .. tostring((rewardData.heroCfg).src_id))
    return 
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Hero).texture = nil
  resLoader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(resCfg.res_Name), function(texture)
    -- function num : 0_1_0 , upvalues : _ENV, self
    if IsNull(texture) then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Hero).texture = texture
  end
)
  local careerCfg = (ConfigData.career)[(rewardData.heroCfg).career]
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Carrer).sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((rewardData.heroCfg).name)
  local rewardCfg = rewardData.rewardCfg
  self.rewardCfg = rewardCfg
  local lock = not (CheckCondition.CheckLua)(rewardCfg.pre_condition, rewardCfg.pre_para1, rewardCfg.pre_para2)
  ;
  ((self.ui).lock):SetActive(lock)
  self.lock = lock
  self:_IsRateUp(rewardData.upHero)
end

UINLtrPoolUpHero._OnClickRoot = function(self)
  -- function num : 0_2 , upvalues : _ENV, cs_MessageCommon
  if self.lock then
    local lockInfo = (CheckCondition.GetUnlockInfoLua)({((self.rewardCfg).pre_condition)[1]}, {((self.rewardCfg).pre_para1)[1]}, {((self.rewardCfg).pre_para2)[1]})
    ;
    (cs_MessageCommon.ShowMessageTips)(lockInfo)
  end
end

UINLtrPoolUpHero._IsRateUp = function(self, bool)
  -- function num : 0_3
  ((self.ui).obj_rateUp):SetActive(bool)
end

UINLtrPoolUpHero.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINLtrPoolUpHero


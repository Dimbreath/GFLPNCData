-- params : ...
-- function num : 0 , upvalues : _ENV
local UILtrPoolDetailRateReward = class("UILtrPoolDetailRateReward", UIBaseNode)
local base = UIBaseNode
UILtrPoolDetailRateReward.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (((self.ui).img_star).gameObject):SetActive(false)
  self.starItemList = {}
end

UILtrPoolDetailRateReward.InitLtrPoolDetailRateReward = function(self, rewardData)
  -- function num : 0_1 , upvalues : _ENV
  local star = 0
  if rewardData.rankCfg ~= nil then
    star = (rewardData.rankCfg).star
  end
  self:__HideAllStar()
  self:__UpdateStar(star)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

  if rewardData.isItem then
    ((self.ui).tex_Name).text = ConfigData:GetTipContent(304)
    ;
    ((self.ui).lock):SetActive(false)
  else
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((rewardData.heroCfg).name)
    local rewardCfg = rewardData.rewardCfg
    local lock = not (CheckCondition.CheckLua)(rewardCfg.pre_condition, rewardCfg.pre_para1, rewardCfg.pre_para2)
    ;
    ((self.ui).lock):SetActive(lock)
    if lock then
      local lockInfo = (CheckCondition.GetUnlockInfoLua)({(rewardCfg.pre_condition)[1]}, {(rewardCfg.pre_para1)[1]}, {(rewardCfg.pre_para2)[1]})
      -- DECOMPILER ERROR at PC67: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).tex_Condition).text = lockInfo
    end
  end
  do
    ;
    ((self.ui).tex_Rate):SetIndex(rewardData.upHero and 1 or 0, GetPreciseDecimalStr(rewardData.rate / 100, 2))
    ;
    ((self.ui).obj_IsUP):SetActive(rewardData.upHero)
  end
end

UILtrPoolDetailRateReward.__UpdateStar = function(self, starCount)
  -- function num : 0_2
  local twoStarCount = starCount // 2
  local oneStarCount = starCount % 2
  for i = 1, twoStarCount do
    local starItem = self:__GetStar(i)
    starItem:SetIndex(0)
  end
  if oneStarCount ~= 0 then
    local starItem = self:__GetStar(twoStarCount + 1)
    starItem:SetIndex(1)
  end
end

UILtrPoolDetailRateReward.__GetStar = function(self, index)
  -- function num : 0_3
  local starItem = (self.starItemList)[index]
  if starItem == nil then
    starItem = ((self.ui).img_star):Instantiate()
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.starItemList)[index] = starItem
  end
  ;
  (starItem.gameObject):SetActive(true)
  return starItem
end

UILtrPoolDetailRateReward.__HideAllStar = function(self)
  -- function num : 0_4 , upvalues : _ENV
  for k,v in pairs(self.starItemList) do
    (v.gameObject):SetActive(false)
  end
end

UILtrPoolDetailRateReward.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UILtrPoolDetailRateReward

-- params : ...
-- function num : 0 , upvalues : _ENV
local UILtrPoolDetailRateReward = class("UILtrPoolDetailRateReward", UIBaseNode)
local base = UIBaseNode
UILtrPoolDetailRateReward.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (((self.ui).img_star).gameObject):SetActive(false)
    self.starItemList = {}
end

UILtrPoolDetailRateReward.InitLtrPoolDetailRateReward =
    function(self, rewardData)
        -- function num : 0_1 , upvalues : _ENV
        local star = 0
        if rewardData.rankCfg ~= nil then
            star = (rewardData.rankCfg).star
        end
        self:__HideAllStar()
        self:__UpdateStar(star)
        -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

        if rewardData.isItem then
            ((self.ui).tex_Name).text = ConfigData:GetTipContent(304);
            ((self.ui).lock):SetActive(false)
        else
            -- DECOMPILER ERROR at PC34: Confused about usage of register: R3 in 'UnsetPending'


            ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(
                                            (rewardData.heroCfg).name)
            local rewardCfg = rewardData.rewardCfg
            local lock = not (CheckCondition.CheckLua)(rewardCfg.pre_condition,
                                                       rewardCfg.pre_para1,
                                                       rewardCfg.pre_para2);
            ((self.ui).lock):SetActive(lock)
            if lock then
                local lockInfo = (CheckCondition.GetUnlockInfoLua)(
                                     {(rewardCfg.pre_condition)[1]},
                                     {(rewardCfg.pre_para1)[1]},
                                     {(rewardCfg.pre_para2)[1]}) -- DECOMPILER ERROR at PC67: Confused about usage of register: R6 in 'UnsetPending'
                ;
                ((self.ui).tex_Condition).text = lockInfo
            end
        end
        do

            ((self.ui).tex_Rate):SetIndex(rewardData.upHero and 1 or 0,
                                          GetPreciseDecimalStr(
                                              rewardData.rate / 100, 2));
            ((self.ui).obj_IsUP):SetActive(rewardData.upHero)
        end
    end

UILtrPoolDetailRateReward.__UpdateStar =
    function(self, starCount)
        -- function num : 0_2
        local twoStarCount = starCount // 2
        local oneStarCount = starCount % 2
        for i = 1, twoStarCount do
            local starItem = self:__GetStar(i)
            starItem:SetIndex(0)
        end
        if oneStarCount ~= 0 then
            local starItem = self:__GetStar(twoStarCount + 1)
            starItem:SetIndex(1)
        end
    end

UILtrPoolDetailRateReward.__GetStar = function(self, index)
    -- function num : 0_3
    local starItem = (self.starItemList)[index]
    if starItem == nil then
        starItem = ((self.ui).img_star):Instantiate() -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'
        ;
        (self.starItemList)[index] = starItem
    end
    (starItem.gameObject):SetActive(true)
    return starItem
end

UILtrPoolDetailRateReward.__HideAllStar =
    function(self)
        -- function num : 0_4 , upvalues : _ENV
        for k, v in pairs(self.starItemList) do
            (v.gameObject):SetActive(false)
        end
    end

UILtrPoolDetailRateReward.OnDelete = function(self)
    -- function num : 0_5 , upvalues : base
    (base.OnDelete)(self)
end

return UILtrPoolDetailRateReward


-- params : ...
-- function num : 0 , upvalues : _ENV
local UILoading = class("UILoading", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
UILoading.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_ResLoader
  self.__permanent = true
  self.onProgressRefresh = BindCallback(self, self.RefreshSceneProgress)
  MsgCenter:AddListener(eMsgEventId.OnSceneLoadingProgress, self.onProgressRefresh)
  self.defaultBg = ((self.ui).bG).texture
  self.bgResLoader = (cs_ResLoader.Create)()
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_LeftArrow, self, self._OnClickLeft)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_RightArrow, self, self._OnClickRight)
  self.__isInitShow = true
end

UILoading.SetLoadingTipsSystemId = function(self, systemId)
  -- function num : 0_1
  self.__systemId = systemId
end

shuffle = function(targetTbl)
  -- function num : 0_2 , upvalues : _ENV
  (math.randomseed)((os.time)())
  local tblLen = #targetTbl
  do
    while tblLen > 0 do
      local idx = (math.random)(tblLen)
      targetTbl[tblLen] = targetTbl[idx]
      tblLen = tblLen - 1
    end
    return targetTbl
  end
end

validTips = function(tipsId)
  -- function num : 0_3 , upvalues : _ENV
  local tipCfg = (ConfigData.loading_tips)[tipsId]
  local valid = (CheckCondition.CheckLua)(tipCfg.in_condition, tipCfg.in_para1, tipCfg.in_para2) and (#tipCfg.out_condition ~= 0 and not (CheckCondition.CheckLua)(tipCfg.out_condition, tipCfg.out_para1, tipCfg.out_para2))
  do return valid end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UILoading.__InitLoadingTips = function(self, systemId)
  -- function num : 0_4 , upvalues : _ENV
  local tipsIdListNew = {}
  for k,id in ipairs(((ConfigData.loading_tips).systemLoadingTipsDic)[0]) do
    if validTips(id) then
      (table.insert)(tipsIdListNew, id)
    end
  end
  local tipsIdListSource = ((ConfigData.loading_tips).systemLoadingTipsDic)[systemId]
  if tipsIdListSource ~= nil then
    for k,id in ipairs(tipsIdListSource) do
      if validTips(id) then
        (table.insert)(tipsIdListNew, id)
      end
    end
  end
  do
    self.tipIdList = shuffle(tipsIdListNew)
    self.curTipsIndex = 1
    self:__SetLoadingTips(self.curTipsIndex)
  end
end

UILoading.__SetLoadingTips = function(self, index)
  -- function num : 0_5 , upvalues : _ENV, cs_ResLoader
  local tipCfg = (ConfigData.loading_tips)[(self.tipIdList)[index]]
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Tips).text = (LanguageUtil.GetLocaleText)(tipCfg.text)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Title).text = (LanguageUtil.GetLocaleText)(tipCfg.title)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

  if (string.IsNullOrEmpty)(tipCfg.pic_path) then
    ((self.ui).bG).texture = self.defaultBg
  else
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R3 in 'UnsetPending'

    if self.curBgPath ~= tipCfg.pic_path then
      ((self.ui).bG).texture = self.defaultBg
      ;
      (self.bgResLoader):Put2Pool()
      self.bgResLoader = (cs_ResLoader.Create)()
      self.curBgPath = tipCfg.pic_path
    end
    local path = PathConsts:GetImagePath(tipCfg.pic_path)
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R4 in 'UnsetPending'

    if self.__isFirstLoad then
      ((self.ui).bG).texture = (self.bgResLoader):LoadABAsset(path)
    else
      ;
      (self.bgResLoader):LoadABAssetAsync(path, function(texture)
    -- function num : 0_5_0 , upvalues : self
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

    ((self.ui).bG).texture = texture
  end
)
    end
  end
end

UILoading.__ChangeLoadingTips = function(self, add)
  -- function num : 0_6
  self.curTipsIndex = self.curTipsIndex + (add and 1 or -1)
  local maxNum = #self.tipIdList
  if self.curTipsIndex <= 0 then
    self.curTipsIndex = maxNum
  else
    if maxNum < self.curTipsIndex then
      self.curTipsIndex = 1
    end
  end
  self:__SetLoadingTips(self.curTipsIndex)
end

UILoading._OnClickLeft = function(self)
  -- function num : 0_7
  self:__ChangeLoadingTips(false)
end

UILoading._OnClickRight = function(self)
  -- function num : 0_8
  self:__ChangeLoadingTips(true)
end

UILoading.OnShow = function(self)
  -- function num : 0_9 , upvalues : base
  ((self.ui).progressNode):SetActive(false)
  if self.__isInitShow then
    self.__isInitShow = false
    ;
    ((self.ui).loadingTipsNode):SetActive(false)
  else
    self.__isFirstLoad = true
    self:__InitLoadingTips(self.__systemId)
    ;
    ((self.ui).loadingTipsNode):SetActive(true)
    self.__isFirstLoad = false
  end
  ;
  (base.OnShow)(self)
end

UILoading.OnHide = function(self)
  -- function num : 0_10 , upvalues : base
  self.__systemId = nil
  ;
  ((self.ui).loadingTipsNode):SetActive(false)
  ;
  (base.OnHide)(self)
end

UILoading.RefreshSceneProgress = function(self, value)
  -- function num : 0_11 , upvalues : _ENV
  ((self.ui).progressNode):SetActive(true)
  local p = value * 100
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_Bar).fillAmount = value
  ;
  ((self.ui).tex_Info):SetIndex(0, tostring((Mathf.Ceil)(p)))
end

UILoading.OnDelete = function(self)
  -- function num : 0_12 , upvalues : _ENV, base
  (self.bgResLoader):Put2Pool()
  self.bgResLoader = nil
  MsgCenter:RemoveListener(eMsgEventId.OnSceneLoadingProgress, self.onProgressRefresh)
  ;
  (base.OnDelete)(self)
end

return UILoading


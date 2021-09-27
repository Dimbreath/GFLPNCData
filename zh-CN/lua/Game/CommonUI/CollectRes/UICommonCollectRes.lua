local UICommonCollectRes = class("UICommonCollectRes", UIBaseWindow)
local base = UIBaseWindow
local CCRProductionItem = require("Game.CommonUI.CollectRes.UICCRProductionItem")
local cs_DOTween = ((CS.DG).Tweening).DOTween
UICommonCollectRes.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, CCRProductionItem
  self.isDetailState = false
  self.__onSyllabusComplete = BindCallback(self, self.__OnSyllabusComplete)
  self.__onDetailComplete = BindCallback(self, self.__OnDetailComplete)
  self.__onCollectAllAnimaComplete = BindCallback(self, self.__OnCollectAllAnimaComplete)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GetAll, self, self.__OnCollectAllClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GetAllSmall, self, self.__OnCollectAllClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ShowSyllabus, self, self.__OnShowSyllabusClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ShowDetail, self, self.__OnShowDetailClick)
  self:__SetDetailUI(self.isDetailState)
  self.buildProduction = {}
  self.ProductItemDic = {}
  self.productionItemPool = (UIItemPool.New)(CCRProductionItem, (self.ui).obj_ProductionItem)
  ;
  ((self.ui).obj_ProductionItem):SetActive(false)
  self.CollectResAction = nil
end

UICommonCollectRes.SetCommonCollectRes = function(self, action)
  -- function num : 0_1
  self.CollectResAction = action
end

UICommonCollectRes.UpdateProduction = function(self, id, resTabSort)
  -- function num : 0_2
  if self.buildProduction ~= nil then
    if (self.buildProduction)[id] == nil then
      self.getNewOne = true
    else
      self.getNewOne = false
    end
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.buildProduction)[id] = resTabSort
  end
  self:__UpdateProductionUI()
end

UICommonCollectRes.__UpdateProductionUI = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.buildProduction == nil then
    return 
  end
  if self.isAllClickAnima then
    return 
  end
  ;
  (self.productionItemPool):HideAll()
  for buildId,buildData in pairs(self.buildProduction) do
    if buildData ~= nil then
      for i = 1, #buildData do
        local Item = (self.productionItemPool):GetOne()
        if self.getNewOne then
          Item:InitProductionItem(buildId, buildData[i])
        else
          Item:UpdateProductionInfo(buildData[i])
        end
      end
    end
  end
end

UICommonCollectRes.__OnCollectAllClick = function(self)
  -- function num : 0_4 , upvalues : cs_DOTween, _ENV
  if self.buildProduction == nil then
    return 
  end
  local sequence = (cs_DOTween.Sequence)()
  self.fristAppend = true
  for index,item in ipairs((self.productionItemPool).listItem) do
    if self.fristAppend then
      sequence:Append((item:GetRingUI()):DOFillAmount(0, (self.ui).ringTime))
    else
      sequence:Join((item:GetRingUI()):DOFillAmount(0, (self.ui).ringTime))
    end
  end
  sequence:AppendCallback(self.__onCollectAllAnimaComplete)
  self.isAllClickAnima = true
  self.CollectAllTween = sequence
end

UICommonCollectRes.__OnCollectAllAnimaComplete = function(self)
  -- function num : 0_5
  self.isAllClickAnima = false
  if self.CollectResAction ~= nil then
    (self.CollectResAction)(self.buildProduction)
  end
end

UICommonCollectRes.__OnShowSyllabusClick = function(self)
  -- function num : 0_6
  if self.isDetailState == false then
    return 
  end
  self.isDetailState = false
  ;
  (((self.ui).tween_side).onRewind):AddListener(self.__onSyllabusComplete)
  ;
  ((self.ui).tween_side):DOPlayBackwards()
end

UICommonCollectRes.__OnSyllabusComplete = function(self)
  -- function num : 0_7
  (((self.ui).tween_side).onRewind):RemoveListener(self.__onSyllabusComplete)
  self:__SetDetailUI(false)
end

UICommonCollectRes.__OnShowDetailClick = function(self)
  -- function num : 0_8
  if self.isDetailState == true then
    return 
  end
  self.isDetailState = true
  ;
  (((self.ui).tween_side).onComplete):AddListener(self.__onDetailComplete)
  ;
  ((self.ui).tween_side):DORestart()
  self:__SetDetailUI(true)
end

UICommonCollectRes.__OnDetailComplete = function(self)
  -- function num : 0_9
  (((self.ui).tween_side).onComplete):RemoveListener(self.__onDetailComplete)
end

UICommonCollectRes.ShowTween = function(self)
  -- function num : 0_10
  ((self.ui).tween_fade):DOPlayBackwards()
end

UICommonCollectRes.HideTween = function(self)
  -- function num : 0_11
  ((self.ui).tween_fade):DORestart()
end

UICommonCollectRes.__SetDetailUI = function(self, isDetail)
  -- function num : 0_12
  (((self.ui).btn_GetAll).gameObject):SetActive(isDetail)
  ;
  (((self.ui).btn_GetAllSmall).gameObject):SetActive(not isDetail)
  ;
  (((self.ui).btn_ShowSyllabus).gameObject):SetActive(isDetail)
  ;
  (((self.ui).btn_ShowDetail).gameObject):SetActive(not isDetail)
  ;
  ((self.ui).obj_Text):SetActive(isDetail)
end

UICommonCollectRes.OnDelete = function(self)
  -- function num : 0_13 , upvalues : _ENV, base
  if not IsNull((self.ui).tween_side) then
    ((self.ui).tween_side):DOKill()
  end
  if self.CollectAllTween ~= nil then
    (self.CollectAllTween):Kill()
    self.CollectAllTween = nil
  end
  ;
  (base.OnDelete)(self)
end

return UICommonCollectRes


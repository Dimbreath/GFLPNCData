local UIAvgNounDes = class("UIAvgNounDes", UIBaseWindow)
local base = UIBaseWindow
local UINAvgNounTypeTog = require("Game.Avg.UI.NounDes.UINAvgNounTypeTog")
local UINAvgNounItem = require("Game.Avg.UI.NounDes.UINAvgNounItem")
local UINAvgNounDetailNode = require("Game.Avg.UI.NounDes.UINAvgNounDetailNode")
local cs_Ease = ((CS.DG).Tweening).Ease
UIAvgNounDes.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINAvgNounTypeTog, UINAvgNounItem, UINAvgNounDetailNode
  self.typePool = (UIItemPool.New)(UINAvgNounTypeTog, (self.ui).obj_tog_NounType)
  ;
  ((self.ui).obj_tog_NounType):SetActive(false)
  self.__selectedTogItem = nil
  self.nounItemPool = (UIItemPool.New)(UINAvgNounItem, (self.ui).obj_nounItem)
  ;
  ((self.ui).obj_nounItem):SetActive(false)
  self.ItemClickDesId = 0
  self.__onClickTypeTog = BindCallback(self, self.OnClickTypeTog)
  self._SetDetailNodeActive = BindCallback(self, self.SetDetailNodeActive)
  self._SetSelect = BindCallback(self, self.SetSelect)
  self.DetailNode = (UINAvgNounDetailNode.New)()
  self.avgwindow = UIManager:GetWindow(UIWindowTypeID.Avg)
  self.DesListMoveAni = (self.ui).Ani_DesList
  self.DetailMoveAni = (self.ui).Ani_Detail
  self.DesListCanvas = (self.ui).Canvas_DesList
  self.DetailCanvas = (self.ui).Canvas_Detail
end

UIAvgNounDes.InitAvgNounDes = function(self, IsOpenOnAvgPerformer, desId, ContinueAutoPlay)
  -- function num : 0_1 , upvalues : _ENV
  if ContinueAutoPlay ~= nil then
    (UIUtil.AddButtonListener)((self.ui).btn_background, self, function()
    -- function num : 0_1_0 , upvalues : ContinueAutoPlay, self
    ContinueAutoPlay()
    self:Delete()
  end
)
  else
    ;
    (UIUtil.AddButtonListener)((self.ui).btn_background, self, self.OnClickClose)
  end
  self.DetailID = desId
  self:SetDetailNodeActive(false)
  ;
  (self.typePool):HideAll()
  local item = (self.typePool):GetOne()
  item:InitAvgNounTypeTog((ConfigData.noun_des_type)[0], self.__onClickTypeTog, 0)
  for typeId,cfg in ipairs(ConfigData.noun_des_type) do
    local item = (self.typePool):GetOne()
    item:InitAvgNounTypeTog(cfg, self.__onClickTypeTog, typeId, desId)
  end
  self:SelectSpecificNounType(0)
  -- DECOMPILER ERROR at PC55: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((item.ui).tog_NounType).isOn = true
  ;
  (self.DesListMoveAni):DOPlay()
  local orginpos = ((self.ui).Rct_Detail).anchoredPosition
  -- DECOMPILER ERROR at PC69: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).Rct_Detail).anchoredPosition = (Vector2.New)(700.7, orginpos.y)
  if IsOpenOnAvgPerformer then
    self.IsDoPlay = true
    ;
    ((self.ui).obj_expand):SetActive(true)
    ;
    ((self.ui).obj_ListNode):SetActive(false)
    local orginpos = ((self.ui).Rct_Detail).anchoredPosition
    -- DECOMPILER ERROR at PC93: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).Rct_Detail).anchoredPosition = (Vector2.New)(73.5, orginpos.y)
    self:SetDetailNodeActive(true)
    ;
    (self.DetailNode):InitInfo((self.ui).obj_nounDetailNode, desId)
  end
end

UIAvgNounDes.SelectSpecificNounType = function(self, typeId)
  -- function num : 0_2 , upvalues : _ENV
  for _,tyoeTogItem in pairs((self.typePool).listItem) do
    if (tyoeTogItem.noun_des_typeCfg).id == typeId then
      tyoeTogItem:OnClickAvgNounTypeTog(true)
    else
      tyoeTogItem:OnClickAvgNounTypeTog(false)
    end
  end
end

UIAvgNounDes.OnClickTypeTog = function(self, tyoeTogItem, bool, typeId, desId)
  -- function num : 0_3 , upvalues : _ENV
  if bool then
    self.__selectedTogItem = tyoeTogItem
    local cor = (Color.New)(1, 1, 1, 1)
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((tyoeTogItem.ui).img_tog).color = cor
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((tyoeTogItem.ui).tex_TypeName).color = Color.black
    self:RefreshNounItemList(typeId, desId)
  else
    do
      ;
      ((self.ui).obj_isSelect):SetActive(false)
      ;
      ((self.ui).obj_IsEmpty):SetActive(false)
      local cor = (Color.New)(1, 1, 1, 0)
      -- DECOMPILER ERROR at PC42: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((tyoeTogItem.ui).img_tog).color = cor
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((tyoeTogItem.ui).tex_TypeName).color = Color.white
    end
  end
end

UIAvgNounDes.RefreshNounItemList = function(self, typeId, desId)
  -- function num : 0_4 , upvalues : _ENV
  (self.nounItemPool):HideAll()
  local newnounlist = {}
  local readnounlist = {}
  if typeId == 0 then
    for key,DesList in pairs((ConfigData.noun_des).typeListDic) do
      for i = 1, #DesList do
        local nounDesCfg = (ConfigData.noun_des)[DesList[i]]
        if nounDesCfg ~= nil then
          local data = {}
          local pre_condition = nounDesCfg.pre_condition
          local pre_para1 = nounDesCfg.pre_para1
          local pre_para2 = nounDesCfg.pre_para2
          if (CheckCondition.CheckLua)(pre_condition, pre_para1, pre_para2) then
            data.DesId = DesList[i]
            data.Sort = nounDesCfg.avg_order
            if self:IsNewNoun(DesList[i]) then
              (table.insert)(newnounlist, data)
            else
              ;
              (table.insert)(readnounlist, data)
            end
          else
            if self:IsReadThisDes(DesList[i]) then
              data.DesId = DesList[i]
              data.Sort = nounDesCfg.avg_order
              if self:IsNewNoun(DesList[i]) then
                (table.insert)(newnounlist, data)
              else
                ;
                (table.insert)(readnounlist, data)
              end
            end
          end
        end
      end
    end
    if #newnounlist == 0 and #readnounlist == 0 then
      ((self.ui).obj_IsEmpty):SetActive(true)
    end
    ;
    (table.sort)(newnounlist, function(a, b)
    -- function num : 0_4_0
    if a.DesId >= b.DesId then
      do return a.Sort ~= b.Sort end
      do return a.Sort < b.Sort end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
)
    ;
    (table.sort)(readnounlist, function(a, b)
    -- function num : 0_4_1
    if a.DesId >= b.DesId then
      do return a.Sort ~= b.Sort end
      do return a.Sort < b.Sort end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
)
    for i = 1, #readnounlist do
      local nounItem = (self.nounItemPool):GetOne()
      nounItem:InitNounItem((readnounlist[i]).DesId, self._SetDetailNodeActive, self._SetSelect)
      if self.DetailID ~= nil and self.DetailID == (readnounlist[i]).DesId then
        self.DesItemIndex = i
      end
    end
    for i = 1, #newnounlist do
      local nounItem = (self.nounItemPool):GetOne()
      nounItem:InitNounItem((newnounlist[i]).DesId, self._SetDetailNodeActive, self._SetSelect)
      if self.DetailID ~= nil and self.DetailID == (newnounlist[i]).DesId then
        self.DesItemIndex = i + #readnounlist
      end
    end
    return 
  end
  local nounTypeList = ((ConfigData.noun_des).typeListDic)[typeId]
  if nounTypeList == nil then
    ((self.ui).obj_IsEmpty):SetActive(true)
    return 
  end
  for i = 1, #nounTypeList do
    local data = {}
    local pre_condition = ((ConfigData.noun_des)[nounTypeList[i]]).pre_condition
    local pre_para1 = ((ConfigData.noun_des)[nounTypeList[i]]).pre_para1
    local pre_para2 = ((ConfigData.noun_des)[nounTypeList[i]]).pre_para2
    if (CheckCondition.CheckLua)(pre_condition, pre_para1, pre_para2) then
      data.DesId = nounTypeList[i]
      data.Sort = ((ConfigData.noun_des)[nounTypeList[i]]).avg_order
      if self:IsNewNoun(nounTypeList[i]) then
        (table.insert)(newnounlist, data)
      else
        ;
        (table.insert)(readnounlist, data)
      end
    else
      if self:IsReadThisDes(nounTypeList[i]) then
        data.DesId = nounTypeList[i]
        data.Sort = ((ConfigData.noun_des)[nounTypeList[i]]).avg_order
        if self:IsNewNoun(nounTypeList[i]) then
          (table.insert)(newnounlist, data)
        else
          ;
          (table.insert)(readnounlist, data)
        end
      end
    end
  end
  if #newnounlist == 0 and #readnounlist == 0 then
    ((self.ui).obj_IsEmpty):SetActive(true)
  end
  ;
  (table.sort)(newnounlist, function(a, b)
    -- function num : 0_4_2
    if a.DesId >= b.DesId then
      do return a.Sort ~= b.Sort end
      do return a.Sort < b.Sort end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
)
  ;
  (table.sort)(readnounlist, function(a, b)
    -- function num : 0_4_3
    if a.DesId >= b.DesId then
      do return a.Sort ~= b.Sort end
      do return a.Sort < b.Sort end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
)
  for i = 1, #readnounlist do
    local nounItem = (self.nounItemPool):GetOne()
    nounItem:InitNounItem((readnounlist[i]).DesId, self._SetDetailNodeActive, self._SetSelect)
  end
  for i = 1, #newnounlist do
    local nounItem = (self.nounItemPool):GetOne()
    nounItem:InitNounItem((newnounlist[i]).DesId, self._SetDetailNodeActive, self._SetSelect)
  end
end

UIAvgNounDes.SetDetailNodeActive = function(self, active)
  -- function num : 0_5
  if active ~= nil then
    ((self.ui).obj_nounDetailNode):SetActive(active)
  end
end

UIAvgNounDes.SetSelect = function(self, parent)
  -- function num : 0_6 , upvalues : _ENV
  ((self.ui).obj_isSelect):SetActive(true)
  ;
  (((self.ui).obj_isSelect).transform):SetParent(parent)
  local temppos = (Vector3.New)(206.5, -37.5, 0)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).obj_isSelect).transform).localPosition = temppos
end

UIAvgNounDes.InitDetatilNode = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local avgnounwindow = UIManager:GetWindow(UIWindowTypeID.AvgNounDes)
  ;
  (avgnounwindow.DetailNode):InitInfo((avgnounwindow.ui).obj_nounDetailNode, avgnounwindow.ItemClickDesId)
end

UIAvgNounDes.IsReadThisDes = function(self, DesID)
  -- function num : 0_8 , upvalues : _ENV
  if self.avgwindow == nil then
    return false
  end
  local DesIdDic = ((((self.avgwindow).dialogNode).ui).text_Dialog).GetInfoDic
  if IsNull(DesIdDic) == false and DesIdDic:ContainsKey(DesID) then
    return true
  end
  return false
end

UIAvgNounDes.OnClickExpand = function(self)
  -- function num : 0_9 , upvalues : cs_Ease, _ENV
  ((self.ui).obj_ListNode):SetActive(true)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.DesListCanvas).alpha = 0
  ;
  ((self.DesListCanvas):DOFade(1, 0.25)):SetEase(cs_Ease.OutQuad)
  ;
  (self.DetailMoveAni):DOPlay()
  if self.DesItemIndex ~= nil then
    ((self.ui).obj_isSelect):SetActive(true)
    local itemparent = ((self.ui).rct_Scroll):GetChild(self.DesItemIndex)
    ;
    (((self.ui).obj_isSelect).transform):SetParent(itemparent)
    local temppos = (Vector3.New)(206.5, -37.5, 0)
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((self.ui).obj_isSelect).transform).localPosition = temppos
    local orginanpos = ((self.ui).rct_Scroll).anchoredPosition
    local anchorposy = (self.DesItemIndex - 1) * 96 > 983 and (self.DesItemIndex - 1) * 96 or 0
    -- DECOMPILER ERROR at PC69: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).rct_Scroll).anchoredPosition = (Vector3.New)(orginanpos.x, anchorposy, 0)
  end
end

UIAvgNounDes.IsNewNoun = function(self, nounID)
  -- function num : 0_10 , upvalues : _ENV
  return (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):GetAvgNounIsRead(nounID)
end

UIAvgNounDes.OnClickClose = function(self)
  -- function num : 0_11
  self:Delete()
end

UIAvgNounDes.OnDelete = function(self)
  -- function num : 0_12 , upvalues : base
  (base.OnDelete)(self)
end

return UIAvgNounDes


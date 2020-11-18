-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthSortList = class("UINAthSortList", UIBaseNode)
local base = UIBaseNode
local UINAthSortListAll = require("Game.Arithmetic.AthSortList.UINAthSortListAll")
local UINAthMatUpgrade = require("Game.Arithmetic.AthSortList.UINAthMatUpgrade")
local UINAthSortCondition = require("Game.Arithmetic.AthSortList.SortCondition.UINAthSortCondition")
local AthFilterEnum = require("Game.Arithmetic.AthSortList.AthFilterEnum")
local CS_DoTween = ((CS.DG).Tweening).DOTween
local CS_ResLoader = CS.ResLoader
local spaceIdDic = {[1] = 1, [2] = 2, [4] = 3, [8] = 4}
UINAthSortList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, CS_ResLoader, UINAthMatUpgrade, UINAthSortListAll
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Filter, self, self.OnBtnFilterClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Sort, self, self.OnClickSort)
  self.resLoader = (CS_ResLoader.Create)()
  self.__OnClickAthItem = BindCallback(self, self.OnClickAthItem)
  self.athMatUpNode = (UINAthMatUpgrade.New)()
  ;
  (self.athMatUpNode):Init((self.ui).athUpgradeItemList)
  self.athListAll = (UINAthSortListAll.New)()
  ;
  (self.athListAll):Init((self.ui).scrollListAll)
  self.__onAthDataUpdate = BindCallback(self, self.OnAthDataUpdate)
  self._sortInvert = false
  self:InitAthListSort()
  self:__RefreshSortBtn()
end

UINAthSortList.InitAthSortListNode = function(self, heroData, withMat, clickItemFunc, areaId)
  -- function num : 0_1
  self.heroData = heroData
  self.clickItemFunc = clickItemFunc
  self.areaId = areaId
  self.withMat = withMat
  if withMat then
    (self.athMatUpNode):Show()
  end
  ;
  (self.athListAll):SetNewAthItemFunc(self._newItemFunc)
  ;
  (self.athListAll):InitAthSortListAll(areaId, self.__OnClickAthItem, self.resLoader, withMat)
  self:RefillCurAthSortList()
end

UINAthSortList.SetAthListNewItemFunc = function(self, newItemFunc)
  -- function num : 0_2
  self._newItemFunc = newItemFunc
end

UINAthSortList.OnAthDataUpdate = function(self)
  -- function num : 0_3
  (self.athListAll):RefreshAthSortListData()
  self:RefillCurAthSortList()
end

UINAthSortList.__RefreshAthCount = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((self.ui).tex_AthCount):SetIndex(0, tostring(#(PlayerDataCenter.allAthData):GetAllAthList()), (ConfigData.game_config).athMaxNum)
end

UINAthSortList.RefillCurAthSortList = function(self)
  -- function num : 0_5 , upvalues : _ENV
  self._curSuitDic = (PlayerDataCenter.allAthData):GetHeroAthSuitIdDic((self.heroData).dataId, self.areaId)
  ;
  (self.athListAll):RefillAthSortListAll(self.__SiftFunction, self._sortFunc, self._curSuitDic)
  self:__RefreshAthCount()
end

UINAthSortList.GetAthMatUpNode = function(self)
  -- function num : 0_6
  return self.athMatUpNode
end

UINAthSortList.OnClickAthItem = function(self, athItem)
  -- function num : 0_7
  if self.clickItemFunc ~= nil then
    (self.clickItemFunc)(athItem)
  end
end

UINAthSortList.SetAthListMultSeletedUidDic = function(self, dic)
  -- function num : 0_8
  self.athMultSeletedUidDic = dic
  ;
  (self.athListAll):SetAthListMultSeletedUidDic(dic)
end

UINAthSortList.GetAthItemGo = function(self, space)
  -- function num : 0_9 , upvalues : spaceIdDic, _ENV
  local index = spaceIdDic[space]
  if index == nil then
    error("Can\'t get athItemGo, space = " .. tostring(space))
    return 
  end
  return (((self.athListAll).ui).athSpaceItemList)[index]
end

UINAthSortList.OnClickSort = function(self)
  -- function num : 0_10
  self._sortInvert = not self._sortInvert
  self:__RefreshSortBtn()
  self:RefillCurAthSortList()
end

UINAthSortList.__RefreshSortBtn = function(self)
  -- function num : 0_11 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  if not self._sortInvert or not Color.white then
    ((self.ui).img_up).color = Color.gray
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

    if not self._sortInvert or not Color.gray then
      ((self.ui).img_Down).color = Color.white
    end
  end
end

UINAthSortList.InitAthListSort = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if self.withMat then
    self._sortFunc = function(a, b)
    -- function num : 0_12_0 , upvalues : _ENV, self
    local aBind = a.bindInfo ~= nil
    local bBind = b.bindInfo ~= nil
    local containIdA = (PlayerDataCenter.allAthData):HeroContainAthById((self.heroData).dataId, self.areaId, a.id)
    local containIdB = (PlayerDataCenter.allAthData):HeroContainAthById((self.heroData).dataId, self.areaId, b.id)
    local qualityA = a:GetAthQuality()
    local qualityB = b:GetAthQuality()
    local sizeA = a:GetAthSize()
    local sizeB = b:GetAthSize()
    local hasSuitA = (self._curSuitDic)[a:GetAthSuit()] ~= nil
    local hasSuitB = (self._curSuitDic)[b:GetAthSuit()] ~= nil
    if qualityA == qualityB then
      if aBind == bBind then
        if containIdA == containIdB then
          if hasSuitA == hasSuitB then
            if a.id >= b.id then
              do return sizeA ~= sizeB end
              do return hasSuitA end
              do return containIdB end
              do return bBind end
              do return qualityB < qualityA end
              if sizeA >= sizeB then
                do return not self._sortInvert end
                do return sizeB < sizeA end
                -- DECOMPILER ERROR: 15 unprocessed JMP targets
              end
            end
          end
        end
      end
    end
  end

  else
    self._sortFunc = function(a, b)
    -- function num : 0_12_1 , upvalues : self
    local sizeA = a:GetAthSize()
    local sizeB = b:GetAthSize()
    local qualityA = a:GetAthQuality()
    local qualityB = b:GetAthQuality()
    local aBind = a.bindInfo ~= nil
    local bBind = b.bindInfo ~= nil
    if qualityA == qualityB then
      if aBind == bBind then
        if a.id >= b.id then
          do return sizeA ~= sizeB end
          do return bBind end
          do return qualityA < qualityB end
          if sizeA >= sizeB then
            do return not self._sortInvert end
            do return sizeB < sizeA end
            -- DECOMPILER ERROR: 11 unprocessed JMP targets
          end
        end
      end
    end
  end

  end
end

UINAthSortList.OnBtnFilterClick = function(self)
  -- function num : 0_13 , upvalues : UINAthSortCondition, AthFilterEnum, _ENV
  do
    if self.siftCondition == nil then
      local SiftConditionPage = (UINAthSortCondition.New)()
      SiftConditionPage:Init((self.ui).sortConditionNode)
      SiftConditionPage:InitAthSortCondition(AthFilterEnum.eKindType, AthFilterEnum.eKindMaxCount, BindCallback(self, self.OnFilterConfirmAction))
      self.siftCondition = SiftConditionPage
    end
    ;
    (self.siftCondition):Show()
  end
end

UINAthSortList.OnFilterConfirmAction = function(self, sortKindData)
  -- function num : 0_14 , upvalues : _ENV
  self.sortKindData = sortKindData
  if self.__SiftFunction == nil then
    self.__SiftFunction = BindCallback(self, self.SiftFunction)
  end
  self:RefillCurAthSortList()
end

UINAthSortList.SiftFunction = function(self, athData)
  -- function num : 0_15 , upvalues : AthFilterEnum, _ENV
  local index = 0
  local athQualityId = athData:GetAthQuality()
  local qualityConfig = (self.sortKindData)[(AthFilterEnum.eKindType).Quality]
  if not qualityConfig.nocondition then
    local qualityOk = (qualityConfig.selectIndexs)[(AthFilterEnum.GetQualityIndex)(athQualityId)]
  end
  local attrIdx = nil
  local attrId = athData:GetAthMainAttrId()
  for k,id in ipairs(AthFilterEnum.eAttribute) do
    if attrId == id then
      attrIdx = k
    end
  end
  local attrConfig = (self.sortKindData)[(AthFilterEnum.eKindType).Attribute]
  if not attrConfig.nocondition then
    local attrOk = (attrConfig.selectIndexs)[attrIdx]
  end
  if qualityOk and attrOk then
    return true
  else
    return false
  end
end

UINAthSortList.DragInAthSortList = function(self, worldPos)
  -- function num : 0_16 , upvalues : _ENV
  local anchordPos = UIManager:World2UIPosition(worldPos, self.transform, nil, UIManager.UICamera)
  if anchordPos.x <= ((self.transform).rect).xMax then
    return true
  end
  return false
end

UINAthSortList.OnShow = function(self)
  -- function num : 0_17 , upvalues : _ENV
  self:SetAthSortListTween()
  MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
end

UINAthSortList.OnHide = function(self)
  -- function num : 0_18 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
end

UINAthSortList.SetAthSortListTween = function(self)
  -- function num : 0_19 , upvalues : _ENV, CS_DoTween
  local moveX = 100
  local pageLocalPos = (self.transform).localPosition
  pageLocalPos = (Vector3.New)(pageLocalPos.x - moveX, pageLocalPos.y, pageLocalPos.z)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).localPosition = pageLocalPos
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).fade).alpha = 0.4
  if self.sequence == nil then
    local sequence = (CS_DoTween.Sequence)()
    sequence:Append(((self.transform):DOLocalMoveX(moveX, 0.3)):SetRelative(true))
    sequence:Join(((self.ui).fade):DOFade(1, 0.3))
    sequence:SetAutoKill(false)
    self.sequence = sequence
  else
    do
      ;
      (self.sequence):Restart()
    end
  end
end

UINAthSortList.OnDelete = function(self)
  -- function num : 0_20 , upvalues : base
  (self.athMatUpNode):Delete()
  ;
  (self.athListAll):Delete()
  if self.siftCondition ~= nil then
    (self.siftCondition):Delete()
  end
  if self.sequence ~= nil then
    (self.sequence):Kill()
    self.sequence = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINAthSortList


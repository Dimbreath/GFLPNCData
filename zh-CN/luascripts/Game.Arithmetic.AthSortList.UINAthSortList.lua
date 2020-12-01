-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthSortList = class("UINAthSortList", UIBaseNode)
local base = UIBaseNode
local UINAthSortListAll = require("Game.Arithmetic.AthSortList.UINAthSortListAll")
local UINAthSortCondition = require("Game.Arithmetic.AthSortList.SortCondition.UINAthSortCondition")
local AthFilterEnum = require("Game.Arithmetic.AthSortList.AthFilterEnum")
local CS_DoTween = ((CS.DG).Tweening).DOTween
local CS_ResLoader = CS.ResLoader
local spaceIdDic = {[1] = 1, [2] = 2, [4] = 3, [8] = 4}
UINAthSortList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, CS_ResLoader, UINAthSortListAll
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Filter, self, self.OnBtnFilterClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Sort, self, self.OnClickSort)
  self.resLoader = (CS_ResLoader.Create)()
  self.__OnClickAthItem = BindCallback(self, self.OnClickAthItem)
  self.athListAll = (UINAthSortListAll.New)()
  ;
  (self.athListAll):Init((self.ui).scrollListAll)
  self.__onAthDataUpdate = BindCallback(self, self.OnAthDataUpdate)
  self.__SiftFunction = BindCallback(self, self.SiftFunction)
  self._sortInvert = false
  self:__RefreshSortBtn()
end

UINAthSortList.InitAthSortListNode = function(self, heroData, withMat, clickItemFunc, areaId, quality)
  -- function num : 0_1
  self.heroData = heroData
  self.clickItemFunc = clickItemFunc
  self.areaId = areaId
  self.withMat = withMat
  ;
  (self.athListAll):SetNewAthItemFunc(self._newItemFunc)
  ;
  (self.athListAll):InitAthSortListAll(areaId, quality, self.__OnClickAthItem, self.__itemStartDragFunc, self.resLoader, withMat)
  self:RefillCurAthSortList()
end

UINAthSortList.SetAthItemStartDragFunc = function(self, itemStartDragFunc)
  -- function num : 0_2
  self.__itemStartDragFunc = itemStartDragFunc
end

UINAthSortList.OnAthDataUpdate = function(self)
  -- function num : 0_3
  (self.athListAll):RefreshAthSortListData()
  self:RefillCurAthSortList(true)
end

UINAthSortList.__RefreshAthCount = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((self.ui).tex_AthCount):SetIndex(0, tostring(#(PlayerDataCenter.allAthData):GetAllAthList()), (ConfigData.game_config).athMaxNum)
end

UINAthSortList.RefillCurAthSortList = function(self, useLastPos)
  -- function num : 0_5 , upvalues : _ENV
  self._curSuitDic = {}
  if self.heroData ~= nil then
    self._curSuitDic = (PlayerDataCenter.allAthData):GetHeroAthSuitIdDic((self.heroData).dataId, self.areaId)
  end
  if self.areaId == nil then
    self._curFreeSpace = nil
  else
    local ok, space = (PlayerDataCenter.allAthData):GetHeroAthFreeSpace(self.heroData, self.areaId)
    self._curFreeSpace = space
  end
  do
    ;
    (self.athListAll):RefillAthSortListAll(self.__SiftFunction, self._sortFunc, self._curSuitDic, useLastPos, self._curFreeSpace)
    self:__RefreshAthCount()
  end
end

UINAthSortList.GetAthMatUpNode = function(self)
  -- function num : 0_6
  return (self.athListAll):GetSortListAthMatUpNode()
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

UINAthSortList.SetAthListInstallSortFuncSet = function(self)
  -- function num : 0_12 , upvalues : _ENV
  self._sortFunc = function(a, b)
    -- function num : 0_12_0 , upvalues : _ENV, self
    local unbindA = a.bindInfo == nil
    local unbindB = b.bindInfo == nil
    local containIdA = (PlayerDataCenter.allAthData):HeroContainAthById((self.heroData).dataId, self.areaId, a.id)
    local containIdB = (PlayerDataCenter.allAthData):HeroContainAthById((self.heroData).dataId, self.areaId, b.id)
    local sizeOkA = a:GetAthSize() <= self._curFreeSpace
    local sizeOkB = b:GetAthSize() <= self._curFreeSpace
    local hasSuitA = (self._curSuitDic)[a:GetAthSuit()] ~= nil
    local hasSuitB = (self._curSuitDic)[b:GetAthSuit()] ~= nil
    local fightPA = a:GetAthFightPower()
    local fightPB = b:GetAthFightPower()
    if unbindA == unbindB then
      if containIdA == containIdB then
        if hasSuitA == hasSuitB then
          if fightPA == fightPB then
            if a.uid >= b.uid then
              do return sizeOkA ~= sizeOkB end
              if fightPA >= fightPB then
                do return not self._sortInvert end
                do return fightPB < fightPA end
                do return hasSuitA end
                do return containIdB end
                do return unbindA end
                do return sizeOkA end
                -- DECOMPILER ERROR: 16 unprocessed JMP targets
              end
            end
          end
        end
      end
    end
  end

end

UINAthSortList.SetAthListEfccSortFunc = function(self)
  -- function num : 0_13
  self._sortFunc = function(a, b)
    -- function num : 0_13_0 , upvalues : self
    local lockA = a.lockUnlock
    local lockB = b.lockUnlock
    local unbindA = a.bindInfo == nil
    local unbindB = b.bindInfo == nil
    local fightPA = a:GetAthFightPower()
    local fightPB = b:GetAthFightPower()
    if unbindA == unbindB then
      if fightPA == fightPB then
        if a.uid >= b.uid then
          do return lockA ~= lockB end
          if fightPB >= fightPA then
            do return not self._sortInvert end
            do return fightPA < fightPB end
            do return unbindA end
            do return lockB end
            -- DECOMPILER ERROR: 10 unprocessed JMP targets
          end
        end
      end
    end
  end

end

UINAthSortList.SetAthListOptSortFunc = function(self)
  -- function num : 0_14
  self._sortFunc = function(a, b)
    -- function num : 0_14_0 , upvalues : self
    local aBind = a.bindInfo ~= nil
    local bBind = b.bindInfo ~= nil
    local fightPA = a:GetAthFightPower()
    local fightPB = b:GetAthFightPower()
    local canOptA = a:CanAthOptimize()
    local canOptB = b:CanAthOptimize()
    if canOptA == canOptB then
      if aBind == bBind then
        if a.id == b.id then
          if a.uid >= b.uid then
            do return fightPA ~= fightPB end
            do return a.id < b.id end
            do return aBind end
            do return canOptA end
            if fightPA >= fightPB then
              do return not self._sortInvert end
              do return fightPB < fightPA end
              -- DECOMPILER ERROR: 12 unprocessed JMP targets
            end
          end
        end
      end
    end
  end

end

UINAthSortList.SetAthListRefactorSortFunc = function(self)
  -- function num : 0_15
  self._sortFunc = function(a, b)
    -- function num : 0_15_0 , upvalues : self
    local aBind = a.bindInfo ~= nil
    local bBind = b.bindInfo ~= nil
    local sizeA = a:GetAthSize()
    local sizeB = b:GetAthSize()
    local lockA = a.lockUnlock
    local lockB = b.lockUnlock
    if aBind == bBind then
      if lockA == lockB then
        if a.id == b.id then
          if a.uid >= b.uid then
            do return sizeA ~= sizeB end
            do return a.id < b.id end
            do return lockB end
            do return bBind end
            if sizeA >= sizeB then
              do return not self._sortInvert end
              do return sizeB < sizeA end
              -- DECOMPILER ERROR: 12 unprocessed JMP targets
            end
          end
        end
      end
    end
  end

end

UINAthSortList.OnBtnFilterClick = function(self)
  -- function num : 0_16 , upvalues : UINAthSortCondition, AthFilterEnum, _ENV
  if self.siftCondition == nil then
    local SiftConditionPage = (UINAthSortCondition.New)()
    SiftConditionPage:Init((self.ui).sortConditionNode)
    local ignoreDic = nil
    if self.areaId == nil then
      ignoreDic = {}
    else
      ignoreDic = {[(AthFilterEnum.eKindType).Area] = true}
    end
    SiftConditionPage:InitAthSortCondition(AthFilterEnum.eKindType, AthFilterEnum.eKindMaxCount, BindCallback(self, self.OnFilterConfirmAction), ignoreDic)
    self.siftCondition = SiftConditionPage
  end
  do
    ;
    (self.siftCondition):Show()
  end
end

UINAthSortList.OnFilterConfirmAction = function(self, sortKindData)
  -- function num : 0_17
  self.sortKindData = sortKindData
  self:RefillCurAthSortList()
end

UINAthSortList.SetCustomSiftFunc = function(self, customSiftFunc)
  -- function num : 0_18
  self.customSiftFunc = customSiftFunc
end

UINAthSortList.SiftFunction = function(self, athData)
  -- function num : 0_19 , upvalues : AthFilterEnum, _ENV
  local index = 0
  local customSiftOk = true
  if self.customSiftFunc ~= nil then
    customSiftOk = (self.customSiftFunc)(athData)
  end
  local areaOk = true
  local qualityOk = true
  local attrOk = true
  local subAttrOk = true
  if self.sortKindData ~= nil then
    local athArea = athData:GetAthAreaType()
    local qualityConfig = (self.sortKindData)[(AthFilterEnum.eKindType).Area]
    if not qualityConfig.nocondition then
      areaOk = (qualityConfig.selectIndexs)[athArea]
    end
    local athQualityId = athData:GetAthQuality()
    local qualityConfig = (self.sortKindData)[(AthFilterEnum.eKindType).Quality]
    if not qualityConfig.nocondition then
      qualityOk = (qualityConfig.selectIndexs)[(AthFilterEnum.GetQualityIndex)(athQualityId)]
    end
    local attrId = athData:GetAthMainAttrId()
    local attrIdx = (AthFilterEnum.GetAttrIndex)(attrId)
    local attrConfig = (self.sortKindData)[(AthFilterEnum.eKindType).Attribute]
    if not attrConfig.nocondition then
      attrOk = (attrConfig.selectIndexs)[attrIdx]
    end
    local subAttrConfig = (self.sortKindData)[(AthFilterEnum.eKindType).SubAttribute]
    subAttrOk = subAttrConfig.nocondition
    if not subAttrOk then
      local subAttrList = athData:GetAthSubAttrIdList()
      for k,subAttrId in ipairs(subAttrList) do
        local subAttrIdx = (AthFilterEnum.GetAttrIndex)(subAttrId)
        subAttrOk = (subAttrConfig.selectIndexs)[subAttrIdx]
      end
    end
  end
  do
    if (subAttrOk or qualityOk) and attrOk and customSiftOk and areaOk and subAttrOk then
      return true
    else
      return false
    end
  end
end

UINAthSortList.DragInAthSortList = function(self, worldPos)
  -- function num : 0_20 , upvalues : _ENV
  local anchordPos = UIManager:World2UIPosition(worldPos, self.transform, nil, UIManager.UICamera)
  if anchordPos.x <= ((self.transform).rect).xMax then
    return true
  end
  return false
end

UINAthSortList.OnShow = function(self)
  -- function num : 0_21 , upvalues : _ENV
  self:SetAthSortListTween()
  MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
end

UINAthSortList.OnHide = function(self)
  -- function num : 0_22 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
end

UINAthSortList.SetAthSortListTween = function(self)
  -- function num : 0_23 , upvalues : _ENV, CS_DoTween
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

UINAthSortList.GetAthItemFromList = function(self, uid)
  -- function num : 0_24
  return (self.athListAll):GetAthItemFromListAll(uid)
end

UINAthSortList.OnDelete = function(self)
  -- function num : 0_25 , upvalues : base
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

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthSortList = class("UINAthSortList", UIBaseNode)
local base = UIBaseNode
local UINAthSortListAll = require(
                              "Game.Arithmetic.AthSortList.UINAthSortListAll")
local UINAthSortCondition = require(
                                "Game.Arithmetic.AthSortList.SortCondition.UINAthSortCondition")
local AthFilterEnum = require("Game.Arithmetic.AthSortList.AthFilterEnum")
local CS_DoTween = ((CS.DG).Tweening).DOTween
local CS_ResLoader = CS.ResLoader
local spaceIdDic = {[1] = 1, [2] = 2, [4] = 3, [8] = 4}
UINAthSortList.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, CS_ResLoader, UINAthSortListAll
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_Filter, self, self.OnBtnFilterClick);
    (UIUtil.AddButtonListener)((self.ui).btn_Sort, self, self.OnClickSort)
    self.resLoader = (CS_ResLoader.Create)()
    self.__OnClickAthItem = BindCallback(self, self.OnClickAthItem)
    self.athListAll = (UINAthSortListAll.New)();
    (self.athListAll):Init((self.ui).scrollListAll)
    self.__onAthDataUpdate = BindCallback(self, self.OnAthDataUpdate)
    self.__SiftFunction = BindCallback(self, self.SiftFunction)
    self._sortInvert = false
    self:__RefreshSortBtn()
end

UINAthSortList.InitAthSortListNode = function(self, heroData, withMat,
                                              clickItemFunc, areaId, quality)
    -- function num : 0_1
    self.heroData = heroData
    self.clickItemFunc = clickItemFunc
    self.areaId = areaId
    self.withMat = withMat;
    (self.athListAll):SetNewAthItemFunc(self._newItemFunc);
    (self.athListAll):InitAthSortListAll(areaId, quality, self.__OnClickAthItem,
                                         self.__itemStartDragFunc,
                                         self.resLoader, withMat)
    self:RefillCurAthSortList()
end

UINAthSortList.SetAthItemStartDragFunc =
    function(self, itemStartDragFunc)
        -- function num : 0_2
        self.__itemStartDragFunc = itemStartDragFunc
    end

UINAthSortList.OnAthDataUpdate = function(self)
    -- function num : 0_3
    (self.athListAll):RefreshAthSortListData()
    self:RefillCurAthSortList(true)
end

UINAthSortList.__RefreshAthCount = function(self)
    -- function num : 0_4 , upvalues : _ENV
    ((self.ui).tex_AthCount):SetIndex(0, tostring(
                                          #(PlayerDataCenter.allAthData):GetAllAthList()),
                                      (ConfigData.game_config).athMaxNum)
end

UINAthSortList.RefillCurAthSortList = function(self, useLastPos)
    -- function num : 0_5 , upvalues : _ENV
    self._curSuitDic = {}
    if self.heroData ~= nil then
        self._curSuitDic = (PlayerDataCenter.allAthData):GetHeroAthSuitIdDic(
                               (self.heroData).dataId, self.areaId)
    end
    if self.areaId == nil then
        self._curFreeSpace = nil
    else
        local ok, space = (PlayerDataCenter.allAthData):GetHeroAthFreeSpace(
                              self.heroData, self.areaId)
        self._curFreeSpace = space
    end
    do

        (self.athListAll):RefillAthSortListAll(self.__SiftFunction,
                                               self._sortFunc, self._curSuitDic,
                                               useLastPos, self._curFreeSpace)
        self:__RefreshAthCount()
    end
end

UINAthSortList.GetAthMatUpNode = function(self)
    -- function num : 0_6
    return (self.athListAll):GetSortListAthMatUpNode()
end

UINAthSortList.OnClickAthItem = function(self, athItem)
    -- function num : 0_7
    if self.clickItemFunc ~= nil then (self.clickItemFunc)(athItem) end
end

UINAthSortList.SetAthListMultSeletedUidDic =
    function(self, dic)
        -- function num : 0_8
        self.athMultSeletedUidDic = dic;
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

UINAthSortList.SetAthListInstallSortFuncSet =
    function(self)
        -- function num : 0_12 , upvalues : _ENV
        self._sortFunc = function(a, b)
            -- function num : 0_12_0 , upvalues : _ENV, self
            local unbindA = a.bindInfo == nil
            local unbindB = b.bindInfo == nil
            local containIdA = (PlayerDataCenter.allAthData):HeroContainAthById(
                                   (self.heroData).dataId, self.areaId, a.id)
            local containIdB = (PlayerDataCenter.allAthData):HeroContainAthById(
                                   (self.heroData).dataId, self.areaId, b.id)
            local sizeOkA = a:GetAthSize() <= self._curFreeSpace
            local sizeOkB = b:GetAthSize() <= self._curFreeSpace
            local hasSuitA = (self._curSuitDic)[a:GetAthSuit()] ~= nil
            local hasSuitB = (self._curSuitDic)[b:GetAthSuit()] ~= nil
            local fightPA = a:GetAthFightPower()
            local fightPB = b:GetAthFightPower()
            if unbindA == unbindB then
                if containIdA == containIdB then
                    if hasSuitA == hasSuitB then
                        if fightPA == fightPB then
                            if a.uid >= b.uid then
                                do
                                    return sizeOkA ~= sizeOkB
                                end
                                if fightPA >= fightPB then
                                    do
                                        return not self._sortInvert
                                    end
                                    do
                                        return fightPB < fightPA
                                    end
                                    do
                                        return hasSuitA
                                    end
                                    do
                                        return containIdB
                                    end
                                    do
                                        return unbindA
                                    end
                                    do
                                        return sizeOkA
                                    end
                                    -- DECOMPILER ERROR: 16 unprocessed JMP targets
                                end
                            end
                        end
                    end
                end
            end
        end

    end

UINAthSortList.SetAthListEfccSortFunc = function(self)
    -- function num : 0_13
    self._sortFunc = function(a, b)
        -- function num : 0_13_0 , upvalues : self
        local lockA = a.lockUnlock
        local lockB = b.lockUnlock
        local unbindA = a.bindInfo == nil
        local unbindB = b.bindInfo == nil
        local fightPA = a:GetAthFightPower()
        local fightPB = b:GetAthFightPower()
        if unbindA == unbindB then
            if fightPA == fightPB then
                if a.uid >= b.uid then
                    do return lockA ~= lockB end
                    if fightPB >= fightPA then
                        do return not self._sortInvert end
                        do return fightPA < fightPB end
                        do return unbindA end
                        do return lockB end
                        -- DECOMPILER ERROR: 10 unprocessed JMP targets
                    end
                end
            end
        end
    end

end

UINAthSortList.SetAthListOptSortFunc = function(self)
    -- function num : 0_14
    self._sortFunc = function(a, b)
        -- function num : 0_14_0 , upvalues : self
        local aBind = a.bindInfo ~= nil
        local bBind = b.bindInfo ~= nil
        local fightPA = a:GetAthFightPower()
        local fightPB = b:GetAthFightPower()
        local canOptA = a:CanAthOptimize()
        local canOptB = b:CanAthOptimize()
        if canOptA == canOptB then
            if aBind == bBind then
                if a.id == b.id then
                    if a.uid >= b.uid then
                        do return fightPA ~= fightPB end
                        do return a.id < b.id end
                        do return aBind end
                        do return canOptA end
                        if fightPA >= fightPB then
                            do
                                return not self._sortInvert
                            end
                            do
                                return fightPB < fightPA
                            end
                            -- DECOMPILER ERROR: 12 unprocessed JMP targets
                        end
                    end
                end
            end
        end
    end

end

UINAthSortList.SetAthListRefactorSortFunc =
    function(self)
        -- function num : 0_15
        self._sortFunc = function(a, b)
            -- function num : 0_15_0 , upvalues : self
            local aBind = a.bindInfo ~= nil
            local bBind = b.bindInfo ~= nil
            local sizeA = a:GetAthSize()
            local sizeB = b:GetAthSize()
            local lockA = a.lockUnlock
            local lockB = b.lockUnlock
            if aBind == bBind then
                if lockA == lockB then
                    if a.id == b.id then
                        if a.uid >= b.uid then
                            do return sizeA ~= sizeB end
                            do return a.id < b.id end
                            do return lockB end
                            do return bBind end
                            if sizeA >= sizeB then
                                do
                                    return not self._sortInvert
                                end
                                do
                                    return sizeB < sizeA
                                end
                                -- DECOMPILER ERROR: 12 unprocessed JMP targets
                            end
                        end
                    end
                end
            end
        end

    end

UINAthSortList.OnBtnFilterClick = function(self)
    -- function num : 0_16 , upvalues : UINAthSortCondition, AthFilterEnum, _ENV
    if self.siftCondition == nil then
        local SiftConditionPage = (UINAthSortCondition.New)()
        SiftConditionPage:Init((self.ui).sortConditionNode)
        local ignoreDic = nil
        if self.areaId == nil then
            ignoreDic = {}
        else
            ignoreDic = {[(AthFilterEnum.eKindType).Area] = true}
        end
        SiftConditionPage:InitAthSortCondition(AthFilterEnum.eKindType,
                                               AthFilterEnum.eKindMaxCount,
                                               BindCallback(self,
                                                            self.OnFilterConfirmAction),
                                               ignoreDic)
        self.siftCondition = SiftConditionPage
    end
    do

        (self.siftCondition):Show()
    end
end

UINAthSortList.OnFilterConfirmAction = function(self, sortKindData)
    -- function num : 0_17
    self.sortKindData = sortKindData
    self:RefillCurAthSortList()
end

UINAthSortList.SetCustomSiftFunc = function(self, customSiftFunc)
    -- function num : 0_18
    self.customSiftFunc = customSiftFunc
end

UINAthSortList.SiftFunction = function(self, athData)
    -- function num : 0_19 , upvalues : AthFilterEnum, _ENV
    local index = 0
    local customSiftOk = true
    if self.customSiftFunc ~= nil then
        customSiftOk = (self.customSiftFunc)(athData)
    end
    local areaOk = true
    local qualityOk = true
    local attrOk = true
    local subAttrOk = true
    if self.sortKindData ~= nil then
        local athArea = athData:GetAthAreaType()
        local qualityConfig =
            (self.sortKindData)[(AthFilterEnum.eKindType).Area]
        if not qualityConfig.nocondition then
            areaOk = (qualityConfig.selectIndexs)[athArea]
        end
        local athQualityId = athData:GetAthQuality()
        local qualityConfig =
            (self.sortKindData)[(AthFilterEnum.eKindType).Quality]
        if not qualityConfig.nocondition then
            qualityOk =
                (qualityConfig.selectIndexs)[(AthFilterEnum.GetQualityIndex)(
                    athQualityId)]
        end
        local attrId = athData:GetAthMainAttrId()
        local attrIdx = (AthFilterEnum.GetAttrIndex)(attrId)
        local attrConfig =
            (self.sortKindData)[(AthFilterEnum.eKindType).Attribute]
        if not attrConfig.nocondition then
            attrOk = (attrConfig.selectIndexs)[attrIdx]
        end
        local subAttrConfig =
            (self.sortKindData)[(AthFilterEnum.eKindType).SubAttribute]
        subAttrOk = subAttrConfig.nocondition
        if not subAttrOk then
            local subAttrList = athData:GetAthSubAttrIdList()
            for k, subAttrId in ipairs(subAttrList) do
                local subAttrIdx = (AthFilterEnum.GetAttrIndex)(subAttrId)
                subAttrOk = (subAttrConfig.selectIndexs)[subAttrIdx]
            end
        end
    end
    do
        if (subAttrOk or qualityOk) and attrOk and customSiftOk and areaOk and
            subAttrOk then
            return true
        else
            return false
        end
    end
end

UINAthSortList.DragInAthSortList = function(self, worldPos)
    -- function num : 0_20 , upvalues : _ENV
    local anchordPos = UIManager:World2UIPosition(worldPos, self.transform, nil,
                                                  UIManager.UICamera)
    if anchordPos.x <= ((self.transform).rect).xMax then return true end
    return false
end

UINAthSortList.OnShow = function(self)
    -- function num : 0_21 , upvalues : _ENV
    self:SetAthSortListTween()
    MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
end

UINAthSortList.OnHide = function(self)
    -- function num : 0_22 , upvalues : _ENV
    MsgCenter:RemoveListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
end

UINAthSortList.SetAthSortListTween = function(self)
    -- function num : 0_23 , upvalues : _ENV, CS_DoTween
    local moveX = 100
    local pageLocalPos = (self.transform).localPosition
    pageLocalPos = (Vector3.New)(pageLocalPos.x - moveX, pageLocalPos.y,
                                 pageLocalPos.z) -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.transform).localPosition = pageLocalPos -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).fade).alpha = 0.4
    if self.sequence == nil then
        local sequence = (CS_DoTween.Sequence)()
        sequence:Append(((self.transform):DOLocalMoveX(moveX, 0.3)):SetRelative(
                            true))
        sequence:Join(((self.ui).fade):DOFade(1, 0.3))
        sequence:SetAutoKill(false)
        self.sequence = sequence
    else
        do

            (self.sequence):Restart()
        end
    end
end

UINAthSortList.GetAthItemFromList = function(self, uid)
    -- function num : 0_24
    return (self.athListAll):GetAthItemFromListAll(uid)
end

UINAthSortList.OnDelete = function(self)
    -- function num : 0_25 , upvalues : base
    (self.athListAll):Delete()
    if self.siftCondition ~= nil then (self.siftCondition):Delete() end
    if self.sequence ~= nil then
        (self.sequence):Kill()
        self.sequence = nil
    end
    (base.OnDelete)(self)
end

return UINAthSortList


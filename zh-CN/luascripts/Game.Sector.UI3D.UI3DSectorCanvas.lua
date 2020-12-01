-- params : ...
-- function num : 0 , upvalues : _ENV
local UI3DSectorCanvas = class("UI3DSectorCanvas", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
local UINSctItemInfo = require("Game.Sector.UI3D.UINSctItemInfo")
local UINSctItemProgress = require("Game.Sector.UI3D.UINSctItemProgress")
local UINSctResPillar = require("Game.Sector.UI3D.UINSctResPillar")
local SectorEnum = require("Game.Sector.SectorEnum")
local PstConfig = require("Game.PersistentManager.PersistentData.PersistentConfig")
UI3DSectorCanvas.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINSctItemInfo, UINSctItemProgress, UINSctResPillar, PstConfig, cs_ResLoader
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).uI_STInfo):SetActive(false)
  ;
  ((self.ui).uI_STProgress):SetActive(false)
  ;
  ((self.ui).tex_ResPercent):SetActive(false)
  self.sctInfoPool = (UIItemPool.New)(UINSctItemInfo, (self.ui).uI_STInfo)
  self.sctInfoDic = {}
  self.sctProgressPool = (UIItemPool.New)(UINSctItemProgress, (self.ui).uI_STProgress)
  self.sctProgressStageDic = {}
  self.sctProgressBuildDic = {}
  self.sctResPillarPool = (UIItemPool.New)(UINSctResPillar, (self.ui).tex_ResPercent)
  ;
  (UIUtil.AddButtonListener)((self.ui).btnFriendshipDungeon, self, self.EnterFriendshipDungeon)
  ;
  (UIUtil.AddButtonListener)((self.ui).btnItemDungeon, self, self.EnterMatDungeon)
  ;
  (UIUtil.AddButtonListener)((self.ui).btnATHDungeon, self, self.EnterATHDungeon)
  self.localModelData = PersistentManager:GetDataModel((PstConfig.ePackage).UserData)
  self.resloader = (cs_ResLoader.Create)()
end

UI3DSectorCanvas.SetFriendshipDungeonUnlock = function(self, unlock, unlockDes)
  -- function num : 0_1
  self.friendshipUnLock = unlock
  self.friendshipUnLockDes = unlockDes
  if self.ui ~= nil then
    ((self.ui).obj_FriendshipLock):SetActive(not self.friendshipUnLock)
  end
end

UI3DSectorCanvas.EnterFriendshipDungeon = function(self, jumpTargetHeroId)
  -- function num : 0_2 , upvalues : cs_MessageCommon, _ENV, SectorEnum
  if not self.friendshipUnLock then
    (cs_MessageCommon.ShowMessageTips)(self.friendshipUnLockDes)
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.FriendShipPlotDungeon, function(window)
    -- function num : 0_2_0 , upvalues : _ENV, jumpTargetHeroId, self, SectorEnum
    if window == nil then
      return 
    end
    local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
    sectorCtrl:OnEnterPlotOrMateralDungeon()
    window:InitPlotDungeon(jumpTargetHeroId, self, function()
      -- function num : 0_2_0_0 , upvalues : sectorCtrl
      sectorCtrl:ResetToNormalState()
    end
)
    if self.localModelData ~= nil then
      (self.localModelData):RecordLastSectorSelected((SectorEnum.eSectorMentionId).FriendshipDungeonId)
    end
    UIManager:HideWindow(UIWindowTypeID.Sector)
    local HomeEnum = require("Game.Home.HomeEnum")
    MsgCenter:Broadcast(eMsgEventId.CleanNotice, (HomeEnum.eNoticeType).FragDungeonRefresh)
  end
)
end

UI3DSectorCanvas.SetMatDungeonUnlock = function(self, unlock, unlockDes)
  -- function num : 0_3
  self.itemUnLock = unlock
  self.itemUnLockDes = unlockDes
  if self.ui ~= nil then
    ((self.ui).obj_ItemLock):SetActive(not self.itemUnLock)
  end
end

UI3DSectorCanvas.EnterMatDungeon = function(self, jumpTargetTypeId)
  -- function num : 0_4 , upvalues : cs_MessageCommon, _ENV, SectorEnum
  if not self.itemUnLock then
    (cs_MessageCommon.ShowMessageTips)(self.itemUnLockDes)
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.MaterialDungeon, function(window)
    -- function num : 0_4_0 , upvalues : _ENV, jumpTargetTypeId, self, SectorEnum
    if window == nil then
      return 
    end
    local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
    sectorCtrl:OnEnterPlotOrMateralDungeon()
    window:InitMatDungeon(jumpTargetTypeId, self, function()
      -- function num : 0_4_0_0 , upvalues : sectorCtrl
      sectorCtrl:ResetToNormalState()
    end
)
    if self.localModelData ~= nil then
      (self.localModelData):RecordLastSectorSelected((SectorEnum.eSectorMentionId).MaterialDungeonId)
    end
    UIManager:HideWindow(UIWindowTypeID.Sector)
    local HomeEnum = require("Game.Home.HomeEnum")
    MsgCenter:Broadcast(eMsgEventId.CleanNotice, (HomeEnum.eNoticeType).ResDungeonRefresh)
  end
)
end

UI3DSectorCanvas.SetATHDungeonUnlock = function(self, unlock, unlockDes)
  -- function num : 0_5
  self.ATHUnLock = unlock
  self.ATHUnLockDes = unlockDes
  if self.ui ~= nil then
    ((self.ui).obj_ATHLock):SetActive(not self.ATHUnLock)
  end
end

UI3DSectorCanvas.EnterATHDungeon = function(self, jumpTargetTypeId)
  -- function num : 0_6 , upvalues : cs_MessageCommon, _ENV, SectorEnum
  if not self.ATHUnLock then
    (cs_MessageCommon.ShowMessageTips)(self.ATHUnLockDes)
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.ATHDungeon, function(window)
    -- function num : 0_6_0 , upvalues : _ENV, jumpTargetTypeId, self, SectorEnum
    if window == nil then
      return 
    end
    local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
    sectorCtrl:OnEnterPlotOrMateralDungeon()
    window:InitATHDungeon(jumpTargetTypeId, self, function()
      -- function num : 0_6_0_0 , upvalues : sectorCtrl
      sectorCtrl:ResetToNormalState()
    end
)
    if self.localModelData ~= nil then
      (self.localModelData):RecordLastSectorSelected((SectorEnum.eSectorMentionId).ATHDungeonId)
    end
    UIManager:HideWindow(UIWindowTypeID.Sector)
    local HomeEnum = require("Game.Home.HomeEnum")
    MsgCenter:Broadcast(eMsgEventId.CleanNotice, (HomeEnum.eNoticeType).ATHDungeonRefresh)
  end
)
end

UI3DSectorCanvas.InitSctUI3DCanvas = function(self)
  -- function num : 0_7
end

UI3DSectorCanvas.AddSctInfoItem = function(self, sectorId, clickFunc)
  -- function num : 0_8 , upvalues : _ENV
  local infoItem = (self.sctInfoPool):GetOne()
  infoItem:InitSctItemInfo(sectorId, clickFunc, self.resloader)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (infoItem.gameObject).name = tostring(sectorId)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.sctInfoDic)[sectorId] = infoItem
  return infoItem
end

UI3DSectorCanvas.AddSctProgressStage = function(self, sectorId, clickFunc)
  -- function num : 0_9
  local item = (self.sctProgressPool):GetOne()
  item:InitSctProgress(sectorId, true, clickFunc)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.sctProgressStageDic)[sectorId] = item
  return item
end

UI3DSectorCanvas.AddSctProgressBuild = function(self, sectorId, clickFunc)
  -- function num : 0_10
  local item = (self.sctProgressPool):GetOne()
  item:InitSctProgress(sectorId, false, clickFunc)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.sctProgressBuildDic)[sectorId] = item
  return item
end

UI3DSectorCanvas.SetUISctSelect = function(self, position, size)
  -- function num : 0_11
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  if self.ui ~= nil then
    ((self.ui).uI_STSelect).position = position
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).uI_STSelect).sizeDelta = size
  end
end

UI3DSectorCanvas.NewUISctResPillar = function(self)
  -- function num : 0_12
  local uiResPillar = (self.sctResPillarPool):GetOne()
  return uiResPillar
end

UI3DSectorCanvas.OnDelete = function(self)
  -- function num : 0_13 , upvalues : base
  (self.sctInfoPool):DeleteAll()
  ;
  (self.sctProgressPool):DeleteAll()
  ;
  (self.sctResPillarPool):DeleteAll()
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  ;
  (base.OnDelete)(self)
end

return UI3DSectorCanvas

-- params : ...
-- function num : 0 , upvalues : _ENV
local UI3DSectorCanvas = class("UI3DSectorCanvas", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
local UINSctItemInfo = require("Game.Sector.UI3D.UINSctItemInfo")
local UINSctItemProgress = require("Game.Sector.UI3D.UINSctItemProgress")
local UINSctResPillar = require("Game.Sector.UI3D.UINSctResPillar")
local SectorEnum = require("Game.Sector.SectorEnum")
local PstConfig = require(
                      "Game.PersistentManager.PersistentData.PersistentConfig")
UI3DSectorCanvas.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINSctItemInfo, UINSctItemProgress, UINSctResPillar, PstConfig, cs_ResLoader
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    ((self.ui).uI_STInfo):SetActive(false);
    ((self.ui).uI_STProgress):SetActive(false);
    ((self.ui).tex_ResPercent):SetActive(false)
    self.sctInfoPool = (UIItemPool.New)(UINSctItemInfo, (self.ui).uI_STInfo)
    self.sctInfoDic = {}
    self.sctProgressPool = (UIItemPool.New)(UINSctItemProgress,
                                            (self.ui).uI_STProgress)
    self.sctProgressStageDic = {}
    self.sctProgressBuildDic = {}
    self.sctResPillarPool = (UIItemPool.New)(UINSctResPillar,
                                             (self.ui).tex_ResPercent);
    (UIUtil.AddButtonListener)((self.ui).btnFriendshipDungeon, self,
                               self.EnterFriendshipDungeon);
    (UIUtil.AddButtonListener)((self.ui).btnItemDungeon, self,
                               self.EnterMatDungeon);
    (UIUtil.AddButtonListener)((self.ui).btnATHDungeon, self,
                               self.EnterATHDungeon)
    self.localModelData = PersistentManager:GetDataModel(
                              (PstConfig.ePackage).UserData)
    self.resloader = (cs_ResLoader.Create)()
end

UI3DSectorCanvas.SetFriendshipDungeonUnlock =
    function(self, unlock, unlockDes)
        -- function num : 0_1
        self.friendshipUnLock = unlock
        self.friendshipUnLockDes = unlockDes
        if self.ui ~= nil then
            ((self.ui).obj_FriendshipLock):SetActive(not self.friendshipUnLock)
        end
    end

UI3DSectorCanvas.EnterFriendshipDungeon =
    function(self, jumpTargetHeroId)
        -- function num : 0_2 , upvalues : cs_MessageCommon, _ENV, SectorEnum
        if not self.friendshipUnLock then
            (cs_MessageCommon.ShowMessageTips)(self.friendshipUnLockDes)
            return
        end
        UIManager:ShowWindowAsync(UIWindowTypeID.FriendShipPlotDungeon,
                                  function(window)
            -- function num : 0_2_0 , upvalues : _ENV, jumpTargetHeroId, self, SectorEnum
            if window == nil then return end
            local sectorCtrl = ControllerManager:GetController(
                                   ControllerTypeId.SectorController)
            sectorCtrl:OnEnterPlotOrMateralDungeon()
            window:InitPlotDungeon(jumpTargetHeroId, self, function()
                -- function num : 0_2_0_0 , upvalues : sectorCtrl
                sectorCtrl:ResetToNormalState()
            end)
            if self.localModelData ~= nil then
                (self.localModelData):RecordLastSectorSelected(
                    (SectorEnum.eSectorMentionId).FriendshipDungeonId)
            end
            UIManager:HideWindow(UIWindowTypeID.Sector)
            local HomeEnum = require("Game.Home.HomeEnum")
            MsgCenter:Broadcast(eMsgEventId.CleanNotice,
                                (HomeEnum.eNoticeType).FragDungeonRefresh)
        end)
    end

UI3DSectorCanvas.SetMatDungeonUnlock = function(self, unlock, unlockDes)
    -- function num : 0_3
    self.itemUnLock = unlock
    self.itemUnLockDes = unlockDes
    if self.ui ~= nil then
        ((self.ui).obj_ItemLock):SetActive(not self.itemUnLock)
    end
end

UI3DSectorCanvas.EnterMatDungeon = function(self, jumpTargetTypeId)
    -- function num : 0_4 , upvalues : cs_MessageCommon, _ENV, SectorEnum
    if not self.itemUnLock then
        (cs_MessageCommon.ShowMessageTips)(self.itemUnLockDes)
        return
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.MaterialDungeon, function(window)
        -- function num : 0_4_0 , upvalues : _ENV, jumpTargetTypeId, self, SectorEnum
        if window == nil then return end
        local sectorCtrl = ControllerManager:GetController(
                               ControllerTypeId.SectorController)
        sectorCtrl:OnEnterPlotOrMateralDungeon()
        window:InitMatDungeon(jumpTargetTypeId, self, function()
            -- function num : 0_4_0_0 , upvalues : sectorCtrl
            sectorCtrl:ResetToNormalState()
        end)
        if self.localModelData ~= nil then
            (self.localModelData):RecordLastSectorSelected(
                (SectorEnum.eSectorMentionId).MaterialDungeonId)
        end
        UIManager:HideWindow(UIWindowTypeID.Sector)
        local HomeEnum = require("Game.Home.HomeEnum")
        MsgCenter:Broadcast(eMsgEventId.CleanNotice,
                            (HomeEnum.eNoticeType).ResDungeonRefresh)
    end)
end

UI3DSectorCanvas.SetATHDungeonUnlock = function(self, unlock, unlockDes)
    -- function num : 0_5
    self.ATHUnLock = unlock
    self.ATHUnLockDes = unlockDes
    if self.ui ~= nil then
        ((self.ui).obj_ATHLock):SetActive(not self.ATHUnLock)
    end
end

UI3DSectorCanvas.EnterATHDungeon = function(self, jumpTargetTypeId)
    -- function num : 0_6 , upvalues : cs_MessageCommon, _ENV, SectorEnum
    if not self.ATHUnLock then
        (cs_MessageCommon.ShowMessageTips)(self.ATHUnLockDes)
        return
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.ATHDungeon, function(window)
        -- function num : 0_6_0 , upvalues : _ENV, jumpTargetTypeId, self, SectorEnum
        if window == nil then return end
        local sectorCtrl = ControllerManager:GetController(
                               ControllerTypeId.SectorController)
        sectorCtrl:OnEnterPlotOrMateralDungeon()
        window:InitATHDungeon(jumpTargetTypeId, self, function()
            -- function num : 0_6_0_0 , upvalues : sectorCtrl
            sectorCtrl:ResetToNormalState()
        end)
        if self.localModelData ~= nil then
            (self.localModelData):RecordLastSectorSelected(
                (SectorEnum.eSectorMentionId).ATHDungeonId)
        end
        UIManager:HideWindow(UIWindowTypeID.Sector)
        local HomeEnum = require("Game.Home.HomeEnum")
        MsgCenter:Broadcast(eMsgEventId.CleanNotice,
                            (HomeEnum.eNoticeType).ATHDungeonRefresh)
    end)
end

UI3DSectorCanvas.InitSctUI3DCanvas = function(self)
    -- function num : 0_7
end

UI3DSectorCanvas.AddSctInfoItem = function(self, sectorId, clickFunc)
    -- function num : 0_8 , upvalues : _ENV
    local infoItem = (self.sctInfoPool):GetOne()
    infoItem:InitSctItemInfo(sectorId, clickFunc, self.resloader) -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'
    ;
    (infoItem.gameObject).name = tostring(sectorId) -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'
    ;
    (self.sctInfoDic)[sectorId] = infoItem
    return infoItem
end

UI3DSectorCanvas.AddSctProgressStage = function(self, sectorId, clickFunc)
    -- function num : 0_9
    local item = (self.sctProgressPool):GetOne()
    item:InitSctProgress(sectorId, true, clickFunc) -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'
    ;
    (self.sctProgressStageDic)[sectorId] = item
    return item
end

UI3DSectorCanvas.AddSctProgressBuild = function(self, sectorId, clickFunc)
    -- function num : 0_10
    local item = (self.sctProgressPool):GetOne()
    item:InitSctProgress(sectorId, false, clickFunc) -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'
    ;
    (self.sctProgressBuildDic)[sectorId] = item
    return item
end

UI3DSectorCanvas.SetUISctSelect = function(self, position, size)
    -- function num : 0_11
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

    if self.ui ~= nil then
        ((self.ui).uI_STSelect).position = position -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).uI_STSelect).sizeDelta = size
    end
end

UI3DSectorCanvas.NewUISctResPillar = function(self)
    -- function num : 0_12
    local uiResPillar = (self.sctResPillarPool):GetOne()
    return uiResPillar
end

UI3DSectorCanvas.OnDelete = function(self)
    -- function num : 0_13 , upvalues : base
    (self.sctInfoPool):DeleteAll();
    (self.sctProgressPool):DeleteAll();
    (self.sctResPillarPool):DeleteAll()
    if self.resloader ~= nil then
        (self.resloader):Put2Pool()
        self.resloader = nil
    end
    (base.OnDelete)(self)
end

return UI3DSectorCanvas

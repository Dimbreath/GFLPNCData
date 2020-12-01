-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpStartRoom = class("UIEpStartRoom", UIBaseNode)
UIEpStartRoom.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIEpStartRoom.InitRoomUI = function(self, roomData)
  -- function num : 0_1 , upvalues : _ENV
  self.roomData = roomData
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_LevelCount).text = tostring(ExplorationManager:GetCurLevelIndex() + 1) .. "/" .. tostring(ExplorationManager:GetLevelCount())
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_LevelName).text = (LanguageUtil.GetLocaleText)((ExplorationManager:GetSectorStageCfg()).name)
end

UIEpStartRoom.GetRoomSize = function(self)
  -- function num : 0_2
  return (((self.ui).roomNode).transform).sizeDelta
end

UIEpStartRoom.ChangeUIState = function(self, eRoomState, withTween, isAutoPath)
  -- function num : 0_3
end

return UIEpStartRoom

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpStartRoom = class("UIEpStartRoom", UIBaseNode)
UIEpStartRoom.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIEpStartRoom.InitRoomUI = function(self, roomData)
    -- function num : 0_1 , upvalues : _ENV
    self.roomData = roomData -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).tex_LevelCount).text = tostring(
                                          ExplorationManager:GetCurLevelIndex() +
                                              1) .. "/" ..
                                          tostring(
                                              ExplorationManager:GetLevelCount()) -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).tex_LevelName).text = (LanguageUtil.GetLocaleText)(
                                         (ExplorationManager:GetSectorStageCfg()).name)
end

UIEpStartRoom.GetRoomSize = function(self)
    -- function num : 0_2
    return (((self.ui).roomNode).transform).sizeDelta
end

UIEpStartRoom.ChangeUIState = function(self, eRoomState, withTween, isAutoPath)
    -- function num : 0_3
end

return UIEpStartRoom


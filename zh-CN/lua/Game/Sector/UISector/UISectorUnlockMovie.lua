local UISectorUnlockMovie = class("UISectorUnlockMovie", UIBaseWindow)
local base = UIBaseWindow
local SectorEnum = require("Game.Sector.SectorEnum")
local CS_MovieManager_ins = (CS.MovieManager).Instance
UISectorUnlockMovie.OnInit = function(self)
  -- function num : 0_0
  ((self.ui).background):SetActive(false)
end

UISectorUnlockMovie.TryPlayVideo = function(self, sectorId)
  -- function num : 0_1 , upvalues : _ENV, SectorEnum, CS_MovieManager_ins
  ((self.ui).movie):SetActive(false)
  local sectorCfg = (ConfigData.sector)[sectorId]
  local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  if sectorCtrl.needPlayEndVideo ~= nil then
    local selfSectorId = sectorId
    if selfSectorId == SectorEnum.NewbeeSectorId then
      selfSectorId = 0
    end
    if (sectorCtrl.needPlayEndVideo).flag and selfSectorId == (sectorCtrl.needPlayEndVideo).sectorId - 1 then
      local unlockSectorId = (sectorCtrl.needPlayEndVideo).sectorId
      do
        ((self.ui).background):SetActive(true)
        ;
        (((self.ui).tex_Touch).gameObject):SetActive(false)
        ;
        (((self.ui).tex_Name).gameObject):SetActive(false)
        ;
        (((self.ui).img_Video).gameObject):SetActive(false)
        ;
        ((self.ui).movie):SetActive(true)
        NoticeManager:PuaseShowNotice("sector")
        ;
        (UIUtil.HideTopStatus)()
        if self.moviePlayer == nil then
          self.moviePlayer = CS_MovieManager_ins:GetMoviePlayer()
        end
        ;
        (self.moviePlayer):SetVideoRender((self.ui).img_Video)
        local path = PathConsts:GetSectorCompleteVideoPath(unlockSectorId)
        local backAction = function()
    -- function num : 0_1_0 , upvalues : _ENV, unlockSectorId, self, path, sectorCtrl, sectorId
    local localModelData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
    if localModelData ~= nil then
      localModelData:RecordLastMaxUnlockSectorId(unlockSectorId, false)
    end
    ;
    (((self.ui).img_Video).gameObject):SetActive(true)
    ;
    (self.moviePlayer):PlayVideo(path, function()
      -- function num : 0_1_0_0 , upvalues : self, sectorCtrl, unlockSectorId, sectorId
      ((self.ui).background):SetActive(false)
      ;
      ((self.ui).movie):SetActive(false)
      sectorCtrl:ShowUnlockSectorEffect(unlockSectorId, function()
        -- function num : 0_1_0_0_0 , upvalues : sectorCtrl, sectorId
        sectorCtrl:OnSectorItemClicked(sectorId)
      end
, true)
    end
, (self.ui).movie_Speed, false)
  end

        local texBackAction = function()
    -- function num : 0_1_1 , upvalues : self, _ENV, sectorCfg, unlockSectorId
    (((self.ui).tex_Touch).gameObject):SetActive(true)
    ;
    (((self.ui).tex_Name).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((self.ui).tex_Touch).text = (string.format)(((self.ui).tex_Touch).text, (LanguageUtil.GetLocaleText)(sectorCfg.name))
    ;
    ((self.ui).tex_Touch):StartScrambleTypeWriter()
    local nextSectorCfg = (ConfigData.sector)[unlockSectorId]
    if nextSectorCfg ~= nil then
      ((self.ui).tex_Name):SetIndex(0, (LanguageUtil.GetLocaleText)(nextSectorCfg.name))
    else
      ;
      ((self.ui).tex_Name):SetIndex(1)
    end
  end

        local canCloseBackAction = function()
    -- function num : 0_1_2 , upvalues : self
    self.__playVideoSeq = nil
    ;
    (self.moviePlayer):StopVideo()
  end

        self.__playVideoSeq = ((((CS.DG).Tweening).DOTween).Sequence)()
        ;
        (self.__playVideoSeq):InsertCallback((self.ui).movie_Begin, backAction)
        ;
        (self.__playVideoSeq):InsertCallback((self.ui).tex_Begin, texBackAction)
        ;
        (self.__playVideoSeq):InsertCallback((self.ui).tex_Begin + (self.ui).movie_CanClose, canCloseBackAction)
        -- DECOMPILER ERROR at PC115: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (sectorCtrl.needPlayEndVideo).flag = false
        return true
      end
    else
      do
        self:Delete()
        do return false end
      end
    end
  end
end

UISectorUnlockMovie._ReturnMovie = function(self)
  -- function num : 0_2 , upvalues : CS_MovieManager_ins
  if self.moviePlayer ~= nil then
    CS_MovieManager_ins:ReturnMoviePlayer(self.moviePlayer)
    self.moviePlayer = nil
  end
end

UISectorUnlockMovie.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  self:_ReturnMovie()
  if self.__playVideoSeq ~= nil then
    (self.__playVideoSeq):Kill()
    self.__playVideoSeq = nil
  end
  ;
  (base.OnDelete)(self)
end

return UISectorUnlockMovie


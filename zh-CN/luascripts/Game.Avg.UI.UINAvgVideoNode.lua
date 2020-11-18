-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAvgVideoNode = class("UINAvgVideoNode", UIBaseNode)
local base = UIBaseNode
local CS_MovieManager_ins = (CS.MovieManager).Instance
UINAvgVideoNode.ctor = function(self, avgSystem)
  -- function num : 0_0
  self.avgSystem = avgSystem
end

UINAvgVideoNode.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (((self.ui).rawImage_LoopVideo).gameObject):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Skip, self, self.__OnClickSkip)
  self.__onVideoPlayComplete = BindCallback(self, self.OnAvgVideoPlayComplete)
end

UINAvgVideoNode.PlayAvgVideo = function(self, videoPath)
  -- function num : 0_2 , upvalues : _ENV, CS_MovieManager_ins
  if (string.IsNullOrEmpty)(videoPath) then
    return 
  end
  self:Show()
  if self.moviePlayer == nil then
    self.moviePlayer = CS_MovieManager_ins:GetMoviePlayer()
  end
  ;
  (self.moviePlayer):SetVideoRender((self.ui).rawImage)
  ;
  (self.moviePlayer):PlayVideo(videoPath, self.__onVideoPlayComplete)
  AudioManager:PauseSource(eAudioSourceType.BgmSource, true)
  return true
end

UINAvgVideoNode.__OnClickSkip = function(self)
  -- function num : 0_3
  (self.moviePlayer):StopVideo()
  self:OnAvgVideoPlayComplete()
end

UINAvgVideoNode.OnAvgVideoPlayComplete = function(self)
  -- function num : 0_4 , upvalues : CS_MovieManager_ins, _ENV
  CS_MovieManager_ins:ReturnMoviePlayer(self.moviePlayer)
  self.moviePlayer = nil
  self:Hide()
  AudioManager:PauseSource(eAudioSourceType.BgmSource, false)
  ;
  (self.avgSystem):PlayAvgVideoComplete()
end

UINAvgVideoNode.PlayAvgVideoLoop = function(self, videoPath, loopFrame)
  -- function num : 0_5 , upvalues : _ENV, CS_MovieManager_ins
  if (string.IsNullOrEmpty)(videoPath) then
    return 
  end
  if self.loopMoviePlayer == nil then
    self.loopMoviePlayer = CS_MovieManager_ins:GetMoviePlayer()
  end
  ;
  (((self.ui).rawImage_LoopVideo).gameObject):SetActive(true)
  ;
  (self.loopMoviePlayer):SetVideoRender((self.ui).rawImage_LoopVideo)
  self:SetAvgVideoLoop(loopFrame)
end

UINAvgVideoNode.SetAvgVideoLoop = function(self, loopFrame)
  -- function num : 0_6 , upvalues : _ENV
  if self.loopMoviePlayer == nil then
    return 
  end
  if loopFrame == nil then
    error("AvgVideoLoop : loopFrame is nil")
    return 
  end
  if #loopFrame ~= 2 then
    error("AvgVideoLoop : loopFrame count is not two")
    return 
  end
  ;
  (self.loopMoviePlayer):SetLoopSeek(loopFrame[1], loopFrame[2], true)
end

UINAvgVideoNode.StopAvgVideoLoop = function(self)
  -- function num : 0_7
  if self.loopMoviePlayer == nil then
    return 
  end
  ;
  (self.loopMoviePlayer):StopVideo()
  ;
  (((self.ui).rawImage_LoopVideo).gameObject):SetActive(false)
end

UINAvgVideoNode.OnDelete = function(self)
  -- function num : 0_8 , upvalues : CS_MovieManager_ins, base
  if self.moviePlayer ~= nil then
    CS_MovieManager_ins:ReturnMoviePlayer(self.moviePlayer)
    self.moviePlayer = nil
  end
  if self.loopMoviePlayer ~= nil then
    CS_MovieManager_ins:ReturnMoviePlayer(self.loopMoviePlayer)
    self.loopMoviePlayer = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINAvgVideoNode


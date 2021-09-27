local UIUltrSkillHeroShow = class("UIUltrSkillHeroShow", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
UIUltrSkillHeroShow.OnInit = function(self)
  -- function num : 0_0
  self.isDeleted = false
end

UIUltrSkillHeroShow.InitUltrSkillHeroShow = function(self, caster, notAutoPlay)
  -- function num : 0_1 , upvalues : _ENV, cs_ResLoader
  if caster == nil then
    return 
  end
  local resName = nil
  if notAutoPlay and isGameDev then
    resName = caster.resName
    ;
    ((self.ui).go_timeLine):SetActive(true)
  else
    local dynPlayer = (BattleUtil.GetCurDynPlayer)()
    if dynPlayer == nil then
      error("can\'t get dynPlayer")
      self:Delete()
      return 
    end
    local heroData = (dynPlayer.heroDic)[caster.roleDataId]
    if heroData == nil then
      error("can\'t get heroData")
      self:Delete()
      return 
    end
    resName = heroData:GetResPicName()
    if resName == nil then
      error("can\'t get resName")
      self:Delete()
      return 
    end
  end
  do
    local playRate = 1
    local speed = (ConfigData.cutin_speed)[resName]
    if speed ~= nil then
      playRate = speed * (Time.unity_time).timeScale
    end
    if self.bigImgResloader ~= nil then
      (self.bigImgResloader):Put2Pool()
      self.bigImgResloader = nil
    end
    self.bigImgResloader = (cs_ResLoader.Create)()
    ;
    (self.bigImgResloader):LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(resName), function(prefab)
    -- function num : 0_1_0 , upvalues : self, _ENV, notAutoPlay, playRate
    if self.isDeleted then
      return 
    end
    DestroyUnityObject(self.bigImgGameObject)
    DestroyUnityObject(self.bigImgGameObject2)
    self.bigImgGameObject = prefab:Instantiate(((self.ui).smallHeroHolder).transform)
    local comPerspHandle = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    comPerspHandle:SetPosType("UltrSkillShowHeroSmall")
    self.bigImgGameObject2 = prefab:Instantiate(((self.ui).bigHeroHolder).transform)
    local comPerspHandle2 = (self.bigImgGameObject2):FindComponent(eUnityComponentID.CommonPicController)
    comPerspHandle2:SetPosType("UltrSkillShowHeroBig")
    local rawImage = (self.bigImgGameObject2):FindComponent(eUnityComponentID.RawImage)
    rawImage.material = (self.ui).uIM_rolo
    ;
    ((self.ui).bigllMask2D):SetEffect2OtherMat(rawImage.material)
    rawImage.color = ((self.ui).img_bigHeroHolder).color
    if notAutoPlay and isGameDev then
      self.__rawImage = rawImage
      UpdateManager:AddUpdate(function()
      -- function num : 0_1_0_0 , upvalues : _ENV, self
      if IsNull(self.__rawImage) then
        return 
      end
      -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (self.__rawImage).color = ((self.ui).img_bigHeroHolder).color
    end
)
      return 
    end
    ;
    ((self.ui).go_timeLine):SetActive(true)
    self.__tlCo = (TimelineUtil.Play)((self.ui).direct, nil, nil, nil, true, function()
      -- function num : 0_1_0_1 , upvalues : rawImage, self
      rawImage.color = ((self.ui).img_bigHeroHolder).color
    end
, playRate)
  end
)
  end
end

UIUltrSkillHeroShow.OnDelete = function(self)
  -- function num : 0_2 , upvalues : _ENV, base
  if self.__tlCo ~= nil then
    (TimelineUtil.StopTlCo)(self.__tlCo)
    self.__tlCo = nil
  end
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  self.isDeleted = true
  ;
  (base.OnDelete)(self)
end

return UIUltrSkillHeroShow


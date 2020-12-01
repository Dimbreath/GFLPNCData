-- params : ...
-- function num : 0 , upvalues : _ENV
local UINSctItemInfo = class("UINSctItemInfo", UIBaseNode)
local base = UIBaseNode
local cs_DoTweenLoopType = ((CS.DG).Tweening).LoopType
UINSctItemInfo.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.__OnClickRootBtn)
end

UINSctItemInfo.InitSctItemInfo = function(self, sectorId, clickFunc, resloader)
  -- function num : 0_1 , upvalues : _ENV
  self.clickFunc = clickFunc
  local sectorCfg = (ConfigData.sector)[sectorId]
  if sectorCfg == nil then
    error("Cant get sectorCfg, sectorId = " .. tostring(sectorId))
    return 
  end
  self.sectorCfg = sectorCfg
  local textureName = sectorCfg.scene_icon
  if textureName ~= nil or textureName ~= "" then
    resloader:LoadABAssetAsync(PathConsts:GetSeceneIconPicPath(textureName), function(texture)
    -- function num : 0_1_0 , upvalues : _ENV, self
    if IsNull(self.transform) then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Career).texture = texture
  end
)
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).fade).alpha = 1
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_SectorName).text = (LanguageUtil.GetLocaleText)(sectorCfg.type_name)
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(sectorCfg.name)
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_ENName).text = sectorCfg.name_en
  self:SetUINSctItemTweens()
end

UINSctItemInfo.SetSctInfoPosConstraint = function(self, sourceTransform)
  -- function num : 0_2
  local source = ((self.ui).posConstraint):GetSource(0)
  source.sourceTransform = sourceTransform
  ;
  ((self.ui).posConstraint):SetSource(0, source)
end

UINSctItemInfo.__OnClickRootBtn = function(self)
  -- function num : 0_3
  if self.clickFunc ~= nil then
    (self.clickFunc)((self.sectorCfg).id)
  end
end

UINSctItemInfo.ShowUISctItemInEp = function(self, show)
  -- function num : 0_4
  ((self.ui).inExplore):SetActive(show)
end

UINSctItemInfo.SetUISctItemLock = function(self, lock)
  -- function num : 0_5
  ((self.ui).lock):SetActive(lock)
  ;
  (((self.ui).img_Career).gameObject):SetActive(not lock)
  if not lock then
    self:SetUINSctItemTweens()
  end
end

UINSctItemInfo.SetUINSctItemTweens = function(self)
  -- function num : 0_6 , upvalues : cs_DoTweenLoopType
  if self.tween ~= nil then
    (self.tween):Restart()
  else
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).fade).alpha = 0
    self.tween = (((((self.ui).fade):DOFade(1, 0.11)):SetDelay(1.1)):SetLoops(5, cs_DoTweenLoopType.Restart)):SetAutoKill(false)
  end
end

UINSctItemInfo.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  if self.tween ~= nil then
    (self.tween):Kill()
  end
  ;
  (base.OnDelete)(self)
end

return UINSctItemInfo

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINSctItemInfo = class("UINSctItemInfo", UIBaseNode)
local base = UIBaseNode
local cs_DoTweenLoopType = ((CS.DG).Tweening).LoopType
UINSctItemInfo.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.__OnClickRootBtn)
end

UINSctItemInfo.InitSctItemInfo = function(self, sectorId, clickFunc, resloader)
    -- function num : 0_1 , upvalues : _ENV
    self.clickFunc = clickFunc
    local sectorCfg = (ConfigData.sector)[sectorId]
    if sectorCfg == nil then
        error("Cant get sectorCfg, sectorId = " .. tostring(sectorId))
        return
    end
    self.sectorCfg = sectorCfg
    local textureName = sectorCfg.scene_icon
    if textureName ~= nil or textureName ~= "" then
        resloader:LoadABAssetAsync(PathConsts:GetSeceneIconPicPath(textureName),
                                   function(texture)
            -- function num : 0_1_0 , upvalues : _ENV, self
            if IsNull(self.transform) then return end -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'
            
            ((self.ui).img_Career).texture = texture
        end)
    end -- DECOMPILER ERROR at PC29: Confused about usage of register: R6 in 'UnsetPending'
    
    ((self.ui).fade).alpha = 1 -- DECOMPILER ERROR at PC36: Confused about usage of register: R6 in 'UnsetPending'
    ;
    ((self.ui).tex_SectorName).text = (LanguageUtil.GetLocaleText)(
                                          sectorCfg.type_name) -- DECOMPILER ERROR at PC43: Confused about usage of register: R6 in 'UnsetPending'
    ;
    ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(sectorCfg.name) -- DECOMPILER ERROR at PC47: Confused about usage of register: R6 in 'UnsetPending'
    ;
    ((self.ui).tex_ENName).text = sectorCfg.name_en
    self:SetUINSctItemTweens()
end

UINSctItemInfo.SetSctInfoPosConstraint =
    function(self, sourceTransform)
        -- function num : 0_2
        local source = ((self.ui).posConstraint):GetSource(0)
        source.sourceTransform = sourceTransform;
        ((self.ui).posConstraint):SetSource(0, source)
    end

UINSctItemInfo.__OnClickRootBtn = function(self)
    -- function num : 0_3
    if self.clickFunc ~= nil then (self.clickFunc)((self.sectorCfg).id) end
end

UINSctItemInfo.ShowUISctItemInEp = function(self, show)
    -- function num : 0_4
    ((self.ui).inExplore):SetActive(show)
end

UINSctItemInfo.SetUISctItemLock = function(self, lock)
    -- function num : 0_5
    ((self.ui).lock):SetActive(lock);
    (((self.ui).img_Career).gameObject):SetActive(not lock)
    if not lock then self:SetUINSctItemTweens() end
end

UINSctItemInfo.SetUINSctItemTweens = function(self)
    -- function num : 0_6 , upvalues : cs_DoTweenLoopType
    if self.tween ~= nil then
        (self.tween):Restart()
    else
        -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'


        ((self.ui).fade).alpha = 0
        self.tween =
            (((((self.ui).fade):DOFade(1, 0.11)):SetDelay(1.1)):SetLoops(5,
                                                                         cs_DoTweenLoopType.Restart)):SetAutoKill(
                false)
    end
end

UINSctItemInfo.OnDelete = function(self)
    -- function num : 0_7 , upvalues : base
    if self.tween ~= nil then (self.tween):Kill() end
    (base.OnDelete)(self)
end

return UINSctItemInfo


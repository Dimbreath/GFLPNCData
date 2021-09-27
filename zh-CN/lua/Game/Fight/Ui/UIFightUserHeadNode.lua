local UIFightUserHeadNode = class("UIFightUserHeadNode", UIBaseNode)
UIFightUserHeadNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIFightUserHeadNode.Init = function(self, root, resLoader)
  -- function num : 0_1 , upvalues : _ENV
  (UIBaseNode.Init)(self, root)
  self.resLoader = resLoader
end

UIFightUserHeadNode.RefreshUserHead = function(self, avatarId)
  -- function num : 0_2 , upvalues : _ENV
  if avatarId == nil or avatarId == 0 then
    return 
  end
  local cfg = (ConfigData.portrait)[avatarId]
  if cfg == nil or cfg.icon == nil then
    error("can\'t read portraitCfg with id:" .. tostring(avatarId))
    return 
  end
  local icon = cfg.icon
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R4 in 'UnsetPending'

  if not (string.IsNullOrEmpty)(icon) then
    ((self.ui).img_UserHead).sprite = CRH:GetSprite(icon, CommonAtlasType.HeroHeadIcon)
  end
end

UIFightUserHeadNode.RefreshUserHeadFrame = function(self, avatarFrameId)
  -- function num : 0_3 , upvalues : _ENV
  if avatarFrameId == nil or avatarFrameId == 0 then
    return 
  end
  local cfg = (ConfigData.portrait_frame)[avatarFrameId]
  if cfg == nil or cfg.icon == nil then
    error("can\'t read portrait_frameCfg with id:" .. tostring(avatarFrameId))
    return 
  end
  local icon = cfg.icon
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R4 in 'UnsetPending'

  if not (string.IsNullOrEmpty)(icon) then
    ((self.ui).img_Frame).sprite = CRH:GetSprite(icon, CommonAtlasType.HeroHeadIcon)
  end
end

return UIFightUserHeadNode


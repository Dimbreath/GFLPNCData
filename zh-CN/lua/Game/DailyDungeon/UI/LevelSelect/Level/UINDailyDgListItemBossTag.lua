local UINDailyDgListItemBossTag = class("UINDailyDgListItemBossTag", UIBaseNode)
local base = UIBaseNode
UINDailyDgListItemBossTag.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINDailyDgListItemBossTag.InitDailyDgListItemBossTag = function(self, monsterTagCfg)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_BossTag).text = (LanguageUtil.GetLocaleText)(monsterTagCfg.tag)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_Tag).color = ((self.ui).tagColorList)[monsterTagCfg.color]
end

UINDailyDgListItemBossTag.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINDailyDgListItemBossTag


local UINWCDebuffResultItem = class("UINWCDebuffResultItem", UIBaseNode)
local base = UIBaseNode
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
UINWCDebuffResultItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (((self.ui).btn_debuffResultItem).onPressDown):AddListener(BindCallback(self, self.__OnPressDown))
  ;
  (((self.ui).btn_debuffResultItem).onPressUp):AddListener(BindCallback(self, self.__OnPressUp))
end

UINWCDebuffResultItem.InitResultItem = function(self, resultItemData)
  -- function num : 0_1 , upvalues : _ENV
  local scoreId = resultItemData.id
  local cfg = (ConfigData.weekly_challenge_score)[scoreId]
  if cfg == nil then
    error("weekly_challenge_score cfg is nill id:" .. tostring(scoreId))
    return 
  end
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_title).text = (LanguageUtil.GetLocaleText)(cfg.title)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_point).text = tostring(resultItemData.score)
  if cfg.check_type == 2 or cfg.check_type == 3 then
    (((self.ui).tex_Count).gameObject):SetActive(false)
    self.resultItemDescribe = (string.format)((LanguageUtil.GetLocaleText)(cfg.intro), tostring(cfg.check_value))
  else
    if cfg.id == 18 then
      (((self.ui).tex_Count).gameObject):SetActive(true)
      -- DECOMPILER ERROR at PC69: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tex_Count).text = GetPreciseDecimalStr(resultItemData.param / 100, 0) .. "%"
      local bossMonsterName = nil
      if ExplorationManager.epCtrl ~= nil then
        local bossRoomData = (ExplorationManager.epCtrl):GetCurrentRoomData()
        if bossRoomData ~= nil and bossRoomData.mode == 5 then
          for _,dynMonster in pairs(bossRoomData.monsterList) do
            if dynMonster:GetBossBloodNum() > 0 then
              bossMonsterName = dynMonster:GetName()
              break
            end
          end
        end
      end
      do
        do
          if bossMonsterName ~= nil then
            self.resultItemDescribe = (string.format)((LanguageUtil.GetLocaleText)(cfg.intro), tostring(bossMonsterName))
          else
            warn("can\'t get boss name")
            self.resultItemDescribe = (string.format)((LanguageUtil.GetLocaleText)(cfg.intro), "BOSS")
          end
          if cfg.id == 19 then
            local time = (math.floor)(resultItemData.param / 15)
            local timeStr = tostring(time)
            ;
            (((self.ui).tex_Count).gameObject):SetActive(true)
            -- DECOMPILER ERROR at PC147: Confused about usage of register: R6 in 'UnsetPending'

            ;
            ((self.ui).tex_Count).text = tostring(timeStr)
            self.resultItemDescribe = (string.format)((LanguageUtil.GetLocaleText)(cfg.intro), timeStr)
          else
            do
              ;
              (((self.ui).tex_Count).gameObject):SetActive(true)
              -- DECOMPILER ERROR at PC169: Confused about usage of register: R4 in 'UnsetPending'

              ;
              ((self.ui).tex_Count).text = resultItemData.score // cfg.unit_score
              self.resultItemDescribe = (LanguageUtil.GetLocaleText)(cfg.intro)
            end
          end
        end
      end
    end
  end
end

UINWCDebuffResultItem.__OnPressDown = function(self)
  -- function num : 0_2 , upvalues : _ENV, HAType, VAType
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  win:SetTitleAndContext(((self.ui).tex_title).text, self.resultItemDescribe)
  win:FloatTo(self.transform, HAType.autoCenter, VAType.up)
end

UINWCDebuffResultItem.__OnPressUp = function(self)
  -- function num : 0_3 , upvalues : _ENV
  UIManager:HideWindow(UIWindowTypeID.FloatingFrame)
end

UINWCDebuffResultItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINWCDebuffResultItem


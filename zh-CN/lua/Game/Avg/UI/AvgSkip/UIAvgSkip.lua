local UIAvgSkip = class("UIAvgSkip", UIBaseWindow)
local base = UIBaseWindow
local NameScriptId = "cpt00_e_01_05"
local ChouKaScriptId = "cpt00_e_01_06"
local NameID = -1000
local ChouKaId = -1001
local cpt00_e_01_05 = "逆转战局"
local cpt00_e_01_06 = "启程"
UIAvgSkip.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._OnClickConfirm = BindCallback(self, self.OnClickConfirm)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_bg, self, self.OnClickClose)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, self.OnClickClose)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self._OnClickConfirm)
  self.avgctrl = ControllerManager:GetController(ControllerTypeId.Avg)
end

UIAvgSkip.InitTextInfo = function(self, SkipTextId)
  -- function num : 0_1 , upvalues : _ENV, NameID, cpt00_e_01_05, ChouKaId, cpt00_e_01_06
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  (self.ui).tex_skip = ConfigData:GetTipContent(TipContent.Avg_SkipAllAvg)
  local NowAvgID = (self.avgctrl).AVGID
  if NowAvgID == nil then
    error("AVGID 不存在")
    return 
  end
  local sectorcfg = 0
  if NowAvgID == 4 or NowAvgID == 101 or NowAvgID == 102 or NowAvgID == 103 or NowAvgID == -1000 or NowAvgID == -1001 then
    sectorcfg = (ConfigData.sector)[100]
  else
    local sectorstagecfg = (ConfigData.sector_stage)[NowAvgID]
    sectorcfg = (ConfigData.sector)[sectorstagecfg.sector]
  end
  do
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R4 in 'UnsetPending'

    if SkipTextId ~= nil then
      ((self.ui).tex_Content).text = (self.avgctrl):GetAvgLanguage(SkipTextId)
    else
      -- DECOMPILER ERROR at PC51: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tex_Content).text = ""
    end
    local titlename = ""
    local strsectorname = ""
    if NowAvgID == NameID then
      titlename = cpt00_e_01_05
      strsectorname = ((ConfigData.story_avg)[4]).number
    else
      if NowAvgID == ChouKaId then
        titlename = cpt00_e_01_06
        strsectorname = ((ConfigData.story_avg)[4]).number
      end
    end
    if NowAvgID ~= ChouKaId and NowAvgID ~= NameID then
      titlename = (LanguageUtil.GetLocaleText)(((ConfigData.story_avg)[NowAvgID]).name)
      strsectorname = ((ConfigData.story_avg)[NowAvgID]).number
    end
    -- DECOMPILER ERROR at PC91: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_Title).text = titlename
    ;
    ((self.ui).tex_SectorName):SetIndex(0, (LanguageUtil.GetLocaleText)(sectorcfg.name), strsectorname)
    -- DECOMPILER ERROR at PC105: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_SectorEnName).text = sectorcfg.name_en
  end
end

UIAvgSkip.OnClickConfirm = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.avgctrl ~= nil then
    (self.avgctrl):SkipAvg()
  else
    error("avgctrl nil")
  end
  self:Delete()
end

UIAvgSkip.OnClickClose = function(self)
  -- function num : 0_3
  self:Delete()
end

UIAvgSkip.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UIAvgSkip


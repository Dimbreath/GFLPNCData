-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAvgRecordItem = class("UINAvgRecordItem", UIBaseNode)
local base = UIBaseNode
local eAvgContentType = require("Game.Avg.Enum.eAvgContentType")
UINAvgRecordItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINAvgRecordItem.InitAvgRecordItem = function(self, avgSystem, recordData, isLast)
  -- function num : 0_1 , upvalues : _ENV, eAvgContentType
  local avgCtrl = avgSystem.avgCtrl
  local actCfg = avgCtrl:GetAcgActCfg(recordData.actId)
  if actCfg.content then
    local content = avgCtrl:GetAvgLanguage(actCfg.content)
  end
  if actCfg.branch ~= nil then
    for k,v in ipairs(actCfg.branch) do
      local isSeleted = recordData.selectedActId ~= nil and recordData.selectedActId == v.jumpAct
      local str = avgCtrl:GetAvgLanguage(v.content)
      str = ((self.ui).tex_Content):GetIndex(isSeleted and 1 or 0, tostring(k), str)
      if (string.IsNullOrEmpty)(content) then
        content = str
      else
        content = content .. "\n" .. str
      end
    end
  end
  ;
  ((self.ui).tex_Content):SetText(content)
  local heroName = nil
  if actCfg.contentType == eAvgContentType.HeroDialog then
    heroName = avgSystem:GetAvgSpeakerName(actCfg.speakerHeroId)
  elseif actCfg.contentType == eAvgContentType.NarratageWithSpeaker then
    heroName = avgCtrl:GetAvgLanguage(actCfg.speakerName)
  end
  if (string.IsNullOrEmpty)(heroName) then
    (((self.ui).tex_Hero).gameObject):SetActive(false)
  else
    (((self.ui).tex_Hero).gameObject):SetActive(true)
    ;
    ((self.ui).tex_Hero):SetIndex(0, heroName)
  end
  ;
  ((self.ui).img_Tag):SetActive(isLast)
  -- DECOMPILER ERROR: 10 unprocessed JMP targets
end

UINAvgRecordItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINAvgRecordItem


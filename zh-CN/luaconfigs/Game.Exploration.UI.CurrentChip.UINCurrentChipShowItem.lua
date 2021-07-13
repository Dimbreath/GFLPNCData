-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCurrentChipShowItem = class("UINCurrentChipShowItem", UIBaseNode)
local base = UIBaseNode
local UINDungeonInfoChipDetailTag = require("Game.CommonUI.DungeonState.Info.UINDungeonInfoChipDetailTag")
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
UINCurrentChipShowItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINDungeonInfoChipDetailTag, UINChipItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.tagPool = (UIItemPool.New)(UINDungeonInfoChipDetailTag, (self.ui).obj_tagItem)
  ;
  ((self.ui).obj_tagItem):SetActive(false)
  self.chipItem = (UINChipItem.New)()
  ;
  (self.chipItem):Init((self.ui).uINChipItem)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Intro, self, self.OnClickIntro)
end

UINCurrentChipShowItem.InitChipShow = function(self, chipData, ShowRichIntroFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.chipData = chipData
  self.ShowRichIntroFunc = ShowRichIntroFunc
  local qualityColor = ItemQualityColor[chipData:GetQuality()]
  ;
  (self.tagPool):HideAll()
  for _,tagId in ipairs(((self.chipData).chipCfg).fun_tag) do
    local chipTagCfg = (ConfigData.chip_tag)[tagId]
    local item = (self.tagPool):GetOne(true)
    item:InitTagItem(chipTagCfg, qualityColor)
  end
  for i,v in ipairs((self.ui).img_arr) do
    v.color = qualityColor
  end
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Description).text = (self.chipData):GetChipDescription()
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_name).text = (self.chipData):GetName()
  ;
  (self.chipItem):InitChipItem(chipData, false, nil, true)
  local tab = {}
  if #((self.chipData).chipCfg).skill_list > 0 then
    local skillId = (((self.chipData).chipCfg).skill_list)[1]
    local labelDic = ((ConfigData.battle_skill).skill_label_Dic)[skillId]
    if labelDic ~= nil then
      for id,unlockLevel in pairs(labelDic) do
        (table.insert)(tab, id)
      end
    end
  end
  do
    self.uiIntroData = {}
    -- DECOMPILER ERROR at PC86: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self.uiIntroData).skillLabeIdList = tab
    ;
    (((self.ui).btn_Intro).gameObject):SetActive(#tab > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
end

UINCurrentChipShowItem.OnClickIntro = function(self)
  -- function num : 0_2
  if #(self.uiIntroData).skillLabeIdList <= 0 then
    return 
  end
  if self.ShowRichIntroFunc ~= nil then
    (self.ShowRichIntroFunc)(self)
  end
end

return UINCurrentChipShowItem


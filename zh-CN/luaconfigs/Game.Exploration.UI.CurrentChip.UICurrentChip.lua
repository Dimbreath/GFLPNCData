-- params : ...
-- function num : 0 , upvalues : _ENV
local UICurrentChip = class("UICurrentChip", UIBaseWindow)
local base = UIBaseWindow
local UINCurrentChipCareerItem = require("Game.Exploration.UI.CurrentChip.UINCurrentChipCareerItem")
local UINCurrentChipShowItem = require("Game.CommonUI.Chip.UINBaseChipDetail")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local cs_resLoader = CS.ResLoader
local cs_Edge = ((CS.UnityEngine).RectTransform).Edge
UICurrentChip.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_resLoader, UINCurrentChipCareerItem, UINCurrentChipShowItem
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnClickCloseCurrentChip)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Bg, self, self.OnClickCloseCurrentChip)
  self.resloader = (cs_resLoader.Create)()
  self.careerItemPool = (UIItemPool.New)(UINCurrentChipCareerItem, (self.ui).obj_careerItem)
  ;
  ((self.ui).obj_careerItem):SetActive(false)
  self.showItemPool = (UIItemPool.New)(UINCurrentChipShowItem, (self.ui).obj_chipItem)
  ;
  ((self.ui).obj_chipItem):SetActive(false)
  self.__OnSelectCareerTag = BindCallback(self, self.OnSelectCareerTag)
end

UICurrentChip.InitCurrentChip = function(self, chipDataList)
  -- function num : 0_1 , upvalues : _ENV, ChipEnum
  (UIUtil.Push2BackStack)(self, self.Delete)
  ;
  (UIUtil.HideTopStatus)()
  self.careerChipDataDic = {}
  for _,chipData in ipairs(chipDataList) do
    local key = nil
    if (chipData.chipCfg).influence == (ChipEnum.eChipInfluenceType).Career then
      key = (chipData.chipCfg).arg
    else
      key = 0
    end
    local list = (self.careerChipDataDic)[key]
    if list == nil then
      list = {}
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.careerChipDataDic)[key] = list
    end
    ;
    (table.insert)(list, chipData)
  end
  for _,list in pairs(self.careerChipDataDic) do
    (table.sort)(list, function(a, b)
    -- function num : 0_1_0
    local aCount = a:GetCount()
    local bCount = b:GetCount()
    if bCount >= aCount then
      do return aCount == bCount end
      do return (a.chipCfg).id < (b.chipCfg).id end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
)
  end
  ;
  (self.careerItemPool):HideAll()
  local tags = {}
  for careerId,_ in pairs(self.careerChipDataDic) do
    (table.insert)(tags, careerId)
  end
  ;
  (table.sort)(tags, function(a, b)
    -- function num : 0_1_1
    if a == 0 then
      return false
    end
    if b == 0 then
      return true
    end
    do return a < b end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for _,careerId in ipairs(tags) do
    local item = (self.careerItemPool):GetOne()
    item:InitCareerTag(careerId, (table.count)((self.careerChipDataDic)[careerId]), self.__OnSelectCareerTag)
  end
  ;
  (((self.careerItemPool).listItem)[1]):Select(true)
end

UICurrentChip.OnSelectCareerTag = function(self, careerTag, flag)
  -- function num : 0_2 , upvalues : _ENV
  if not flag then
    return 
  end
  local selectCareerId = careerTag.careerId
  for _,v in ipairs((self.careerItemPool).listItem) do
    v:SetSelectState()
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).scrollbar).value = 1
  ;
  (self.showItemPool):HideAll()
  local chipDataList = (self.careerChipDataDic)[selectCareerId]
  for index,chipData in ipairs(chipDataList) do
    local item = (self.showItemPool):GetOne()
    item:InitBaseChipDetail(index, chipData, nil, self.resloader)
  end
end

UICurrentChip.OnClickCloseCurrentChip = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (UIUtil.OnClickBack)()
end

UICurrentChip.SetCurrentChipCloseFunc = function(self, func)
  -- function num : 0_4
  self.closeFunc = func
end

UICurrentChip.OnHide = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if ExplorationManager:GetDynPlayer() == nil then
    UIManager:ShowWindowOnly(UIWindowTypeID.TopStatus)
  end
end

UICurrentChip.OnDelete = function(self)
  -- function num : 0_6 , upvalues : _ENV, base
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  local window = UIManager:GetWindow(UIWindowTypeID.RichIntro)
  if window ~= nil then
    window:Delete()
  end
  if self.closeFunc ~= nil then
    (self.closeFunc)()
  end
  ;
  (base.OnDelete)(self)
end

return UICurrentChip


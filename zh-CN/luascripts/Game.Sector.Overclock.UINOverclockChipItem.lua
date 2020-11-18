-- params : ...
-- function num : 0 , upvalues : _ENV
local UINOverclockChipItem = class("UINOverclockChipItem", UIBaseNode)
local base = UIBaseNode
UINOverclockChipItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.OverclockCtrl = ControllerManager:GetController(ControllerTypeId.Overclock, false)
  self.clickCallback = nil
  self.isSelected = false
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_sortChipKindItem, self, self.OnChipItemClick)
end

UINOverclockChipItem.InitChipItem = function(self, data, clickCallback)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).img_ChipPic).sprite = CRH:GetSprite(data:GetIcon())
  self.data = data
  if (self.OverclockCtrl):IsChipUnlock(data.dataId) then
    self.clickCallback = clickCallback
  else
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_ChipPic).color = (self.ui).color_gray
  end
end

UINOverclockChipItem.OnChipItemClick = function(self)
  -- function num : 0_2
  if self.clickCallback ~= nil then
    local transform = ((self.ui).trs_sortChipKindItem).transform
    ;
    (self.clickCallback)(self, transform)
  end
end

UINOverclockChipItem.SetSelect = function(self, bool)
  -- function num : 0_3
  ((self.ui).obj_img_OnSelect):SetActive(bool)
  self.isSelected = bool
end

UINOverclockChipItem.GetName = function(self)
  -- function num : 0_4
  return (self.data):GetName()
end

UINOverclockChipItem.GetDes = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local des = nil
  local chipCfg = (self.data).chipCfg
  if #chipCfg.skill_list > 0 then
    local skillId = (chipCfg.skill_list)[1]
    local skillCfg = (((CS.GameData).instance).listBattleSkillDatas):GetDataById(skillId)
    if skillCfg == nil then
      error("Can\'t find skillCfg, id = " .. tostring(skillId))
    else
      des = skillCfg:GetLevelDescribe(1)
    end
  else
    do
      if #chipCfg.attribute_id > 0 then
        local attrId = (chipCfg.attribute_id)[1]
        local initValue = (chipCfg.attribute_initial)[1]
        local fluenceIntro = ConfigData:GetChipinfluenceIntro(chipCfg.id)
        local increaseVal = (chipCfg.level_increase)[1]
        local attrInfo = (BattleUtil.GetChipAttrInfo)(attrId, initValue, increaseVal, 1)
        des = fluenceIntro .. attrInfo
      else
        do
          des = ""
          return des
        end
      end
    end
  end
end

UINOverclockChipItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINOverclockChipItem


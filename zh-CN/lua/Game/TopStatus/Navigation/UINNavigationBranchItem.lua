local UINNavigationBranchItem = class("UINNavigationBranchItem", UIBaseNode)
local base = UIBaseNode
local UINNavigationBranchBtn = require("Game.TopStatus.Navigation.UINNavigationBranchBtn")
UINNavigationBranchItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.branchBtnItemDic = {}
end

UINNavigationBranchItem.InitNavigationBranchItem = function(self, navigation_mainCfg, resloader)
  -- function num : 0_1 , upvalues : _ENV
  self.navigation_mainCfg = navigation_mainCfg
  self.resloader = resloader
  self:GenAllButtons(navigation_mainCfg)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(navigation_mainCfg.name)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_NameEn).text = navigation_mainCfg.name_en
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.transform).gameObject).name = navigation_mainCfg.name_en
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).enabled = false
  ;
  (self.resloader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath("UI_NavigationBar"), function(spriteAtlas)
    -- function num : 0_1_0 , upvalues : self, navigation_mainCfg
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = spriteAtlas:GetSprite(navigation_mainCfg.img)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).enabled = true
  end
)
end

UINNavigationBranchItem.GenAllButtons = function(self, navigation_mainCfg)
  -- function num : 0_2 , upvalues : _ENV, UINNavigationBranchBtn
  local isFirst = true
  for index,sub_id in ipairs(navigation_mainCfg.sub_id) do
    local navigation_subCfg = (ConfigData.navigation_sub)[sub_id]
    if navigation_subCfg == nil then
      error("can\'t get navigation_subCfg with sub_id" .. tostring(sub_id))
    else
      if (self.branchBtnItemDic)[sub_id] == nil then
        local item = (UINNavigationBranchBtn.New)()
        if isFirst then
          item:Init((self.ui).obj_subNavBranchItem)
          isFirst = false
        else
          local go = ((self.ui).obj_subNavBranchItem):Instantiate()
          item:Init(go)
        end
        do
          do
            do
              -- DECOMPILER ERROR at PC40: Confused about usage of register: R10 in 'UnsetPending'

              ;
              (self.branchBtnItemDic)[sub_id] = item
              ;
              ((self.branchBtnItemDic)[sub_id]):InitNavigationBranchBtn(navigation_subCfg, self.resloader, index)
              -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
end

UINNavigationBranchItem.RefreshAllNBB = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for sub_id,NBB in pairs(self.branchBtnItemDic) do
    NBB:RefreshNBBIsUnlock()
  end
end

UINNavigationBranchItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : _ENV, base
  for sub_id,NBB in pairs(self.branchBtnItemDic) do
    NBB:Delete()
  end
  ;
  (base.OnDelete)(self)
end

UINNavigationBranchItem.SetIconParent = function(self, parent)
  -- function num : 0_5
  (((self.ui).img_Icon).transform):SetParent(parent, true)
end

return UINNavigationBranchItem


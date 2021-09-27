local UIHeadSortNode = class("UIHeadSortNode", UIBaseNode)
local base = UIBaseNode
local UIHeadSortNodeItem = require("Game.User.Dialogs.UIHeadSortNodeItem")
UIHeadSortNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIHeadSortNodeItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.CloseWindow)
  ;
  ((self.ui).tog_SortItem):SetActive(false)
  self.itemPool = (UIItemPool.New)(UIHeadSortNodeItem, (self.ui).tog_SortItem)
  self.isHead = true
  self.lastChoose = 0
end

UIHeadSortNode.InitSortList = function(self, showList, lastChoose)
  -- function num : 0_1 , upvalues : _ENV
  self.lastChoose = lastChoose
  ;
  (self.itemPool):HideAll()
  if showList ~= nil then
    self.showList = showList
  end
  self.typeNum = {}
  if self.isHead then
    for k,v in pairs((ConfigData.portrait).types) do
      (table.insert)(self.typeNum, k)
    end
  else
    do
      for k,v in pairs((ConfigData.portrait_frame).types) do
        (table.insert)(self.typeNum, k)
      end
      do
        ;
        (table.sort)(self.typeNum, function(a, b)
    -- function num : 0_1_0
    do return a < b end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
        for k,val in ipairs(self.typeNum) do
          if (self.isHead and ((ConfigData.portrait).typeCount)[val] > 0) or not self.isHead and ((ConfigData.portrait_frame).typeCount)[val] > 0 then
            local item = (self.itemPool):GetOne()
            item:InitNodeItemCId(val, self.isHead)
            item.changeValueFunc = self.changeValueFunc
          end
        end
        for idx,item in pairs((self.itemPool).listItem) do
          if (table.count)(self.typeNum) > 0 and self.lastChoose == 0 then
            item:SelectActivityTag(0)
            self.lastChoose = 1
          else
            item:SelectActivityTag(self.lastChoose - 1)
          end
        end
      end
    end
  end
end

UIHeadSortNode.ShowWindow = function(self)
  -- function num : 0_2
  (self.gameObject):SetActive(true)
end

UIHeadSortNode.CloseWindow = function(self)
  -- function num : 0_3
  if self.BackFun ~= nil then
    (self.BackFun)()
  end
  ;
  (self.itemPool):HideAll()
  ;
  (self.gameObject):SetActive(false)
end

UIHeadSortNode.OnDelte = function(self)
  -- function num : 0_4 , upvalues : base
  (self.itemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UIHeadSortNode


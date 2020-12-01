-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCampBondItem = class("UINCampBondItem", UIBaseNode)
local base = UIBaseNode
UINCampBondItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.OnClickRoot)
  self.countImgWidth = (((self.ui).img_HeroCount).sizeDelta).x
end

UINCampBondItem.InitCampBondItem = function(self, campId, count, clickEvent)
  -- function num : 0_1 , upvalues : _ENV
  self.campId = campId
  self.count = count
  self.clickEvent = clickEvent
  ;
  ((self.ui).img_CampBG):SetIndex(campId - 1)
  ;
  ((self.ui).img_Camp):SetIndex(campId - 1)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_HeroCount).text = tostring(count)
  local size = ((self.ui).img_HeroCount).sizeDelta
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_HeroCount).sizeDelta = (Vector2.New)(self.countImgWidth * count, size.y)
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).infoCanvas).alpha = count > 0 and 1 or 0.3
  local campCfg = (ConfigData.camp)[campId]
  if campCfg == nil then
    error("Can\'t get campCfg, campId = " .. tostring(campId))
    return 
  end
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_CampName).text = (LanguageUtil.GetLocaleText)(campCfg.name)
end

UINCampBondItem.OnClickRoot = function(self)
  -- function num : 0_2
  if self.clickEvent ~= nil then
    (self.clickEvent)(self)
  end
end

UINCampBondItem.GetCampBondItemIdCount = function(self)
  -- function num : 0_3
  return self.campId, self.count
end

UINCampBondItem.CampBondItemDetailTween = function(self, isShow, showHolder, completeFunc)
  -- function num : 0_4 , upvalues : _ENV
  self:__ClearTween()
  ;
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
  if isShow then
    self.lastPos = (self.transform).position
    self.lastParent = (self.transform).parent
    self.lastIndex = (self.transform):GetSiblingIndex()
    ;
    (self.transform):SetParent(showHolder)
    if (self.lastPos).x - (showHolder.position).x >= 0.02 or not 0 then
      local duration = (self.ui).tweenDuration
    end
    ;
    ((self.transform):DOMove(showHolder.position, duration)):OnComplete(function()
    -- function num : 0_4_0 , upvalues : _ENV, completeFunc
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    if completeFunc ~= nil then
      completeFunc()
    end
  end
)
  else
    do
      ;
      ((self.transform):DOMove(self.lastPos, (self.ui).tweenDuration)):OnComplete(function()
    -- function num : 0_4_1 , upvalues : self, _ENV, completeFunc
    (self.transform):SetParent(self.lastParent)
    ;
    (self.transform):SetSiblingIndex(self.lastIndex)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    if completeFunc ~= nil then
      completeFunc()
    end
  end
)
    end
  end
end

UINCampBondItem.__ClearTween = function(self)
  -- function num : 0_5
  (self.transform):DOKill(true)
end

UINCampBondItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  self:__ClearTween()
  ;
  (base.OnDelete)(self)
end

return UINCampBondItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCampBondItem = class("UINCampBondItem", UIBaseNode)
local base = UIBaseNode
UINCampBondItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.OnClickRoot)
    self.countImgWidth = (((self.ui).img_HeroCount).sizeDelta).x
end

UINCampBondItem.InitCampBondItem = function(self, campId, count, clickEvent)
    -- function num : 0_1 , upvalues : _ENV
    self.campId = campId
    self.count = count
    self.clickEvent = clickEvent;
    ((self.ui).img_CampBG):SetIndex(campId - 1);
    ((self.ui).img_Camp):SetIndex(campId - 1) -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).tex_HeroCount).text = tostring(count)
    local size = ((self.ui).img_HeroCount).sizeDelta -- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.ui).img_HeroCount).sizeDelta =
        (Vector2.New)(self.countImgWidth * count, size.y) -- DECOMPILER ERROR at PC39: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.ui).infoCanvas).alpha = count > 0 and 1 or 0.3
    local campCfg = (ConfigData.camp)[campId]
    if campCfg == nil then
        error("Can\'t get campCfg, campId = " .. tostring(campId))
        return
    end -- DECOMPILER ERROR at PC59: Confused about usage of register: R6 in 'UnsetPending'
    
    ((self.ui).tex_CampName).text = (LanguageUtil.GetLocaleText)(campCfg.name)
end

UINCampBondItem.OnClickRoot = function(self)
    -- function num : 0_2
    if self.clickEvent ~= nil then (self.clickEvent)(self) end
end

UINCampBondItem.GetCampBondItemIdCount =
    function(self)
        -- function num : 0_3
        return self.campId, self.count
    end

UINCampBondItem.CampBondItemDetailTween =
    function(self, isShow, showHolder, completeFunc)
        -- function num : 0_4 , upvalues : _ENV
        self:__ClearTween();
        (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil,
                                                                          nil,
                                                                          nil,
                                                                          Color.clear,
                                                                          false)
        if isShow then
            self.lastPos = (self.transform).position
            self.lastParent = (self.transform).parent
            self.lastIndex = (self.transform):GetSiblingIndex();
            (self.transform):SetParent(showHolder)
            if (self.lastPos).x - (showHolder.position).x >= 0.02 or not 0 then
                local duration = (self.ui).tweenDuration
            end
            ((self.transform):DOMove(showHolder.position, duration)):OnComplete(
                function()
                    -- function num : 0_4_0 , upvalues : _ENV, completeFunc
                    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
                    if completeFunc ~= nil then
                        completeFunc()
                    end
                end)
        else
            do

                ((self.transform):DOMove(self.lastPos, (self.ui).tweenDuration)):OnComplete(
                    function()
                        -- function num : 0_4_1 , upvalues : self, _ENV, completeFunc
                        (self.transform):SetParent(self.lastParent);
                        (self.transform):SetSiblingIndex(self.lastIndex)
                        UIManager:HideWindow(UIWindowTypeID.ClickContinue)
                        if completeFunc ~= nil then
                            completeFunc()
                        end
                    end)
            end
        end
    end

UINCampBondItem.__ClearTween = function(self)
    -- function num : 0_5
    (self.transform):DOKill(true)
end

UINCampBondItem.OnDelete = function(self)
    -- function num : 0_6 , upvalues : base
    self:__ClearTween();
    (base.OnDelete)(self)
end

return UINCampBondItem


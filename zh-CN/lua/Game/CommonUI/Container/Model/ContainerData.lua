local ContainerData = class("ContainerData")
ContainerData.ctor = function(self)
  -- function num : 0_0
  self.imgCount = 0
  self.imgPath = nil
  self.urlType = 1
  self.urlValue = nil
end

ContainerData.Init = function(self, imgPath, urlType, urlValue)
  -- function num : 0_1
  self.imgPath = imgPath
  self.urlType = urlType
  self.urlValue = urlValue
end

ContainerData.GetUrl = function(self)
  -- function num : 0_2
  return self.urlValue, self.urlType
end

return ContainerData


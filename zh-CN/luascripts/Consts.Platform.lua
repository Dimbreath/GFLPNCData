-- params : ...
-- function num : 0 , upvalues : _ENV
local cs_platform = ((CS.UnityEngine).Application).platform
PlatformType = {Windows = 1, Mac = 2, Android = 3, iOS = 4}
if cs_platform == 11 then
    Platform = PlatformType.Android
else
    if cs_platform == 8 then
        Platform = PlatformType.iOS
    else
        if cs_platform == 0 or cs_platform == 1 then
            Platform = PlatformType.Mac
        else
            Platform = PlatformType.Windows
        end
    end
end


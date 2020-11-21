-- params : ...
-- function num : 0 , upvalues : _ENV
local cs_unity_object = (CS.UnityEngine).Object
IsNull = function(unity_object)
    -- function num : 0_0 , upvalues : _ENV
    if unity_object == nil then return true end
    if type(unity_object) == "userdata" and unity_object.IsNull ~= nil then
        return unity_object:IsNull()
    end
    return false
end

DestroyUnityObject = function(obj, immediate)
    -- function num : 0_1 , upvalues : _ENV, cs_unity_object
    if IsNull(obj) then return end
    if not immediate then immediate = false end
    if immediate then
        (cs_unity_object.DestroyImmediate)(obj)
    else

        (cs_unity_object.Destroy)(obj)
    end
end


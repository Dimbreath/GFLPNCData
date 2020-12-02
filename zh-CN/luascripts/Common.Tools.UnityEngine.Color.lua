-- params : ...
-- function num : 0 , upvalues : _ENV
local rawget = rawget
local setmetatable = setmetatable
local type = type
local Mathf = Mathf
local Color = {}
local _getter = {}
local unity_color = (CS.UnityEngine).Color
Color.__index = function(t, k)
  -- function num : 0_0 , upvalues : rawget, Color, _getter, unity_color
  local var = rawget(Color, k)
  if var ~= nil then
    return var
  end
  var = rawget(_getter, k)
  if var ~= nil then
    return var(t)
  end
  return rawget(unity_color, k)
end

Color.__call = function(t, r, g, b, a)
  -- function num : 0_1 , upvalues : setmetatable, Color
  return setmetatable({r = r or 0, g = g or 0, b = b or 0, a = a or 1}, Color)
end

Color.New = function(r, g, b, a)
  -- function num : 0_2 , upvalues : setmetatable, Color
  return setmetatable({r = r or 0, g = g or 0, b = b or 0, a = a or 1}, Color)
end

Color.Set = function(self, r, g, b, a)
  -- function num : 0_3
  self.r = r
  self.g = g
  self.b = b
  self.a = a or 1
end

Color.Get = function(self)
  -- function num : 0_4
  return self.r, self.g, self.b, self.a
end

Color.Equals = function(self, other)
  -- function num : 0_5
  do return self.r == other.r and self.g == other.g and self.b == other.b and self.a == other.a end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Color.Lerp = function(a, b, t)
  -- function num : 0_6 , upvalues : Mathf, Color
  t = (Mathf.Clamp01)(t)
  return (Color.New)(a.r + t * (b.r - a.r), a.g + t * (b.g - a.g), a.b + t * (b.b - a.b), a.a + t * (b.a - a.a))
end

Color.LerpUnclamped = function(a, b, t)
  -- function num : 0_7 , upvalues : Color
  return (Color.New)(a.r + t * (b.r - a.r), a.g + t * (b.g - a.g), a.b + t * (b.b - a.b), a.a + t * (b.a - a.a))
end

Color.HSVToRGB = function(H, S, V, hdr)
  -- function num : 0_8 , upvalues : Color, Mathf
  if hdr then
    hdr = true
    local white = (Color.New)(1, 1, 1, 1)
    if S == 0 then
      white.r = V
      white.g = V
      white.b = V
      return white
    end
    if V == 0 then
      white.r = 0
      white.g = 0
      white.b = 0
      return white
    end
    white.r = 0
    white.g = 0
    white.b = 0
    local num = S
    local num2 = V
    local f = H * 6
    local num4 = (Mathf.Floor)(f)
    local num5 = f - num4
    local num6 = num2 * (1 - num)
    local num7 = num2 * (1 - num * num5)
    local num8 = num2 * (1 - num * (1 - num5))
    local num9 = num4
    local flag = num9 + 1
    if flag == 0 then
      white.r = num2
      white.g = num6
      white.b = num7
    else
      if flag == 1 then
        white.r = num2
        white.g = num8
        white.b = num6
      else
        if flag == 2 then
          white.r = num7
          white.g = num2
          white.b = num6
        else
          if flag == 3 then
            white.r = num6
            white.g = num2
            white.b = num8
          else
            if flag == 4 then
              white.r = num6
              white.g = num7
              white.b = num2
            else
              if flag == 5 then
                white.r = num8
                white.g = num6
                white.b = num2
              else
                if flag == 6 then
                  white.r = num2
                  white.g = num6
                  white.b = num7
                else
                  if flag == 7 then
                    white.r = num2
                    white.g = num8
                    white.b = num6
                  end
                end
              end
            end
          end
        end
      end
    end
    if not hdr then
      white.r = (Mathf.Clamp)(white.r, 0, 1)
      white.g = (Mathf.Clamp)(white.g, 0, 1)
      white.b = (Mathf.Clamp)(white.b, 0, 1)
    end
    return white
  end
end

local RGBToHSVHelper = function(offset, dominantcolor, colorone, colortwo)
  -- function num : 0_9
  local V = dominantcolor
  if V ~= 0 then
    local num = 0
    if colortwo < colorone then
      num = colortwo
    else
      num = colorone
    end
    local num2 = V - num
    local H = 0
    local S = 0
    if num2 ~= 0 then
      S = num2 / V
      H = offset + (colorone - colortwo) / num2
    else
      S = 0
      H = offset + (colorone - colortwo)
    end
    H = (H) / 6
    if H < 0 then
      H = H + 1
    end
    return H, S, V
  end
  do
    return 0, 0, V
  end
end

Color.RGBToHSV = function(rgbColor)
  -- function num : 0_10 , upvalues : RGBToHSVHelper
  if rgbColor.g < rgbColor.b and rgbColor.r < rgbColor.b then
    return RGBToHSVHelper(4, rgbColor.b, rgbColor.r, rgbColor.g)
  else
    if rgbColor.r < rgbColor.g then
      return RGBToHSVHelper(2, rgbColor.g, rgbColor.b, rgbColor.r)
    else
      return RGBToHSVHelper(0, rgbColor.r, rgbColor.g, rgbColor.b)
    end
  end
end

Color.GrayScale = function(a)
  -- function num : 0_11
  return 0.299 * a.r + 0.587 * a.g + 0.114 * a.b
end

Color.__tostring = function(self)
  -- function num : 0_12 , upvalues : _ENV
  return (string.format)("RGBA(%f,%f,%f,%f)", self.r, self.g, self.b, self.a)
end

Color.__add = function(a, b)
  -- function num : 0_13 , upvalues : Color
  return (Color.New)(a.r + b.r, a.g + b.g, a.b + b.b, a.a + b.a)
end

Color.__sub = function(a, b)
  -- function num : 0_14 , upvalues : Color
  return (Color.New)(a.r - b.r, a.g - b.g, a.b - b.b, a.a - b.a)
end

Color.__mul = function(a, b)
  -- function num : 0_15 , upvalues : type, Color, _ENV
  if type(b) == "number" then
    return (Color.New)(a.r * b, a.g * b, a.b * b, a.a * b)
  else
    if getmetatable(b) == Color then
      return (Color.New)(a.r * b.r, a.g * b.g, a.b * b.b, a.a * b.a)
    end
  end
end

Color.__div = function(a, d)
  -- function num : 0_16 , upvalues : Color
  return (Color.New)(a.r / d, a.g / d, a.b / d, a.a / d)
end

Color.__eq = function(a, b)
  -- function num : 0_17
  do return a.r == b.r and a.g == b.g and a.b == b.b and a.a == b.a end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

_getter.red = function()
  -- function num : 0_18 , upvalues : Color
  return (Color.New)(1, 0, 0, 1)
end

_getter.green = function()
  -- function num : 0_19 , upvalues : Color
  return (Color.New)(0, 1, 0, 1)
end

_getter.blue = function()
  -- function num : 0_20 , upvalues : Color
  return (Color.New)(0, 0, 1, 1)
end

_getter.white = function()
  -- function num : 0_21 , upvalues : Color
  return (Color.New)(1, 1, 1, 1)
end

_getter.black = function()
  -- function num : 0_22 , upvalues : Color
  return (Color.New)(0, 0, 0, 1)
end

_getter.yellow = function()
  -- function num : 0_23 , upvalues : Color
  return (Color.New)(1, 0.9215686, 0.01568628, 1)
end

_getter.cyan = function()
  -- function num : 0_24 , upvalues : Color
  return (Color.New)(0, 1, 1, 1)
end

_getter.magenta = function()
  -- function num : 0_25 , upvalues : Color
  return (Color.New)(1, 0, 1, 1)
end

_getter.gray = function()
  -- function num : 0_26 , upvalues : Color
  return (Color.New)(0.5, 0.5, 0.5, 1)
end

_getter.clear = function()
  -- function num : 0_27 , upvalues : Color
  return (Color.New)(0, 0, 0, 0)
end

_getter.gamma = function(c)
  -- function num : 0_28 , upvalues : Color, Mathf
  return (Color.New)((Mathf.LinearToGammaSpace)(c.r), (Mathf.LinearToGammaSpace)(c.g), (Mathf.LinearToGammaSpace)(c.b), c.a)
end

_getter.linear = function(c)
  -- function num : 0_29 , upvalues : Color, Mathf
  return (Color.New)((Mathf.GammaToLinearSpace)(c.r), (Mathf.GammaToLinearSpace)(c.g), (Mathf.GammaToLinearSpace)(c.b), c.a)
end

_getter.maxColorComponent = function(c)
  -- function num : 0_30 , upvalues : Mathf
  return (Mathf.Max)((Mathf.Max)(c.r, c.g), c.b)
end

_getter.grayscale = Color.GrayScale
Color.unity_color = (CS.UnityEngine).Color
-- DECOMPILER ERROR at PC78: Confused about usage of register: R8 in 'UnsetPending'

;
(CS.UnityEngine).Color = Color
setmetatable(Color, Color)
return Color


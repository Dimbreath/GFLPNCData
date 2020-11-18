-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt00_tutorial_18 = {
[1] = {content = 10, contentType = 2}
, 
[2] = {content = 20, contentType = 2}
, 
[3] = {content = 30, contentType = 2}
, 
[4] = {
images = {
{imgId = 1, imgPath = "persicaria_avg", imgType = 3, 
pos = {-475, -310, 0}
, 
scale = {1.7, 1.7, 1.7}
, alpha = 0.1, order = 2}
}
, 
imgTween = {
{imgId = 1, duration = 0.5, 
pos = {-400, -310, 0}
, alpha = 1}
}
, content = 40, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[5] = {
images = {
{imgId = 2, imgPath = "sol", imgType = 3, 
pos = {600, -400, 0}
, 
scale = {1.45, 1.45, 1.45}
, alpha = 0.2, order = 1}
}
, 
imgTween = {
{imgId = 2, duration = 0.5, 
pos = {500, -400, 0}
, alpha = 1}
, 
{imgId = 1, isDark = true}
}
, content = 50, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[6] = {
imgTween = {
{imgId = 2, isDark = true}
, 
{imgId = 1, isDark = false}
}
, content = 60, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
branch = {
{content = 91, jumpAct = 10}
, 
{content = 92, jumpAct = 10}
}
}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[11] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 2, isDark = false}
}
, content = 110, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[13] = {
imgTween = {
{imgId = 2, isDark = true}
, 
{imgId = 1, isDark = false}
}
, content = 130, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[14] = {
images = {
{imgId = 9, imgPath = "cpt00/cpt00_e_bg001", imgType = 4, fullScreen = true, alpha = 0}
}
, 
imgTween = {
{imgId = 1, duration = 0.7, alpha = 0}
, 
{imgId = 2, duration = 0.7, alpha = 0}
, 
{imgId = 1, delay = 0.7, duration = 0.1, 
pos = {0, -310, 0}
}
, 
{imgId = 1, delay = 0.7, duration = 0.7, alpha = 1}
, 
{imgId = 9, duration = 0.7, alpha = 1}
, 
{imgId = 9, delay = 0.7, duration = 0.8, alpha = 0}
}
, content = 140, contentType = 3, speakerHeroId = 1001}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 1001}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 1001}
}
return AvgCfg_cpt00_tutorial_18


-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt00_e_01_03 = {
[1] = {
images = {
{imgId = 5, imgPath = "cpt00/cpt00_e_bg001", imgType = 2, fullScreen = true, alpha = 0}
}
, 
imgTween = {
{imgId = 5, duration = 0.7, alpha = 0.4}
, 
{imgId = 5, delay = 0.7, duration = 0.7, alpha = 0}
, 
{imgId = 5, delay = 1.4, duration = 0.7, alpha = 0.6}
, 
{imgId = 5, delay = 2.1, duration = 0.7, alpha = 0.3}
, 
{imgId = 5, delay = 2.8, duration = 1, alpha = 1}
}
, content = 10, contentType = 3, speakerHeroId = 1001, 
audio = {
bgm = {stop = true, cue = "", sheet = "Music"}
}
}
, 
[2] = {
images = {
{imgId = 4, imgPath = "cpt00/cpt00_e_bg001", imgType = 2, fullScreen = true}
}
, vedioPath = "avg/cpt00_pv", 
effect = {
effect1 = {prefabName = "avg/ui_avg"}
}
, autoContinue = true}
, 
[3] = {
images = {
{imgId = 5, delete = true}
}
, content = 30, contentType = 3, speakerHeroId = 1001}
, 
[4] = {content = 40, contentType = 3, speakerHeroId = 1001}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 1001}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = 1005}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 1003}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 1005}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 1001}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1005}
, 
[11] = {content = 110, contentType = 3, speakerHeroId = 1001}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 1001, 
branch = {
{content = 121, jumpAct = 13}
}
}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 1001, 
audio = {
bgm = {cue = "Mus_Story_Relax", sheet = "Music"}
}
}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 1003, 
branch = {
{content = 141, jumpAct = 15}
}
}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 1003}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 1001}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1001, 
branch = {
{content = 171, jumpAct = 18}
}
}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 1001}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 1001}
, 
[20] = {content = 200, contentType = 2}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 1005}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 1001, 
branch = {
{content = 221, jumpAct = 23}
}
}
, 
[23] = {content = 230, contentType = 2}
, 
[24] = {content = 240, contentType = 2}
, 
[25] = {
images = {
{imgId = 1, imgPath = "sol", imgType = 3, 
pos = {-270, -400, 0}
, 
scale = {1.45, 1.45, 1.45}
, alpha = 0.2, order = 1}
, 
{imgId = 2, imgPath = "persicaria_avg", imgType = 3, 
pos = {400, -310, 0}
, 
scale = {-1.7, 1.7, 1.7}
, alpha = 0.2, order = 2}
}
, 
imgTween = {
{imgId = 1, duration = 0.8, alpha = 1}
, 
{imgId = 2, duration = 0.8, alpha = 1, isDark = true}
}
, content = 250, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
ppv = {
cg = {saturation = -80}
}
}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[27] = {content = 270, contentType = 2}
, 
[28] = {
imgTween = {
{imgId = 4, duration = 1, alpha = 0}
}
, content = 280, contentType = 2, 
effect = {
stopList = {"effect1"}
, 
effect2 = {prefabName = "avg/fxp_avg-screen", layer = 1}
}
}
, 
[29] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 2, isDark = false}
}
, content = 290, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
ppv = {
cg = {saturation = 0}
}
}
, 
[30] = {
imgTween = {
{imgId = 2, isDark = true}
, 
{imgId = 1, isDark = false}
}
, content = 300, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[31] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 2, isDark = false}
}
, content = 310, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[33] = {
imgTween = {
{imgId = 2, isDark = true}
, 
{imgId = 1, isDark = false}
}
, content = 330, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[35] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 2, isDark = false}
}
, content = 350, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[38] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 2, isDark = true}
}
, content = 380, contentType = 2}
, 
[39] = {
images = {
{imgId = 3, imgPath = "croque_avg", imgType = 3, 
pos = {-380, -300, 0}
, 
scale = {-1.55, 1.55, 1.55}
, order = 0}
}
, 
imgTween = {
{imgId = 1, alpha = 0}
}
, content = 390, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[41] = {
imgTween = {
{imgId = 3, isDark = true}
, 
{imgId = 2, isDark = false}
}
, content = 410, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[42] = {
imgTween = {
{imgId = 2, isDark = true}
, 
{imgId = 3, isDark = false}
}
, content = 420, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[43] = {
imgTween = {
{imgId = 3, isDark = true}
, 
{imgId = 2, isDark = false}
}
, content = 430, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[45] = {
imgTween = {
{imgId = 3, alpha = 0}
, 
{imgId = 1, alpha = 1, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 450, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[46] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 2, isDark = false}
}
, content = 460, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[47] = {
imgTween = {
{imgId = 2, isDark = true}
, 
{imgId = 1, isDark = false}
}
, content = 470, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[48] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 2, isDark = false}
}
, content = 480, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
branch = {
{content = 481, jumpAct = 49}
, 
{content = 482, jumpAct = 50}
}
}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, nextId = 51}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[52] = {
imgTween = {
{imgId = 1, alpha = 0}
, 
{imgId = 3, alpha = 1, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 520, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[53] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 530, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[54] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 540, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[55] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 550, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
}
return AvgCfg_cpt00_e_01_03


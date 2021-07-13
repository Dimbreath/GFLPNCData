-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt00_e_01_03 = {
[1] = {content = 10, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
images = {
{imgId = 1, imgType = 2, alpha = 0, imgPath = "cpt00/cpt00_e_bg001", fullScreen = true}
, 
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt00/cpt00_e_bg005", fullScreen = true}
, 
{imgId = 3, imgType = 2, alpha = 0, imgPath = "cpt00/cpt00_e_bg007_2", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 105, imgType = 3, alpha = 0, imgPath = "croque_avg"}
, 
{imgId = 114, imgType = 3, alpha = 0, imgPath = "shadow_avg"}
}
, 
imgTween = {
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {stop = false, cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 3, fadeOut = 3}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, nextId = 114}
, 
[3] = {content = 30, contentType = 4, speakerName = 31, autoContinue = true, scrambleTypeWriter = true, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 1, delay = 0, duration = 1, alpha = 0.75, isDark = false}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[4] = {content = 40, contentType = 4, speakerName = 31, scrambleTypeWriter = true, 
imgTween = {
{imgId = 1, delay = 0, duration = 3, alpha = 1, isDark = false}
}
}
, 
[5] = {content = 50, contentType = 4, speakerName = 31, scrambleTypeWriter = true}
, 
[6] = {vedioPath = "avg/cpt00_pv", 
vedioAudio = {cue = "GF_YT_PV", sheet = "GF_YT_PV"}
, 
effect = {
effect1 = {prefabName = "avg/ui_avg"}
}
, autoContinue = true, customCode = "AvgUtil.ShowMainCamera(false)"}
, 
[7] = {
effect = {
stopList = {"effect1"}
, 
effect2 = {prefabName = "avg/fxp_avg-screen", layer = 1}
}
, 
ppv = {
cg = {saturation = -100}
}
, content = 70, contentType = 4, speakerName = 32, customCode = "AvgUtil.ShowMainCamera(true)", nextId = 100, 
imgTween = {
{imgId = 1, delay = 0, duration = 1, alpha = 0.25, isDark = false}
}
}
, 
[8] = {content = 80, contentType = 4, speakerName = 32, nextId = 101}
, 
[9] = {content = 90, contentType = 4, speakerName = 32}
, 
[10] = {content = 100, contentType = 4, speakerName = 32}
, 
[11] = {content = 110, contentType = 4, speakerName = 32}
, 
[12] = {content = 120, contentType = 4, speakerName = 32}
, 
[13] = {content = 130, contentType = 4, speakerName = 32}
, 
[14] = {content = 140, contentType = 4, speakerName = 141}
, 
[15] = {content = 150, contentType = 4, speakerName = 142}
, 
[16] = {content = 160, contentType = 4, speakerName = 32}
, 
[17] = {content = 170, contentType = 4, speakerName = 32}
, 
[18] = {content = 180, contentType = 4, speakerName = 142}
, 
[19] = {content = 190, contentType = 4, speakerName = 141, contentShake = true}
, 
[20] = {content = 200, contentType = 4, speakerName = 31, scrambleTypeWriter = true}
, 
[21] = {content = 210, contentType = 4, speakerName = 31, scrambleTypeWriter = true, nextId = 23}
, 
[22] = {content = 220, contentType = 4, speakerName = 31, scrambleTypeWriter = true}
, 
[23] = {content = 230, contentType = 4, speakerName = 32}
, 
[24] = {content = 240, contentType = 4, speakerName = 31, scrambleTypeWriter = true}
, 
[25] = {content = 250, contentType = 4, speakerName = 31, scrambleTypeWriter = true, 
imgTween = {
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 1, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 1, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 1, delay = 0, duration = 1, alpha = 0, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[26] = {bgColor = 2, content = 260, contentType = 4, speakerName = 31, scrambleTypeWriter = true, 
ppv = {
cg = {saturation = -100}
}
, 
imgTween = {
{imgId = 3, delay = 0, duration = 0.6, alpha = 1, isDark = false}
}
, 
effect = {
stopList = {"effect2"}
}
}
, 
[27] = {content = 270, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.6, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.6, posId = 4, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {stop = false, cue = "Mus_YT_Story_Quiet", sheet = "Music", fadeIn = 3, fadeOut = 3}
}
, 
ppv = {
cg = {saturation = 0}
}
}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[30] = {content = 300, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false, 
rot = {0, 180, 0}
}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[34] = {autoContinue = true, contentShake = true, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, 
audio = {
sfx = {cue = "Atk_Chong_02", sheet = "Mon_Chong"}
}
}
, 
[35] = {content = 350, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {stop = false, cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 3, fadeOut = 3}
}
, 
heroFace = {
{imgId = 103, faceId = 4}
}
}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 103, faceId = 3}
}
}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 6}
}
}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[44] = {content = 440, contentType = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 3, delay = 0, duration = 0.3, alpha = 0, isDark = false}
, 
{imgId = 2, delay = 0, duration = 0.3, alpha = 1, isDark = false}
, 
{imgId = 114, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 114, delay = 0.6, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
}
, 
[45] = {content = 450, contentType = 2, 
imgTween = {
{imgId = 114, delay = 0, duration = 0.6, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_RunStep", sheet = "AVG_gf"}
}
}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.6, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 2, delay = 0, duration = 0.3, alpha = 0, isDark = false}
, 
{imgId = 3, delay = 0, duration = 0.3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, nextId = 111, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, nextId = 112, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
, isEnd = true}
, 
[100] = {
branch = {
{content = 71, jumpAct = 8}
}
, nextId = 8}
, 
[101] = {
branch = {
{content = 81, jumpAct = 9}
}
, nextId = 9}
, 
[111] = {
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, nextId = 49, 
branch = {
{content = 481, jumpAct = 49}
}
}
, 
[112] = {nextId = 50, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
branch = {
{content = 491, jumpAct = 50}
}
}
, 
[114] = {nextId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
branch = {
{content = 583, jumpAct = 3}
}
}
}
return AvgCfg_cpt00_e_01_03


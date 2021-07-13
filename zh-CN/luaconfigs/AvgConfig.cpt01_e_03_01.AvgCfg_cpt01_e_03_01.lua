-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt01_e_03_01 = {
[1] = {bgColor = 2, content = 10, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
images = {
{imgId = 1, imgType = 2, alpha = 0, imgPath = "cpt01/cpt01_e_bg003", fullScreen = true}
, 
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt01/cpt01_e_bg001", fullScreen = true}
, 
{imgId = 3, imgType = 2, alpha = 0, imgPath = "cpt01/cpt01_e_bg002", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 105, imgType = 3, alpha = 0, imgPath = "croque_avg"}
, 
{imgId = 6, imgType = 3, alpha = 0, imgPath = "turing_avg"}
, 
{imgId = 11, imgType = 3, alpha = 0, imgPath = "42lab_npc_01_avg"}
, 
{imgId = 102, imgType = 3, alpha = 0, imgPath = "anna_hood_avg"}
}
, 
imgTween = {
{imgId = 1, delay = 0, duration = 0.3, alpha = 1}
, 
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false, 
rot = {0, 180, 0}
}
, 
{imgId = 105, delay = 0, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {stop = false, cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 3, fadeOut = 3}
}
, 
heroFace = {
{imgId = 105, faceId = 6}
}
}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[3] = {content = 30, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
}
, 
[4] = {content = 40, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.6, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 0}
, 
{imgId = 101, faceId = 0}
, 
{imgId = 103, faceId = 6}
}
}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 0}
}
}
, 
[7] = {autoContinue = true, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 1, delay = 0, duration = 0.6, alpha = 0, isDark = false}
}
, 
audio = {
bgm = {stop = true, cue = "Mus_Story_BattleTension", sheet = "Music"}
, 
sfx = {cue = "AVG_RunStep", sheet = "AVG_gf"}
}
}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
imgTween = {
{imgId = 3, delay = 0, duration = 0.3, alpha = 1, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0.3, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {stop = false, cue = "Mus_YT_Story_Quiet", sheet = "Music", fadeIn = 3, fadeOut = 3}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[11] = {content = 110, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_BaseDoor_Open", sheet = "AVG_gf"}
}
}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 3, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 6, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 1, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[15] = {autoContinue = true, content = 150, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[16] = {content = 160, contentType = 2, contentShake = true, 
imgTween = {
{imgId = 103, delay = 0, duration = 1, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_body_fall", sheet = "AVG"}
}
}
, 
[17] = {content = 170, contentType = 2}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, contentShake = true, 
imgTween = {
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 6, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[21] = {autoContinue = true, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 3, delay = 0, duration = 0.6, alpha = 0, isDark = false}
}
}
, 
[22] = {content = 220, contentType = 2, 
imgTween = {
{imgId = 3, delay = 0, duration = 0.6, alpha = 1, isDark = false}
}
}
, 
[23] = {content = 230, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2, 
imgTween = {
{imgId = 6, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[27] = {content = 270, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[30] = {content = 300, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 1, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 1}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[35] = {content = 350, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[37] = {autoContinue = true, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 3, delay = 0, duration = 0.6, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_footsteps_cave", sheet = "AVG_gf"}
}
}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2, 
imgTween = {
{imgId = 3, delay = 0, duration = 0.3, alpha = 1, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 1, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = true}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 11, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 11, speakerHeroPosId = 3}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 1, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 6, delay = 0, duration = 0, posId = 1, alpha = 1, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[43] = {content = 430, contentType = 2, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
}
}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 11, speakerHeroPosId = 2, 
imgTween = {
{imgId = 11, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[56] = {content = 560, contentType = 2, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
}
}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2}
, 
[59] = {content = 590, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 1}
}
}
, 
[60] = {content = 600, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[61] = {content = 610, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 1}
, 
[62] = {content = 620, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 1}
, 
[63] = {content = 630, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, nextId = 200}
, 
[64] = {content = 650, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 1, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, nextId = 201}
, 
[65] = {content = 670, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 1, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[66] = {content = 680, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[67] = {content = 690, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 1, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[68] = {content = 700, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[69] = {content = 710, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[70] = {content = 720, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[71] = {content = 730, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 1, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[72] = {content = 740, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[73] = {content = 750, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 1, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[74] = {content = 760, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[75] = {content = 770, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 1, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[76] = {content = 780, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 1}
, 
[77] = {content = 790, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[78] = {content = 800, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[79] = {content = 810, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 1, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[80] = {content = 820, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 1}
}
}
, 
[81] = {content = 830, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 1, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[82] = {content = 840, contentType = 2, contentShake = true, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
audio = {
sfx = {cue = "AVG_ClothingUp", sheet = "AVG_gf"}
}
}
, 
[83] = {content = 850, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[84] = {autoContinue = true, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 1, posId = 3, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 1, duration = 2, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_RunStep", sheet = "AVG_gf"}
, 
bgm = {stop = true}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[85] = {content = 870, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 6}
}
}
, 
[86] = {content = 880, contentType = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[87] = {content = 890, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
audio = {
bgm = {stop = false, cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 3, fadeOut = 3}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[88] = {content = 900, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[89] = {content = 910, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 6, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[90] = {content = 920, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[91] = {content = 930, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 3, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[92] = {content = 940, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[93] = {content = 950, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[94] = {content = 960, contentType = 3, speakerHeroId = 11, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {stop = true, cue = "Mus_Story_BattleTension", sheet = "Music"}
, 
sfx = {cue = "AVG_BaseDoor_Open", sheet = "AVG_gf"}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[95] = {content = 970, contentType = 3, speakerHeroId = 11, speakerHeroPosId = 2}
, 
[96] = {autoContinue = true, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 3, delay = 0, duration = 0.6, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_RunStep", sheet = "AVG_gf"}
}
}
, 
[97] = {content = 990, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 3, delay = 0, duration = 0.3, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[98] = {content = 1000, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[99] = {content = 1010, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {stop = false, cue = "Mus_YT_Story_Quiet", sheet = "Music", fadeIn = 3, fadeOut = 3}
}
}
, 
[100] = {content = 1020, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[101] = {content = 1030, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[102] = {content = 1040, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[103] = {content = 1050, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
heroFace = {
{imgId = 103, faceId = 5}
}
}
, 
[104] = {content = 1060, contentType = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 103, faceId = 0}
}
}
, 
[105] = {content = 1070, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[106] = {content = 1080, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[107] = {content = 1090, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[108] = {content = 1100, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
, 
{imgId = 101, faceId = 0}
}
}
, 
[109] = {content = 1110, contentType = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
}
}
, 
[110] = {content = 1120, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[111] = {content = 1130, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[112] = {content = 1140, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[113] = {content = 1150, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[114] = {content = 1160, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[115] = {autoContinue = true, 
imgTween = {
{imgId = 3, delay = 0, duration = 0.6, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[116] = {content = 1180, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 3, delay = 0, duration = 0.3, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[117] = {content = 1190, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 6, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[118] = {content = 1200, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[119] = {content = 1210, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[120] = {content = 1220, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[121] = {content = 1230, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[122] = {content = 1240, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2}
, 
[123] = {content = 1250, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[124] = {content = 1260, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[125] = {content = 1270, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[126] = {content = 1280, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[127] = {content = 1290, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[128] = {content = 1300, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2}
, 
[129] = {content = 1310, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2}
, 
[130] = {content = 1320, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[131] = {content = 1330, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[132] = {content = 1340, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[133] = {content = 1350, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2}
, 
[134] = {content = 1360, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2}
, 
[135] = {content = 1370, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2}
, 
[136] = {content = 1380, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[137] = {content = 1390, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[138] = {content = 1400, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[139] = {content = 1410, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[140] = {content = 1420, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[141] = {content = 1430, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[142] = {content = 1440, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 6, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[143] = {content = 1450, contentType = 2, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.6, posId = 3, alpha = 0, isDark = false}
}
}
, 
[144] = {content = 1460, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[145] = {content = 1470, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[146] = {content = 1480, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[147] = {content = 1490, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[148] = {content = 1500, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[149] = {content = 1510, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[150] = {content = 1520, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[151] = {content = 1530, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[152] = {content = 1540, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[153] = {content = 1550, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2}
, 
[154] = {content = 1560, contentType = 3, speakerHeroId = 11, speakerHeroPosId = 3, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 11, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[155] = {content = 1570, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 1, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[156] = {content = 1580, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[157] = {content = 1590, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[158] = {content = 1600, contentType = 2, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
, 
{imgId = 3, delay = 0, duration = 2, alpha = 1, isDark = true}
}
, 
audio = {
bgm = {stop = true, cue = "Mus_YT_Story_Quiet", sheet = "Music"}
}
}
, 
[159] = {content = 1610, contentType = 2, 
imgTween = {
{imgId = 3, delay = 0, duration = 1, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0.3, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_BaseDoor_Close", sheet = "AVG_gf"}
}
, isEnd = true}
, 
[200] = {
branch = {
{content = 1612, jumpAct = 64}
}
, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[201] = {
branch = {
{content = 1613, jumpAct = 65}
}
, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, nextId = 65}
}
return AvgCfg_cpt01_e_03_01


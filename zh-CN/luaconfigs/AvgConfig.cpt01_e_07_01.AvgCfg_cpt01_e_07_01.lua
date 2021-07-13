-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt01_e_07_01 = {
[1] = {bgColor = 2, content = 10, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
images = {
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt01/cpt01_e_bg004", fullScreen = true}
, 
{imgId = 3, imgType = 2, alpha = 0, imgPath = "cpt01/cpt01_e_bg005", fullScreen = true}
, 
{imgId = 4, imgType = 2, alpha = 0, imgPath = "cpt01/cpt01_e_cg004", fullScreen = true}
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
, 
{imgId = 16, imgType = 3, alpha = 0, imgPath = "faith_avg"}
}
, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.3, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false, 
rot = {0, 180, 0}
}
, 
{imgId = 105, delay = 0.6, duration = 0.3, posId = 3, alpha = 1, isDark = false}
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
[2] = {content = 20, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
, 
{imgId = 103, faceId = 6}
}
}
, 
[3] = {content = 30, contentType = 4, speakerName = 31, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_body_fall", sheet = "AVG"}
}
, 
heroFace = {
{imgId = 103, faceId = 0}
}
}
, 
[4] = {content = 40, contentType = 4, speakerName = 31}
, 
[5] = {content = 50, contentType = 4, speakerName = 31}
, 
[6] = {content = 60, contentType = 4, speakerName = 31, 
audio = {
sfx = {cue = "AVG_Explode", sheet = "AVG_gf"}
}
}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false, 
rot = {0, 180, 0}
}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 1, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 1, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
, 
{imgId = 103, faceId = 3}
}
}
, 
[11] = {content = 110, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
, 
{imgId = 103, faceId = 0}
}
}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
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
, 
{imgId = 103, faceId = 3}
}
}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 103, faceId = 0}
}
}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 11, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
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
[21] = {content = 210, contentType = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 2, duration = 0.3, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {stop = false, cue = "Mus_Story_Passion", sheet = "Music", fadeIn = 3, fadeOut = 3}
, 
sfx = {cue = "AVG_digital_typing", sheet = "AVG"}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[23] = {content = 230, contentType = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 4, delay = 1, duration = 0.6, alpha = 1, isDark = false}
}
, 
audio = {
sfx = {cue = "Skill_Sol_01", sheet = "Chara_Sol"}
}
}
, 
[24] = {content = 240, contentType = 4, speakerName = 241}
, 
[25] = {content = 250, contentType = 4, speakerName = 251}
, 
[26] = {content = 260, contentType = 4, speakerName = 241}
, 
[27] = {content = 270, contentType = 4, speakerName = 241}
, 
[28] = {content = 280, contentType = 4, speakerName = 241, contentShake = true}
, 
[29] = {content = 290, contentType = 4, speakerName = 251}
, 
[30] = {content = 300, contentType = 4, speakerName = 241}
, 
[31] = {content = 310, contentType = 2}
, 
[32] = {content = 320, contentType = 4, speakerName = 241}
, 
[33] = {content = 330, contentType = 4, speakerName = 241}
, 
[34] = {autoContinue = true, 
imgTween = {
{imgId = 4, delay = 0, duration = 0.6, alpha = 0, isDark = false}
}
}
, 
[35] = {content = 350, contentType = 2}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
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
[38] = {content = 380, contentType = 4, speakerName = 381, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[39] = {content = 390, contentType = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 16, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 1, duration = 0.6, posId = 3, alpha = 1, isDark = false}
, 
{imgId = 2, delay = 0, duration = 0.3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {stop = false, cue = "Mus_Story_Purifier", sheet = "Music", fadeIn = 3, fadeOut = 3}
}
, 
heroFace = {
{imgId = 103, faceId = 0}
, 
{imgId = 105, faceId = 0}
}
}
, 
[40] = {content = 400, contentType = 2, 
audio = {
sfx = {cue = "AVG_body_fall", sheet = "AVG"}
}
}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.6, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 11, speakerHeroPosId = 2, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[46] = {content = 460, contentType = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 11, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 2, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 11, speakerHeroPosId = 2, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 1, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 11, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 103, faceId = 4}
}
}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 16, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 0}
}
}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 11, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[59] = {content = 590, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
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
[60] = {content = 600, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[61] = {content = 610, contentType = 3, speakerHeroId = 12, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[62] = {content = 620, contentType = 3, speakerHeroId = 7, speakerHeroPosId = 2, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[63] = {content = 630, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[64] = {content = 640, contentType = 3, speakerHeroId = 12, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[65] = {content = 650, contentType = 3, speakerHeroId = 12, speakerHeroPosId = 2}
, 
[66] = {content = 660, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[67] = {content = 670, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[68] = {content = 680, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[69] = {content = 690, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[70] = {content = 700, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[71] = {content = 710, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[72] = {content = 720, contentType = 3, speakerHeroId = 12, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[73] = {content = 730, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[74] = {content = 740, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[75] = {content = 750, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[76] = {content = 760, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[77] = {content = 770, contentType = 3, speakerHeroId = 12, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[78] = {content = 780, contentType = 3, speakerHeroId = 7, speakerHeroPosId = 2, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[79] = {content = 790, contentType = 2, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[80] = {content = 800, contentType = 3, speakerHeroId = 7, speakerHeroPosId = 2, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[81] = {content = 810, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[82] = {content = 820, contentType = 3, speakerHeroId = 7, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[83] = {content = 830, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[84] = {content = 840, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[85] = {content = 850, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[86] = {content = 860, contentType = 3, speakerHeroId = 12, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[87] = {content = 870, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[88] = {content = 880, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[89] = {content = 890, contentType = 3, speakerHeroId = 12, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[90] = {content = 900, contentType = 3, speakerHeroId = 7, speakerHeroPosId = 2, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.3, posId = 3, alpha = 1, isDark = false}
}
}
, 
[91] = {content = 910, contentType = 2}
, 
[92] = {content = 920, contentType = 2}
, 
[93] = {content = 930, contentType = 2}
, 
[94] = {content = 940, contentType = 2, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[95] = {content = 950, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, contentShake = true, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 6}
}
, 
audio = {
bgm = {stop = false, cue = "Mus_Story_Passion", sheet = "Music", fadeIn = 3, fadeOut = 3}
}
}
, 
[96] = {content = 960, contentType = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 0}
}
, 
audio = {
sfx = {cue = "Skill_Sol_Ex_End", sheet = "Chara_Sol"}
}
}
, 
[97] = {content = 970, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false, shake = true}
}
}
, 
[98] = {content = 980, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 6}
}
}
, 
[99] = {content = 990, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, contenShake = true}
, 
[100] = {content = 1000, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
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
[101] = {content = 1010, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[102] = {content = 1020, contentType = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 0}
, 
{imgId = 101, faceId = 0}
}
}
, 
[103] = {content = 1030, contentType = 2, 
audio = {
sfx = {cue = "Skill_Persicaria_Ex_Start", sheet = "Chara_Persicaria"}
}
}
, 
[104] = {content = 1040, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[105] = {content = 1050, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[106] = {content = 1060, contentType = 3, speakerHeroId = 12, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[107] = {content = 1070, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
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
[108] = {content = 1080, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
heroFace = {
{imgId = 105, faceId = 1}
}
}
, 
[109] = {content = 1090, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[110] = {content = 1100, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 0}
, 
{imgId = 105, faceId = 0}
}
}
, 
[111] = {content = 1110, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[112] = {content = 1120, contentType = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[113] = {content = 1130, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = true}
, 
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
[114] = {content = 1140, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[115] = {content = 1150, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 6}
, 
{imgId = 101, faceId = 0}
}
}
}
return AvgCfg_cpt01_e_07_01


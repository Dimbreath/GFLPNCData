-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt04_e_04_01 = {
[1] = {bgColor = 2, content = 10, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
images = {
{imgId = 1, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg001", fullScreen = true}
, 
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg002", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 105, imgType = 3, alpha = 0, imgPath = "croque_avg"}
, 
{imgId = 112, imgType = 3, alpha = 0, imgPath = "max_avg"}
, 
{imgId = 27, imgType = 3, alpha = 0, imgPath = "adele_avg"}
, 
{imgId = 30, imgType = 3, alpha = 0, imgPath = "gabriel_avg"}
}
, 
imgTween = {
{imgId = 1, delay = 0, duration = 0.6, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 1, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0.6, duration = 0.6, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = true}
, 
{imgId = 112, delay = 0.6, duration = 0.6, posId = 4, alpha = 1, isDark = true}
}
, 
audio = {
bgm = {cue = "Mus_Story_Creepy", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 112, faceId = 1}
}
}
, 
[3] = {content = 30, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 27, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 27, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[4] = {content = 40, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 2, 
imgTween = {
{imgId = 27, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 2}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 2, 
imgTween = {
{imgId = 27, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false, shakeIntensity = 2}
}
, 
audio = {
sfx = {cue = "AVG_whitenoise", sheet = "AVG_gf"}
}
}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 2, autoContinue = true, 
imgTween = {
{imgId = 27, delay = 0, duration = 0.3, posId = 3, alpha = 1, isDark = true, shake = true}
, 
{imgId = 27, delay = 0.3, duration = 0.3, posId = 3, alpha = 0, isDark = true}
}
}
, 
[8] = {content = 80, contentType = 3, contentShake = true, speakerHeroId = 1012, speakerHeroPosId = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0.6, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 112, faceId = 0}
}
}
, 
[9] = {content = 90, contentType = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_body_fall", sheet = "AVG"}
}
}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
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
[11] = {content = 110, contentType = 5, tipsTypeWriter = true, tipsShowDuration = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, 
audio = {
sfx = {cue = "AVG_digital_typing", sheet = "AVG"}
}
}
, 
[12] = {content = 120, contentType = 5, tipsTypeWriter = true, tipsShowDuration = 1}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.6, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 112, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0.6, posId = 4, alpha = 1, isDark = false}
}
}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[15] = {content = 150, contentType = 4, speakerName = 11, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[17] = {content = 170, contentType = 5, tipsTypeWriter = true, tipsShowDuration = 1, 
audio = {
sfx = {cue = "AVG_digital_typing", sheet = "AVG"}
}
}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[20] = {content = 200, contentType = 4, speakerName = 13, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
}
, 
audio = {
sfx = {cue = "AVG_whitenoise", sheet = "AVG_gf"}
}
}
, 
[21] = {content = 210, contentType = 4, speakerName = 13}
, 
[22] = {content = 220, contentType = 4, speakerName = 13, scrambleTypeWriter = true}
, 
[23] = {content = 230, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 4}
}
}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[27] = {content = 270, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 103, faceId = 3}
}
}
, 
[28] = {contentShake = true, autoContinue = true, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
}
, 
audio = {
sfx = {cue = "Atk_Simo_01", sheet = "Chara_Simo"}
, 
bgm = {stop = true}
}
}
, 
[29] = {content = 290, contentType = 4, speakerName = 12}
, 
[30] = {content = 300, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true, 
rot = {0, 180, 0}
}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 103, faceId = 4}
}
}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 105, faceId = 6}
}
}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[33] = {content = 330, contentType = 4, speakerName = 12, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 1, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_Purifier", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
heroFace = {
{imgId = 30, faceId = 3}
}
}
, 
[34] = {content = 340, contentType = 4, speakerName = 12, 
heroFace = {
{imgId = 30, faceId = 0}
}
}
, 
[35] = {content = 350, contentType = 2, contentShake = true, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.6, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "Atk_Xin_02", sheet = "Mon_Xin"}
}
}
, 
[36] = {content = 360, contentType = 2, contentShake = true, 
audio = {
sfx = {cue = "Atk_Simo_01", sheet = "Chara_Simo"}
}
}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
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
[38] = {content = 380, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 30, faceId = 0}
}
}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 4}
}
}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, contentShake = true, 
heroFace = {
{imgId = 103, faceId = 6}
}
}
, 
[42] = {content = 420, contentType = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "Atk_Simo_01", sheet = "Chara_Simo"}
}
}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.6, posId = 3, alpha = 1, shake = true, shakeIntensity = 2, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 30, faceId = 1}
}
}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
heroFace = {
{imgId = 30, faceId = 4}
}
}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
heroFace = {
{imgId = 30, faceId = 5}
}
}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 1}
}
}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
branch = {
{content = 501, jumpAct = 51}
, 
{content = 502, jumpAct = 53}
}
, 
heroFace = {
{imgId = 30, faceId = 3}
}
}
, 
[51] = {content = 510, contentType = 4, speakerName = 11, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, nextId = 55, 
heroFace = {
{imgId = 30, faceId = 5}
}
}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
heroFace = {
{imgId = 30, faceId = 1}
}
}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.6, posId = 3, alpha = 1, shake = true, shakeIntensity = 2, isDark = false}
}
, 
heroFace = {
{imgId = 30, faceId = 5}
}
}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.6, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.6, posId = 4, alpha = 1, shake = true, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_Passion", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
heroFace = {
{imgId = 105, faceId = 6}
}
}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 112, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 112, faceId = 0}
}
}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, shake = true, isDark = false}
}
}
}
return AvgCfg_cpt04_e_04_01


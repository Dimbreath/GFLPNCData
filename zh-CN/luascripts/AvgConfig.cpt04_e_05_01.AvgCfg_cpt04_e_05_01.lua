-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt04_e_05_01 = {
[1] = {
heroFace = {
{imgId = 105, faceId = 6}
}
, content = 10, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
images = {
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg001", fullScreen = true}
, 
{imgId = 3, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg005", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 105, imgType = 3, alpha = 0, imgPath = "croque_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 112, imgType = 3, alpha = 0, imgPath = "max_avg"}
, 
{imgId = 26, imgType = 3, alpha = 0, imgPath = "beelneith_avg"}
, 
{imgId = 30, imgType = 3, alpha = 0, imgPath = "gabriel_avg"}
, 
{imgId = 4, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg001_2", fullScreen = true}
, 
{imgId = 1, imgType = 1, alpha = 1, imgPath = "cpt00/cpt00_e_bg001", fullScreen = true}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
imgTween = {
{imgId = 105, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.6, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.6, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 2, delay = 0, duration = 0.2, alpha = 1}
}
}
, 
[2] = {
heroFace = {
{imgId = 103, faceId = 4}
}
, content = 20, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[3] = {content = 30, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[4] = {
heroFace = {
{imgId = 101, faceId = 4}
}
, content = 40, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
branch = {
{content = 1411, jumpAct = 5}
}
}
, 
[5] = {content = 60, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[6] = {content = 70, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[7] = {
heroFace = {
{imgId = 30, faceId = 4}
}
, content = 80, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.6, posId = 3, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
}
}
, 
[8] = {content = 90, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[9] = {content = 100, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[10] = {content = 110, contentType = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[11] = {content = 120, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[12] = {
heroFace = {
{imgId = 30, faceId = 0}
}
, content = 130, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[13] = {content = 140, contentType = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[14] = {contentShake = true, autoContinue = true, 
audio = {
bgm = {stop = true}
, 
sfx = {cue = "Atk_Abstinence_01", sheet = "Mon_Abstinence"}
}
}
, 
[15] = {content = 160, contentType = 4, speakerName = 12}
, 
[16] = {content = 170, contentType = 2, contentShake = true}
, 
[17] = {
heroFace = {
{imgId = 30, faceId = 4}
}
, content = 180, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[18] = {
heroFace = {
{imgId = 26, faceId = 1}
}
, content = 190, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[19] = {content = 200, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
audio = {
bgm = {cue = "Mus_Story_Purifier", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
imgTween = {
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[20] = {content = 210, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[21] = {content = 220, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[22] = {content = 230, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[23] = {
heroFace = {
{imgId = 30, faceId = 5}
}
, content = 240, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[24] = {
heroFace = {
{imgId = 26, faceId = 6}
}
, content = 250, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[25] = {
heroFace = {
{imgId = 26, faceId = 4}
}
, content = 260, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[26] = {
heroFace = {
{imgId = 26, faceId = 1}
}
, content = 270, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[27] = {
heroFace = {
{imgId = 30, faceId = 3}
}
, content = 280, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[28] = {
heroFace = {
{imgId = 26, faceId = 0}
}
, content = 290, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[29] = {
heroFace = {
{imgId = 30, faceId = 0}
}
, content = 300, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[30] = {
heroFace = {
{imgId = 30, faceId = 4}
}
, content = 310, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[31] = {content = 320, contentType = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[32] = {content = 330, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
imgTween = {
{imgId = 26, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[33] = {content = 340, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[34] = {content = 350, contentType = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[35] = {
heroFace = {
{imgId = 103, faceId = 5}
}
, content = 360, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[36] = {content = 370, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[37] = {
heroFace = {
{imgId = 101, faceId = 4}
}
, content = 380, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[38] = {
heroFace = {
{imgId = 26, faceId = 6}
}
, content = 390, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 26, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[39] = {content = 400, contentType = 2, contentShake = true, 
audio = {
sfx = {cue = "Atk_Abstinence_01", sheet = "Mon_Abstinence"}
}
, 
imgTween = {
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[40] = {content = 410, contentType = 2, contentShake = true, 
audio = {
sfx = {cue = "Atk_Abstinence_01", sheet = "Mon_Abstinence"}
}
}
, 
[41] = {content = 420, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
imgTween = {
{imgId = 26, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[42] = {
heroFace = {
{imgId = 26, faceId = 4}
}
, content = 430, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[43] = {
heroFace = {
{imgId = 26, faceId = 0}
}
, content = 440, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[44] = {
heroFace = {
{imgId = 101, faceId = 0}
}
, content = 450, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[45] = {content = 460, contentType = 2, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
, 
sfx = {cue = "AVG_Alarm", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.6, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 2, delay = 0, duration = 0.6, alpha = 0, isDark = false}
, 
{imgId = 4, delay = 0, duration = 0.6, alpha = 1, isDark = false}
}
}
, 
[46] = {
heroFace = {
{imgId = 101, faceId = 4}
}
, content = 470, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[47] = {
heroFace = {
{imgId = 30, faceId = 3}
}
, content = 480, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[48] = {content = 490, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[49] = {content = 500, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[50] = {
heroFace = {
{imgId = 30, faceId = 4}
}
, content = 510, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[51] = {content = 520, contentType = 2}
, 
[52] = {
heroFace = {
{imgId = 30, faceId = 0}
}
, content = 530, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[53] = {content = 540, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[54] = {content = 550, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[55] = {content = 560, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[56] = {
heroFace = {
{imgId = 26, faceId = 6}
}
, content = 570, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[57] = {content = 580, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[58] = {content = 590, contentType = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.6, posId = 3, alpha = 0, isDark = false}
}
}
, 
[59] = {
heroFace = {
{imgId = 26, faceId = 4}
}
, content = 600, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
imgTween = {
{imgId = 26, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[60] = {content = 610, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[61] = {
heroFace = {
{imgId = 26, faceId = 0}
}
, content = 620, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[62] = {
heroFace = {
{imgId = 26, faceId = 1}
}
, content = 630, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[63] = {
heroFace = {
{imgId = 26, faceId = 0}
}
, content = 640, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[64] = {
heroFace = {
{imgId = 26, faceId = 1}
}
, content = 650, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[65] = {content = 660, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[66] = {
heroFace = {
{imgId = 26, faceId = 6}
}
, content = 670, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[67] = {
heroFace = {
{imgId = 26, faceId = 1}
}
, content = 680, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[68] = {content = 690, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[69] = {
heroFace = {
{imgId = 101, faceId = 4}
}
, content = 700, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[70] = {
heroFace = {
{imgId = 101, faceId = 0}
}
, content = 710, contentType = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[71] = {
heroFace = {
{imgId = 103, faceId = 5}
}
, content = 720, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[72] = {
heroFace = {
{imgId = 103, faceId = 0}
}
, content = 730, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[73] = {
heroFace = {
{imgId = 101, faceId = 5}
}
, content = 740, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[74] = {
heroFace = {
{imgId = 103, faceId = 0}
}
, content = 750, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[75] = {content = 760, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[76] = {content = 770, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[77] = {
heroFace = {
{imgId = 101, faceId = 0}
}
, content = 780, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[78] = {content = 790, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[79] = {
heroFace = {
{imgId = 101, faceId = 5}
}
, content = 800, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[80] = {content = 810, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 112, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[81] = {
heroFace = {
{imgId = 112, faceId = 3}
}
, content = 820, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[82] = {content = 830, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[83] = {content = 840, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[84] = {
heroFace = {
{imgId = 103, faceId = 4}
}
, content = 850, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[85] = {content = 860, contentType = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
}
}
, 
[86] = {content = 870, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[87] = {
heroFace = {
{imgId = 112, faceId = 3}
}
, content = 880, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[88] = {
heroFace = {
{imgId = 112, faceId = 0}
}
, content = 890, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[89] = {
heroFace = {
{imgId = 103, faceId = 0}
}
, content = 900, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[90] = {
heroFace = {
{imgId = 112, faceId = 1}
}
, content = 910, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[91] = {
heroFace = {
{imgId = 101, faceId = 0}
}
, content = 920, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[92] = {content = 930, contentType = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
}
}
, 
[93] = {
heroFace = {
{imgId = 105, faceId = 0}
}
, content = 940, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[94] = {
heroFace = {
{imgId = 101, faceId = 4}
}
, content = 950, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[95] = {content = 960, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[96] = {content = 970, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[97] = {content = 980, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[98] = {content = 990, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[99] = {content = 1000, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[100] = {
heroFace = {
{imgId = 101, faceId = 5}
}
, content = 1010, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[101] = {content = 1020, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[102] = {
heroFace = {
{imgId = 103, faceId = 0}
}
, content = 1030, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[103] = {content = 1040, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[104] = {content = 1050, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[105] = {content = 1060, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[106] = {autoContinue = true, 
audio = {
bgm = {stop = true}
}
, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 4, delay = 0, duration = 0.6, alpha = 0, isDark = false}
}
}
, 
[107] = {content = 1080, contentType = 4, speakerName = 1081, speakerHeroId = 1, speakerHeroPosId = 2, tipsTypeWriter = true, 
images = {
{imgId = 112, delete = true}
, 
{imgId = 102, imgType = 3, alpha = 0, imgPath = "anna_avg"}
}
, 
audio = {
bgm = {cue = "Mus_Story_Creepy", sheet = "Music", fadeIn = 2, fadeOut = 3}
, 
sfx = {cue = "AVG_whitenoise", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 3, delay = 0, duration = 1, alpha = 0.4, isDark = false}
}
}
, 
[108] = {content = 1090, contentType = 4, speakerName = 1081, speakerHeroId = 1, speakerHeroPosId = 2, tipsTypeWriter = true}
, 
[109] = {
heroFace = {
{imgId = 102, faceId = 5}
}
, content = 1100, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[110] = {content = 1110, contentType = 4, speakerName = 1081, speakerHeroId = 1, speakerHeroPosId = 2, tipsTypeWriter = true, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[111] = {content = 1120, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[112] = {content = 1130, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[113] = {content = 1140, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[114] = {content = 1150, contentType = 4, speakerName = 1081, speakerHeroId = 1, speakerHeroPosId = 2, tipsTypeWriter = true, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[115] = {content = 1160, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[116] = {content = 1170, contentType = 4, speakerName = 1171, speakerHeroId = 29, speakerHeroPosId = 2, tipsTypeWriter = true, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[117] = {content = 1180, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[118] = {content = 1190, contentType = 4, speakerName = 1171, speakerHeroId = 29, speakerHeroPosId = 2, tipsTypeWriter = true, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[119] = {content = 1200, contentType = 4, speakerName = 1171, speakerHeroId = 29, speakerHeroPosId = 2, tipsTypeWriter = true}
, 
[120] = {content = 1210, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[121] = {content = 1220, contentType = 4, speakerName = 1171, speakerHeroId = 29, speakerHeroPosId = 2, tipsTypeWriter = true, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[122] = {content = 1230, contentType = 4, speakerName = 1171, speakerHeroId = 29, speakerHeroPosId = 2, tipsTypeWriter = true}
, 
[123] = {content = 1240, contentType = 4, speakerName = 1171, speakerHeroId = 29, speakerHeroPosId = 2, tipsTypeWriter = true}
, 
[124] = {content = 1250, contentType = 4, speakerName = 1171, speakerHeroId = 29, speakerHeroPosId = 2, tipsTypeWriter = true}
, 
[125] = {content = 1260, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[126] = {content = 1270, contentType = 5, autoContinue = true, tipsShowDuration = 0.2, tipsTypeWriter = true}
, 
[127] = {content = 1280, contentType = 5, autoContinue = true, tipsShowDuration = 0.2, tipsTypeWriter = true}
, 
[128] = {content = 1290, contentType = 2, speakerHeroId = 29, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[129] = {content = 1300, contentType = 2}
, 
[130] = {content = 1310, contentType = 5, autoContinue = true, tipsShowDuration = 0.2, tipsTypeWriter = true}
, 
[131] = {content = 1320, contentType = 5, autoContinue = true, tipsShowDuration = 0.2, tipsTypeWriter = true}
, 
[132] = {content = 1330, contentType = 4, speakerName = 1171, speakerHeroId = 29, speakerHeroPosId = 2, tipsTypeWriter = true}
, 
[133] = {
heroFace = {
{imgId = 102, faceId = 1}
}
, content = 1340, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[134] = {
heroFace = {
{imgId = 102, faceId = 5}
}
, content = 1350, contentType = 4, speakerName = 1171, speakerHeroId = 29, speakerHeroPosId = 2, tipsTypeWriter = true, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[135] = {content = 1360, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[136] = {content = 1370, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[137] = {
heroFace = {
{imgId = 102, faceId = 0}
}
, content = 1380, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.6, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[138] = {content = 1390, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
audio = {
bgm = {stop = true, sheet = "Mus_Story_Creepy"}
, 
sfx = {cue = "AVG_tinnitus", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 3, delay = 0, duration = 0, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[139] = {content = 1400, contentType = 4, speakerName = 1171, speakerHeroId = 29, speakerHeroPosId = 2, tipsTypeWriter = true}
, 
[140] = {
heroFace = {
{imgId = 102, faceId = 6}
}
, content = 1410, contentType = 4, speakerName = 1412, speakerHeroId = 1002, speakerHeroPosId = 2}
}
return AvgCfg_cpt04_e_05_01


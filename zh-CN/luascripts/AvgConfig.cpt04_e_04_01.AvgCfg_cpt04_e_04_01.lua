-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt04_e_04_01 = {
[1] = {
heroFace = {
{imgId = 101, faceId = 4}
}
, content = 10, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
images = {
{imgId = 1, imgType = 1, alpha = 1, imgPath = "cpt00/cpt00_e_bg001", fullScreen = true}
, 
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg001", fullScreen = true}
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
{imgId = 27, imgType = 3, alpha = 0, imgPath = "adele_avg"}
, 
{imgId = 30, imgType = 3, alpha = 0, imgPath = "gabriel_avg"}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
imgTween = {
{imgId = 2, delay = 0, duration = 1, alpha = 1}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.6, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 112, delay = 0, duration = 0.6, posId = 4, alpha = 1, isDark = true}
}
}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
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
[4] = {content = 40, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 2}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 2}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 2, 
imgTween = {
{imgId = 27, delay = 0, duration = 0.6, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 2}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 2, 
imgTween = {
{imgId = 27, delay = 0, duration = 0.6, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0.6, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[9] = {content = 90, contentType = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[11] = {content = 110, contentType = 5, speakerHeroId = 1, speakerHeroPosId = 2, autoContinue = true, tipsShowDuration = 0.2, tipsTypeWriter = true, 
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[12] = {
heroFace = {
{imgId = 101, faceId = 5}
}
, content = 120, contentType = 5, speakerHeroId = 1, speakerHeroPosId = 2, autoContinue = true, tipsShowDuration = 0.2, tipsTypeWriter = true}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 112, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[14] = {
heroFace = {
{imgId = 101, faceId = 4}
}
, content = 140, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[15] = {content = 150, contentType = 4, speakerName = 151, speakerHeroId = 2, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[17] = {content = 170, contentType = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[18] = {
heroFace = {
{imgId = 101, faceId = 5}
}
, content = 180, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[19] = {
heroFace = {
{imgId = 101, faceId = 0}
}
, content = 190, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[20] = {content = 200, contentType = 4, speakerName = 201, speakerHeroId = 1, speakerHeroPosId = 2, 
audio = {
sfx = {cue = "AVG_whitenoise", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[21] = {content = 210, contentType = 4, speakerName = 201, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[22] = {content = 220, contentType = 4, speakerName = 201, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[23] = {
heroFace = {
{imgId = 103, faceId = 4}
}
, content = 230, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
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
[24] = {
heroFace = {
{imgId = 101, faceId = 5}
}
, content = 240, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[26] = {
heroFace = {
{imgId = 103, faceId = 3}
}
, content = 260, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[27] = {autoContinue = true, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.6, posId = 2, alpha = 1, shake = true, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.6, posId = 4, alpha = 1, shake = true, isDark = false}
}
, 
audio = {
bgm = {stop = true, sheet = "Mus_Story_BattleTension"}
, 
sfx = {cue = "Atk_Abstinence_01", sheet = "Mon_Abstinence"}
}
}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
}
, 
[29] = {
heroFace = {
{imgId = 103, faceId = 4}
}
, content = 290, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, shake = true, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[30] = {content = 300, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[32] = {
heroFace = {
{imgId = 30, faceId = 3}
}
, content = 320, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
audio = {
bgm = {cue = "Mus_Story_Purifier", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[34] = {content = 340, contentType = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[35] = {content = 350, contentType = 2, 
audio = {
sfx = {cue = "Atk_Abstinence_01", sheet = "Mon_Abstinence"}
}
}
, 
[36] = {
heroFace = {
{imgId = 105, faceId = 6}
}
, content = 360, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.6, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[37] = {
heroFace = {
{imgId = 105, faceId = 5}
}
, content = 370, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[38] = {
heroFace = {
{imgId = 30, faceId = 4}
}
, content = 380, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[39] = {
heroFace = {
{imgId = 103, faceId = 6}
}
, content = 390, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[41] = {content = 410, contentType = 2, 
audio = {
bgm = {stop = true, sheet = "Mus_Story_Purifier"}
, 
sfx = {cue = "Skill_Sol_01", sheet = "Chara_Sol"}
}
, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[42] = {
heroFace = {
{imgId = 103, faceId = 3}
}
, content = 420, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[43] = {
heroFace = {
{imgId = 30, faceId = 1}
}
, content = 430, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
audio = {
bgm = {cue = "Mus_Story_Passion", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[46] = {
heroFace = {
{imgId = 30, faceId = 4}
}
, content = 460, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.1, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.1, posId = 3, alpha = 1, isDark = false}
}
, 
branch = {
{content = 491, jumpAct = 50}
, 
{content = 492, jumpAct = 52}
}
}
, 
[50] = {content = 500, contentType = 4, speakerName = 151, speakerHeroId = 2, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.1, posId = 3, alpha = 1, isDark = true}
}
}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, nextId = 54, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.1, posId = 3, alpha = 1, isDark = false}
}
}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[53] = {
heroFace = {
{imgId = 30, faceId = 5}
}
, content = 530, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, nextId = 54, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.6, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, shake = true, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 112, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[57] = {
heroFace = {
{imgId = 101, faceId = 4}
}
, content = 570, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, shake = true, isDark = false}
}
}
}
return AvgCfg_cpt04_e_04_01


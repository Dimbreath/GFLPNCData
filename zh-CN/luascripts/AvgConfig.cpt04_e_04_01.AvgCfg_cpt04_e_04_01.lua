-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt04_e_04_01 = {
[1] = {
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 10, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, bgColor = 2, 
images = {
{imgId = 1, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg001", fullScreen = true}
, 
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg002", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 104, imgType = 3, alpha = 0, imgPath = "simo_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 105, imgType = 3, alpha = 0, imgPath = "croque_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 112, imgType = 3, alpha = 0, imgPath = "max_avg"}
, 
{imgId = 28, imgType = 3, alpha = 0, imgPath = "adele_avg"}
, 
{imgId = 30, imgType = 3, alpha = 0, imgPath = "gabriel_avg"}
}
, 
imgTween = {
{imgId = 1, delay = 0, duration = 0.6, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[3] = {content = 30, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[4] = {content = 40, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.6, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 2}
, 
[6] = {
audio = {
sfx = {cue = "AVG_whitenoise", sheet = "AVG_gf"}
}
, content = 60, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.6, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 2}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
, 
{imgId = 28, delay = 0, duration = 1, posId = 3, alpha = 0, isDark = false}
}
}
, 
[9] = {content = 90, contentType = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_ClothingUp", sheet = "AVG_gf"}
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
audio = {
sfx = {cue = "AVG_tele_connect", sheet = "AVG_gf"}
}
}
, 
[11] = {content = 110, contentType = 4, speakerName = 171, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[12] = {
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf"}
}
, content = 120, contentType = 4, speakerName = 171}
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
}
, 
[17] = {
audio = {
sfx = {cue = "AVG_tele_connect", sheet = "AVG_gf"}
}
, content = 170, contentType = 5, tipsTypeWriter = true, tipsShowDuration = 0.8, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[19] = {
audio = {
sfx = {cue = "AVG_whitenoise", sheet = "AVG_gf"}
}
, content = 190, contentType = 5, tipsTypeWriter = true, tipsShowDuration = 0.8, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
}
}
, 
[20] = {content = 200, contentType = 5, tipsTypeWriter = true, tipsShowDuration = 0.8}
, 
[21] = {content = 210, contentType = 5, tipsTypeWriter = true, tipsShowDuration = 0.8}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
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
[23] = {content = 230, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[26] = {content = 260, contentType = 4, speakerName = 261, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[27] = {content = 270, contentType = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_Purifier", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.6, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[30] = {content = 300, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[33] = {contentShake = true, autoContinue = true}
, 
[34] = {content = 340, contentType = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.6, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "Atk_Simo_01", sheet = "Chara_Simo"}
}
}
, 
[35] = {content = 350, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
}
, 
[36] = {
audio = {
sfx = {cue = "Skill_Gangyi_01", sheet = "Mon_Gangyi"}
}
, content = 360, contentType = 2, contentShake = true, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.6, posId = 3, alpha = 1, isDark = false}
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
}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[42] = {
audio = {
sfx = {cue = "Skill_Gangyi_01", sheet = "Mon_Gangyi"}
}
, content = 420, contentType = 2, contentShake = true, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
, 
branch = {
{content = 501, jumpAct = 51}
, 
{content = 502, jumpAct = 53}
}
}
, 
[51] = {content = 510, contentType = 4, speakerName = 511, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, nextId = 55, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[54] = {
audio = {
sfx = {cue = "Skill_Patience_01_BS", sheet = "Mon_Patience"}
}
, content = 540, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, nextId = 55, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.6, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
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
[56] = {content = 560, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
}
return AvgCfg_cpt04_e_04_01


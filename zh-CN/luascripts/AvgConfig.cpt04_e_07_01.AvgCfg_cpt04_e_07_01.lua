-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt04_e_07_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 99, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg001_2", fullScreen = true}
, 
{imgId = 98, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg005", fullScreen = true}
, 
{imgId = 1, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 5, imgType = 3, alpha = 0, imgPath = "croque_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 12, imgType = 3, alpha = 0, imgPath = "max_avg"}
, 
{imgId = 36, imgType = 3, alpha = 0, imgPath = "lam_avg"}
}
, 
imgTween = {
{imgId = 5, posId = 5}
, 
{imgId = 5, posId = 4, isDark = false, delay = 1, duration = 0.2}
, 
{imgId = 99, duration = 1, alpha = 1}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 10, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[2] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 5, isDark = true}
}
, content = 20, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[3] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 30, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[4] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, 
heroFace = {
{imgId = 1, faceId = 4}
}
, content = 40, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[5] = {
imgTween = {
{imgId = 1, posId = 3, isDark = false, duration = 0.2}
, 
{imgId = 5, posId = 5, isDark = false, duration = 0.2}
}
, content = 50, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[7] = {
heroFace = {
{imgId = 1, faceId = 0}
}
, content = 70, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[8] = {
audio = {
sfx = {cue = "Skill_Guardian_01_Start", sheet = "Mon_Guardian"}
}
, 
imgTween = {
{imgId = 1, duration = 0.2, alpha = 0}
, 
{imgId = 12, posId = 5}
, 
{imgId = 12, posId = 4, delay = 0.5, isDark = false, duration = 0.2}
}
, content = 80, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[9] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 12, duration = 0.2, posId = 5}
, 
{imgId = 5, posId = 5}
, 
{imgId = 5, posId = 4, isDark = false, duration = 0.2, isDark = true}
}
, content = 90, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[11] = {content = 110, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[12] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 120, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[13] = {
imgTween = {
{imgId = 1, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 5, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 12, posId = 5}
, 
{imgId = 12, posId = 4, isDark = false, duration = 0.2}
}
, content = 130, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[14] = {
imgTween = {
{imgId = 12, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 99, duration = 0.5, shake = true}
}
, 
audio = {
sfx = {cue = "Atk_Maimai_01", sheet = "Chara_Maimai"}
}
, content = 140, contentType = 2}
, 
[15] = {
imgTween = {
{imgId = 12, posId = 1}
, 
{imgId = 12, posId = 2, isDark = true, duration = 0.2}
, 
{imgId = 5, posId = 4, isDark = false, duration = 0.2}
}
, content = 150, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[16] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 160, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[18] = {
audio = {
sfx = {cue = "Skill_Croque_01", sheet = "Chara_Croque"}
}
, 
imgTween = {
{imgId = 12, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 5, posId = 5, isDark = false, duration = 0.2}
}
, content = 180, contentType = 2}
, 
[19] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
}
, content = 170, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[21] = {
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, content = 210, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[22] = {
heroFace = {
{imgId = 1, faceId = 4}
}
, content = 220, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[23] = {content = 230, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[24] = {
heroFace = {
{imgId = 1, faceId = 5}
}
, content = 240, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[26] = {
heroFace = {
{imgId = 1, faceId = 1}
}
, 
audio = {
sfx = {cue = "AVG_whitenoise", sheet = "AVG_gf"}
}
, content = 260, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, contentShake = true}
, 
[27] = {
heroFace = {
{imgId = 5, faceId = 6}
, 
{imgId = 1, faceId = 0}
}
, 
imgTween = {
{imgId = 1, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 5, posId = 5}
, 
{imgId = 5, posId = 4, isDark = false, duration = 0.2}
}
, content = 270, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, contentShake = true}
, 
[28] = {
imgTween = {
{imgId = 12, posId = 1}
, 
{imgId = 12, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 5, isDark = true}
}
, content = 280, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[29] = {
heroFace = {
{imgId = 5, faceId = 0}
}
, 
imgTween = {
{imgId = 12, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 5, posId = 5, isDark = false, duration = 0.2}
}
, content = 290, contentType = 4, speakerName = 12, contentShake = true}
, 
[30] = {
audio = {
sfx = {cue = "Skill_Lam_01_Start", sheet = "Chara_Lam"}
}
, content = 300, contentType = 2, 
imgTween = {
{imgId = 99, duration = 1, shake = true}
}
}
, 
[31] = {
imgTween = {
{imgId = 12, posId = 2, alpha = 0}
, 
{imgId = 12, alpha = 1, isDark = false, duration = 0.2}
}
, content = 310, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[33] = {
imgTween = {
{imgId = 36, posId = 5}
, 
{imgId = 36, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 12, posId = 1, isDark = false, duration = 0.2}
}
, content = 330, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3}
, 
[34] = {
{imgId = 5, faceId = 0}
; 
imgTween = {
{imgId = 5, posId = 1}
, 
{imgId = 5, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 36, isDark = true}
}
, content = 340, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[35] = {
imgTween = {
{imgId = 36, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 350, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3}
, 
[38] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 36, isDark = true}
}
, content = 380, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[39] = {
imgTween = {
{imgId = 36, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 390, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3}
, 
[40] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 36, isDark = true}
}
, content = 400, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[41] = {
imgTween = {
{imgId = 36, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 410, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3}
, 
[42] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 36, isDark = true}
}
, content = 420, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[44] = {
imgTween = {
{imgId = 36, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 440, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3}
, 
[45] = {
imgTween = {
{imgId = 12, posId = 1}
, 
{imgId = 12, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 36, isDark = true}
, 
{imgId = 5, posId = 1, isDark = false, duration = 0.2}
}
, content = 450, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[46] = {
{imgId = 36, faceId = 1}
; 
imgTween = {
{imgId = 36, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 460, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3}
, 
[47] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 36, isDark = true}
}
, content = 470, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[48] = {
imgTween = {
{imgId = 36, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 480, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3}
, 
[49] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 36, isDark = true}
}
, content = 490, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[50] = {
{imgId = 36, faceId = 0}
; 
imgTween = {
{imgId = 36, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 500, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3}
, 
[52] = {
imgTween = {
{imgId = 5, posId = 5}
, 
{imgId = 5, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 36, posId = 5, isDark = false, duration = 0.2}
}
, content = 520, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[54] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 540, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[55] = {
images = {
{imgId = 1, delete = true}
, 
{imgId = 5, delete = true}
, 
{imgId = 12, delete = true}
, 
{imgId = 36, delete = true}
}
, 
imgTween = {
{imgId = 99, duration = 0.5, alpha = 0}
, 
{imgId = 98, duration = 0.5, delay = 0.3, alpha = 1}
}
, 
audio = {
bgm = {stop = true}
}
, autoContinue = true}
, 
[56] = {
images = {
{imgId = 3, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "neumann_avg"}
}
, 
imgTween = {
{imgId = 101, posId = 3, alpha = 0}
, 
{imgId = 101, alpha = 1, isDark = false, duration = 0.2}
}
, 
audio = {
bgm = {cue = "Mus_Story_Creepy", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 560, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[57] = {
imgTween = {
{imgId = 3, posId = 5}
, 
{imgId = 3, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, posId = 2, isDark = true, duration = 0.2}
}
, 
heroFace = {
{imgId = 3, faceId = 3}
}
, content = 570, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[58] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 580, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 1}
, 
[59] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 590, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[60] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 600, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 1}
, 
[61] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 101, isDark = true}
}
, 
heroFace = {
{imgId = 3, faceId = 6}
}
, content = 610, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[62] = {content = 620, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[63] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 630, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 1}
, 
[64] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 101, isDark = true}
}
, 
heroFace = {
{imgId = 3, faceId = 4}
}
, content = 640, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[65] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 650, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 1}
, 
[66] = {
imgTween = {
{imgId = 101, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 3, posId = 5, isDark = false, duration = 0.2}
}
, content = 660, contentType = 2}
, 
[67] = {
imgTween = {
{imgId = 101, posId = 2, isDark = true, duration = 0.2}
, 
{imgId = 3, posId = 4, isDark = false, duration = 0.2}
}
, content = 670, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[68] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 680, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 1}
, 
[69] = {
imgTween = {
{imgId = 101, posId = 3, isDark = false, duration = 0.2}
, 
{imgId = 3, posId = 5, isDark = false, duration = 0.2}
}
, content = 690, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[70] = {
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf"}
, 
bgm = {stop = true}
}
, 
imgTween = {
{imgId = 101, isDark = true}
}
, content = 700, contentType = 4, speakerName = 13}
, 
[71] = {
imgTween = {
{imgId = 101, isDark = false}
}
, content = 710, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[72] = {
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 720, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[73] = {
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 101, isDark = true}
}
, content = 730, contentType = 4, speakerName = 13}
, 
[74] = {
imgTween = {
{imgId = 101, isDark = false}
}
, content = 740, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[75] = {content = 750, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[76] = {
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 101, isDark = true}
}
, content = 760, contentType = 4, speakerName = 13}
, 
[77] = {
imgTween = {
{imgId = 101, isDark = false}
}
, content = 770, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[78] = {
imgTween = {
{imgId = 3, posId = 3, alpha = 0}
, 
{imgId = 3, alpha = 1, duration = 0.5, isDark = false}
, 
{imgId = 101, alpha = 0, duration = 0.2, isDark = false}
}
, content = 780, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[79] = {
imgTween = {
{imgId = 101, alpha = 1, duration = 0.5, isDark = false}
, 
{imgId = 3, alpha = 0, duration = 0.2, isDark = false}
}
, content = 790, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[80] = {
imgTween = {
{imgId = 101, isDark = true}
}
, content = 800, contentType = 4, speakerName = 13}
, 
[81] = {content = 810, contentType = 4, speakerName = 13}
, 
[82] = {
imgTween = {
{imgId = 101, isDark = false}
}
, content = 820, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[83] = {
imgTween = {
{imgId = 3, alpha = 1, duration = 0.5, isDark = false}
, 
{imgId = 101, alpha = 0, duration = 0.2, isDark = false}
}
, 
heroFace = {
{imgId = 3, faceId = 6}
}
, content = 830, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[84] = {
imgTween = {
{imgId = 3, isDark = true}
}
, content = 840, contentType = 4, speakerName = 11}
, 
[85] = {
imgTween = {
{imgId = 101, alpha = 1, duration = 0.5, isDark = false}
, 
{imgId = 3, alpha = 0, duration = 0.2, isDark = false}
}
, content = 850, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[86] = {content = 860, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
branch = {
{content = 870, jumpAct = 87}
}
}
, 
[87] = {
imgTween = {
{imgId = 101, isDark = true}
}
, content = 870, contentType = 4, speakerName = 11}
, 
[88] = {content = 880, contentType = 4, speakerName = 11}
, 
[89] = {
imgTween = {
{imgId = 101, alpha = 0, duration = 0.2, isDark = false}
, 
{imgId = 3, alpha = 1, duration = 0.2, isDark = false}
}
, content = 890, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[90] = {
heroFace = {
{imgId = 3, faceId = 4}
}
, content = 900, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[91] = {
imgTween = {
{imgId = 3, alpha = 0, duration = 0.2, isDark = false}
}
, content = 910, contentType = 2}
, 
[92] = {
imgTween = {
{imgId = 101, alpha = 1, duration = 0.2, isDark = false}
}
, content = 920, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[93] = {content = 930, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[94] = {
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, content = 940, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[95] = {
imgTween = {
{imgId = 101, alpha = 0, duration = 0.2, isDark = false}
, 
{imgId = 3, alpha = 1, duration = 0.2, isDark = false}
}
, content = 950, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[96] = {
heroFace = {
{imgId = 3, faceId = 6}
}
, content = 960, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[97] = {content = 970, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[98] = {
imgTween = {
{imgId = 3, alpha = 0, duration = 0.2, isDark = false}
, 
{imgId = 101, alpha = 1, duration = 0.2, isDark = false}
}
, content = 980, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[99] = {
imgTween = {
{imgId = 101, alpha = 0, duration = 0.2, isDark = false}
, 
{imgId = 3, alpha = 1, duration = 0.2, isDark = false}
}
, 
heroFace = {
{imgId = 3, faceId = 4}
}
, content = 990, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[100] = {
imgTween = {
{imgId = 3, alpha = 0, duration = 0.2, isDark = false}
}
, content = 1000, contentType = 2}
, 
[101] = {
audio = {
sfx = {cue = "AVG_Rope", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 3, alpha = 1, duration = 0.2, isDark = false}
}
, content = 1010, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[102] = {
imgTween = {
{imgId = 3, shake = true, duration = 0.2}
}
, content = 1020, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
branch = {
{content = 1021, jumpAct = 103}
, 
{content = 1022, jumpAct = 105}
}
}
, 
[103] = {
imgTween = {
{imgId = 101, alpha = 1, isDark = false}
, 
{imgId = 3, alpha = 0, duration = 0.2, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 1}
}
, content = 1030, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[104] = {content = 1040, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, nextId = 107}
, 
[105] = {content = 1050, contentType = 4, speakerName = 11}
, 
[106] = {
imgTween = {
{imgId = 101, alpha = 1, duration = 0.2, isDark = false}
, 
{imgId = 3, alpha = 0, duration = 0.2, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 1}
}
, content = 1060, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[107] = {content = 1070, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[108] = {content = 1080, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[109] = {content = 1090, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
}
return AvgCfg_cpt04_e_07_01


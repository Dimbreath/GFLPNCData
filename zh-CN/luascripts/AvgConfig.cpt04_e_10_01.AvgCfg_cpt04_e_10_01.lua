-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt04_e_10_01 = {
[1] = {
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 10, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, bgColor = 2, 
images = {
{imgId = 1, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg001_2", fullScreen = true}
, 
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg005", fullScreen = true}
, 
{imgId = 3, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg006", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 102, imgType = 3, alpha = 0, imgPath = "anna_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 105, imgType = 3, alpha = 0, imgPath = "croque_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 27, imgType = 3, alpha = 0, imgPath = "adele_avg"}
, 
{imgId = 28, imgType = 3, alpha = 0, imgPath = "neumann_avg"}
, 
{imgId = 29, imgType = 3, alpha = 0, imgPath = "eniac_avg"}
, 
{imgId = 30, imgType = 3, alpha = 0, imgPath = "gabriel_avg"}
, 
{imgId = 136, imgType = 3, alpha = 0, imgPath = "lam_avg"}
}
, 
imgTween = {
{imgId = 2, delay = 0, duration = 1, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[3] = {content = 30, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[4] = {content = 40, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[5] = {
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, content = 50, contentType = 5, speakerHeroId = 4, speakerHeroPosId = 2, tipsTypeWriter = true, tipsShowDuration = 0.8, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[6] = {content = 60, contentType = 5, speakerHeroId = 4, speakerHeroPosId = 2, tipsTypeWriter = true, tipsShowDuration = 0.8}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = true}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[8] = {
audio = {
sfx = {cue = "Skill_Gangyi_01", sheet = "Mon_Gangyi"}
}
, content = 80, contentType = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[9] = {content = 90, contentType = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = true}
}
}
, 
[10] = {
audio = {
bgm = {stop = true}
}
, content = 100, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[11] = {content = 110, contentType = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = true}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[13] = {
audio = {
bgm = {cue = "Mus_Story_Sad", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 130, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0.6, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[23] = {content = 230, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[27] = {content = 270, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[29] = {content = 290, contentType = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 2, delay = 0, duration = 1, alpha = 0, isDark = false}
, 
{imgId = 1, delay = 0.6, duration = 1, alpha = 1, isDark = false}
}
}
, 
[30] = {
audio = {
sfx = {cue = "AVG_whitenoise", sheet = "AVG_gf"}
}
, content = 300, contentType = 2}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 1, delay = 0, duration = 1, alpha = 0, isDark = false}
, 
{imgId = 2, delay = 0, duration = 1, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 28, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[35] = {content = 350, contentType = 4, speakerName = 13, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[36] = {
audio = {
sfx = {cue = "Skill_Guardian_01_Loop", sheet = "Mon_Guardian", audioId = 58}
}
, content = 360, contentType = 2, 
imgTween = {
{imgId = 29, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 29, delay = 0, duration = 2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[37] = {
audio = {
stopAudioId = {58}
}
, content = 370, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
imgTween = {
{imgId = 29, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0.75, isDark = false}
}
}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 29, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 29, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 3, 
imgTween = {
{imgId = 29, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 28, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0.2, posId = 4, alpha = 0.75, shake = true, isDark = false}
}
}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 3, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 4, alpha = 0.75, shake = true, isDark = false}
}
}
, 
[42] = {content = 420, contentType = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 4, alpha = 0.75, isDark = true}
}
}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 1, 
imgTween = {
{imgId = 29, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 1}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 1}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 1}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 1}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 3, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 4, alpha = 0.75, isDark = false}
, 
{imgId = 29, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 1, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 4, alpha = 0.75, isDark = true}
, 
{imgId = 29, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 1}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 1}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 1}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 1}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 29, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 29, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 29, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2}
, 
[59] = {content = 590, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 3, 
imgTween = {
{imgId = 29, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 28, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0.2, posId = 4, alpha = 0.75, isDark = false}
}
}
, 
[60] = {content = 600, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 3}
, 
[61] = {content = 610, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 3}
, 
[62] = {content = 620, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 1, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 4, alpha = 0.75, isDark = true}
, 
{imgId = 29, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[63] = {content = 630, contentType = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 29, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
}
}
, 
[64] = {
audio = {
sfx = {cue = "Skill_Guardian_01_Loop", sheet = "Mon_Guardian", audioId = 58}
}
, content = 640, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0.75, isDark = false}
}
}
, 
[65] = {content = 650, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0.5, isDark = false}
}
}
, 
[66] = {content = 660, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[67] = {content = 670, contentType = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0.5, isDark = false}
}
}
, 
[68] = {content = 680, contentType = 4, speakerHeroId = 29, speakerName = 681, 
imgTween = {
{imgId = 28, delay = 0, duration = 1, posId = 3, alpha = 0.25, isDark = false}
}
}
, 
[69] = {content = 690, contentType = 4, speakerHeroId = 29, speakerName = 681, 
imgTween = {
{imgId = 28, delay = 0, duration = 1, posId = 3, alpha = 0, isDark = false}
}
}
, 
[70] = {
audio = {
stopAudioId = {58}
}
, content = 700, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
imgTween = {
{imgId = 102, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[71] = {content = 710, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[72] = {content = 720, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
}
, 
[73] = {
audio = {
bgm = {stop = true}
}
, content = 730, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[74] = {content = 740, contentType = 2}
, 
[75] = {
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 750, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[76] = {content = 760, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[77] = {content = 770, contentType = 4, speakerName = 11, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[78] = {content = 780, contentType = 4, speakerName = 12, contentShake = true}
, 
[79] = {content = 790, contentType = 2}
, 
[80] = {content = 800, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[81] = {content = 810, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 136, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 136, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[82] = {content = 820, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3, 
imgTween = {
{imgId = 136, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[83] = {content = 830, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 136, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
}
, 
[84] = {content = 840, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[85] = {content = 850, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 136, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 136, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
}
return AvgCfg_cpt04_e_10_01


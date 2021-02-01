-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt01_h_01_01 = {
[1] = {bgColor = 2, content = 10, contentType = 1, nextId = 89, 
images = {
{imgId = 1, imgType = 1, alpha = 1, imgPath = "cpt00/cpt00_e_bg001", fullScreen = true}
, 
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt00/cpt00_e_bg005", fullScreen = true}
, 
{imgId = 3, imgType = 2, alpha = 0, imgPath = "cpt00/cpt00_e_bg006", fullScreen = true}
, 
{imgId = 4, imgType = 2, alpha = 0, imgPath = "cpt00/cpt00_e_bg006_2", fullScreen = true}
, 
{imgId = 16, imgType = 3, alpha = 0, imgPath = "faith_avg"}
, 
{imgId = 35, imgType = 3, alpha = 0, imgPath = "wisdom_w_avg"}
}
, 
imgTween = {
{imgId = 4, delay = 0, duration = 1, alpha = 1}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[2] = {content = 20, contentType = 2, 
imgTween = {
{imgId = 4, delay = 0, duration = 0.6, alpha = 0}
, 
{imgId = 3, delay = 0, duration = 0.6, alpha = 1}
}
, 
audio = {
bgm = {cue = "Mus_Story_Purifier", sheet = "Music", fadeIn = 2, fadeOut = 3}
, 
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
}
, 
[3] = {content = 30, contentType = 3, speakerHeroId = 17, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[4] = {content = 40, contentType = 3, speakerHeroId = 17, speakerHeroPosId = 2}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 3, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 35, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = true}
, 
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 1, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 1}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 3, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 1, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 3, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[11] = {content = 110, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 1, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 3, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 3}
, 
[14] = {content = 140, contentType = 4, speakerName = 141, speakerHeroId = 17, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
audio = {
sfx = {cue = "AVG_tele_connect", sheet = "AVG_gf"}
}
}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 1, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[16] = {content = 160, contentType = 4, speakerName = 141, speakerHeroId = 17, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
audio = {
sfx = {cue = "AVG_tele_connect", sheet = "AVG_gf"}
}
}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 3, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 1, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 3, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 1, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 1}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 1}
, 
[23] = {content = 230, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 3, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 3}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 1, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 3, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[27] = {content = 270, contentType = 4, speakerName = 141, speakerHeroId = 17, speakerHeroPosId = 2, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
audio = {
sfx = {cue = "AVG_tele_connect", sheet = "AVG_gf"}
}
}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 1, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 1}
, 
[30] = {content = 300, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 3, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[31] = {content = 310, contentType = 4, speakerName = 141, speakerHeroId = 17, speakerHeroPosId = 2, contentShake = true, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
audio = {
{cue = "AVG_Explode", sheet = "AVG_gf"}
; 
sfx = {cue = "AVG_whitenoise", sheet = "AVG_gf"}
}
}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 3, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf"}
}
}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 3}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 1, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[35] = {content = 350, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 3, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 3}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 1, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 3, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 1, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 3, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 1, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 3, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 3}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 3}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 3}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 1, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 1}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 35, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 35, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {stop = true, sheet = "Mus_Story_Purifier"}
}
}
, 
[49] = {autoContinue = true, 
imgTween = {
{imgId = 35, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 3, delay = 0, duration = 0.6, alpha = 0, isDark = false}
}
}
, 
[50] = {content = 500, contentType = 2, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.6, alpha = 1}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[51] = {content = 510, contentType = 4, speakerName = 141, speakerHeroId = 17}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[53] = {content = 530, contentType = 4, speakerName = 141, speakerHeroId = 17, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[55] = {content = 550, contentType = 4, speakerName = 141, speakerHeroId = 17, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[59] = {content = 590, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[60] = {content = 600, contentType = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[61] = {content = 610, contentType = 2}
, 
[62] = {content = 620, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[63] = {content = 630, contentType = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "Skill_Gangyi_01", sheet = "Mon_Gangyi"}
}
}
, 
[64] = {content = 640, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[65] = {content = 650, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.6, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[66] = {autoContinue = true, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.6, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
bgm = {stop = true, sheet = "Mus_Story_BattleTension"}
}
}
, 
[67] = {content = 670, contentType = 4, speakerName = 671, 
imgTween = {
{imgId = 4, delay = 0, duration = 0.3, alpha = 1, isDark = false}
}
, 
ppv = {
cg = {saturation = -100}
}
}
, 
[68] = {content = 680, contentType = 4, speakerName = 671}
, 
[69] = {content = 690, contentType = 4, speakerName = 671}
, 
[70] = {content = 700, contentType = 4, speakerName = 671}
, 
[71] = {content = 710, contentType = 4, speakerName = 671}
, 
[72] = {content = 720, contentType = 4, speakerName = 721, 
imgTween = {
{imgId = 16, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[73] = {content = 730, contentType = 4, speakerName = 671, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[74] = {content = 740, contentType = 4, speakerName = 671}
, 
[75] = {content = 750, contentType = 4, speakerName = 671}
, 
[76] = {content = 760, contentType = 4, speakerName = 721, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[77] = {content = 770, contentType = 4, speakerName = 671, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[78] = {content = 780, contentType = 4, speakerName = 721, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[79] = {content = 790, contentType = 4, speakerName = 721}
, 
[80] = {autoContinue = true, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 4, delay = 0, duration = 0.6, alpha = 0, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
ppv = {
cg = {saturation = 0}
}
}
, 
[81] = {content = 810, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.3, alpha = 1, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[82] = {content = 820, contentType = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[83] = {content = 830, contentType = 2}
, 
[84] = {content = 840, contentType = 4, speakerHeroId = 17}
, 
[85] = {content = 850, contentType = 2}
, 
[86] = {content = 860, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[87] = {content = 870, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[88] = {content = 880, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.6, posId = 3, alpha = 1, shake = true, isDark = false}
}
, isEnd = true}
, 
[89] = {content = 890, contentType = 1, scrambleTypeWriter = true, nextId = 2}
}
return AvgCfg_cpt01_h_01_01


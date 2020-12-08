-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt04_e_01_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 99, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg005", fullScreen = true}
, 
{imgId = 98, imgType = 2, alpha = 0, imgPath = "cpt00/cpt00_e_bg007_1", fullScreen = true}
, 
{imgId = 97, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg001", fullScreen = true}
, 
{imgId = 1, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 2, imgType = 3, alpha = 0, imgPath = "anna_avg"}
, 
{imgId = 3, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 4, imgType = 3, alpha = 0, imgPath = "simo_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 5, imgType = 3, alpha = 0, imgPath = "croque_avg", 
rot = {0, 180, 0}
}
}
, 
imgTween = {
{imgId = 99, duration = 2, alpha = 0.2}
, 
{imgId = 99, duration = 2, delay = 2, alpha = 0}
}
, content = 10, contentType = 1, scrambleTypeWriter = true, 
audio = {
bgm = {cue = "Mus_YT_Story_Quiet", sheet = "Music", fadeIn = 2, fadeOut = 3}
, 
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
}
, 
[2] = {content = 20, contentType = 1, scrambleTypeWriter = true}
, 
[3] = {
imgTween = {
{imgId = 99, duration = 1.1, alpha = 0}
, 
{imgId = 2, posId = 3, alpha = 0}
, 
{imgId = 2, alpha = 0.5, isDark = false, duration = 0.2}
}
, content = 30, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[4] = {content = 40, contentType = 1, scrambleTypeWriter = true}
, 
[5] = {content = 50, contentType = 1, scrambleTypeWriter = true}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[7] = {content = 70, contentType = 1, scrambleTypeWriter = true}
, 
[8] = {content = 80, contentType = 1, scrambleTypeWriter = true}
, 
[9] = {
audio = {
bgm = {stop = true}
, 
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, content = 90, contentType = 1, scrambleTypeWriter = true}
, 
[10] = {
imgTween = {
{imgId = 2, alpha = 0, isDark = false, duration = 0.5}
}
, autoContinue = true}
, 
[11] = {content = 110, contentType = 1}
, 
[12] = {
audio = {
bgm = {cue = "Mus_Story_Relax", sheet = "Music", fadeIn = 2, fadeOut = 3}
, 
sfx = {cue = "AVG_BaseDoor_Open", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 98, duration = 1, alpha = 1}
, 
{imgId = 1, posId = 3, alpha = 0}
, 
{imgId = 1, delay = 1, alpha = 1, duration = 0.2}
}
, content = 120, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[13] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 130, contentType = 4, speakerName = 11}
, 
[14] = {
imgTween = {
{imgId = 1, isDark = false}
}
, content = 140, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[16] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 160, contentType = 4, speakerName = 11}
, 
[17] = {content = 170, contentType = 4, speakerName = 11}
, 
[18] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 1, duration = 0.2, 
pos = {50, -310, 0}
}
, 
{imgId = 1, duration = 0.2, delay = 0.2, 
pos = {0, -310, 0}
}
}
, content = 180, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
branch = {
{content = 181, jumpAct = 19}
, 
{content = 182, jumpAct = 21}
}
}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[20] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 200, contentType = 4, speakerName = 11, nextId = 23}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[22] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 220, contentType = 4, speakerName = 11}
, 
[23] = {
imgTween = {
{imgId = 1, isDark = false}
}
, content = 230, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[25] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 250, contentType = 4, speakerName = 11}
, 
[26] = {
imgTween = {
{imgId = 1, isDark = false}
}
, content = 260, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[27] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 270, contentType = 4, speakerName = 11}
, 
[28] = {
imgTween = {
{imgId = 1, isDark = false}
}
, content = 280, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[29] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 290, contentType = 4, speakerName = 11}
, 
[30] = {
imgTween = {
{imgId = 1, isDark = false}
}
, content = 300, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[31] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 310, contentType = 4, speakerName = 11}
, 
[32] = {
imgTween = {
{imgId = 1, isDark = false}
}
, content = 320, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[33] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 330, contentType = 4, speakerName = 11}
, 
[34] = {
imgTween = {
{imgId = 1, isDark = false}
}
, content = 340, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[35] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 350, contentType = 4, speakerName = 11}
, 
[36] = {
imgTween = {
{imgId = 1, isDark = false}
}
, content = 360, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[38] = {
imgTween = {
{imgId = 98, duration = 1, alpha = 0}
, 
{imgId = 97, duration = 1, delay = 1, alpha = 1}
, 
{imgId = 1, duration = 0.2, alpha = 0}
}
, 
audio = {
bgm = {stop = true}
}
, autoContinue = true}
, 
[39] = {
imgTween = {
{imgId = 1, posId = 5}
, 
{imgId = 1, posId = 4, isDark = false, duration = 0.2}
}
, 
audio = {
bgm = {cue = "Mus_Story_Creepy", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 390, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[40] = {
imgTween = {
{imgId = 3, posId = 1}
, 
{imgId = 3, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
}
, content = 400, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[41] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 410, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[43] = {
imgTween = {
{imgId = 5, posId = 5}
, 
{imgId = 5, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, posId = 5, isDark = false, duration = 0.2}
}
, content = 430, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[44] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 440, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[45] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 450, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[46] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 460, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[47] = {
imgTween = {
{imgId = 3, duration = 0.2, posId = 1}
, 
{imgId = 5, duration = 0.2, posId = 5}
}
, content = 470, contentType = 2}
, 
[48] = {
imgTween = {
{imgId = 3, duration = 0.2, posId = 2}
}
, content = 480, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[49] = {
imgTween = {
{imgId = 1, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 3, isDark = true}
, 
{imgId = 5, posId = 5, isDark = false, duration = 0.2}
}
, content = 490, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[50] = {
imgTween = {
{imgId = 5, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, posId = 5, isDark = false, duration = 0.2}
}
, content = 500, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[51] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 510, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[52] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 520, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[53] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 530, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[54] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 540, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[55] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 550, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[56] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 560, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[57] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 570, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[58] = {
imgTween = {
{imgId = 1, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 3, isDark = true}
, 
{imgId = 5, posId = 5, isDark = false, duration = 0.2}
}
, 
audio = {
sfx = {cue = "Skill_Common_ExCast", sheet = "Common_Skill"}
}
, content = 580, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[59] = {content = 590, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[60] = {
imgTween = {
{imgId = 5, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, posId = 5, isDark = false, duration = 0.2}
}
, content = 600, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[61] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 610, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[62] = {
imgTween = {
{imgId = 4, posId = 1}
, 
{imgId = 4, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 3, posId = 1, isDark = false, duration = 0.2}
}
, content = 620, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[63] = {
imgTween = {
{imgId = 4, duration = 0.2, posId = 1}
, 
{imgId = 5, duration = 0.2, posId = 5}
, 
{imgId = 97, duration = 1, 
scale = {1.5, 1.5, 1.5}
, 
pos = {0, -200, 0}
}
}
, content = 630, contentType = 2}
, 
[64] = {
imgTween = {
{imgId = 4, duration = 0.2, delay = 1, posId = 2}
, 
{imgId = 97, duration = 1, 
scale = {1, 1, 1}
, 
pos = {0, 0, 0}
}
}
, content = 640, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[65] = {
imgTween = {
{imgId = 4, isDark = true}
, 
{imgId = 1, posId = 4, isDark = false, duration = 0.2}
}
, content = 650, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[66] = {content = 660, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[67] = {
imgTween = {
{imgId = 5, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, posId = 5, isDark = false, duration = 0.2}
}
, content = 670, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[68] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 680, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[69] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 690, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[70] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 700, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[71] = {
imgTween = {
{imgId = 3, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 4, posId = 1, isDark = false, duration = 0.2}
}
, content = 710, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[72] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 720, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[73] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 730, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[74] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 740, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[75] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 750, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[76] = {
imgTween = {
{imgId = 4, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 3, posId = 1, isDark = false, duration = 0.2}
}
, content = 760, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[77] = {
imgTween = {
{imgId = 3, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 4, posId = 1, isDark = false, duration = 0.2}
}
, content = 770, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[78] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 780, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
}
return AvgCfg_cpt04_e_01_01


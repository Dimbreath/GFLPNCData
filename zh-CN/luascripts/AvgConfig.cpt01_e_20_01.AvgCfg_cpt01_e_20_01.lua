-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt01_e_20_01 = {
[1] = {
images = {
{imgId = 99, imgPath = "cpt01/cpt01_e_bg005", imgType = 2, order = 97, fullScreen = true, delete = false}
, 
{imgId = 102, imgPath = "riko_avg", imgType = 3, 
pos = {475, -300, 0}
, 
rot = {0, 0, 0}
, order = 11, 
scale = {-1.05, 1.05, 1.05}
, alpha = 0}
}
, 
imgTween = {
{imgId = 102, duration = 0.2, 
pos = {400, -300, 0}
, alpha = 1, isDark = false}
}
, content = 10, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3, 
audio = {
bgm = {stop = true, cue = "", sheet = "Music"}
}
}
, 
[2] = {
images = {
{imgId = 1, imgPath = "persicaria_avg", imgType = 3, 
pos = {-475, -310, 0}
, 
rot = {0, 0, 0}
, 
scale = {1.7, 1.7, 1.7}
, alpha = 0.2}
}
, 
imgTween = {
{imgId = 1, duration = 0.2, 
pos = {-400, -310, 0}
, alpha = 1, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 20, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[3] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 102, isDark = false}
}
, content = 30, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3, 
audio = {
bgm = {cue = "Mus_Story_Relax", sheet = "Music"}
}
}
, 
[4] = {
images = {
{imgId = 2, imgPath = "anna_avg", imgType = 3, 
pos = {470, -330, 0}
, 
rot = {0, 180, 0}
, 
scale = {1.6, 1.6, 1.6}
, alpha = 0.2}
}
, 
imgTween = {
{imgId = 2, duration = 0.2, 
pos = {400, -330, 0}
, alpha = 1, isDark = false}
, 
{imgId = 1, duration = 0.2, 
pos = {-475, -310, 0}
, alpha = 0, isDark = false}
, 
{imgId = 102, duration = 0.2, 
pos = {475, -300, 0}
, alpha = 0, isDark = false}
}
, content = 40, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[6] = {
imgTween = {
{imgId = 1, duration = 0.2, 
pos = {-400, -310, 0}
, alpha = 1, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 60, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[11] = {content = 110, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[12] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 120, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
branch = {
{content = 121, jumpAct = 13}
, 
{content = 122, jumpAct = 14}
}
}
, 
[13] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 130, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, nextId = 15}
, 
[14] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 140, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[15] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 150, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
audio = {
bgm = {stop = true, cue = "", sheet = "Music"}
}
}
, 
[16] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 160, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[17] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 170, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[20] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 200, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[21] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 210, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
branch = {
{content = 221, jumpAct = 23}
}
}
, 
[23] = {content = 230, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[25] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 250, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[26] = {
images = {
{imgId = 3, imgPath = "sol", imgType = 3, 
pos = {-345, -400, 0}
, 
rot = {0, 0, 0}
, 
scale = {1.45, 1.45, 1.45}
, alpha = 0.2}
}
, 
imgTween = {
{imgId = 1, duration = 0.2, 
pos = {-475, -310, 0}
, alpha = 0, isDark = false}
, 
{imgId = 3, duration = 0.2, 
pos = {-270, -400, 0}
, alpha = 1, isDark = false}
}
, content = 260, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[27] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 270, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[30] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 300, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[31] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 310, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[32] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 320, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[33] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 330, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[34] = {
imgTween = {
{imgId = 2, isDark = true}
, 
{imgId = 1, duration = 0.2, 
pos = {-400, -310, 0}
, alpha = 1, isDark = false}
, 
{imgId = 3, duration = 0.2, 
pos = {-345, -400, 0}
, alpha = 0, isDark = false}
}
, content = 340, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[35] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 350, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[36] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 360, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[37] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 370, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[38] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 380, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[40] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 400, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[41] = {
imgTween = {
{imgId = 2, duration = 0.5, 
pos = {0, -330, 0}
, alpha = 1, isDark = false}
, 
{imgId = 1, duration = 0.5, 
pos = {-475, -310, 0}
, alpha = 0, isDark = false}
}
, content = 410, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
branch = {
{content = 431, jumpAct = 44}
}
}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
audio = {
bgm = {cue = "Mus_Story_Relax", sheet = "Music"}
}
}
, 
[46] = {
imgTween = {
{imgId = 2, isDark = true}
, 
{imgId = 2, duration = 0.2, 
pos = {400, -330, 0}
, alpha = 1, isDark = false}
, 
{imgId = 3, duration = 0.2, 
pos = {-270, -400, 0}
, alpha = 1, isDark = false}
}
, content = 460, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[47] = {
imgTween = {
{imgId = 1, duration = 0.2, 
pos = {-400, -310, 0}
, alpha = 1, isDark = false}
, 
{imgId = 3, duration = 0.2, 
pos = {-345, -400, 0}
, alpha = 0, isDark = false}
}
, content = 470, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[48] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 480, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[49] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 490, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[50] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 500, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[51] = {
images = {
{imgId = 101, imgPath = "turing", imgType = 3, 
pos = {50, -330, 0}
, 
rot = {0, 0, 0}
, 
scale = {1.2, 1.2, 1.2}
, alpha = 0.2}
}
, 
imgTween = {
{imgId = 2, alpha = 0}
, 
{imgId = 1, alpha = 0}
, 
{imgId = 101, duration = 0.2, 
pos = {0, -330, 0}
, alpha = 1, isDark = false}
}
, content = 510, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2}
, 
[52] = {
imgTween = {
{imgId = 2, alpha = 1}
, 
{imgId = 101, alpha = 0}
}
, content = 520, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[53] = {
imgTween = {
{imgId = 2, alpha = 0}
, 
{imgId = 101, 
pos = {475, -360, 0}
, alpha = 0.2}
, 
{imgId = 101, duration = 0.2, 
pos = {400, -360, 0}
, alpha = 1, isDark = false}
}
, content = 530, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[55] = {
imgTween = {
{imgId = 1, alpha = 1, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 550, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[56] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 560, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[58] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 580, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[59] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 590, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[60] = {content = 600, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[61] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 610, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[62] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 620, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[63] = {
imgTween = {
{imgId = 101, duration = 0.2, 
pos = {400, -360, 0}
, alpha = 0, isDark = false}
, 
{imgId = 1, isDark = true}
, 
{imgId = 2, duration = 0.2, 
pos = {400, -330, 0}
, alpha = 1, isDark = false}
}
, content = 630, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[64] = {content = 640, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[65] = {content = 650, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[66] = {
imgTween = {
{imgId = 2, isDark = true}
, 
{imgId = 1, isDark = false}
}
, content = 660, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[67] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 2, isDark = false}
}
, content = 670, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[68] = {content = 680, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[69] = {
imgTween = {
{imgId = 2, isDark = true}
, 
{imgId = 1, isDark = false}
}
, content = 690, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[70] = {content = 700, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[71] = {
imgTween = {
{imgId = 101, duration = 0.2, 
pos = {400, -360, 0}
, alpha = 1, isDark = false}
, 
{imgId = 1, isDark = true}
, 
{imgId = 2, duration = 0.2, 
pos = {475, -330, 0}
, alpha = 0, isDark = false}
}
, content = 710, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[72] = {
imgTween = {
{imgId = 101, duration = 0.2, 
pos = {500, -360, 0}
, alpha = 0, isDark = false}
, 
{imgId = 2, duration = 0.2, 
pos = {400, -330, 0}
, alpha = 1, isDark = false}
}
, content = 720, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[73] = {
imgTween = {
{imgId = 3, duration = 0.2, 
pos = {-270, -400, 0}
, alpha = 1, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 730, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[74] = {
imgTween = {
{imgId = 101, duration = 0.2, 
pos = {400, -360, 0}
, alpha = 1, isDark = false}
, 
{imgId = 3, isDark = true}
, 
{imgId = 2, duration = 0.2, 
pos = {475, -330, 0}
, alpha = 0, isDark = false}
}
, content = 740, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[75] = {
imgTween = {
{imgId = 101, isDark = true}
, 
{imgId = 3, isDark = false}
}
, content = 750, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[76] = {
imgTween = {
{imgId = 1, duration = 0.2, 
pos = {-400, -310, 0}
, alpha = 1, isDark = false}
, 
{imgId = 3, duration = 0.2, 
pos = {-345, -400, 0}
, alpha = 0, isDark = false}
}
, content = 760, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[77] = {
imgTween = {
{imgId = 1, duration = 0.2, 
pos = {-475, -310, 0}
, alpha = 0, isDark = false}
, 
{imgId = 3, duration = 0.2, 
pos = {-270, -400, 0}
, alpha = 1, isDark = false}
}
, content = 770, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[78] = {
imgTween = {
{imgId = 3, isDark = true}
, 
{imgId = 101, alpha = 0}
, 
{imgId = 102, duration = 0.2, 
pos = {400, -300, 0}
, alpha = 1, isDark = false}
}
, content = 780, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[79] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 790, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[80] = {
imgTween = {
{imgId = 3, isDark = true}
, 
{imgId = 101, alpha = 1, isDark = false}
, 
{imgId = 102, alpha = 0, isDark = false}
}
, content = 800, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[81] = {
imgTween = {
{imgId = 101, isDark = true}
, 
{imgId = 3, isDark = false}
}
, content = 810, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[82] = {content = 820, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[83] = {
imgTween = {
{imgId = 3, isDark = true}
, 
{imgId = 102, alpha = 1}
, 
{imgId = 101, alpha = 0}
}
, content = 830, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[84] = {
imgTween = {
{imgId = 1, 
pos = {-400, -310, 0}
, duration = 0.2, alpha = 1, isDark = false}
, 
{imgId = 3, 
pos = {-345, -400, 0}
, duration = 0.2, alpha = 0}
, 
{imgId = 102, alpha = 0}
}
, content = 840, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[85] = {content = 850, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
}
return AvgCfg_cpt01_e_20_01


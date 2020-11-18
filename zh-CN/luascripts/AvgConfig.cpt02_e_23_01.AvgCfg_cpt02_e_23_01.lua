-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt02_e_23_01 = {
[1] = {
images = {
{imgId = 99, imgPath = "cpt02/cpt02_e_bg004_2", imgType = 2, fullScreen = true}
, 
{imgId = 103, imgPath = "mara_blue_avg", imgType = 3, 
pos = {0, 0, 0}
, alpha = 1}
}
, content = 10, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2, 
audio = {
bgm = {cue = "Mus_Story_Purifier", sheet = "Music"}
}
}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2}
, 
[3] = {
images = {
{imgId = 4, imgPath = "simo", imgType = 3, 
pos = {-500, -50, 0}
, 
rot = {0, 180, 0}
, 
scale = {1.15, 1.15, 1.15}
, alpha = 0.2}
}
, 
imgTween = {
{imgId = 4, duration = 0.2, 
pos = {-430, -50, 0}
, alpha = 1, isDark = false}
, 
{imgId = 103, duration = 0.2, 
pos = {0, 0, 0}
, alpha = 0, isDark = false}
}
, content = 30, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[4] = {
imgTween = {
{imgId = 4, alpha = 0}
, 
{imgId = 103, duration = 0.2, 
pos = {0, 0, 0}
, alpha = 1, isDark = false}
}
, content = 40, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2}
, 
[7] = {
imgTween = {
{imgId = 103, duration = 3, 
pos = {0, 0, 0}
, alpha = 0, isDark = false}
}
, content = 70, contentType = 2}
, 
[8] = {
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
{imgId = 3, duration = 0.2, 
pos = {-270, -400, 0}
, alpha = 1, isDark = false}
}
, content = 80, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[10] = {
images = {
{imgId = 2, imgPath = "anna_avg", imgType = 3, 
pos = {475, -330, 0}
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
{imgId = 3, duration = 0.2, 
pos = {-345, -400, 0}
, alpha = 0, isDark = false}
}
, content = 100, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, contentShake = true}
, 
[11] = {
images = {
{imgId = 1, imgPath = "persicaria_avg", imgType = 3, 
pos = {-475, -310, 0}
, 
rot = {0, 0, 0}
, 
scale = {1.7, 1.7, 1.7}
, alpha = 0.2}
, 
{imgId = 103, delete = true}
}
, 
imgTween = {
{imgId = 1, duration = 0.2, 
pos = {-400, -310, 0}
, alpha = 1, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 110, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[12] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 2, isDark = false}
}
, content = 120, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[15] = {
imgTween = {
{imgId = 3, duration = 0.2, 
pos = {-270, -400, 0}
, alpha = 1, isDark = false}
, 
{imgId = 1, duration = 0.2, 
pos = {-475, -310, 0}
, alpha = 0, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 150, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[16] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 160, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[17] = {
images = {
{imgId = 101, imgPath = "olivia_avg", imgType = 3, 
pos = {-450, -350, 0}
, 
rot = {0, 0, 0}
, 
scale = {1.6, 1.6, 1.6}
, alpha = 0.2}
}
, 
imgTween = {
{imgId = 2, duration = 0.2, 
pos = {475, -330, 0}
, alpha = 0, isDark = false}
, 
{imgId = 3, duration = 0.2, 
pos = {-345, -400, 0}
, alpha = 0, isDark = false}
, 
{imgId = 101, duration = 0.2, 
pos = {-400, -350, 0}
, alpha = 1}
}
, content = 170, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 1, 
audio = {
bgm = {stop = true, sheet = "Music"}
}
}
, 
[18] = {
imgTween = {
{imgId = 1, duration = 0.2, 
pos = {-400, -310, 0}
, alpha = 1, isDark = false}
, 
{imgId = 101, duration = 0.2, 
pos = {-450, -350, 0}
, alpha = 0}
}
, content = 180, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
audio = {
bgm = {cue = "Mus_Story_Relax", sheet = "Music"}
}
}
, 
[19] = {
imgTween = {
{imgId = 1, duration = 0.2, 
pos = {-475, -310, 0}
, alpha = 0, isDark = false}
, 
{imgId = 101, duration = 0.2, 
pos = {-400, -350, 0}
, alpha = 1}
}
, content = 190, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 1}
, 
[20] = {
images = {
{imgId = 103, imgPath = "arrow_avg", imgType = 3, 
pos = {450, -350, 0}
, 
rot = {0, 0, 0}
, 
scale = {1.6, 1.6, 1.6}
, alpha = 0.2}
}
, 
imgTween = {
{imgId = 103, duration = 0.2, 
pos = {400, -350, 0}
, alpha = 1, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 200, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[21] = {
imgTween = {
{imgId = 103, duration = 0.2, 
pos = {450, -350, 0}
, alpha = 0, isDark = false}
, 
{imgId = 101, duration = 0.2, 
pos = {-450, -350, 0}
, alpha = 0, isDark = false}
}
, content = 210, contentType = 2}
, 
[22] = {
imgTween = {
{imgId = 103, duration = 0.2, 
pos = {400, -350, 0}
, alpha = 1, isDark = true}
, 
{imgId = 101, duration = 0.2, 
pos = {-400, -350, 0}
, alpha = 1, isDark = false}
}
, content = 220, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 1}
, 
[23] = {
imgTween = {
{imgId = 101, isDark = true}
, 
{imgId = 103, isDark = false}
}
, content = 230, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[25] = {
imgTween = {
{imgId = 103, isDark = true}
, 
{imgId = 101, isDark = false}
}
, content = 250, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 1}
, 
[26] = {
imgTween = {
{imgId = 101, isDark = true}
, 
{imgId = 103, isDark = false}
}
, content = 260, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[27] = {
imgTween = {
{imgId = 103, duration = 1, 
pos = {0, -350, 0}
, alpha = 1, isDark = false}
, 
{imgId = 101, duration = 0.2, 
pos = {-450, -350, 0}
, alpha = 0, isDark = false}
}
, content = 270, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2}
, 
[28] = {
imgTween = {
{imgId = 101, 
pos = {-50, -350, 0}
, alpha = 0.2, isDark = false}
, 
{imgId = 101, duration = 0.2, 
pos = {0, -350, 0}
, alpha = 1, isDark = false}
, 
{imgId = 103, 
pos = {50, -350, 0}
, alpha = 0, isDark = false}
}
, content = 280, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2}
, 
[29] = {
imgTween = {
{imgId = 103, duration = 0.2, 
pos = {0, -350, 0}
, alpha = 1, isDark = false}
, 
{imgId = 101, duration = 0.2, 
pos = {-50, -350, 0}
, alpha = 0, isDark = false}
}
, content = 290, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2}
, 
[30] = {content = 300, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2}
, 
[33] = {
imgTween = {
{imgId = 103, duration = 1, 
pos = {50, -350, 0}
, alpha = 0, isDark = true}
}
, content = 330, contentType = 2}
, 
[34] = {
imgTween = {
{imgId = 3, duration = 0.2, 
pos = {-270, -400, 0}
, alpha = 1, isDark = false}
}
, content = 340, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[35] = {
imgTween = {
{imgId = 3, duration = 0.2, 
pos = {-345, -400, 0}
, alpha = 0, isDark = false}
, 
{imgId = 1, duration = 0.2, 
pos = {-400, -310, 0}
, alpha = 1, isDark = false}
}
, content = 350, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[36] = {
imgTween = {
{imgId = 2, duration = 0.2, 
pos = {400, -330, 0}
, alpha = 1, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 360, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[37] = {
imgTween = {
{imgId = 2, duration = 0.2, 
pos = {450, -330, 0}
, alpha = 0, isDark = false}
, 
{imgId = 1, duration = 0.2, 
pos = {-475, -310, 0}
, alpha = 0, isDark = false}
, 
{imgId = 101, 
pos = {-450, -350, 0}
, alpha = 0.2}
, 
{imgId = 101, duration = 0.2, 
pos = {-400, -350, 0}
, alpha = 1, isDark = false}
}
, content = 370, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 1}
, 
[38] = {
imgTween = {
{imgId = 101, duration = 0.2, 
pos = {-450, -350, 0}
, alpha = 0, isDark = false}
}
, content = 380, contentType = 2, contentShake = true}
, 
[39] = {
imgTween = {
{imgId = 103, 
pos = {400, -350, 0}
, alpha = 1, isDark = false}
}
, content = 390, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3, contentShake = true}
, 
[40] = {
imgTween = {
{imgId = 3, duration = 0.2, 
pos = {-270, -400, 0}
, alpha = 1, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 400, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
branch = {
{content = 401, jumpAct = 41}
, 
{content = 402, jumpAct = 44}
}
}
, 
[41] = {
imgTween = {
{imgId = 3, duration = 0.2, 
pos = {-345, -400, 0}
, alpha = 0, isDark = false}
, 
{imgId = 103, isDark = false}
}
, content = 410, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[43] = {
imgTween = {
{imgId = 101, duration = 0.2, 
pos = {-400, -350, 0}
, alpha = 1, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 430, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 1, nextId = 47}
, 
[44] = {
imgTween = {
{imgId = 3, duration = 0.2, 
pos = {-345, -400, 0}
, alpha = 0, isDark = false}
, 
{imgId = 103, isDark = false}
}
, content = 440, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3, contentShake = true}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[46] = {
imgTween = {
{imgId = 101, duration = 0.2, 
pos = {-400, -350, 0}
, alpha = 1, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 460, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 1}
, 
[47] = {
imgTween = {
{imgId = 1, duration = 0.2, 
pos = {-400, -310, 0}
, alpha = 1, isDark = false}
, 
{imgId = 101, duration = 0.2, 
pos = {-450, -350, 0}
, alpha = 0, isDark = false}
}
, content = 470, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[48] = {
imgTween = {
{imgId = 1, duration = 0.2, 
pos = {-475, -310, 0}
, alpha = 0, isDark = false}
, 
{imgId = 101, duration = 0.2, 
pos = {-400, -350, 0}
, alpha = 1, isDark = false}
}
, content = 480, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 1}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 1}
, 
[50] = {
imgTween = {
{imgId = 103, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 500, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[51] = {
imgTween = {
{imgId = 103, alpha = 0}
, 
{imgId = 101, alpha = 0}
}
, content = 510, contentType = 2}
, 
[52] = {
imgTween = {
{imgId = 101, alpha = 1, isDark = false}
, 
{imgId = 103, alpha = 1, isDark = true}
}
, content = 520, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 1}
, 
[53] = {
imgTween = {
{imgId = 103, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 530, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[54] = {
imgTween = {
{imgId = 1, 
pos = {0, -310, 0}
, alpha = 1, isDark = false}
, 
{imgId = 103, alpha = 0}
, 
{imgId = 101, alpha = 0}
}
, content = 540, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[55] = {content = 550, contentType = 2}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[58] = {
images = {
{imgId = 98, imgPath = "cpt00/cpt00_e_bg005", imgType = 2, alpha = 0, fullScreen = true}
}
, 
imgTween = {
{imgId = 99, duration = 4, alpha = 0}
, 
{imgId = 98, duration = 1, alpha = 1}
}
, content = 580, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[59] = {
images = {
{imgId = 99, delete = true}
}
, content = 590, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[60] = {
images = {
{imgId = 5, imgPath = "croque_avg", imgType = 3, 
pos = {50, -300, 0}
, 
rot = {0, 0, 0}
, 
scale = {1.55, 1.55, 1.55}
, alpha = 0.2}
}
, 
imgTween = {
{imgId = 5, duration = 0.2, 
pos = {0, -300, 0}
, alpha = 1, isDark = false}
, 
{imgId = 1, alpha = 0}
}
, content = 600, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[61] = {
imgTween = {
{imgId = 4, 
pos = {-100, -50, 0}
, 
rot = {0, 180, 0}
, alpha = 0.2, isDark = false}
, 
{imgId = 4, duration = 0.2, 
pos = {-50, -50, 0}
, alpha = 1, isDark = false}
, 
{imgId = 5, duration = 0.2, 
pos = {50, -300, 0}
, alpha = 0, isDark = false}
}
, content = 610, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[62] = {
imgTween = {
{imgId = 4, alpha = 0}
, 
{imgId = 2, 
pos = {-50, -330, 0}
, 
rot = {0, 0, 0}
, alpha = 0.2}
, 
{imgId = 2, 
pos = {0, -330, 0}
, duration = 0.2, alpha = 1, isDark = false}
}
, content = 620, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[63] = {
imgTween = {
{imgId = 1, 
pos = {-400, -310, 0}
, alpha = 1, isDark = false}
, 
{imgId = 2, alpha = 0}
}
, content = 630, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[64] = {
imgTween = {
{imgId = 3, 
pos = {500, -400, 0}
, alpha = 1, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 640, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[65] = {
imgTween = {
{imgId = 3, isDark = true}
, 
{imgId = 1, isDark = false}
}
, content = 650, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[66] = {
imgTween = {
{imgId = 3, alpha = 0}
, 
{imgId = 5, 
pos = {380, -300, 0}
, 
rot = {0, 0, 0}
, alpha = 1}
, 
{imgId = 1, isDark = true}
}
, content = 660, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[67] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 670, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[68] = {
images = {
{imgId = 9, imgPath = "cpt02/cpt02_e_bg002", imgType = 2, fullScreen = true}
}
, 
imgTween = {
{imgId = 1, alpha = 0}
, 
{imgId = 5, alpha = 0}
}
, content = 680, contentType = 1}
, 
[69] = {
imgTween = {
{imgId = 1, alpha = 1}
, 
{imgId = 101, 
pos = {450, -350, 0}
, alpha = 0.2, 
rot = {0, 180, 0}
}
, 
{imgId = 101, duration = 0.2, 
pos = {400, -350, 0}
, isDark = true, alpha = 1}
}
, content = 690, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
audio = {
bgm = {cue = "Mus_Story_Relax", sheet = "Music"}
}
}
, 
[70] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 101, isDark = false}
}
, content = 700, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[71] = {
images = {
{imgId = 99, imgPath = "cpt02/cpt02_e_bg001_2", imgType = 2, fullScreen = true}
}
, 
imgTween = {
{imgId = 1, alpha = 0}
, 
{imgId = 101, alpha = 0}
}
, content = 710, contentType = 1, 
audio = {
bgm = {stop = true, sheet = "Music"}
}
}
, 
[72] = {
imgTween = {
{imgId = 103, 
pos = {450, -350, 0}
, alpha = 0.2, 
rot = {0, 0, 0}
}
, 
{imgId = 103, duration = 0.2, 
pos = {400, -350, 0}
, isDark = false, alpha = 1}
}
, content = 720, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[73] = {
imgTween = {
{imgId = 4, 
pos = {-500, -50, 0}
, alpha = 0.2, isDark = false}
, 
{imgId = 4, duration = 0.2, 
pos = {-430, -50, 0}
, alpha = 1, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 730, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[74] = {
imgTween = {
{imgId = 4, isDark = true}
, 
{imgId = 103, isDark = false}
}
, content = 740, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[75] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 750, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[76] = {
imgTween = {
{imgId = 4, isDark = true}
, 
{imgId = 103, isDark = false}
}
, content = 760, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[77] = {content = 770, contentType = 2}
, 
[78] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 780, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[79] = {
imgTween = {
{imgId = 4, isDark = true}
, 
{imgId = 103, isDark = false}
}
, content = 790, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3, 
audio = {
bgm = {cue = "Mus_Story_Relax", sheet = "Music"}
}
}
, 
[80] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 800, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[81] = {
imgTween = {
{imgId = 4, isDark = true}
, 
{imgId = 103, isDark = false}
}
, content = 810, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[82] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 820, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[83] = {content = 830, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[84] = {content = 840, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[85] = {content = 850, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[86] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 103, isDark = false}
}
, content = 860, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[87] = {
imgTween = {
{imgId = 4, duration = 4, 
pos = {-600, -50, 0}
, alpha = 0, isDark = false}
}
, content = 870, contentType = 2}
, 
[88] = {content = 880, contentType = 2}
, 
[89] = {
imgTween = {
{imgId = 103, duration = 1, 
pos = {0, -350, 0}
, alpha = 1, isDark = false}
}
, content = 890, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2}
}
return AvgCfg_cpt02_e_23_01


-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt02_e_21_01 = {
[1] = {
images = {
{imgId = 99, imgPath = "cpt02/cpt02_e_bg004_2", imgType = 2, fullScreen = true}
, 
{imgId = 103, imgPath = "mara_blue_avg", imgType = 3, 
rot = {0, 0, 0}
, alpha = 1}
}
, 
imgTween = {
{imgId = 103, duration = 1, shake = true}
}
, content = 10, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}
}
}
, 
[2] = {
imgTween = {
{imgId = 103, alpha = 0}
}
, content = 20, contentType = 2}
, 
[3] = {
images = {
{imgId = 3, imgPath = "sol", imgType = 3, 
pos = {100, -400, 0}
, 
rot = {0, 0, 0}
, 
scale = {1.45, 1.45, 1.45}
, alpha = 0.2}
}
, 
imgTween = {
{imgId = 3, duration = 0.2, 
pos = {0, -400, 0}
, alpha = 1, isDark = false}
, 
{imgId = 103, duration = 0.2, 
pos = {-50, 0, 0}
, alpha = 0, isDark = false}
}
, content = 30, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[4] = {
imgTween = {
{imgId = 3, duration = 0.2, 
pos = {100, -400, 0}
, alpha = 0, isDark = false}
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
{imgId = 103, alpha = 0}
}
, content = 70, contentType = 2}
, 
[8] = {
imgTween = {
{imgId = 103, alpha = 1, duration = 1, shake = true}
}
, content = 80, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2, contentShake = true}
, 
[9] = {
imgTween = {
{imgId = 103, alpha = 0}
}
, content = 90, contentType = 2}
, 
[10] = {
imgTween = {
{imgId = 103, duration = 2, alpha = 1, shake = true}
}
, content = 100, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2, contentShake = true}
, 
[11] = {
imgTween = {
{imgId = 103, alpha = 0}
}
, content = 110, contentType = 2}
, 
[12] = {
images = {
{imgId = 2, imgPath = "anna_avg", imgType = 3, 
pos = {-475, -330, 0}
, 
rot = {0, 0, 0}
, 
scale = {1.6, 1.6, 1.6}
, alpha = 0.2}
}
, 
imgTween = {
{imgId = 2, duration = 0.2, 
pos = {-400, -330, 0}
, alpha = 1, isDark = false}
}
, content = 120, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[13] = {
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
{imgId = 2, duration = 0.2, 
pos = {-475, -330, 0}
, alpha = 0, isDark = false}
}
, content = 130, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[14] = {
imgTween = {
{imgId = 3, 
pos = {-270, -400, 0}
, alpha = 1, isDark = false}
, 
{imgId = 1, alpha = 0}
}
, content = 140, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[15] = {
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
{imgId = 3, duration = 0.2, 
pos = {-345, -400, 0}
, alpha = 0}
}
, content = 150, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[16] = {
images = {
{imgId = 5, imgPath = "croque_avg", imgType = 3, 
pos = {-455, -300, 0}
, 
rot = {0, 180, 0}
, 
scale = {1.55, 1.55, 1.55}
, alpha = 0.2}
}
, 
imgTween = {
{imgId = 5, duration = 0.2, 
pos = {-380, -300, 0}
, alpha = 1, isDark = false}
, 
{imgId = 4, duration = 0.2, 
pos = {-500, -50, 0}
, alpha = 0}
}
, content = 160, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[17] = {
imgTween = {
{imgId = 5, duration = 0.2, 
pos = {-455, -300, 0}
, alpha = 0}
}
, content = 170, contentType = 2, contentShake = true}
, 
[18] = {
imgTween = {
{imgId = 103, duration = 2, 
pos = {0, 0, 0}
, alpha = 1, shake = true, isDark = false}
}
, content = 180, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2, contentShake = true}
, 
[19] = {
imgTween = {
{imgId = 103, duration = 0.2, 
pos = {-50, 0, 0}
, alpha = 0, isDark = false}
}
, content = 190, contentType = 2, 
audio = {
bgm = {stop = true, sheet = "Music"}
}
}
, 
[20] = {
imgTween = {
{imgId = 103, duration = 0.2, 
pos = {0, 0, 0}
, alpha = 1, isDark = false}
}
, content = 200, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2}
, 
[23] = {
imgTween = {
{imgId = 103, duration = 0.2, 
pos = {-50, 0, 0}
, alpha = 0, isDark = false}
, 
{imgId = 1, duration = 0.2, 
pos = {-400, -310, 0}
, alpha = 1, isDark = false}
}
, content = 230, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[24] = {
imgTween = {
{imgId = 103, 
pos = {-50, 0, 0}
, alpha = 1, isDark = false}
, 
{imgId = 1, duration = 0.2, 
pos = {-450, -310, 0}
, alpha = 0, isDark = false}
}
, content = 240, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2}
, 
[25] = {
imgTween = {
{imgId = 103, duration = 1, 
pos = {50, 0, 0}
, alpha = 1, isDark = false}
}
, content = 250, contentType = 2}
, 
[26] = {
imgTween = {
{imgId = 3, duration = 0.2, 
pos = {-270, -400, 0}
, alpha = 1}
, 
{imgId = 103, duration = 0.2, 
pos = {50, 0, 0}
, alpha = 0, isDark = false}
}
, content = 260, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[27] = {
imgTween = {
{imgId = 3, 
pos = {-345, -400, 0}
, alpha = 0}
, 
{imgId = 103, 
pos = {-50, 0, 0}
, alpha = 1, isDark = false}
, 
{imgId = 103, duration = 1, 
pos = {50, 0, 0}
, alpha = 1, isDark = false}
}
, content = 270, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2}
, 
[28] = {
imgTween = {
{imgId = 103, duration = 1, 
pos = {100, 0, 0}
, alpha = 1, isDark = false}
}
, content = 280, contentType = 2}
, 
[29] = {
imgTween = {
{imgId = 1, duration = 0.2, 
pos = {-400, -310, 0}
, alpha = 1}
, 
{imgId = 103, duration = 0.2, 
pos = {100, 0, 0}
, alpha = 0, isDark = false}
}
, content = 290, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[30] = {
imgTween = {
{imgId = 2, duration = 0.2, 
pos = {-400, -330, 0}
, alpha = 1, isDark = false}
, 
{imgId = 1, duration = 0.2, 
pos = {-475, -310, 0}
, alpha = 0}
}
, content = 300, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[32] = {
imgTween = {
{imgId = 2, 
pos = {-475, -330, 0}
, alpha = 0}
, 
{imgId = 103, 
pos = {-50, 0, 0}
, alpha = 1}
, 
{imgId = 103, duration = 1, 
pos = {50, 0, 0}
, alpha = 1}
}
, content = 320, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2}
, 
[33] = {
imgTween = {
{imgId = 4, duration = 0.2, 
pos = {-430, -50, 0}
, alpha = 1, isDark = false}
, 
{imgId = 103, duration = 0.2, 
pos = {50, 0, 0}
, alpha = 0}
}
, content = 330, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[35] = {
imgTween = {
{imgId = 4, duration = 0.2, 
pos = {-500, -50, 0}
, alpha = 0, isDark = false}
, 
{imgId = 103, 
pos = {0, 0, 0}
, alpha = 1}
}
, content = 350, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2}
, 
[36] = {
imgTween = {
{imgId = 3, duration = 0.2, 
pos = {-270, -400, 0}
, alpha = 1, isDark = false}
, 
{imgId = 103, duration = 0.2, 
pos = {0, 0, 0}
, alpha = 0}
}
, content = 360, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[37] = {
imgTween = {
{imgId = 3, duration = 0.2, 
pos = {-345, -400, 0}
, alpha = 0, isDark = false}
, 
{imgId = 5, duration = 0.2, 
pos = {-380, -300, 0}
, alpha = 1, isDark = false}
}
, content = 370, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[38] = {
imgTween = {
{imgId = 5, duration = 0.2, 
pos = {-455, -300, 0}
, alpha = 0, isDark = false}
, 
{imgId = 2, duration = 0.2, 
pos = {-400, -330, 0}
, alpha = 1, isDark = false}
}
, content = 380, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
branch = {
{content = 381, jumpAct = 39}
}
}
, 
[39] = {
imgTween = {
{imgId = 2, duration = 0.2, 
pos = {-475, -330, 0}
, alpha = 0, isDark = false}
}
, content = 390, contentType = 2}
, 
[40] = {
imgTween = {
{imgId = 103, 
pos = {0, 0, 0}
, alpha = 0}
, 
{imgId = 103, duration = 3, 
pos = {0, 0, 0}
, alpha = 1}
}
, content = 400, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2}
, 
[41] = {
imgTween = {
{imgId = 103, duration = 0.1, 
pos = {0, 0, 0}
, alpha = 0}
}
, content = 410, contentType = 2, contentShake = true, 
audio = {
bgm = {stop = true, sheet = "Music"}
}
}
, 
[42] = {content = 420, contentType = 2}
, 
[43] = {
imgTween = {
{imgId = 3, duration = 0.2, 
pos = {-270, -400, 0}
, alpha = 1, isDark = false}
}
, content = 430, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[44] = {
imgTween = {
{imgId = 5, 
pos = {380, -300, 0}
, 
rot = {0, 0, 0}
, alpha = 1, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 440, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[45] = {
imgTween = {
{imgId = 3, duration = 0.2, 
pos = {-345, -400, 0}
, alpha = 0, isDark = false}
, 
{imgId = 2, duration = 0.2, 
pos = {-400, -330, 0}
, alpha = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 450, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[46] = {
imgTween = {
{imgId = 2, isDark = true}
, 
{imgId = 4, 
pos = {430, -50, 0}
, 
rot = {0, 0, 0}
, alpha = 1, isDark = false}
, 
{imgId = 5, alpha = 0}
}
, content = 460, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[47] = {
imgTween = {
{imgId = 2, duration = 0.2, 
pos = {-475, -330, 0}
, alpha = 0, isDark = false}
, 
{imgId = 1, duration = 0.2, 
pos = {-400, -310, 0}
, alpha = 1, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 470, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[48] = {
imgTween = {
{imgId = 1, duration = 0.2, 
pos = {-475, -310, 0}
, alpha = 0, isDark = false}
, 
{imgId = 4, alpha = 0}
}
, content = 480, contentType = 4, speakerName = 471, 
audio = {
bgm = {cue = "Mus_Story_Purifier", sheet = "Music"}
}
}
, 
[49] = {
imgTween = {
{imgId = 1, duration = 0.2, 
pos = {-400, -310, 0}
, alpha = 1, isDark = false}
}
, content = 490, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[50] = {
imgTween = {
{imgId = 1, duration = 0.2, 
pos = {-475, -310, 0}
, alpha = 0, isDark = false}
}
, content = 500, contentType = 2}
, 
[51] = {
imgTween = {
{imgId = 3, duration = 0.2, 
pos = {-270, -400, 0}
, alpha = 1, isDark = false}
}
, content = 510, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[52] = {
imgTween = {
{imgId = 3, duration = 0.2, 
pos = {-345, -400, 0}
, alpha = 0, isDark = false}
}
, content = 520, contentType = 2}
, 
[53] = {content = 530, contentType = 4, speakerName = 471}
, 
[54] = {
imgTween = {
{imgId = 1, duration = 0.2, 
pos = {-400, -310, 0}
, alpha = 1, isDark = false}
}
, content = 540, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[55] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 550, contentType = 4, speakerName = 471}
, 
[56] = {
imgTween = {
{imgId = 1, isDark = false}
}
, content = 560, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[57] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 570, contentType = 4, speakerName = 471}
, 
[58] = {content = 580, contentType = 4, speakerName = 471}
, 
[59] = {
imgTween = {
{imgId = 1, isDark = false}
}
, content = 590, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[60] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 600, contentType = 4, speakerName = 471}
, 
[61] = {content = 610, contentType = 4, speakerName = 471, 
audio = {
bgm = {cue = "Mus_Story_Purifier", sheet = "Music"}
}
}
, 
[62] = {
imgTween = {
{imgId = 1, alpha = 0}
, 
{imgId = 3, duration = 0.2, 
pos = {-270, -400, 0}
, alpha = 1, isDark = false}
}
, content = 620, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[63] = {content = 630, contentType = 1}
, 
[64] = {content = 640, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[65] = {content = 650, contentType = 1}
, 
[66] = {content = 660, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[67] = {content = 670, contentType = 1}
, 
[68] = {
imgTween = {
{imgId = 3, alpha = 0}
, 
{imgId = 1, alpha = 1, isDark = false}
}
, content = 680, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[69] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 690, contentType = 4, speakerName = 471}
, 
[70] = {
imgTween = {
{imgId = 103, duration = 3, 
pos = {0, 0, 0}
, alpha = 0.5}
, 
{imgId = 1, alpha = 0}
}
, content = 700, contentType = 2}
, 
[71] = {
imgTween = {
{imgId = 1, alpha = 1, isDark = false}
, 
{imgId = 103, duration = 0.2, 
pos = {0, 0, 0}
, alpha = 0}
}
, content = 710, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[72] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 720, contentType = 4, speakerName = 471}
, 
[73] = {
imgTween = {
{imgId = 1, alpha = 0}
, 
{imgId = 103, 
pos = {0, 0, 0}
, alpha = 0.5}
, 
{imgId = 103, duration = 1.5, 
pos = {0, 0, 0}
, alpha = 1}
}
, content = 730, contentType = 2}
, 
[74] = {
imgTween = {
{imgId = 3, alpha = 1}
, 
{imgId = 103, alpha = 0}
}
, content = 740, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[75] = {
imgTween = {
{imgId = 4, 
pos = {430, -50, 0}
, alpha = 1, isDark = false}
}
, content = 750, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
}
return AvgCfg_cpt02_e_21_01


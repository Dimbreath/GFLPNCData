-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt01_e_08_01 = {
[1] = {
images = {
{imgId = 99, imgPath = "cpt01/cpt01_e_bg001", imgType = 2, fullScreen = true, delete = false}
, 
{imgId = 3, imgPath = "sol", imgType = 3, 
pos = {575, -400, 0}
, 
rot = {0, 0, 0}
, order = 10, 
scale = {1.45, 1.45, 1.45}
, alpha = 0.2}
}
, 
imgTween = {
{imgId = 3, duration = 0.2, 
pos = {500, -400, 0}
, alpha = 1, isDark = false}
}
, content = 10, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}
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
{imgId = 3, isDark = true}
}
, content = 20, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[3] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 3, isDark = false}
}
, content = 30, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[4] = {
imgTween = {
{imgId = 3, duration = 0.2, 
pos = {575, -400, 0}
, alpha = 0, isDark = false}
, 
{imgId = 1, duration = 0.2, 
pos = {-475, -310, 0}
, alpha = 0, isDark = false}
}
, content = 40, contentType = 4, speakerName = 41, 
audio = {
bgm = {stop = true, sheet = "Music"}
}
}
, 
[5] = {content = 50, contentType = 4, speakerName = 41}
, 
[6] = {
imgTween = {
{imgId = 3, duration = 0.2, 
pos = {500, -400, 0}
, alpha = 1, isDark = false, shake = true}
}
, content = 60, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, contentShake = true}
, 
[7] = {
images = {
{imgId = 6, imgPath = "fresnel_avg", imgType = 3, 
pos = {-465, -300, 0}
, 
rot = {0, 0, 0}
, 
scale = {1.2, 1.2, 1.2}
, alpha = 0.2}
}
, 
imgTween = {
{imgId = 6, duration = 0.2, 
pos = {-390, -300, 0}
, alpha = 1, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 70, contentType = 3, speakerHeroId = 1006, speakerHeroPosId = 1}
, 
[8] = {
imgTween = {
{imgId = 6, duration = 0.2, 
pos = {-465, -300, 0}
, alpha = 0, isDark = false}
, 
{imgId = 1, duration = 0.2, 
pos = {-400, -310, 0}
, alpha = 1, isDark = false}
}
, content = 80, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[9] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 3, isDark = false}
}
, content = 90, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[10] = {
imgTween = {
{imgId = 3, isDark = true}
, 
{imgId = 1, isDark = false}
}
, content = 100, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[11] = {
images = {
{imgId = 102, imgPath = "riko_avg", imgType = 3, 
pos = {0, -300, 0}
, 
rot = {0, 0, 0}
, order = 11, 
scale = {-1.05, 1.05, 1.05}
, alpha = 0}
}
, 
imgTween = {
{imgId = 1, duration = 0.2, 
pos = {-475, -310, 0}
, alpha = 0, isDark = false}
, 
{imgId = 3, isDark = false, duration = 0.2, 
pos = {575, -400, 0}
, alpha = 0, isDark = false}
, 
{imgId = 102, duration = 1, alpha = 1, isDark = false}
}
, content = 110, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2, 
audio = {
bgm = {cue = "Mus_Story_Funny", sheet = "Music"}
}
}
, 
[12] = {
imgTween = {
{imgId = 102, isDark = true}
}
, content = 120, contentType = 4, speakerName = 121}
, 
[13] = {
imgTween = {
{imgId = 1, duration = 0.2, 
pos = {-400, -310, 0}
, alpha = 1, isDark = false}
, 
{imgId = 102, alpha = 0, isDark = false}
}
, content = 130, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[15] = {
imgTween = {
{imgId = 3, duration = 0.2, 
pos = {500, -400, 0}
, alpha = 1, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 150, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[16] = {
imgTween = {
{imgId = 3, duration = 0.5, 
pos = {300, -400, 0}
, alpha = 0, isDark = false}
, 
{imgId = 1, alpha = 0, isDark = false}
, 
{imgId = 102, duration = 0.5, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 1, duration = 0.5, shake = true}
}
, content = 160, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 2, contentShake = true}
, 
[17] = {
imgTween = {
{imgId = 102, duration = 0.5, 
pos = {400, -300, 0}
}
}
, content = 170, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3, contentShake = true}
, 
[18] = {
imgTween = {
{imgId = 3, 
pos = {-200, -400, 0}
, alpha = 0.2}
, 
{imgId = 3, duration = 0.5, 
pos = {-270, -400, 0}
, alpha = 1, isDark = false}
}
, content = 180, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[19] = {
imgTween = {
{imgId = 102, isDark = true}
}
, content = 190, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[20] = {
imgTween = {
{imgId = 3, isDark = true}
, 
{imgId = 102, isDark = false}
}
, content = 200, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[22] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 220, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[23] = {
imgTween = {
{imgId = 3, isDark = true}
, 
{imgId = 102, isDark = false}
}
, content = 230, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[24] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 240, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
branch = {
{content = 241, jumpAct = 25}
, 
{content = 242, jumpAct = 27}
}
}
, 
[25] = {
imgTween = {
{imgId = 3, 
pos = {-345, -400, 0}
, alpha = 0, isDark = false}
, 
{imgId = 102, isDark = false}
}
, content = 250, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3, nextId = 30}
, 
[27] = {
imgTween = {
{imgId = 3, 
pos = {-345, -400, 0}
, alpha = 0, isDark = false}
, 
{imgId = 102, isDark = false}
}
, content = 270, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[30] = {content = 300, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[33] = {
imgTween = {
{imgId = 1, duration = 0.2, 
pos = {-400, -310, 0}
, alpha = 1, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 330, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[34] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 102, isDark = false}
}
, content = 340, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[35] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 350, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[36] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 102, isDark = false}
}
, content = 360, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[41] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 410, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[42] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 102, isDark = false}
}
, content = 420, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[45] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 450, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[46] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 102, isDark = false}
}
, content = 460, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[48] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 480, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[49] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 102, isDark = false}
}
, content = 490, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[51] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 510, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[52] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 102, isDark = false}
}
, content = 520, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[53] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 530, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[54] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 102, isDark = false}
}
, content = 540, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[55] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 550, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[56] = {
imgTween = {
{imgId = 3, duration = 0.2, 
pos = {-270, -400, 0}
, alpha = 1, isDark = false}
, 
{imgId = 1, duration = 0.2, 
pos = {-500, -310, 0}
, alpha = 0, isDark = false}
}
, content = 560, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[57] = {
imgTween = {
{imgId = 1, duration = 0.2, 
pos = {-400, -310, 0}
, alpha = 1, isDark = false}
, 
{imgId = 3, duration = 0.2, 
pos = {-345, -400, 0}
, alpha = 0, isDark = false}
}
, content = 570, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[58] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 102, isDark = false}
}
, content = 580, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[59] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 590, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[60] = {
imgTween = {
{imgId = 3, duration = 0.2, 
pos = {-270, -400, 0}
, alpha = 1, isDark = false}
, 
{imgId = 1, duration = 0.2, 
pos = {-475, -310, 0}
, alpha = 0, isDark = false}
}
, content = 600, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[61] = {
imgTween = {
{imgId = 3, isDark = true}
, 
{imgId = 102, isDark = false}
}
, content = 610, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3, contentShake = true, 
audio = {
bgm = {stop = true, sheet = "Music"}
}
}
, 
[62] = {
images = {
{imgId = 98, imgPath = "cpt01/cpt01_e_bg003", imgType = 2, fullScreen = true, delete = false, alpha = 0}
, 
{imgId = 50, imgPath = "cpt00/cpt00_e_bg001", imgType = 4, fullScreen = true, alpha = 0}
}
, 
imgTween = {
{imgId = 50, duration = 0.5, alpha = 1}
, 
{imgId = 50, delay = 0.5, duration = 0.5, alpha = 0}
, 
{imgId = 3, alpha = 0}
, 
{imgId = 3, delay = 1, alpha = 1, isDark = false}
, 
{imgId = 102, alpha = 0}
, 
{imgId = 98, delay = 0.5, alpha = 1}
, 
{imgId = 99, delay = 0.5, alpha = 0}
}
, content = 620, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
audio = {
bgm = {stop = true, cue = "", sheet = "Music"}
}
}
, 
[63] = {
images = {
{imgId = 99, delete = true}
}
, 
imgTween = {
{imgId = 3, isDark = true}
, 
{imgId = 102, 
pos = {450, -300, 0}
, alpha = 0.2, isDark = false}
, 
{imgId = 102, duration = 0.2, 
pos = {400, -300, 0}
, alpha = 1, isDark = false}
}
, content = 630, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[64] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 640, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[65] = {
imgTween = {
{imgId = 3, isDark = true}
, 
{imgId = 102, isDark = false}
}
, content = 650, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[66] = {
imgTween = {
{imgId = 1, duration = 0.2, 
pos = {-400, -310, 0}
, alpha = 1, isDark = false}
, 
{imgId = 3, duration = 0.2, 
pos = {-345, -400, 0}
, alpha = 0, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 660, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[67] = {content = 670, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[68] = {
imgTween = {
{imgId = 3, duration = 0.2, 
pos = {-270, -400, 0}
, alpha = 1, isDark = false}
, 
{imgId = 1, duration = 0.2, 
pos = {-500, -310, 0}
, alpha = 0, isDark = false}
}
, content = 680, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[69] = {
imgTween = {
{imgId = 3, isDark = true}
, 
{imgId = 102, isDark = false}
}
, content = 690, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[70] = {
imgTween = {
{imgId = 1, duration = 0.2, 
pos = {-400, -310, 0}
, alpha = 1, isDark = false}
, 
{imgId = 3, duration = 0.2, 
pos = {-270, -400, 0}
, alpha = 0, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 700, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
}
return AvgCfg_cpt01_e_08_01


-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt03_e_02_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 98, imgType = 2, alpha = 0, imgPath = "cpt03/cpt03_e_bg002", fullScreen = true}
, 
{imgId = 97, imgType = 2, alpha = 0, imgPath = "cpt03/cpt03_e_bg004", fullScreen = true}
, 
{imgId = 1, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 5, imgType = 3, alpha = 0, imgPath = "croque_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 27, imgType = 3, alpha = 0, imgPath = "zion_avg", order = 1}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "choco_avg", order = 2}
, 
{imgId = 102, imgType = 3, alpha = 0, imgPath = "sisy_avg"}
}
, 
imgTween = {
{imgId = 98, duration = 1, alpha = 1}
}
, content = 10, contentType = 4, speakerName = 12, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 4}
, 
sfx = {cue = "AVG_Alarm", sheet = "AVG_gf", audioId = 1}
}
}
, 
[2] = {content = 20, contentType = 2, 
audio = {
sfx = {cue = "AVG_Crowd_Run", sheet = "AVG_gf", audioId = 2}
}
}
, 
[3] = {content = 30, contentType = 4, speakerName = 12}
, 
[4] = {content = 40, contentType = 4, speakerName = 12}
, 
[5] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.5}
}
, 
heroFace = {
{imgId = 1, faceId = 4}
}
, content = 50, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[6] = {
imgTween = {
{imgId = 5, posId = 5}
, 
{imgId = 5, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
}
, content = 60, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, nextId = 99}
, 
[7] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 70, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[8] = {
imgTween = {
{imgId = 1, duration = 0.5, posId = 1}
, 
{imgId = 5, duration = 0.5, posId = 5}
}
, content = 80, contentType = 2}
, 
[9] = {content = 90, contentType = 2}
, 
[10] = {
imgTween = {
{imgId = 102, posId = 5}
, 
{imgId = 102, posId = 4, isDark = false, duration = 0.2}
}
, content = 110, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[11] = {
imgTween = {
{imgId = 102, 
pos = {0, -280, 0}
, isDark = false, duration = 0.5}
}
, content = 120, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2}
, 
[12] = {content = 130, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2}
, 
[13] = {
imgTween = {
{imgId = 102, isDark = true, duration = 0.5}
}
, 
branch = {
{content = 131, jumpAct = 14}
}
}
, 
[14] = {
imgTween = {
{imgId = 102, isDark = false}
}
, content = 150, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2}
, 
[15] = {content = 160, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2}
, 
[16] = {
imgTween = {
{imgId = 102, duration = 0.2, alpha = 0}
, 
{imgId = 1, duration = 0.2, posId = 1}
, 
{imgId = 98, duration = 1, alpha = 0}
, 
{imgId = 97, duration = 1, delay = 1, alpha = 1}
}
, autoContinue = true}
, 
[17] = {
imgTween = {
{imgId = 102, alpha = 0, posId = 5}
, 
{imgId = 102, posId = 4, isDark = false, duration = 0.2}
}
, content = 180, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3, 
audio = {
sfx = {cue = "AVG_BaseDoor_Close", sheet = "AVG_gf"}
}
}
, 
[18] = {content = 190, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[19] = {
imgTween = {
{imgId = 5, posId = 1}
, 
{imgId = 5, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 102, isDark = true}
}
, content = 200, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[20] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 210, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[21] = {
imgTween = {
{imgId = 101, posId = 1}
, 
{imgId = 101, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 102, isDark = true}
, 
{imgId = 5, posId = 1, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 101, faceId = 6}
}
, content = 220, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[22] = {content = 230, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[23] = {
imgTween = {
{imgId = 1, posId = 5}
, 
{imgId = 1, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
, 
{imgId = 102, posId = 5, isDark = false, duration = 0.2}
}
, content = 240, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[24] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 1, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
, content = 250, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[25] = {
imgTween = {
{imgId = 101, duration = 0.2, shake = true}
}
, 
heroFace = {
{imgId = 101, faceId = 7}
}
, content = 260, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[26] = {content = 270, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[27] = {
imgTween = {
{imgId = 101, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 6}
}
, content = 280, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[28] = {content = 290, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[29] = {
imgTween = {
{imgId = 101, isDark = true}
}
, content = 300, contentType = 2}
, 
[30] = {
imgTween = {
{imgId = 102, posId = 5}
, 
{imgId = 102, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
, 
{imgId = 1, posId = 5, isDark = false, duration = 0.2}
}
, content = 310, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[31] = {content = 320, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[32] = {
imgTween = {
{imgId = 5, posId = 1}
, 
{imgId = 5, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 102, isDark = true}
, 
{imgId = 101, posId = 1, isDark = false, duration = 0.2}
}
, content = 330, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[33] = {
imgTween = {
{imgId = 5, isDark = true}
}
, content = 340, contentType = 4, speakerName = 11}
, 
[34] = {
imgTween = {
{imgId = 5, isDark = false}
}
, content = 350, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[35] = {content = 360, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[36] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 370, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[37] = {content = 380, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[38] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 102, isDark = true}
, 
{imgId = 5, posId = 1, isDark = false, duration = 0.2}
}
, content = 390, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[39] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 400, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[40] = {content = 410, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3, 
branch = {
{content = 411, jumpAct = 41}
}
}
, 
[41] = {
imgTween = {
{imgId = 102, isDark = false}
}
, content = 430, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[42] = {
imgTween = {
{imgId = 102, isDark = true}
, 
{imgId = 1, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 5, posId = 2, isDark = false, duration = 0.2}
}
, content = 440, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[43] = {content = 450, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[44] = {
imgTween = {
{imgId = 101, posId = 5}
, 
{imgId = 101, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 5, isDark = true}
, 
{imgId = 102, posId = 5, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 101, faceId = 6}
}
, content = 460, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3, nextId = 103}
, 
[45] = {content = 470, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[46] = {
imgTween = {
{imgId = 101, posId = 4, isDark = true, alpha = 0, duration = 0.2}
, 
{imgId = 5, isDark = true}
, 
{imgId = 1, posId = 4, isDark = false, alpha = 0, duration = 0}
, 
{imgId = 1, posId = 4, isDark = false, alpha = 1, duration = 0.2}
}
, content = 480, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[47] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 500, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[48] = {
imgTween = {
{imgId = 1, posId = 4, isDark = true, alpha = 0, duration = 0.2}
, 
{imgId = 5, isDark = true}
, 
{imgId = 101, posId = 4, isDark = false, alpha = 0, duration = 0}
, 
{imgId = 101, posId = 4, isDark = false, alpha = 1, duration = 0.2}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
, content = 510, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3}
, 
[49] = {
imgTween = {
{imgId = 102, posId = 5}
, 
{imgId = 102, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 5, isDark = true}
, 
{imgId = 101, posId = 5, isDark = false, duration = 0.2}
}
, content = 520, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[50] = {content = 530, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[51] = {content = 540, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[52] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 550, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[53] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 560, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[54] = {content = 570, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[55] = {content = 580, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[56] = {
imgTween = {
{imgId = 102, duration = 0.5, 
pos = {0, -280, 0}
}
, 
{imgId = 27, posId = 1}
, 
{imgId = 27, posId = 2, isDark = false, delay = 0.5, duration = 0.2}
, 
{imgId = 5, posId = 1, duration = 0.2}
, 
{imgId = 102, duration = 0.5, delay = 1, posId = 4}
, 
{imgId = 102, duration = 0.1, isDark = true, delay = 1.5}
}
, content = 590, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 1, 
audio = {
sfx = {cue = "AVG_BaseDoor_Open", sheet = "AVG_gf"}
}
}
, 
[57] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 27, isDark = true}
}
, content = 600, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[58] = {
imgTween = {
{imgId = 27, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 610, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 1}
, 
[59] = {
imgTween = {
{imgId = 101, posId = 5}
, 
{imgId = 101, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 27, isDark = true}
, 
{imgId = 102, posId = 5, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 101, faceId = 1}
}
, content = 620, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3}
, 
[60] = {
imgTween = {
{imgId = 27, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 630, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[61] = {content = 640, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[62] = {content = 650, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[63] = {
imgTween = {
{imgId = 102, posId = 5}
, 
{imgId = 102, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 27, isDark = true}
, 
{imgId = 101, posId = 5, isDark = false, duration = 0.2}
}
, content = 660, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[64] = {
imgTween = {
{imgId = 5, posId = 1}
, 
{imgId = 5, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 102, isDark = true}
, 
{imgId = 27, posId = 1, isDark = false, duration = 0.2}
}
, content = 670, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[65] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 680, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[66] = {
imgTween = {
{imgId = 1, posId = 5}
, 
{imgId = 1, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 5, isDark = true}
, 
{imgId = 102, posId = 5, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 1, faceId = 5}
}
, content = 690, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[67] = {
imgTween = {
{imgId = 27, posId = 1}
, 
{imgId = 27, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 5, posId = 1, isDark = false, duration = 0.2}
}
, content = 700, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[68] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 27, isDark = true}
}
, content = 710, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[69] = {
imgTween = {
{imgId = 97, duration = 2, shake = true}
, 
{imgId = 1, isDark = true}
, 
{imgId = 1, duration = 2, shake = true}
, 
{imgId = 27, duration = 2, shake = true}
, 
{imgId = 97, duration = 0.5, alpha = 0.5, delay = 2}
}
, content = 720, contentType = 2, 
audio = {
sfx = {cue = "AVG_Explode", sheet = "AVG_gf"}
}
}
, 
[70] = {
imgTween = {
{imgId = 102, posId = 5}
, 
{imgId = 102, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 27, isDark = true}
, 
{imgId = 1, posId = 5, isDark = false, duration = 0.2}
}
, content = 730, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[71] = {
imgTween = {
{imgId = 102, alpha = 0, duration = 0.2}
, 
{imgId = 27, alpha = 0, duration = 0.2}
}
, content = 740, contentType = 4, speakerName = 13, 
audio = {
sfx = {cue = "Skill_Chong_01", sheet = "Mon_Chong", audioId = 4}
}
}
, 
[72] = {content = 750, contentType = 4, speakerName = 13}
, 
[73] = {
imgTween = {
{imgId = 5, posId = 1}
, 
{imgId = 5, posId = 2, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 5, faceId = 6}
}
, content = 760, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[74] = {
imgTween = {
{imgId = 5, isDark = true}
}
, content = 770, contentType = 4, speakerName = 11, isEnd = true}
, 
[99] = {
imgTween = {
{imgId = 5, isDark = true}
, 
{imgId = 1, isDark = false}
}
, content = 61, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[100] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 62, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[101] = {content = 63, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[102] = {content = 64, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, nextId = 7}
, 
[103] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 461, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, nextId = 46}
}
return AvgCfg_cpt03_e_02_01


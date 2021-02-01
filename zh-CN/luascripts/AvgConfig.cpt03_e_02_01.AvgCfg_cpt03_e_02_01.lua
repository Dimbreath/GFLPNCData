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
{imgId = 27, imgType = 3, alpha = 0, imgPath = "zion_avg"}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "choco_avg"}
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
, content = 60, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
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
[9] = {
imgTween = {
{imgId = 102, posId = 4}
, 
{imgId = 102, 
pos = {0, -280, 0}
, isDark = false, duration = 1}
, 
{imgId = 102, alpha = 0, delay = 1, duration = 0.2}
}
, content = 90, contentType = 2}
, 
[10] = {content = 100, contentType = 4, speakerName = 11}
, 
[11] = {
imgTween = {
{imgId = 102, posId = 5}
, 
{imgId = 102, posId = 4, isDark = false, duration = 0.2}
}
, content = 110, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[12] = {
imgTween = {
{imgId = 102, 
pos = {0, -280, 0}
, isDark = false, duration = 0.5}
}
, content = 120, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2}
, 
[14] = {
imgTween = {
{imgId = 102, isDark = true, duration = 0.5}
}
, content = 140, contentType = 4, speakerName = 11}
, 
[15] = {
imgTween = {
{imgId = 102, isDark = false}
}
, content = 150, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2}
, 
[17] = {
imgTween = {
{imgId = 102, duration = 0.2, alpha = 0}
, 
{imgId = 1, duration = 0.2, posId = 1}
, 
{imgId = 98, duration = 1, alpha = 0}
, 
{imgId = 97, duration = 1, delay = 1, alpha = 1}
}
}
, 
[18] = {
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
[19] = {content = 190, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[20] = {
imgTween = {
{imgId = 5, posId = 1}
, 
{imgId = 5, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 102, isDark = true}
}
, content = 200, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[21] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 210, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[22] = {
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
[23] = {content = 230, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[24] = {
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
[25] = {
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
[26] = {
imgTween = {
{imgId = 101, duration = 0.2, shake = true}
}
, 
heroFace = {
{imgId = 101, faceId = 7}
}
, content = 260, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[27] = {
imgTween = {
{imgId = 101, isDark = true}
}
, content = 270, contentType = 4, speakerName = 11}
, 
[28] = {
imgTween = {
{imgId = 101, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 6}
}
, content = 280, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[30] = {
imgTween = {
{imgId = 101, isDark = true}
}
, content = 300, contentType = 2}
, 
[31] = {
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
[32] = {content = 320, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[33] = {
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
[34] = {
imgTween = {
{imgId = 5, isDark = true}
}
, content = 340, contentType = 4, speakerName = 11}
, 
[35] = {
imgTween = {
{imgId = 5, isDark = false}
}
, content = 350, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[37] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 370, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[39] = {
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
[40] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 400, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[42] = {
imgTween = {
{imgId = 102, isDark = true}
}
, content = 420, contentType = 4, speakerName = 11}
, 
[43] = {
imgTween = {
{imgId = 102, isDark = false}
}
, content = 430, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[44] = {
imgTween = {
{imgId = 102, isDark = true}
, 
{imgId = 1, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 5, posId = 2, isDark = false, duration = 0.2}
}
, content = 440, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[46] = {
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
, content = 460, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3}
, 
[47] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 470, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[49] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 5, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 7}
}
, content = 490, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3}
, 
[50] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 101, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
, content = 500, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[52] = {
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
[53] = {content = 530, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[55] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 550, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[56] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 560, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[59] = {
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
[60] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 27, isDark = true}
}
, content = 600, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[61] = {
imgTween = {
{imgId = 27, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 610, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 1}
, 
[62] = {
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
[63] = {
imgTween = {
{imgId = 27, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 630, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[64] = {content = 640, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[65] = {content = 650, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[66] = {
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
[67] = {
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
[68] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 680, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[69] = {
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
[70] = {
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
[71] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 27, isDark = true}
}
, content = 710, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[72] = {
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
[73] = {
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
[74] = {
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
[75] = {content = 750, contentType = 4, speakerName = 13}
, 
[76] = {
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
[77] = {
imgTween = {
{imgId = 5, isDark = true}
}
, content = 770, contentType = 4, speakerName = 11}
}
return AvgCfg_cpt03_e_02_01


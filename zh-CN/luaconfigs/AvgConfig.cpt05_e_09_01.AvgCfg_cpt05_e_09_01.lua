-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt05_e_09_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 1, imgType = 2, alpha = 0, imgPath = "cpt05/cpt05_e_bg001_3", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 104, imgType = 3, alpha = 0, imgPath = "simo_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 105, imgType = 3, alpha = 0, imgPath = "croque_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 117, imgType = 3, alpha = 0, imgPath = "angela_avg"}
, 
{imgId = 34, imgType = 3, alpha = 0, imgPath = "odile_w_avg"}
}
, 
imgTween = {
{imgId = 1, alpha = 1, duration = 1}
, 
{imgId = 1, duration = 0.5, delay = 1.5, shake = true}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
, 
sfx = {cue = "AVG_Battlefield", sheet = "AVG_gf"}
}
, content = 10, contentType = 2}
, 
[2] = {
imgTween = {
{imgId = 103, posId = 1}
, 
{imgId = 103, posId = 2, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 103, faceId = 4}
}
, 
audio = {
sfx = {cue = "Skill_Sol_Passive", sheet = "Chara_Sol"}
}
, content = 20, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[3] = {content = 30, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[4] = {
imgTween = {
{imgId = 105, posId = 5}
, 
{imgId = 105, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 103, isDark = true}
}
, 
audio = {
sfx = {cue = "Skill_Croque_Ex_Start", sheet = "Chara_Croque"}
}
, content = 40, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[5] = {
imgTween = {
{imgId = 103, isDark = false}
, 
{imgId = 103, duration = 0.5, shake = true}
, 
{imgId = 105, isDark = true}
}
, 
audio = {
sfx = {cue = "Skill_Sol_Passive", sheet = "Chara_Sol"}
}
, content = 50, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[6] = {
imgTween = {
{imgId = 103, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 105, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 117, posId = 3}
, 
{imgId = 117, duration = 0.5, shake = true}
}
, 
audio = {
sfx = {cue = "AVG_Explode", sheet = "AVG_gf"}
}
, content = 60, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 2}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 2}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 2}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 2}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 2}
, 
[11] = {
imgTween = {
{imgId = 117, alpha = 0}
, 
{imgId = 101, posId = 3}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
, content = 110, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[12] = {
imgTween = {
{imgId = 101, alpha = 0}
, 
{imgId = 117, posId = 3}
}
, content = 120, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 2}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 2}
, 
[14] = {
imgTween = {
{imgId = 117, alpha = 0}
, 
{imgId = 34, posId = 3, alpha = 0.5}
, 
{imgId = 34, duration = 0.5, alpha = 0, posId = 4}
}
, 
audio = {
sfx = {cue = "AVG_RunStep", sheet = "AVG_gf"}
}
, content = 140, contentType = 2}
, 
[15] = {
imgTween = {
{imgId = 104, posId = 3}
}
, 
heroFace = {
{imgId = 104, faceId = 4}
}
, content = 150, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[16] = {
imgTween = {
{imgId = 103, posId = 3}
, 
{imgId = 103, duration = 0.2, shake = true}
, 
{imgId = 103, delay = 0.5, duration = 0.2, alpha = 0}
, 
{imgId = 104, alpha = 0}
}
, 
audio = {
sfx = {cue = "Atk_Simo_01", sheet = "Chara_Simo"}
}
, content = 160, contentType = 2}
, 
[17] = {
imgTween = {
{imgId = 103, alpha = 1}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
, 
audio = {
sfx = {cue = "AVG_Punch", sheet = "AVG_gf"}
}
, content = 170, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[18] = {
imgTween = {
{imgId = 103, alpha = 0}
}
, content = 180, contentType = 2}
, 
[19] = {
imgTween = {
{imgId = 103, alpha = 1}
}
, 
heroFace = {
{imgId = 103, faceId = 6}
}
, content = 190, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[20] = {
imgTween = {
{imgId = 103, alpha = 0}
, 
{imgId = 105, posId = 3}
}
, content = 200, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[21] = {
imgTween = {
{imgId = 105, alpha = 0}
}
, 
audio = {
sfx = {cue = "Skill_Croque_Ex_Start", sheet = "Chara_Croque"}
}
, content = 210, contentType = 2}
, 
[22] = {
imgTween = {
{imgId = 105, posId = 3}
}
, 
heroFace = {
{imgId = 105, faceId = 6}
}
, content = 220, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, contentShake = true}
, 
[23] = {
imgTween = {
{imgId = 105, alpha = 0}
, 
{imgId = 1, duration = 1, shake = true}
}
, 
audio = {
sfx = {cue = "Skill_Croque_Ex_Cast", sheet = "Chara_Croque"}
}
, content = 230, contentType = 2}
, 
[24] = {
imgTween = {
{imgId = 105, posId = 3}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
, content = 240, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[25] = {
imgTween = {
{imgId = 105, alpha = 0}
, 
{imgId = 103, posId = 3}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
, content = 250, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[27] = {
imgTween = {
{imgId = 103, alpha = 0}
}
, 
heroFace = {
{imgId = 103, faceId = 0}
}
, content = 270, contentType = 2}
, 
[28] = {
imgTween = {
{imgId = 1, duration = 0.5, alpha = 0}
, 
{imgId = 1, duration = 0.5, delay = 0.5, alpha = 1}
}
, autoContinue = true}
, 
[29] = {
imgTween = {
{imgId = 101, posId = 1}
, 
{imgId = 101, posId = 2, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
, content = 290, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[30] = {
imgTween = {
{imgId = 117, posId = 5}
, 
{imgId = 117, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
}
, content = 300, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[32] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 117, isDark = true}
}
, content = 320, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[33] = {
imgTween = {
{imgId = 117, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 330, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[34] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 117, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
, content = 340, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[35] = {content = 350, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[36] = {
heroFace = {
{imgId = 101, faceId = 5}
}
, content = 360, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
branch = {
{content = 361, jumpAct = 37}
, 
{content = 362, jumpAct = 43}
}
}
, 
[37] = {
imgTween = {
{imgId = 117, isDark = false}
, 
{imgId = 117, posId = 4, duration = 0.2, isDark = false}
, 
{imgId = 105, posId = 5, duration = 0.2, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 370, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[40] = {
imgTween = {
{imgId = 103, posId = 1}
, 
{imgId = 103, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 117, isDark = true}
, 
{imgId = 101, posId = 1, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 103, faceId = 3}
}
, content = 400, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[41] = {
imgTween = {
{imgId = 117, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 410, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[42] = {
imgTween = {
{imgId = 103, isDark = false}
, 
{imgId = 117, isDark = true}
}
, content = 420, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, nextId = 46}
, 
[43] = {
imgTween = {
{imgId = 105, posId = 5}
, 
{imgId = 105, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 117, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
}
, 
heroFace = {
{imgId = 105, faceId = 1}
}
, content = 430, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[44] = {
imgTween = {
{imgId = 103, posId = 1}
, 
{imgId = 103, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 105, isDark = true}
, 
{imgId = 101, posId = 1, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 103, faceId = 4}
, 
{imgId = 105, faceId = 0}
}
, content = 440, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[45] = {
imgTween = {
{imgId = 101, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 103, posId = 1, isDark = false, duration = 0.2}
}
, content = 450, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
branch = {
{content = 451, jumpAct = 37}
, 
{content = 452, jumpAct = 43}
}
}
, 
[46] = {
imgTween = {
{imgId = 101, posId = 1}
, 
{imgId = 101, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 117, isDark = true}
, 
{imgId = 103, posId = 1, isDark = false, duration = 0.2}
}
, content = 460, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
branch = {
{content = 461, jumpAct = 49}
, 
{content = 462, jumpAct = 47}
}
}
, 
[47] = {
heroFace = {
{imgId = 101, faceId = 1}
}
, content = 470, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
branch = {
{content = 481, jumpAct = 49}
, 
{content = 482, jumpAct = 47}
}
}
, 
[49] = {
imgTween = {
{imgId = 117, isDark = false}
, 
{imgId = 101, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
, content = 490, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[51] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 117, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
, content = 510, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[52] = {
imgTween = {
{imgId = 117, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 520, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3, 
branch = {
{content = 531, jumpAct = 54}
, 
{content = 532, jumpAct = 57}
}
}
, 
[54] = {
imgTween = {
{imgId = 103, posId = 5}
, 
{imgId = 103, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 117, posId = 5, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
, content = 540, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[55] = {
heroFace = {
{imgId = 103, faceId = 4}
}
, content = 550, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, nextId = 59}
, 
[57] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 117, isDark = true}
}
, content = 570, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[59] = {
imgTween = {
{imgId = 103, posId = 4}
, 
{imgId = 117, posId = 5}
, 
{imgId = 101, isDark = true}
}
, 
heroFace = {
{imgId = 103, faceId = 3}
}
, content = 590, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[60] = {
imgTween = {
{imgId = 117, posId = 5}
, 
{imgId = 117, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
, 
{imgId = 103, posId = 5, isDark = false, duration = 0.2}
}
, content = 600, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[61] = {content = 610, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[62] = {content = 620, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[63] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 117, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
, content = 630, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[64] = {
heroFace = {
{imgId = 101, faceId = 4}
}
, 
audio = {
sfx = {cue = "Atk_Persicaria_01_Hit", sheet = "Chara_Persicaria"}
}
, content = 640, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[65] = {
imgTween = {
{imgId = 101, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 117, posId = 5, isDark = false, duration = 0.2}
}
, content = 650, contentType = 2}
, 
[66] = {
imgTween = {
{imgId = 101, posId = 3}
}
, content = 660, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[67] = {content = 670, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[68] = {
heroFace = {
{imgId = 101, faceId = 5}
}
, content = 680, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[69] = {
heroFace = {
{imgId = 101, faceId = 4}
}
, content = 690, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[70] = {
imgTween = {
{imgId = 101, duration = 0.5, posId = 2, isDark = true}
, 
{imgId = 117, posId = 4, isDark = false, duration = 0.2}
}
, content = 700, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[71] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 117, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
, content = 710, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[72] = {
imgTween = {
{imgId = 117, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 720, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[73] = {
imgTween = {
{imgId = 105, posId = 5}
, 
{imgId = 105, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 117, posId = 5, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
, content = 730, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[74] = {content = 740, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[75] = {
imgTween = {
{imgId = 103, posId = 5}
, 
{imgId = 103, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 105, posId = 5, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 103, faceId = 4}
}
, content = 750, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[76] = {
imgTween = {
{imgId = 103, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 101, posId = 1, isDark = false, duration = 0.2}
}
, content = 760, contentType = 2}
, 
[77] = {content = 770, contentType = 2}
, 
[78] = {
imgTween = {
{imgId = 103, posId = 4, isDark = true, duration = 0.2}
, 
{imgId = 101, posId = 2, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
, content = 780, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[79] = {
imgTween = {
{imgId = 103, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 790, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[80] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 800, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[81] = {
imgTween = {
{imgId = 103, isDark = false}
, 
{imgId = 103, duration = 0.2, shake = true}
, 
{imgId = 101, isDark = true}
}
, content = 810, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[82] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 820, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[83] = {content = 830, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[84] = {
imgTween = {
{imgId = 103, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 101, posId = 1, isDark = false, duration = 0.2}
}
, content = 840, contentType = 2}
, 
[85] = {
imgTween = {
{imgId = 103, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, posId = 2, isDark = true, duration = 0.2}
}
, content = 850, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[86] = {
imgTween = {
{imgId = 104, posId = 5}
, 
{imgId = 104, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 103, posId = 5, isDark = false, duration = 0.2}
}
, content = 860, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[87] = {content = 870, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[88] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 880, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[89] = {content = 890, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[90] = {content = 900, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[91] = {content = 910, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[92] = {
imgTween = {
{imgId = 105, posId = 5}
, 
{imgId = 105, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
, 
{imgId = 104, posId = 5, isDark = false, duration = 0.2}
}
, content = 920, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[93] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 105, isDark = true}
}
, content = 930, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[94] = {content = 940, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[95] = {
imgTween = {
{imgId = 117, posId = 5}
, 
{imgId = 117, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
, 
{imgId = 105, posId = 5, isDark = false, duration = 0.2}
}
, content = 950, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3, 
branch = {
{content = 951, jumpAct = 96}
}
}
, 
[96] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 117, isDark = true}
}
, content = 960, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[97] = {
imgTween = {
{imgId = 105, posId = 5}
, 
{imgId = 105, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
, 
{imgId = 117, posId = 5, isDark = false, duration = 0.2}
}
, content = 970, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[98] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 105, isDark = true}
}
, content = 980, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[99] = {content = 990, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[100] = {content = 1000, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[101] = {content = 1010, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[102] = {
heroFace = {
{imgId = 101, faceId = 0}
}
, content = 1020, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[103] = {
imgTween = {
{imgId = 117, posId = 5}
, 
{imgId = 117, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
, 
{imgId = 105, posId = 5, isDark = false, duration = 0.2}
}
, content = 1030, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[104] = {content = 1040, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[105] = {content = 1050, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[106] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 117, isDark = true}
}
, content = 1060, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[107] = {content = 1070, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[108] = {
imgTween = {
{imgId = 105, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
, 
{imgId = 117, posId = 5, isDark = false, duration = 0.2}
}
, content = 1080, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[109] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 105, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
, content = 1090, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[110] = {content = 1100, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[111] = {content = 1110, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[112] = {
audio = {
bgm = {stop = true}
}
, content = 1120, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[113] = {
imgTween = {
{imgId = 105, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 101, posId = 1, isDark = false, duration = 0.2}
}
, content = 1130, contentType = 2}
, 
[114] = {
imgTween = {
{imgId = 103, posId = 5}
, 
{imgId = 103, posId = 4, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
, 
audio = {
bgm = {cue = "Mus_Story_Creepy", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 1140, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[115] = {
imgTween = {
{imgId = 103, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 105, posId = 4, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
, content = 1150, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[116] = {
heroFace = {
{imgId = 105, faceId = 0}
}
, content = 1160, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[117] = {
imgTween = {
{imgId = 103, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 105, posId = 5, isDark = false, duration = 0.2}
}
, content = 1170, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[118] = {content = 1180, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[119] = {
images = {
{imgId = 10, imgType = 2, alpha = 0, imgPath = "cpt05/cpt05_e_bg005", fullScreen = true}
}
, 
imgTween = {
{imgId = 103, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 1, duration = 2, 
pos = {-200, 0, 0}
, 
scale = {1.2, 1.2, 1.2}
}
}
, content = 1190, contentType = 2}
, 
[120] = {
imgTween = {
{imgId = 1, duration = 2, 
pos = {-1200, -100, 0}
, 
scale = {2.5, 2.5, 2.5}
}
, 
{imgId = 10, duration = 0.5, delay = 2, alpha = 1}
, 
{imgId = 10, duration = 0.5, delay = 3, alpha = 0}
}
, content = 1200, contentType = 4, speakerName = 1261}
, 
[121] = {
imgTween = {
{imgId = 1, duration = 2, 
pos = {-2300, -250, 0}
, 
scale = {5, 5, 5}
}
, 
{imgId = 10, delay = 2, duration = 0.5, alpha = 1}
, 
{imgId = 10, duration = 0.5, delay = 3, alpha = 0}
}
, content = 1210, contentType = 4, speakerName = 1261}
, 
[122] = {
imgTween = {
{imgId = 10, duration = 0.5, alpha = 1}
, 
{imgId = 10, duration = 0.5, delay = 1, alpha = 0}
}
, content = 1220, contentType = 4, speakerName = 1221}
, 
[123] = {
imgTween = {
{imgId = 10, duration = 0.3, alpha = 1}
, 
{imgId = 10, duration = 0.3, delay = 0.5, alpha = 0}
}
, content = 1230, contentType = 4, speakerName = 1231}
, 
[124] = {
images = {
{imgId = 3, imgType = 2, alpha = 0, imgPath = "cpt05/cpt05_e_bg001_2", fullScreen = true}
}
, 
imgTween = {
{imgId = 10, duration = 0.3, alpha = 1}
, 
{imgId = 10, duration = 0.3, delay = 0.5, alpha = 0}
}
, content = 1240, contentType = 4, speakerName = 1221}
, 
[125] = {
images = {
{imgId = 34, delete = true}
, 
{imgId = 33, imgType = 3, alpha = 0, imgPath = "odette_avg"}
, 
{imgId = 108, imgType = 3, alpha = 0, imgPath = "gin_avg"}
}
, 
imgTween = {
{imgId = 1, alpha = 0, duration = 2}
}
, 
audio = {
sfx = {cue = "AVG_tinnitus", sheet = "AVG_gf"}
, 
bgm = {stop = true}
}
, autoContinue = true}
, 
[126] = {content = 1260, contentType = 4, speakerName = 1261, contentShake = true}
, 
[127] = {content = 1270, contentType = 4, speakerName = 1271, contentShake = true}
, 
[128] = {
imgTween = {
{imgId = 3, alpha = 0.5, duration = 1}
, 
{imgId = 3, delay = 1.5, alpha = 0, duration = 0.5}
, 
{imgId = 3, alpha = 1, delay = 2.5, duration = 1}
, 
{imgId = 103, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, alpha = 1, delay = 4, duration = 0}
}
, 
heroFace = {
{imgId = 103, faceId = 0}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 1280, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[129] = {
images = {
{imgId = 1, delete = true}
, 
{imgId = 341, imgType = 3, alpha = 0, imgPath = "odile_b_avg"}
}
, 
imgTween = {
{imgId = 33, posId = 1}
, 
{imgId = 33, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 103, duration = 0.5, posId = 4, isDark = true}
}
, content = 1290, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 1}
, 
[130] = {content = 1300, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 1}
, 
[131] = {content = 1310, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 1}
, 
[132] = {
imgTween = {
{imgId = 103, isDark = false}
, 
{imgId = 33, isDark = true}
}
, content = 1320, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[133] = {
imgTween = {
{imgId = 33, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 1330, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 1}
, 
[134] = {content = 1340, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 1}
, 
[135] = {
imgTween = {
{imgId = 117, posId = 5}
, 
{imgId = 117, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 33, isDark = true}
, 
{imgId = 103, posId = 5, isDark = false, duration = 0.2}
}
, content = 1350, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[136] = {
imgTween = {
{imgId = 33, isDark = false}
, 
{imgId = 117, isDark = true}
}
, content = 1360, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 1}
, 
[137] = {content = 1370, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 1}
, 
[138] = {
imgTween = {
{imgId = 101, posId = 1}
, 
{imgId = 101, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 33, posId = 1, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
, content = 1380, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[139] = {
imgTween = {
{imgId = 101, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 117, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 341, posId = 3, isDark = true}
}
, 
heroFace = {
{imgId = 341, faceId = 3}
}
, content = 1390, contentType = 2}
, 
[140] = {
images = {
{imgId = 341, delete = true}
}
, 
imgTween = {
{imgId = 33, posId = 1}
, 
{imgId = 33, posId = 2, isDark = false, duration = 0.2}
}
, content = 1400, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 1}
, 
[141] = {content = 1410, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 1}
, 
[142] = {
imgTween = {
{imgId = 117, posId = 5}
, 
{imgId = 117, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 33, isDark = true}
}
, content = 1420, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[143] = {
imgTween = {
{imgId = 105, posId = 5}
, 
{imgId = 105, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 33, isDark = true}
, 
{imgId = 117, posId = 5, isDark = false, duration = 0.2}
}
, content = 1430, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[144] = {
imgTween = {
{imgId = 108, posId = 3}
, 
{imgId = 105, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 33, posId = 1, isDark = false, duration = 0.2}
}
, content = 1440, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[145] = {
imgTween = {
{imgId = 108, alpha = 0}
}
, content = 1450, contentType = 2}
, 
[146] = {
imgTween = {
{imgId = 117, posId = 4, isDark = false, duration = 0.2}
}
, content = 1460, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[147] = {
imgTween = {
{imgId = 104, posId = 1}
, 
{imgId = 104, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 117, isDark = true}
}
, content = 1470, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1, contentShake = true}
, 
[148] = {
imgTween = {
{imgId = 117, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 1480, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[149] = {
imgTween = {
{imgId = 117, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 104, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 33, posId = 3}
}
, content = 1490, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 2}
}
return AvgCfg_cpt05_e_09_01


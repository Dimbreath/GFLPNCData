-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt05_e_12_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 1, imgType = 2, alpha = 0, imgPath = "cpt05/cpt05_e_bg002", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 104, imgType = 3, alpha = 0, imgPath = "simo_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 105, imgType = 3, alpha = 0, imgPath = "croque_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 108, imgType = 3, alpha = 0, imgPath = "gin_avg"}
, 
{imgId = 117, imgType = 3, alpha = 0, imgPath = "angela_avg"}
, 
{imgId = 33, imgType = 3, alpha = 0, imgPath = "odette_avg"}
, 
{imgId = 35, imgType = 3, alpha = 0, imgPath = "wisdom_w_avg"}
}
, 
imgTween = {
{imgId = 1, duration = 1, alpha = 1}
, 
{imgId = 105, duration = 0.2, delay = 1, alpha = 1}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 10, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[2] = {
imgTween = {
{imgId = 105, alpha = 0}
, 
{imgId = 35, posId = 3}
}
, content = 20, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[3] = {
imgTween = {
{imgId = 35, alpha = 0}
, 
{imgId = 117, posId = 1}
, 
{imgId = 117, posId = 2, isDark = false, duration = 0.2}
}
, content = 30, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 1}
, 
[4] = {
imgTween = {
{imgId = 105, posId = 5}
, 
{imgId = 105, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 117, isDark = true}
}
, content = 40, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[5] = {
imgTween = {
{imgId = 117, isDark = false}
, 
{imgId = 105, isDark = true}
}
, content = 50, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 1}
, 
[6] = {
imgTween = {
{imgId = 117, alpha = 0}
, 
{imgId = 105, alpha = 0}
, 
{imgId = 35, alpha = 1}
}
, content = 60, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[9] = {
imgTween = {
{imgId = 35, shake = true, duration = 0.2}
, 
{imgId = 35, delay = 0.5, duration = 0.2, isDark = true}
}
, 
audio = {
sfx = {cue = "AVG_rifle_finalshot_3h", sheet = "AVG_gf"}
}
, content = 90, contentType = 2}
, 
[10] = {
imgTween = {
{imgId = 35, alpha = 0}
}
, 
audio = {
sfx = {cue = "Skill_Sol_Passive", sheet = "Chara_Sol"}
}
, content = 100, contentType = 2}
, 
[11] = {
heroFace = {
{imgId = 101, faceId = 4}
}
, 
imgTween = {
{imgId = 101, posId = 1}
, 
{imgId = 101, posId = 2, isDark = false, duration = 0.2}
}
, content = 110, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[12] = {
imgTween = {
{imgId = 104, posId = 5}
, 
{imgId = 104, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
}
, 
heroFace = {
{imgId = 104, faceId = 4}
}
, content = 120, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[13] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 130, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[14] = {
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 140, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[15] = {
audio = {
sfx = {cue = "AVG_weapon_reload", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 104, alpha = 0}
, 
{imgId = 101, alpha = 0}
}
, content = 150, contentType = 2}
, 
[16] = {
imgTween = {
{imgId = 101, posId = 3, isDark = false}
}
, content = 160, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, contentShake = true}
, 
[17] = {
imgTween = {
{imgId = 101, alpha = 0}
}
, 
audio = {
sfx = {cue = "Skill_Persicaria_Ex_Start", sheet = "Chara_Persicaria"}
}
, content = 170, contentType = 2}
, 
[18] = {
audio = {
sfx = {cue = "AVG_rifle_finalshot_h", sheet = "AVG_gf"}
}
, content = 180, contentType = 2}
, 
[19] = {
heroFace = {
{imgId = 105, faceId = 6}
}
, 
imgTween = {
{imgId = 105, posId = 3, isDark = false}
}
, content = 190, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, contentShake = true}
, 
[20] = {
audio = {
sfx = {cue = "AVG_Broken_Glass", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 105, alpha = 0}
}
, content = 200, contentType = 2}
, 
[21] = {
imgTween = {
{imgId = 105, alpha = 1}
}
, content = 210, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[22] = {
audio = {
sfx = {cue = "AVG_RunStep", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 105, alpha = 0}
}
, content = 220, contentType = 2}
, 
[23] = {
imgTween = {
{imgId = 101, alpha = 1}
}
, content = 230, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[25] = {
imgTween = {
{imgId = 101, alpha = 0}
}
, content = 250, contentType = 2}
, 
[26] = {
imgTween = {
{imgId = 101, alpha = 1}
}
, 
heroFace = {
{imgId = 101, faceId = 1}
}
, content = 260, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[27] = {
imgTween = {
{imgId = 101, alpha = 0}
, 
{imgId = 35, alpha = 1, isDark = false}
}
, content = 270, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[28] = {
imgTween = {
{imgId = 35, alpha = 0}
}
, content = 280, contentType = 2}
, 
[29] = {
imgTween = {
{imgId = 105, alpha = 1}
, 
{imgId = 35, alpha = 0}
}
, content = 290, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[30] = {
imgTween = {
{imgId = 105, alpha = 0}
}
, content = 300, contentType = 2}
, 
[31] = {
imgTween = {
{imgId = 101, alpha = 1}
}
, content = 310, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[32] = {
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 101, alpha = 0}
, 
{imgId = 35, alpha = 1}
}
, content = 320, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[33] = {
imgTween = {
{imgId = 101, alpha = 1}
, 
{imgId = 35, alpha = 0}
}
, content = 330, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[34] = {
imgTween = {
{imgId = 105, alpha = 1}
, 
{imgId = 101, alpha = 0}
}
, content = 340, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, contentShake = true}
, 
[35] = {
imgTween = {
{imgId = 117, posId = 3}
, 
{imgId = 105, alpha = 0}
}
, content = 350, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 2, contentShake = true}
, 
[36] = {
audio = {
sfx = {cue = "Skill_Persicaria_Ex_Cast", sheet = "Chara_Persicaria"}
}
, 
imgTween = {
{imgId = 117, alpha = 0}
}
, content = 360, contentType = 2}
, 
[37] = {
imgTween = {
{imgId = 33, posId = 3}
, 
{imgId = 33, duration = 0.2, shake = true}
}
, content = 370, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 2, contentShake = true}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 2}
, 
[39] = {
imgTween = {
{imgId = 105, alpha = 1}
, 
{imgId = 33, alpha = 0}
}
, content = 390, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[40] = {
audio = {
sfx = {cue = "Skill_Sol_Passive", sheet = "Chara_Sol"}
}
, 
imgTween = {
{imgId = 105, alpha = 0}
}
, content = 400, contentType = 2}
, 
[41] = {
imgTween = {
{imgId = 35, alpha = 1}
}
, content = 410, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[42] = {
imgTween = {
{imgId = 35, duration = 0.2, shake = true}
, 
{imgId = 35, duration = 0.2, isDark = true, delay = 0.5}
}
, content = 420, contentType = 2}
, 
[43] = {
imgTween = {
{imgId = 35, alpha = 0}
, 
{imgId = 104, alpha = 1, posId = 3}
}
, 
heroFace = {
{imgId = 104, faceId = 6}
}
, content = 430, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[44] = {
imgTween = {
{imgId = 105, alpha = 1}
, 
{imgId = 104, alpha = 0}
}
, content = 440, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[45] = {
audio = {
sfx = {cue = "Skill_Sol_Passive", sheet = "Chara_Sol"}
}
, 
imgTween = {
{imgId = 105, alpha = 0}
}
, content = 450, contentType = 2}
, 
[46] = {
imgTween = {
{imgId = 101, alpha = 1}
}
, content = 460, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[47] = {
imgTween = {
{imgId = 101, alpha = 0}
, 
{imgId = 105, alpha = 1}
}
, content = 470, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[48] = {
imgTween = {
{imgId = 105, alpha = 0}
, 
{imgId = 108, posId = 3}
}
, content = 480, contentType = 3, speakerHeroId = 1008, speakerHeroPosId = 2}
, 
[49] = {
imgTween = {
{imgId = 108, alpha = 0}
}
, content = 490, contentType = 2}
, 
[50] = {content = 500, contentType = 2}
, 
[51] = {
imgTween = {
{imgId = 117, alpha = 1}
}
, content = 510, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 2, 
branch = {
{content = 511, jumpAct = 52}
, 
{content = 512, jumpAct = 56}
}
}
, 
[52] = {
imgTween = {
{imgId = 117, alpha = 0}
, 
{imgId = 105, alpha = 1}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
, content = 520, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[54] = {
imgTween = {
{imgId = 117, alpha = 1}
, 
{imgId = 105, alpha = 0}
}
, content = 540, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 2}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 2, nextId = 58}
, 
[56] = {
imgTween = {
{imgId = 117, alpha = 0}
, 
{imgId = 104, posId = 3}
}
, 
heroFace = {
{imgId = 104, faceId = 4}
}
, content = 560, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[58] = {
imgTween = {
{imgId = 117, alpha = 1}
, 
{imgId = 104, alpha = 0}
}
, content = 580, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 2}
, 
[59] = {
imgTween = {
{imgId = 117, alpha = 0}
, 
{imgId = 104, alpha = 1}
}
, content = 590, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[60] = {
imgTween = {
{imgId = 33, alpha = 1}
, 
{imgId = 104, alpha = 0}
}
, content = 600, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 2}
}
return AvgCfg_cpt05_e_12_01


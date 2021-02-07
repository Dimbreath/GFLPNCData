-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt05_e_10_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 1, imgType = 2, alpha = 0, imgPath = "cpt05/cpt05_e_bg001_2", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "sol_avg"}
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
}
, 
imgTween = {
{imgId = 1, duration = 1, alpha = 1}
, 
{imgId = 101, posId = 3, alpha = 0}
, 
{imgId = 101, alpha = 1, delay = 1, duration = 0.1}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 10, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[2] = {
imgTween = {
{imgId = 101, alpha = 0}
, 
{imgId = 105, posId = 3}
, 
{imgId = 105, shake = true, duration = 0.1}
}
, 
heroFace = {
{imgId = 105, faceId = 1}
}
, content = 20, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[3] = {
heroFace = {
{imgId = 105, faceId = 0}
}
, 
imgTween = {
{imgId = 105, alpha = 0}
, 
{imgId = 1, shake = true, duration = 0.1}
}
, 
audio = {
sfx = {cue = "Atk_Croque_01", sheet = "Chara_Croque"}
}
, content = 30, contentType = 2}
, 
[4] = {
imgTween = {
{imgId = 105, duration = 0.1, alpha = 1}
}
, content = 40, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[5] = {
imgTween = {
{imgId = 105, alpha = 0}
, 
{imgId = 103, posId = 3}
, 
{imgId = 103, duration = 0.5, shake = true}
, 
{imgId = 103, delay = 1, duration = 0.5, alpha = 0}
}
, 
audio = {
sfx = {cue = "Skill_Sol_Passive", sheet = "Chara_Sol"}
}
, content = 50, contentType = 2}
, 
[6] = {
imgTween = {
{imgId = 105, duration = 0.1, alpha = 1}
}
, content = 60, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[8] = {
heroFace = {
{imgId = 103, faceId = 6}
}
, 
imgTween = {
{imgId = 103, duration = 0.1, alpha = 1}
, 
{imgId = 105, duration = 0.1, alpha = 0}
}
, 
audio = {
sfx = {cue = "Skill_Sol_Passive", sheet = "Chara_Sol"}
}
, content = 80, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, contentShake = true}
, 
[9] = {
heroFace = {
{imgId = 103, faceId = 4}
}
, 
audio = {
sfx = {cue = "Skill_Sol_Passive", sheet = "Chara_Sol"}
}
, content = 90, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, contentShake = true}
, 
[10] = {
imgTween = {
{imgId = 105, posId = 5}
, 
{imgId = 105, posId = 4, isDark = false, duration = 0.1}
, 
{imgId = 103, duration = 0.5, posId = 2, isDark = true}
}
, content = 100, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[11] = {
heroFace = {
{imgId = 103, faceId = 5}
}
, 
imgTween = {
{imgId = 103, isDark = false}
, 
{imgId = 105, isDark = true}
}
, content = 110, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[12] = {
heroFace = {
{imgId = 105, faceId = 0}
}
, 
imgTween = {
{imgId = 105, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 120, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[13] = {
imgTween = {
{imgId = 108, posId = 5}
, 
{imgId = 108, posId = 4, isDark = false, duration = 0.1}
, 
{imgId = 105, posId = 5, isDark = false, duration = 0.1}
}
, content = 130, contentType = 3, speakerHeroId = 1008, speakerHeroPosId = 3}
, 
[14] = {
imgTween = {
{imgId = 117, posId = 1}
, 
{imgId = 117, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 108, isDark = true}
, 
{imgId = 103, posId = 1, isDark = false, duration = 0.2}
}
, content = 140, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 1}
, 
[15] = {
imgTween = {
{imgId = 108, isDark = false}
, 
{imgId = 117, isDark = true}
}
, content = 150, contentType = 3, speakerHeroId = 1008, speakerHeroPosId = 3}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 1008, speakerHeroPosId = 3}
, 
[17] = {
imgTween = {
{imgId = 117, isDark = false}
, 
{imgId = 108, isDark = true}
}
, content = 170, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 1}
, 
[18] = {
imgTween = {
{imgId = 108, isDark = false}
, 
{imgId = 117, isDark = true}
}
, content = 180, contentType = 3, speakerHeroId = 1008, speakerHeroPosId = 3}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 1008, speakerHeroPosId = 3}
, 
[20] = {
heroFace = {
{imgId = 101, faceId = 4}
}
, 
imgTween = {
{imgId = 101, posId = 1}
, 
{imgId = 101, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 108, isDark = true}
, 
{imgId = 117, posId = 1, isDark = false, duration = 0.2}
}
, content = 200, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[22] = {
imgTween = {
{imgId = 108, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 220, contentType = 3, speakerHeroId = 1008, speakerHeroPosId = 3}
, 
[23] = {content = 230, contentType = 3, speakerHeroId = 1008, speakerHeroPosId = 3}
, 
[24] = {
heroFace = {
{imgId = 101, faceId = 5}
}
, 
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 108, isDark = true}
}
, content = 240, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[26] = {
imgTween = {
{imgId = 33, posId = 5}
, 
{imgId = 33, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
, 
{imgId = 108, posId = 5, isDark = false, duration = 0.2}
}
, content = 260, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 3}
, 
[27] = {
heroFace = {
{imgId = 101, faceId = 0}
}
, 
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 33, isDark = true}
}
, content = 270, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[30] = {
heroFace = {
{imgId = 103, faceId = 5}
}
, 
imgTween = {
{imgId = 103, posId = 5}
, 
{imgId = 103, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
, 
{imgId = 33, posId = 5, isDark = false, duration = 0.2}
}
, content = 300, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[31] = {
imgTween = {
{imgId = 108, posId = 5}
, 
{imgId = 108, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 103, posId = 5, isDark = false, duration = 0.2}
}
, content = 310, contentType = 3, speakerHeroId = 1008, speakerHeroPosId = 3}
, 
[32] = {
imgTween = {
{imgId = 33, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 108, posId = 5, isDark = false, duration = 0.2}
}
, content = 320, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 3}
, 
[33] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 33, isDark = true}
}
, content = 330, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[35] = {
imgTween = {
{imgId = 33, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 350, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 3}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 3}
, 
[37] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 33, isDark = true}
}
, content = 370, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[38] = {
imgTween = {
{imgId = 33, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 380, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 3}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 3}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 3, 
branch = {
{content = 401, jumpAct = 41}
, 
{content = 402, jumpAct = 45}
}
}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 3}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 3}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 3}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 3, nextId = 48, 
branch = {
{content = 441, jumpAct = 48}
}
}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 3}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 3}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 3, 
branch = {
{content = 471, jumpAct = 48}
}
}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 3}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 3}
, 
[50] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 33, isDark = true}
}
, content = 500, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[51] = {
imgTween = {
{imgId = 33, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 510, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 3}
, 
[52] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 33, isDark = true}
}
, content = 520, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[53] = {
imgTween = {
{imgId = 101, alpha = 0}
, 
{imgId = 33, alpha = 0}
}
, 
audio = {
sfx = {cue = "AVG_ClothingUp", sheet = "AVG_gf"}
}
, content = 530, contentType = 2}
, 
[54] = {
imgTween = {
{imgId = 105, posId = 3}
}
, content = 540, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
}
return AvgCfg_cpt05_e_10_01


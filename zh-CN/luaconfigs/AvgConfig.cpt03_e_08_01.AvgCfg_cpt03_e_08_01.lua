-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt03_e_08_01 = {
[1] = {bgColor = 2, content = 10, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2, 
images = {
{imgId = 3, imgType = 2, alpha = 0, imgPath = "cpt03/cpt03_e_bg008", fullScreen = true}
, 
{imgId = 4, imgType = 2, alpha = 0, imgPath = "cpt03/cpt03_e_bg002", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 105, imgType = 3, alpha = 0, imgPath = "croque_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 127, imgType = 3, alpha = 0, imgPath = "zion_avg"}
, 
{imgId = 24, imgType = 3, alpha = 0, imgPath = "sisy_avg"}
, 
{imgId = 25, imgType = 3, alpha = 0, imgPath = "phus_avg"}
, 
{imgId = 23, imgType = 3, alpha = 0, imgPath = "choco_avg"}
, 
{imgId = 26, imgType = 3, alpha = 0, imgPath = "beelneith_avg"}
, 
{imgId = 14, imgType = 3, alpha = 0, imgPath = "helios_npc_02_avg"}
}
, 
imgTween = {
{imgId = 3, delay = 0, duration = 0.3, alpha = 1}
, 
{imgId = 23, delay = 0, duration = 0, posId = 3, alpha = 0}
, 
{imgId = 23, delay = 0, duration = 0.6, posId = 3, alpha = 1, shake = true}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
heroFace = {
{imgId = 23, faceId = 6}
}
}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2, 
heroFace = {
{imgId = 23, faceId = 7}
}
}
, 
[3] = {content = 30, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 23, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[4] = {content = 40, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 23, delay = 0, duration = 0.2, posId = 2, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 23, faceId = 4}
}
}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 23, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
sfx = {cue = "Skill_Abstinence_01_Hit", sheet = "Mon_Abstinence"}
}
, 
heroFace = {
{imgId = 23, faceId = 0}
, 
{imgId = 101, faceId = 0}
, 
{imgId = 26, faceId = 6}
}
}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 1, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 24, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[9] = {content = 90, contentType = 2, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", stop = true}
}
}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
branch = {
{content = 101, jumpAct = 11}
, 
{content = 102, jumpAct = 13}
}
, 
heroFace = {
{imgId = 24, faceId = 4}
}
}
, 
[11] = {content = 110, contentType = 4, speakerName = 111, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[12] = {content = 120, contentType = 4, speakerName = 111, nextId = 15}
, 
[13] = {content = 130, contentType = 4, speakerName = 111, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[14] = {content = 140, contentType = 4, speakerName = 111}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 24, faceId = 0}
}
}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 23, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 23, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_Sad", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
heroFace = {
{imgId = 23, faceId = 4}
}
}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 23, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 23, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 23, faceId = 1}
}
}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 23, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 24, faceId = 1}
}
}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 23, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
sfx = {cue = "Skill_Persicaria_01", sheet = "Chara_Persicaria"}
}
, 
heroFace = {
{imgId = 23, faceId = 0}
, 
{imgId = 24, faceId = 0}
, 
{imgId = 101, faceId = 2}
}
}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[23] = {content = 230, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 24, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 24, faceId = 1}
}
}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3, 
heroFace = {
{imgId = 24, faceId = 4}
}
}
, 
[25] = {content = 250, contentType = 2, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.3, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 3, delay = 0, duration = 0.3, alpha = 0, isDark = false}
, 
{imgId = 4, delay = 0, duration = 0.3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 24, faceId = 0}
, 
{imgId = 101, faceId = 0}
}
}
, 
[26] = {content = 260, contentType = 2}
, 
[27] = {content = 270, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2, 
imgTween = {
{imgId = 4, delay = 0, duration = 0.2, alpha = 0, isDark = false}
, 
{imgId = 3, delay = 0, duration = 0.3, alpha = 1, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 25, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 25, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1, 
imgTween = {
{imgId = 25, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 24, faceId = 4}
}
}
, 
[30] = {content = 300, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3, 
imgTween = {
{imgId = 25, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1, 
imgTween = {
{imgId = 25, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 24, faceId = 4}
}
}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1, 
heroFace = {
{imgId = 24, faceId = 5}
}
}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2, 
imgTween = {
{imgId = 25, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[35] = {content = 350, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 25, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 25, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3, 
imgTween = {
{imgId = 25, delay = 0, duration = 0.2, posId = 4, alpha = 1, shake = true, isDark = false}
}
}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1, 
imgTween = {
{imgId = 25, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 24, faceId = 4}
}
}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3, 
imgTween = {
{imgId = 25, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 2, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 25, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 2}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 2}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2, 
imgTween = {
{imgId = 25, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0, posId = 3, alpha = 1, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2, 
heroFace = {
{imgId = 24, faceId = 0}
}
}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 25, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = false}
, 
{imgId = 25, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 25, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1}
, 
[55] = {content = 550, contentType = 2, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 25, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
}
}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 2, 
imgTween = {
{imgId = 25, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 25, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 24, faceId = 0}
}
}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 25, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 25, faceId = 0}
, 
{imgId = 105, faceId = 5}
}
}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_Sad", sheet = "Music", stop = true}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
, 
{imgId = 26, faceId = 1}
}
}
, 
[59] = {content = 590, contentType = 2, 
imgTween = {
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, 
audio = {
sfx = {cue = "Skill_Mala_01_Start", sheet = "Mon_Mala"}
}
}
, 
[60] = {content = 600, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 1, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 127, delay = 0, duration = 0, posId = 5, alpha = 1, isDark = true}
, 
{imgId = 127, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
audio = {
bgm = {cue = "Mus_Story_Creepy", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
heroFace = {
{imgId = 26, faceId = 0}
, 
{imgId = 105, faceId = 6}
}
}
, 
[61] = {content = 610, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 3, 
imgTween = {
{imgId = 127, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
audio = {
sfx = {cue = "Skill_Mala_01_Start", sheet = "Mon_Mala"}
}
}
, 
[62] = {content = 620, contentType = 4, speakerName = 111, 
imgTween = {
{imgId = 127, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[63] = {content = 630, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
, 
{imgId = 127, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[64] = {content = 640, contentType = 2, speakerName = 111, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[65] = {content = 650, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 1}
}
}
, 
[66] = {content = 660, contentType = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_RunStep", sheet = "AVG_gf"}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[67] = {content = 670, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
imgTween = {
{imgId = 26, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 26, faceId = 6}
}
}
, 
[68] = {content = 680, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
audio = {
bgm = {cue = "Mus_Story_Passion", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
heroFace = {
{imgId = 26, faceId = 0}
}
}
, 
[69] = {content = 690, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
heroFace = {
{imgId = 26, faceId = 6}
}
}
, 
[70] = {content = 700, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
imgTween = {
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 26, faceId = 1}
}
}
, 
[71] = {content = 710, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 2, 
imgTween = {
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 0, shake = true, isDark = false}
, 
{imgId = 127, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 127, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 26, faceId = 0}
}
}
}
return AvgCfg_cpt03_e_08_01


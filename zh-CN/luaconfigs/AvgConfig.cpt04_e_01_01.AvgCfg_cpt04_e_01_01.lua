-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt04_e_01_01 = {
[1] = {bgColor = 2, content = 10, contentType = 4, speakerName = 11, scrambleTypeWriter = true, 
images = {
{imgId = 1, imgType = 2, alpha = 0, imgPath = "cpt00/cpt00_e_bg010_1", fullScreen = true}
, 
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg001", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 105, imgType = 3, alpha = 0, imgPath = "croque_avg"}
}
, 
audio = {
bgm = {cue = "Mus_Story_Creepy", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[2] = {content = 20, contentType = 4, speakerName = 12}
, 
[3] = {content = 30, contentType = 4, speakerName = 11, scrambleTypeWriter = true}
, 
[4] = {content = 40, contentType = 4, speakerName = 11, scrambleTypeWriter = true}
, 
[5] = {content = 50, contentType = 4, speakerName = 11, scrambleTypeWriter = true}
, 
[6] = {content = 60, contentType = 4, speakerName = 11, scrambleTypeWriter = true}
, 
[7] = {contentType = 4, speakerName = 12, autoContinue = true}
, 
[8] = {content = 80, contentType = 4, speakerName = 11, scrambleTypeWriter = true}
, 
[9] = {content = 90, contentType = 4, speakerName = 11, scrambleTypeWriter = true}
, 
[10] = {content = 100, contentType = 4, speakerName = 11, scrambleTypeWriter = true, 
audio = {
bgm = {stop = true}
}
}
, 
[11] = {autoContinue = true}
, 
[12] = {content = 120, contentType = 1, scrambleTypeWriter = true}
, 
[13] = {content = 130, contentType = 2, 
imgTween = {
{imgId = 1, delay = 0, duration = 1.5, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_General", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 1, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_BaseDoor_Open", sheet = "AVG_gf"}
}
}
, 
[15] = {content = 150, contentType = 4, speakerName = 13, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
branch = {
{content = 161, jumpAct = 17}
, 
{content = 162, jumpAct = 19}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[18] = {content = 180, contentType = 4, speakerName = 13, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, nextId = 21}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[20] = {content = 200, contentType = 4, speakerName = 13, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
branch = {
{content = 211, jumpAct = 22}
, 
{content = 212, jumpAct = 23}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, nextId = 25, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[23] = {content = 230, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[27] = {content = 270, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
branch = {
{content = 281, jumpAct = 29}
, 
{content = 282, jumpAct = 34}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[29] = {content = 290, contentType = 4, speakerName = 13, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[30] = {content = 300, contentType = 4, speakerName = 13}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[33] = {content = 330, contentType = 4, speakerName = 13, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, nextId = 39}
, 
[34] = {content = 340, contentType = 4, speakerName = 13, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[35] = {content = 350, contentType = 4, speakerName = 13}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[42] = {content = 420, contentType = 4, speakerName = 13, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[44] = {content = 440, contentType = 4, speakerName = 13, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[48] = {content = 480, contentType = 4, speakerName = 13, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[50] = {autoContinue = true, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 1, delay = 0, duration = 0.6, alpha = 0, isDark = false}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[51] = {content = 510, contentType = 2, 
audio = {
sfx = {cue = "AVG_RunStep", sheet = "AVG_gf"}
}
}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 2, delay = 0, duration = 1, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 1, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 1, duration = 0.6, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 1, duration = 0.6, posId = 4, alpha = 1, isDark = true}
}
, 
audio = {
bgm = {cue = "Mus_YT_Story_Quiet", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
, 
{imgId = 103, faceId = 3}
}
}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
heroFace = {
{imgId = 103, faceId = 5}
}
}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false, 
rot = {0, 180, 0}
}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[59] = {content = 590, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[60] = {content = 600, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[61] = {content = 610, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, shake = true, isDark = false}
}
}
, 
[62] = {content = 620, contentType = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_Creepy", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[63] = {content = 630, contentType = 2}
, 
[64] = {content = 640, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 3}
}
}
, 
[65] = {content = 650, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[66] = {content = 660, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[67] = {content = 670, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 103, faceId = 4}
}
}
, 
[68] = {content = 680, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 105, faceId = 1}
}
}
, 
[69] = {content = 690, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
}
, 
[70] = {content = 700, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[71] = {content = 710, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 3}
}
}
, 
[72] = {content = 720, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[73] = {content = 730, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
}
, 
[74] = {content = 740, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[75] = {content = 750, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[76] = {content = 760, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[77] = {content = 770, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
}
, 
[78] = {content = 780, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[79] = {content = 790, contentType = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 2, duration = 3, 
scale = {1.6, 1.6, 1.6}
, 
pos = {0, 0, 0}
}
, 
{imgId = 2, duration = 3, delay = 3, 
scale = {1, 1, 1}
, 
pos = {0, 0, 0}
}
}
}
, 
[80] = {content = 800, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[81] = {content = 810, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[82] = {content = 820, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[83] = {content = 830, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[84] = {content = 840, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
heroFace = {
{imgId = 105, faceId = 5}
}
, 
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
}
, 
[85] = {content = 850, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[86] = {content = 860, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[87] = {content = 870, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
}
, 
[88] = {content = 880, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[89] = {content = 890, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
branch = {
{content = 891, jumpAct = 90}
, 
{content = 892, jumpAct = 92}
}
, 
heroFace = {
{imgId = 103, faceId = 3}
}
}
, 
[90] = {content = 900, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
heroFace = {
{imgId = 103, faceId = 5}
}
}
, 
[91] = {content = 910, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, nextId = 94}
, 
[92] = {content = 920, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 1}
}
}
, 
[93] = {content = 930, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
}
, 
[94] = {content = 940, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[95] = {content = 950, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
}
, 
[96] = {content = 960, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
heroFace = {
{imgId = 103, faceId = 4}
}
}
}
return AvgCfg_cpt04_e_01_01


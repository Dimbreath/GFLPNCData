-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt04_e_02_01 = {
[1] = {content = 10, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
images = {
{imgId = 1, imgType = 1, alpha = 1, imgPath = "cpt00/cpt00_e_bg001", fullScreen = true}
, 
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg002", fullScreen = true}
, 
{imgId = 3, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg003", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 105, imgType = 3, alpha = 0, imgPath = "croque_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 112, imgType = 3, alpha = 0, imgPath = "max_avg"}
, 
{imgId = 27, imgType = 3, alpha = 0, imgPath = "adele_avg"}
}
, 
audio = {
bgm = {cue = "Mus_YT_Story_Quiet", sheet = "Music", fadeIn = 2, fadeOut = 4}
}
, 
imgTween = {
{imgId = 2, delay = 0, duration = 1, posId = 0, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.6, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.6, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[3] = {content = 30, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[4] = {autoContinue = true, 
audio = {
sfx = {cue = "AVG_Door_Open_Close", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 2, delay = 0, duration = 0.6, alpha = 0, isDark = false}
}
}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.6, alpha = 0.75, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 0}
}
}
, 
[9] = {content = 90, contentType = 2, contentShake = true, 
audio = {
sfx = {cue = "AVG_lifttable", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[11] = {content = 110, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[12] = {content = 120, contentType = 2, 
audio = {
bgm = {stop = true, sheet = "Mus_YT_Story_Quiet"}
}
, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 2, delay = 0, duration = 0.6, alpha = 0.75, isDark = true}
}
}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
audio = {
bgm = {cue = "Mus_Story_Creepy", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[19] = {content = 190, contentType = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
}
}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 103, faceId = 4}
}
}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[22] = {autoContinue = true, 
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
}
}
, 
[23] = {content = 230, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
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
[27] = {content = 270, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
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
[29] = {content = 290, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[30] = {content = 300, contentType = 4, speakerName = 301, speakerHeroId = 4, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, 
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf"}
}
}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, posId = 3, alpha = 1, isDark = false}
}
}
, 
[32] = {content = 320, contentType = 4, speakerName = 301, speakerHeroId = 4, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, 
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf"}
}
}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[35] = {content = 350, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 4}
}
}
, 
[37] = {content = 370, contentType = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
}
}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 0}
}
}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[42] = {content = 420, contentType = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
}
}
, 
[43] = {content = 430, contentType = 2, autoContinue = true, 
imgTween = {
{imgId = 112, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = true}
, 
{imgId = 112, delay = 0, duration = 2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 1, posId = 3, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.6, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = true}
, 
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = true}
}
}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
audio = {
sfx = {cue = "AVG_Walk", sheet = "AVG_gf", audioId = 47}
}
, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 112, posId = 3, alpha = 1, isDark = true}
, 
{imgId = 112, delay = 0.5, posId = 3, duration = 0.5, isDark = false}
}
}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
audio = {
stopAudioId = {47}
}
}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.6, posId = 4, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 6}
}
}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 1, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.6, posId = 2, alpha = 1, shake = true, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 112, faceId = 3}
}
}
, 
[56] = {
heroFace = {
{imgId = 112, faceId = 0}
}
, content = 560, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 2}
, 
[57] = {content = 570, contentType = 4, speakerName = 571, speakerHeroId = 2, speakerHeroPosId = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[58] = {content = 580, contentType = 4, speakerName = 571, speakerHeroId = 2, speakerHeroPosId = 2}
, 
[59] = {content = 590, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 112, faceId = 1}
}
}
, 
[60] = {content = 600, contentType = 4, speakerName = 571, speakerHeroId = 2, speakerHeroPosId = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 112, faceId = 3}
}
}
, 
[61] = {content = 610, contentType = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = true}
, 
{imgId = 27, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = true}
, 
{imgId = 27, delay = 0, duration = 1, posId = 3, alpha = 1, isDark = true}
}
}
, 
[62] = {content = 620, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 27, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 0}
}
}
, 
[63] = {content = 630, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
audio = {
bgm = {stop = true, sheet = "Mus_Story_Funny"}
}
, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[64] = {content = 640, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 112, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 112, faceId = 0}
}
}
, 
[65] = {content = 650, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 2}
}
return AvgCfg_cpt04_e_02_01


-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt02_e_11_01 = {
[1] = {content = 10, contentType = 3, speakerHeroId = 22, speakerHeroPosId = 2, 
images = {
{imgId = 1, imgType = 1, alpha = 1, imgPath = "cpt00/cpt00_e_bg001", fullScreen = true}
, 
{imgId = 3, imgType = 2, alpha = 0, imgPath = "cpt02/cpt02_e_bg003", fullScreen = true}
, 
{imgId = 4, imgType = 2, alpha = 0, imgPath = "cpt02/cpt02_e_bg004_2", fullScreen = true}
, 
{imgId = 5, imgType = 2, alpha = 0, imgPath = "cpt02/cpt02_e_cg002", fullScreen = true}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 105, imgType = 3, alpha = 0, imgPath = "croque_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 19, imgType = 3, alpha = 0, imgPath = "olivia_avg"}
, 
{imgId = 20, imgType = 3, alpha = 0, imgPath = "arrow_avg"}
, 
{imgId = 22, imgType = 3, alpha = 0, imgPath = "mara_blue_avg"}
}
, 
imgTween = {
{imgId = 4, delay = 0, duration = 0.6, alpha = 1, isDark = false}
, 
{imgId = 22, delay = 0, duration = 0, alpha = 0, isDark = false}
, 
{imgId = 22, delay = 0, duration = 0.6, alpha = 0.5, isDark = false}
}
, 
audio = {
bgm = {stop = false, cue = "Mus_Story_Purifier", sheet = "Music", fadeIn = 3, fadeOut = 3}
}
}
, 
[2] = {content = 20, contentType = 2, 
imgTween = {
{imgId = 22, delay = 0, duration = 0.6, alpha = 0.5, shake = true, isDark = false}
}
, 
audio = {
sfx = {cue = "Skill_Abstinence_01_Loop", sheet = "Mon_Abstinence", audioId = 2}
}
}
, 
[3] = {content = 30, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 22, delay = 0, duration = 0.2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
stopAudioId = {2}
}
}
, 
[4] = {content = 40, contentType = 3, speakerHeroId = 22, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 22, delay = 0, duration = 0, alpha = 0, isDark = false}
, 
{imgId = 22, delay = 0, duration = 0.2, alpha = 0.5, isDark = false}
}
, 
audio = {
sfx = {cue = "Skill_Common_buff_P", sheet = "Common_Skill"}
}
}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 22, delay = 0, duration = 0.2, alpha = 0, isDark = false}
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
[6] = {content = 60, contentType = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "Skill_Abstinence_01_Loop", sheet = "Mon_Abstinence", audioId = 2}
}
}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 22, speakerHeroPosId = 2, 
imgTween = {
{imgId = 22, delay = 0, duration = 0, alpha = 0, isDark = false}
, 
{imgId = 22, delay = 0, duration = 0.2, alpha = 0.5, isDark = false}
}
, 
audio = {
stopAudioId = {2}
}
}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 22, speakerHeroPosId = 2, 
audio = {
sfx = {cue = "AVG_whitenoise", sheet = "AVG_gf"}
}
}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 22, speakerHeroPosId = 2}
, 
[10] = {content = 100, contentType = 4, speakerName = 11, 
imgTween = {
{imgId = 22, delay = 0, duration = 1, alpha = 0, isDark = false}
}
}
, 
[11] = {
images = {
{imgId = 22, delete = true}
}
, content = 110, contentType = 2, 
audio = {
bgm = {stop = true}
}
}
, 
[12] = {
images = {
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 102, imgType = 3, alpha = 0, imgPath = "anna_avg"}
}
, content = 120, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
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
{imgId = 103, faceId = 4}
, 
{imgId = 101, faceId = 5}
}
}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 5}
}
}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
audio = {
bgm = {cue = "Mus_Story_Passion", sheet = "Music", fadeIn = 2, fadeOut = 3}
, 
sfx = {cue = "AVG_Alarm", sheet = "AVG_gf", audioId = 15}
}
, 
heroFace = {
{imgId = 102, faceId = 6}
}
}
, 
[16] = {content = 160, contentType = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 4, delay = 0.2, duration = 3, alpha = 1}
, 
{imgId = 5, delay = 0.5, duration = 3, alpha = 1}
}
}
, 
[17] = {content = 170, contentType = 4, speakerName = 12, contentShake = true}
, 
[18] = {content = 180, contentType = 4, speakerName = 11, contentShake = true}
, 
[19] = {content = 190, contentType = 4, speakerName = 11}
, 
[20] = {content = 200, contentType = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = true}
}
}
, 
[21] = {
imgTween = {
{imgId = 5, duration = 3, shake = true}
}
, 
audio = {
sfx = {cue = "AVG_Battlefield", sheet = "AVG_gf"}
}
, content = 210, contentType = 2}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 2, 
imgTween = {
{imgId = 20, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
, 
{imgId = 5, duration = 0.2, alpha = 0}
, 
{imgId = 4, alpha = 0.5}
}
}
, 
[23] = {
imgTween = {
{imgId = 4, duration = 2, shake = true}
}
, 
audio = {
sfx = {cue = "AVG_Battlefield", sheet = "AVG_gf"}
}
, content = 230, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 2, 
heroFace = {
{imgId = 20, faceId = 6}
}
}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3, 
imgTween = {
{imgId = 20, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 19, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 19, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 19, faceId = 4}
}
}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 1, 
imgTween = {
{imgId = 19, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 20, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3, 
imgTween = {
{imgId = 19, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[27] = {content = 270, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 1, 
imgTween = {
{imgId = 19, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 20, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 19, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[30] = {content = 300, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 20, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 19, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 19, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[35] = {content = 350, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 1, 
imgTween = {
{imgId = 19, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 20, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 20, faceId = 0}
}
}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 1}
, 
[37] = {
heroFace = {
{imgId = 19, faceId = 0}
}
, content = 370, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3, 
imgTween = {
{imgId = 19, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[38] = {content = 380, contentType = 2, 
imgTween = {
{imgId = 19, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
}
}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 2, 
imgTween = {
{imgId = 20, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 20, faceId = 6}
}
}
, 
[40] = {
heroFace = {
{imgId = 20, faceId = 0}
}
, content = 400, contentType = 2, 
imgTween = {
{imgId = 20, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_footsteps_cave", sheet = "AVG_gf"}
}
}
, 
[41] = {
imgTween = {
{imgId = 4, duration = 3, alpha = 0}
, 
{imgId = 5, duration = 3, alpha = 1}
}
, 
audio = {
sfx = {cue = "AVG_Alarm", sheet = "AVG_gf", audioId = 15}
}
, content = 410, contentType = 2}
, 
[42] = {
audio = {
bgm = {stop = true}
}
, content = 420, contentType = 4, speakerName = 13}
, 
[43] = {autoContinue = true, 
imgTween = {
{imgId = 5, delay = 0, duration = 1, alpha = 0}
, 
{imgId = 19, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 3, delay = 0, duration = 1, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 1.5, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 1.5, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 1.5, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 102, delay = 1.5, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 103, faceId = 3}
, 
{imgId = 102, faceId = 2}
}
}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
audio = {
bgm = {stop = false, cue = "Mus_YT_Story_Quiet", sheet = "Music", fadeIn = 3, fadeOut = 3}
}
}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 5}
}
}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
heroFace = {
{imgId = 102, faceId = 2}
}
}
, 
[51] = {content = 510, contentType = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
audio = {
sfx = {cue = "AVG_tele_connect", sheet = "AVG_gf"}
}
}
, 
[52] = {content = 520, contentType = 2}
, 
[53] = {content = 530, contentType = 2}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 5}
}
}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 5}
}
}
, 
[58] = {content = 580, contentType = 1, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
}
}
, 
[59] = {content = 600, contentType = 1}
, 
[60] = {content = 630, contentType = 1}
, 
[61] = {content = 640, contentType = 1}
, 
[62] = {content = 650, contentType = 1}
, 
[63] = {content = 670, contentType = 1}
, 
[64] = {content = 680, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[65] = {content = 690, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[66] = {content = 700, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[67] = {content = 710, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 102, faceId = 2}
}
}
, 
[68] = {content = 720, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[69] = {content = 730, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[70] = {content = 740, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[71] = {content = 750, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[72] = {content = 760, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 102, faceId = 5}
, 
{imgId = 101, faceId = 2}
}
}
, 
[73] = {content = 770, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
heroFace = {
{imgId = 102, faceId = 2}
}
}
, 
[74] = {content = 780, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[75] = {content = 790, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[76] = {content = 800, contentType = 4, speakerName = 11, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[77] = {content = 810, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[78] = {content = 820, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[79] = {
audio = {
bgm = {stop = true}
}
, content = 830, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[80] = {content = 840, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[81] = {content = 850, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[82] = {content = 860, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[83] = {
heroFace = {
{imgId = 101, faceId = 0}
}
, autoContinue = true, 
imgTween = {
{imgId = 3, delay = 0, duration = 1, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
}
}
, 
[84] = {content = 880, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 2, 
imgTween = {
{imgId = 3, delay = 0, duration = 0.6, alpha = 1, isDark = false}
, 
{imgId = 19, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 19, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 19, faceId = 4}
}
}
, 
[85] = {content = 890, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 2, 
heroFace = {
{imgId = 19, faceId = 0}
}
}
, 
[86] = {content = 900, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 19, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[87] = {content = 910, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 19, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 19, faceId = 4}
}
}
, 
[88] = {
audio = {
bgm = {cue = "Mus_Story_Sad", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 920, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 1}
, 
[89] = {content = 930, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 19, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[90] = {content = 940, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[91] = {content = 950, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[92] = {
heroFace = {
{imgId = 19, faceId = 0}
}
, content = 960, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 19, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[93] = {content = 970, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 19, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[94] = {content = 980, contentType = 4, speakerName = 11, 
imgTween = {
{imgId = 19, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
}
}
, 
[95] = {
heroFace = {
{imgId = 19, faceId = 4}
}
, content = 990, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 2, 
imgTween = {
{imgId = 19, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 19, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[96] = {content = 1000, contentType = 4, speakerName = 11, 
imgTween = {
{imgId = 19, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[97] = {content = 1010, contentType = 4, speakerName = 11}
, 
[98] = {content = 1020, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 2, 
imgTween = {
{imgId = 19, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[99] = {content = 1030, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 2, 
heroFace = {
{imgId = 19, faceId = 0}
}
}
, 
[100] = {autoContinue = true, 
imgTween = {
{imgId = 3, delay = 0, duration = 1, alpha = 0, isDark = false}
, 
{imgId = 19, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[101] = {
heroFace = {
{imgId = 19, faceId = 0}
}
, content = 1050, contentType = 4, speakerName = 1031, 
imgTween = {
{imgId = 1, delay = 0, duration = 0, alpha = 1, isDark = false}
}
}
, 
[102] = {
heroFace = {
{imgId = 20, faceId = 0}
}
, content = 1080, contentType = 4, speakerName = 1031, 
imgTween = {
{imgId = 20, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 20, delay = 0, duration = 1, posId = 3, alpha = 0.5, isDark = false}
}
}
, 
[103] = {
imgTween = {
{imgId = 20, delay = 0, duration = 0.5, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 5, duration = 1, alpha = 0.7}
}
, content = 1100, contentType = 4, speakerName = 1031}
, 
[104] = {content = 1112, contentType = 4, speakerName = 1031}
}
return AvgCfg_cpt02_e_11_01


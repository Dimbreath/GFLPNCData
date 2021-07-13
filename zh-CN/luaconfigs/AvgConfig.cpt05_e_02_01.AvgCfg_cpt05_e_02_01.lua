-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt05_e_02_01 = {
[1] = {content = 10, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, bgColor = 2, 
images = {
{imgId = 2, imgType = 2, alpha = -1, imgPath = "cpt00/cpt00_e_bg005_2", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = -1, imgPath = "persicaria_avg"}
, 
{imgId = 102, imgType = 3, alpha = -1, imgPath = "anna_avg"}
, 
{imgId = 103, imgType = 3, alpha = -1, imgPath = "sol_avg"}
, 
{imgId = 104, imgType = 3, alpha = -1, imgPath = "simo_avg"}
, 
{imgId = 105, imgType = 3, alpha = -1, imgPath = "croque_avg"}
}
, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.3, alpha = 0.75, isDark = False}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 4}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 104, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = false, 
rot = {0, 180, 0}
}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false, 
rot = {0, 180, 0}
}
}
, 
audio = {
sfx = {cue = "Atk_Simo_01", sheet = "Chara_Simo"}
}
, 
heroFace = {
{imgId = 104, faceId = 6}
}
}
, 
[3] = {content = 30, contentType = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
}
, 
audio = {
sfx = {cue = "Skill_Guardian_01_Start", sheet = "Mon_Guardian"}
}
, 
heroFace = {
{imgId = 104, faceId = 0}
}
}
, 
[4] = {content = 40, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 3}
}
, 
audio = {
bgm = {cue = "Mus_Story_General", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = false, 
rot = {0, 180, 0}
}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false, 
rot = {0, 180, 0}
}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 105, faceId = 1}
}
}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, shake = true, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 1, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[11] = {content = 110, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 2}
}
}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
heroFace = {
{imgId = 102, faceId = 5}
}
}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 3}
}
}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
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
[19] = {content = 190, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 1, alpha = 0, isDark = false, 
rot = {0, 180, 0}
}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false, 
rot = {0, 180, 0}
}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 3}
}
}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[23] = {content = 230, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 1, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 5}
}
}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
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
[26] = {content = 260, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 102, faceId = 5}
}
}
, 
[27] = {content = 270, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
heroFace = {
{imgId = 102, faceId = 2}
}
}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[30] = {content = 300, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 102, faceId = 5}
}
}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
heroFace = {
{imgId = 102, faceId = 2}
}
}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[35] = {content = 350, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 1, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {stop = true}
, 
sfx = {cue = "AVG_wind_grass", sheet = "AVG_gf"}
}
, 
heroFace = {
{imgId = 103, faceId = 3}
}
}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 4}
}
}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
, 
audio = {
sfx = {cue = "Skill_Gangyi_01", sheet = "Mon_Gangyi"}
}
}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false, 
rot = {0, 180, 0}
}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false, 
rot = {0, 180, 0}
}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[42] = {content = 420, contentType = 4, speakerName = 421, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 104, faceId = 4}
}
}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 6}
, 
{imgId = 104, faceId = 0}
}
}
, 
[45] = {content = 450, contentType = 4, speakerName = 421, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[46] = {content = 460, contentType = 2, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.3, alpha = 0.6, isDark = Flase}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
}
}
, 
[47] = {
audio = {
sfx = {cue = "Skill_Refactorer_01_Loop", sheet = "Mon_Refactorer", audioId = 14}
}
, content = 470, contentType = 2}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
, 
stopAudioId = {14}
}
, 
heroFace = {
{imgId = 102, faceId = 6}
}
}
, 
[49] = {content = 490, contentType = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "Skill_Abstinence_01_Start", sheet = "Mon_Abstinence"}
}
}
, 
[50] = {content = 500, contentType = 2}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
branch = {
{content = 521, jumpAct = 53}
, 
{content = 522, jumpAct = 60}
}
, 
heroFace = {
{imgId = 102, faceId = 6}
}
}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
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
[54] = {content = 540, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
heroFace = {
{imgId = 105, faceId = 6}
}
}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[59] = {content = 590, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, nextId = 67, 
heroFace = {
{imgId = 105, faceId = 6}
}
}
, 
[60] = {content = 600, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 6}
}
}
, 
[61] = {content = 610, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[62] = {content = 620, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[63] = {content = 630, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[64] = {content = 640, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 2}
}
}
, 
[65] = {content = 650, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
branch = {
{content = 651, jumpAct = 66}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[66] = {content = 660, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
sfx = {cue = "Skill_Croque_01", sheet = "Chara_Croque"}
}
, 
heroFace = {
{imgId = 105, faceId = 6}
}
}
, 
[67] = {content = 670, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
}
}
return AvgCfg_cpt05_e_02_01


-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt04_h_05_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 99, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg005", fullScreen = true}
, 
{imgId = 98, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg001", fullScreen = true}
, 
{imgId = 97, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg002", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "neumann_avg"}
}
, 
audio = {
bgm = {stop = true}
}
, content = 10, contentType = 1, nextId = 53}
, 
[2] = {
audio = {
bgm = {cue = "Mus_Story_Creepy", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 20, contentType = 2}
, 
[3] = {
imgTween = {
{imgId = 99, alpha = 0.7, duration = 1}
}
, content = 30, contentType = 2}
, 
[4] = {content = 40, contentType = 2}
, 
[5] = {
imgTween = {
{imgId = 101, posId = 3, alpha = 0}
, 
{imgId = 101, alpha = 1, duration = 0.2}
}
, content = 50, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[10] = {
imgTween = {
{imgId = 101, alpha = 0, duration = 0.2}
}
, 
audio = {
sfx = {cue = "AVG_Punch", sheet = "AVG_gf"}
}
, content = 100, contentType = 2}
, 
[11] = {
imgTween = {
{imgId = 101, alpha = 1, duration = 0.2}
}
, content = 110, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[22] = {
imgTween = {
{imgId = 101, alpha = 0, duration = 0.2}
, 
{imgId = 99, alpha = 0, duration = 1}
, 
{imgId = 98, alpha = 1, duration = 1, delay = 1}
}
, autoContinue = true}
, 
[23] = {
images = {
{imgId = 101, delete = true}
, 
{imgId = 99, delete = true}
, 
{imgId = 12, imgType = 3, alpha = 0, imgPath = "max_avg"}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "adele_avg"}
}
, 
imgTween = {
{imgId = 101, posId = 1}
, 
{imgId = 101, posId = 2, isDark = false, duration = 0.2}
}
, content = 230, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 1}
, 
[24] = {
imgTween = {
{imgId = 12, posId = 5}
, 
{imgId = 12, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
}
, content = 240, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[27] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 270, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 1}
, 
[28] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 280, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[29] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 290, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 1}
, 
[30] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 300, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[31] = {
audio = {
sfx = {cue = "SupSkill_Cannon_4_chain", sheet = "SupSkill_Cannon"}
}
, 
imgTween = {
{imgId = 12, isDark = true}
, 
{imgId = 12, duration = 0.2, shake = true}
}
, content = 310, contentType = 2}
, 
[32] = {
imgTween = {
{imgId = 12, isDark = false}
}
, content = 320, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[33] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 330, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 1}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 1}
, 
[35] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 350, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[36] = {
audio = {
sfx = {cue = "Skill_Guardian_01_Start", sheet = "Mon_Guardian"}
}
, 
imgTween = {
{imgId = 12, isDark = true}
}
, content = 360, contentType = 4, speakerName = 361}
, 
[37] = {
imgTween = {
{imgId = 12, isDark = false}
}
, content = 370, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3, contentShake = true}
, 
[40] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 400, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 1}
, 
[41] = {
audio = {
sfx = {cue = "AVG_whitenoise", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 101, isDark = true}
}
, content = 410, contentType = 2}
, 
[42] = {
imgTween = {
{imgId = 12, isDark = false}
}
, content = 420, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[43] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 430, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 1}
, 
[44] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 440, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[45] = {
imgTween = {
{imgId = 101, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 12, posId = 5, isDark = false, duration = 0.2}
}
, content = 450, contentType = 2}
, 
[46] = {
audio = {
sfx = {cue = "AVG_RunStep", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 101, posId = 2, isDark = true, duration = 0.2}
, 
{imgId = 12, posId = 4, isDark = false, duration = 0.2}
}
, content = 460, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[50] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 500, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 1}
, 
[51] = {
audio = {
sfx = {cue = "AVG_BaseDoor_Close", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 101, alpha = 0}
, 
{imgId = 12, alpha = 0}
, 
{imgId = 98, alpha = 0, duration = 0.5}
, 
{imgId = 97, alpha = 1, duration = 0.5}
, 
{imgId = 12, duration = 0.2, delay = 0.5, isDark = false, alpha = 1}
}
, content = 510, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3, contentShake = true, isEnd = true}
, 
[53] = {content = 530, contentType = 1, scrambleTypeWriter = true, nextId = 2}
}
return AvgCfg_cpt04_h_05_01


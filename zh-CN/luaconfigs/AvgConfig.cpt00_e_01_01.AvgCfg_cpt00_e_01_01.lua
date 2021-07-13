-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt00_e_01_01 = {
[1] = {bgColor = 2, content = 10, contentType = 4, speakerName = 11, 
images = {
{imgId = 1, imgType = 2, alpha = 0, imgPath = "cpt00/cpt00_e_bg005", fullScreen = true}
, 
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt00/cpt00_e_bg008", 
scale = {1.5, 1.5, 1.5}
, 
pos = {500, -100, 0}
, fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 105, imgType = 3, alpha = 0, imgPath = "croque_avg"}
}
, 
audio = {
bgm = {stop = true}
, 
sfx = {cue = "AVG_ElecSpace", sheet = "AVG_gf"}
}
}
, 
[2] = {content = 20, contentType = 4, speakerName = 11, 
audio = {
sfx = {cue = "AVG_RunStep", sheet = "AVG_gf"}
}
}
, 
[3] = {content = 30, contentType = 4, speakerName = 11}
, 
[4] = {content = 40, contentType = 4, speakerName = 11, 
branch = {
{content = 41, jumpAct = 5}
}
}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 1, delay = 0, duration = 1, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 1, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[11] = {content = 110, contentType = 4, speakerName = 111, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, 
audio = {
bgm = {stop = false, cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 3, fadeOut = 3}
, 
sfx = {cue = "AVG_whitenoise", sheet = "AVG_gf"}
}
}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[13] = {content = 130, contentType = 4, speakerName = 111, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, 
branch = {
{content = 131, jumpAct = 14}
}
}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_body_fall", sheet = "AVG"}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[16] = {content = 160, contentType = 4, speakerName = 111, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[18] = {content = 180, contentType = 2, speakerName = 181, contentShake = true, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[19] = {content = 190, contentType = 2, 
imgTween = {
{imgId = 2, delay = 0, duration = 1, alpha = 1, 
pos = {-500, -100, 0}
, isDark = false}
}
, 
audio = {
bgm = {stop = false, cue = "Mus_Story_Passion", sheet = "Music", fadeIn = 3, fadeOut = 3}
, 
sfx = {cue = "Skill_Croque_Ex_Cast", sheet = "Chara_Croque"}
}
}
, 
[20] = {content = 200, contentType = 4, speakerName = 11}
, 
[21] = {content = 210, contentType = 4, speakerName = 211, 
imgTween = {
{imgId = 2, duration = 1, 
pos = {0, 100, 0}
}
}
}
, 
[22] = {content = 220, contentType = 4, speakerName = 221}
, 
[23] = {content = 230, contentType = 4, speakerName = 11}
, 
[24] = {content = 240, contentType = 4, speakerName = 11}
, 
[25] = {content = 250, contentType = 4, speakerName = 211}
, 
[26] = {content = 260, contentType = 4, speakerName = 11}
, 
[27] = {content = 270, contentType = 4, speakerName = 211, 
imgTween = {
{imgId = 2, duration = 1, 
pos = {0, 0, 0}
, 
scale = {1, 1, 1}
}
}
}
, 
[28] = {content = 280, contentType = 4, speakerName = 221}
, 
[29] = {content = 290, contentType = 4, speakerName = 11}
, 
[30] = {content = 300, contentType = 4, speakerName = 11, contentShake = true}
}
return AvgCfg_cpt00_e_01_01


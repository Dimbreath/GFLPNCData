-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_Test = {
[1] = {
images = {
{imgId = 1, imgPath = "cpt00/cpt00_e_bg005", imgType = 2, fullScreen = true}
}
, content = 10, contentType = 1, contentShake = true, scrambleTypeWriter = true, 
effect = {
effect1 = {prefabName = "Avg/AvgTest", layer = 2}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[2] = {customCode = "print(\'customCode\')", 
images = {
{imgId = 2, imgPath = "42lab_npc_01_avg", imgType = 3, 
pos = {-1000, 0, 0}
, alpha = 0.2, comm = true}
}
, 
imgTween = {
{imgId = 2, duration = 1.5, posId = 1, alpha = 1}
, 
{imgId = 2, delay = 1.5, duration = 0.5, shake = true}
}
, content = 20, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 1, 
audio = {
bgm = {cue = "Mus_Story_Relax", sheet = "Music", fadeIn = 3, fadeOut = 3}
, 
sfx = {cue = "AVG_Alarm", sheet = "AVG_gf", audioId = 0}
, 
voice = {heroId = 1002, voiceId = 1}
}
, 
branch = {
{content = 21, jumpAct = 3}
, 
{content = 22, jumpChapter = "Test"}
}
, 
effect = {
stopList = {"effect1"}
}
}
, 
[3] = {
images = {
{imgId = 3, imgPath = "sol_avg", imgType = 3, 
pos = {1000, 0, 0}
, alpha = 0.2}
, 
{imgId = 4, imgPath = "cpt00/cpt00_e_bg005", order = 2, imgType = 2, fullScreen = true, 
pos = {0, -1080, 0}
, alpha = 0.1}
}
, 
imgTween = {
{imgId = 3, duration = 1.5, posId = 4, alpha = 1}
, 
{imgId = 4, duration = 0.5, 
pos = {0, 0, 0}
, alpha = 1}
, 
{imgId = 2, duration = 1, isDark = true}
}
, 
heroFace = {
{imgId = 3, faceId = 3}
}
, content = 30, contentType = 3, contentShake = true, speakerHeroId = 1034, 
audio = {
bgm = {stop = true}
, 
voice = {heroId = 1001, voiceId = 1}
, 
stopAudioId = {0}
}
}
, 
[4] = {
heroFace = {
{imgId = 3, faceId = 4}
}
, content = 40, contentType = 3, speakerHeroId = 1034, vedioPath = "avg/cpt00_pv"}
, 
[5] = {
images = {
{imgId = 1, delete = true}
}
, content = 50, contentType = 2, 
ppv = {
cg = {saturation = -100}
}
}
, 
[6] = {
images = {
{imgId = 2, delete = true}
, 
{imgId = 3, delete = true}
}
, content = 60, contentType = 2, contentShake = true}
, 
[7] = {content = 70, contentType = 4, speakerName = 71, 
ppv = {
cg = {saturation = 0}
}
}
, 
[8] = {content = 80, contentType = 5, tipsTypeWriter = true, vedioLoopPath = "avg/cpt00_pv", 
vedioLoopFrame = {0, 20}
}
, 
[9] = {content = 90, contentType = 2, scrambleTypeWriter = true, 
vedioLoopFrame = {21, 40}
}
, 
[10] = {content = 100, contentType = 2, vedioLoopStop = true}
, 
[-1] = {bgColor = 1, 
images = {
{imgId = 1, imgPath = "", order = 0, imgType = 1, fullScreen = true, posId = 1, 
pos = {0, 0, 0}
, 
rot = {0, 0, 0}
, 
scale = {1, 1, 1}
, alpha = 1, isDark = false, comm = true, delete = false}
}
, 
imgTween = {
{imgId = 1, duration = 1, delay = 0, posId = 1, 
pos = {0, 0, 0}
, 
rot = {0, 0, 0}
, alpha = 0.5, 
scale = {1, 1, 1}
, isDark = nil, shake = true}
}
, 
heroFace = {
{imgId = 1, faceId = 1}
, 
{imgId = 2, faceId = 3}
}
, content = 40, contentType = 1, contentShake = true, speakerHeroId = nil, speakerHeroPosId = 1, speakerName = nil, tipsShowDuration = 0, tipsTypeWriter = true, scrambleTypeWriter = true, autoContinue = true, 
ppv = {
cg = {saturation = 0}
}
, vedioPath = "avg/cpt00_pv", vedioLoopPath = "avg/cpt00_pv", 
vedioLoopFrame = {0, 100}
, vedioLoopStop = true, 
effect = {
effect1 = {prefabName = "Avg/AvgTest", 
pos = {0, 0, 0}
, layer = 1}
, 
stopList = {"effect1"}
}
, 
audio = {
bgm = {stop = true, cue = "Mus_Story_Relax", sheet = "Music", fadeIn = 2, fadeOut = 3}
, 
sfx = {cue = "Menu_Victory", sheet = "UI", audioId = 0}
, 
stopAudioId = {0, 1, 2}
, 
voice = {heroId = 1001, voiceId = 1}
}
, 
branch = {
{content = 21, jumpAct = 3, jumpChapter = "story1"}
, 
{content = 22, jump = 4}
}
, nextId = 2, isEnd = true, customCode = "print(\'customCode\')"}
}
return AvgCfg_Test


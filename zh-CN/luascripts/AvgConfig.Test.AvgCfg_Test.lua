-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_Test = {
[1] = {
images = {
{imgId = 1, imgPath = "TestBg1", imgType = 2, fullScreen = true}
}
, content = 10, contentType = 1, contentShake = true, scrambleTypeWriter = true, 
audio = {
bgm = {cue = "m_bat_default", sheet = "Music"}
}
, 
effect = {
effect1 = {prefabName = "Avg/AvgTest", layer = 2}
}
}
, 
[2] = {customCode = "print(\'customCode\')", 
images = {
{imgId = 2, imgPath = "mai", imgType = 3, 
pos = {-1000, 0, 0}
, alpha = 0.2}
}
, 
imgTween = {
{imgId = 2, duration = 1.5, posId = 1, alpha = 1}
, 
{imgId = 2, delay = 1.5, duration = 0.5, shake = true}
}
, content = 20, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 1, 
audio = {
voice = {cue = "ui_recieve", sheet = "SFX"}
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
{imgId = 3, imgPath = "simo", imgType = 3, 
pos = {1000, 0, 0}
, alpha = 0.2}
, 
{imgId = 4, imgPath = "TestBg2", order = 2, imgType = 2, fullScreen = true, 
pos = {0, -1080, 0}
, alpha = 0.1}
}
, 
imgTween = {
{imgId = 3, duration = 1.5, posId = 3, alpha = 1}
, 
{imgId = 4, duration = 0.5, 
pos = {0, 0, 0}
, alpha = 1}
, 
{imgId = 2, duration = 1, isDark = true}
}
, content = 30, contentType = 3, contentShake = true, speakerHeroId = 1034, 
audio = {
voice = {cue = "ui_recieve", sheet = "SFX"}
}
}
, 
[4] = {
images = {
{imgId = 5, imgPath = "Test1", order = 2, imgType = 4, 
pos = {0, 1080, 0}
}
}
, 
imgTween = {
{imgId = 5, duration = 1, 
pos = {0, 0, 0}
, 
rot = {0, 0, 360}
, 
scale = {0.5, 0.5, 0.5}
}
, 
{imgId = 5, delay = 1, duration = 1, 
pos = {-500, 0, 0}
, 
rot = {0, 0, -360}
, 
scale = {1, 1, 1}
, alpha = 0.5}
}
, content = 40, contentType = 3, speakerHeroId = 1034, vedioPath = "avg/avg001"}
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
[8] = {content = 80, contentType = 5, tipsTypeWriter = true, vedioLoopPath = "avg/avg001", 
vedioLoopFrame = {0, 20}
}
, 
[9] = {content = 90, contentType = 2, scrambleTypeWriter = true, 
vedioLoopFrame = {21, 40}
}
, 
[10] = {content = 100, contentType = 2, vedioLoopStop = true}
, 
[-1] = {
images = {
{imgId = 1, imgPath = "", order = 0, imgType = 1, fullScreen = true, posId = 1, 
pos = {0, 0, 0}
, 
rot = {0, 0, 0}
, 
scale = {1, 1, 1}
, alpha = 1, isDark = false, delete = false}
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
, content = 40, contentType = 1, contentShake = true, speakerHeroId = nil, speakerHeroPosId = 1, speakerName = nil, tipsShowDuration = 0, tipsTypeWriter = true, scrambleTypeWriter = true, autoContinue = true, 
ppv = {
cg = {saturation = 0}
}
, vedioPath = "avg/avg001", vedioLoopPath = "avg/avg001", 
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
bgm = {stop = true, cue = "m_bat_default", sheet = "Music"}
, sfx = nil, 
voice = {cue = "ui_recieve", sheet = "SFX"}
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


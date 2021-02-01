-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt01_h_04_01 = {
[1] = {bgColor = 2, content = 10, contentType = 1, nextId = 55, 
images = {
{imgId = 1, imgType = 1, alpha = 1, imgPath = "cpt00/cpt00_e_bg001", fullScreen = true}
, 
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt00/cpt00_e_bg007_1", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 102, imgType = 3, alpha = 0, imgPath = "anna_avg"}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[2] = {content = 20, contentType = 2, 
imgTween = {
{imgId = 2, delay = 0, duration = 1, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_General", sheet = "Music", fadeIn = 2, fadeOut = 2}
, 
sfx = {cue = "AVG_BaseDoor_Open", sheet = "AVG_gf"}
}
}
, 
[3] = {content = 30, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[4] = {content = 40, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[11] = {content = 110, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[23] = {content = 230, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
audio = {
bgm = {stop = true, sheet = "Mus_Story_General"}
}
}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
audio = {
bgm = {cue = "Mus_Story_Exiles", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[27] = {content = 270, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[30] = {content = 300, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[35] = {content = 350, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 2, delay = 0, duration = 0.6, alpha = 0, isDark = false}
}
, isEnd = true}
, 
[55] = {content = 550, contentType = 1, scrambleTypeWriter = true, nextId = 2}
}
return AvgCfg_cpt01_h_04_01


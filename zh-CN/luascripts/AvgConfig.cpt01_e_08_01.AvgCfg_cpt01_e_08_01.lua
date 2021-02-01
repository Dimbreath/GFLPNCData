-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt01_e_08_01 = {
[1] = {content = 10, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
audio = {
bgm = {cue = "Mus_Story_Passion", sheet = "Music"}
, 
sfx = {cue = "Atk_Xin_01", sheet = "Mon_Xin"}
}
, bgColor = 2, 
images = {
{imgId = 98, imgType = 2, alpha = 0, order = 1, imgPath = "cpt01/cpt01_e_bg005", fullScreen = true}
, 
{imgId = 97, imgType = 2, alpha = 0, imgPath = "cpt01/cpt01_e_cg001", 
scale = {1.7, 1.7, 1.7}
, 
pos = {0, -300, 0}
, fullScreen = true}
, 
{imgId = 1, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 2, imgType = 3, alpha = 0, imgPath = "anna_hood_avg"}
, 
{imgId = 3, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "faith_avg"}
}
, 
imgTween = {
{imgId = 3, posId = 3, alpha = 0}
, 
{imgId = 98, delay = 0, duration = 0.5, alpha = 1}
, 
{imgId = 3, delay = 0.5, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 3, faceId = 4}
}
}
, 
[2] = {
imgTween = {
{imgId = 3, duration = 0.2, alpha = 0, isDark = false}
, 
{imgId = 101, posId = 3, isDark = false}
}
, 
audio = {
sfx = {cue = "Skill_Xin_01", sheet = "Mon_Xin", audioId = 1}
}
, content = 20, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[3] = {
imgTween = {
{imgId = 3, duration = 0.2, alpha = 1, isDark = false}
, 
{imgId = 101, duration = 0.2, alpha = 0, isDark = false}
}
, 
audio = {
stopAudioId = {1}
}
, content = 30, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, contentShake = true}
, 
[4] = {
imgTween = {
{imgId = 3, duration = 0.2, alpha = 0, isDark = false}
, 
{imgId = 101, duration = 0.2, alpha = 1, isDark = false}
, 
{imgId = 101, duration = 0.2, delay = 0.2, shake = true}
}
, 
audio = {
sfx = {cue = "Atk_Chong_01", sheet = "Mon_Chong"}
}
, content = 40, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[5] = {
imgTween = {
{imgId = 3, duration = 0.2, alpha = 1, isDark = false}
, 
{imgId = 3, duration = 0.2, delay = 0.2, shake = true}
, 
{imgId = 101, duration = 0.2, alpha = 0, isDark = false}
}
, content = 50, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
audio = {
sfx = {cue = "Skill_Sol_Passive", sheet = "Chara_Sol"}
}
, 
heroFace = {
{imgId = 3, faceId = 6}
}
}
, 
[6] = {
imgTween = {
{imgId = 3, duration = 0.2, alpha = 0, isDark = false}
, 
{imgId = 101, duration = 0.2, alpha = 1, isDark = false}
, 
{imgId = 101, duration = 0.2, delay = 0.2, shake = true}
}
, content = 60, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
audio = {
sfx = {cue = "Skill_Sol_Passive", sheet = "Chara_Sol"}
}
}
, 
[7] = {
imgTween = {
{imgId = 3, duration = 0.3, alpha = 0}
, 
{imgId = 101, duration = 0.3, alpha = 0}
}
, content = 70, contentType = 2, 
audio = {
sfx = {cue = "AVG_BaseDoor_Open", sheet = "AVG_gf"}
}
}
, 
[8] = {
imgTween = {
{imgId = 1, posId = 3}
}
, content = 80, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
heroFace = {
{imgId = 1, faceId = 4}
}
}
, 
[9] = {
imgTween = {
{imgId = 1, duration = 0.2, alpha = 0}
, 
{imgId = 3, posId = 3, alpha = 0}
, 
{imgId = 3, duration = 0.2, alpha = 1, isDark = false}
}
, content = 90, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
heroFace = {
{imgId = 3, faceId = 6}
}
}
, 
[10] = {
imgTween = {
{imgId = 3, duration = 0.5, alpha = 0}
}
, content = 100, contentType = 2}
, 
[11] = {
imgTween = {
{imgId = 2, posId = 3, alpha = 0}
, 
{imgId = 2, duration = 0.7, alpha = 1, isDark = true}
}
, 
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, content = 110, contentType = 2}
, 
[12] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, duration = 0.5, posId = 2}
, 
{imgId = 2, duration = 0.5, 
pos = {400, -190, 0}
, isDark = true}
}
, content = 120, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
heroFace = {
{imgId = 1, faceId = 4}
}
}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[14] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 140, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 3}
, 
[15] = {
imgTween = {
{imgId = 1, duration = 0.3, alpha = 0}
, 
{imgId = 2, duration = 0.3, alpha = 0}
}
, content = 150, contentType = 2}
, 
[16] = {
imgTween = {
{imgId = 3, posId = 2}
, 
{imgId = 3, duration = 0.2, posId = 3}
}
, 
audio = {
sfx = {cue = "AVG_Combat_Hits", sheet = "AVG_gf"}
}
, content = 160, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
heroFace = {
{imgId = 3, faceId = 0}
}
}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, contentShake = true, 
heroFace = {
{imgId = 3, faceId = 6}
}
}
, 
[18] = {
imgTween = {
{imgId = 3, duration = 0.3, alpha = 0}
, 
{imgId = 101, duration = 0.5, posId = 3, delay = 0.5}
}
, content = 180, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[19] = {
imgTween = {
{imgId = 3, alpha = 1}
, 
{imgId = 3, duration = 0.3, shake = true}
, 
{imgId = 101, alpha = 0}
}
, 
audio = {
sfx = {cue = "AVG_Punch", sheet = "AVG_gf"}
}
, content = 190, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
heroFace = {
{imgId = 3, faceId = 4}
}
}
, 
[20] = {
imgTween = {
{imgId = 3, duration = 0.2, alpha = 0}
, 
{imgId = 101, duration = 0.3, alpha = 1}
}
, content = 200, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[22] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 0}
, 
{imgId = 3, duration = 0.3, alpha = 1}
}
, content = 220, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
heroFace = {
{imgId = 3, faceId = 5}
}
}
, 
[23] = {
imgTween = {
{imgId = 3, duration = 0.2, alpha = 0}
, 
{imgId = 1, posId = 3, isDark = false}
}
, content = 230, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
heroFace = {
{imgId = 1, faceId = 4}
}
}
, 
[24] = {
imgTween = {
{imgId = 1, duration = 0.2, alpha = 0}
, 
{imgId = 3, duration = 0.3, alpha = 1}
}
, content = 240, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
heroFace = {
{imgId = 3, faceId = 4}
}
}
, 
[25] = {
imgTween = {
{imgId = 3, duration = 0.2, alpha = 0}
, 
{imgId = 1, duration = 0.3, alpha = 1}
}
, content = 250, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
heroFace = {
{imgId = 1, faceId = 5}
}
}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
heroFace = {
{imgId = 1, faceId = 2}
}
}
, 
[27] = {
imgTween = {
{imgId = 1, duration = 0.5, alpha = 0}
}
, 
audio = {
sfx = {cue = "AVG_ElecSpace", sheet = "AVG_gf", audioId = 1}
}
, content = 270, contentType = 4, speakerName = 271}
, 
[28] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 1}
}
, 
audio = {
stopAudioId = {1}
}
, content = 280, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[29] = {
imgTween = {
{imgId = 2, posId = 1}
, 
{imgId = 2, duration = 0.5, posId = 2}
, 
{imgId = 101, duration = 0.5, posId = 4, isDark = true}
}
, content = 290, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 1}
, 
[30] = {
imgTween = {
{imgId = 2, alpha = 0}
, 
{imgId = 101, alpha = 0}
}
, content = 300, contentType = 2}
, 
[31] = {
imgTween = {
{imgId = 98, duration = 1.5, alpha = 0}
, 
{imgId = 97, duration = 1.5, alpha = 1}
}
, content = 310, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[32] = {content = 320, contentType = 4, speakerName = 321}
, 
[33] = {content = 330, contentType = 4, speakerName = 322}
, 
[34] = {content = 340, contentType = 4, speakerName = 322}
, 
[35] = {content = 350, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[36] = {
imgTween = {
{imgId = 97, duration = 0.5, alpha = 0}
, 
{imgId = 98, duration = 0.5, alpha = 1}
, 
{imgId = 101, posId = 3, alpha = 0}
, 
{imgId = 101, delay = 0.5, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, content = 360, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[38] = {
imgTween = {
{imgId = 3, posId = 1}
, 
{imgId = 3, duration = 0.2, alpha = 1}
, 
{imgId = 101, duration = 0.2, alpha = 0}
}
, content = 380, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
heroFace = {
{imgId = 1, faceId = 2}
}
}
, 
[39] = {
imgTween = {
{imgId = 98, duration = 0.5, alpha = 0}
, 
{imgId = 97, duration = 0.5, alpha = 1}
, 
{imgId = 3, duration = 0.2, alpha = 0}
}
, content = 390, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[40] = {
imgTween = {
{imgId = 97, duration = 3, 
scale = {1, 1, 1}
, 
pos = {0, 0, 0}
}
}
, 
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf", audioId = 1}
}
, content = 400, contentType = 2}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[43] = {content = 430, contentType = 4, speakerName = 323}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[45] = {
imgTween = {
{imgId = 97, duration = 0.5, alpha = 0}
, 
{imgId = 98, duration = 0.5, alpha = 1}
, 
{imgId = 3, delay = 0.5, posId = 3, duration = 0.2, alpha = 1}
}
, content = 450, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
heroFace = {
{imgId = 3, faceId = 0}
}
}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
heroFace = {
{imgId = 3, faceId = 6}
}
}
}
return AvgCfg_cpt01_e_08_01


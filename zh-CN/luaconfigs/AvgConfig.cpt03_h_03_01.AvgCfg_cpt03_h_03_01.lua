-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt03_h_03_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 99, imgType = 2, alpha = 0, imgPath = "cpt03/cpt03_e_bg001", fullScreen = true}
, 
{imgId = 98, imgType = 2, alpha = 0, imgPath = "cpt03/cpt03_e_bg002", fullScreen = true}
, 
{imgId = 97, imgType = 2, alpha = 0, imgPath = "cpt03/cpt03_e_bg005", fullScreen = true}
, 
{imgId = 96, imgType = 2, alpha = 0, imgPath = "cpt03/cpt03_e_bg007", fullScreen = true}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "zion_avg"}
, 
{imgId = 102, imgType = 3, alpha = 0, imgPath = "beelneith_avg"}
, 
{imgId = 104, imgType = 3, alpha = 0, imgPath = "sisy_avg"}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "choco_avg"}
}
, 
audio = {
bgm = {stop = true}
}
, content = 10, contentType = 1, scrambleTypeWriter = true}
, 
[2] = {
audio = {
bgm = {cue = "Mus_Story_Relax", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
imgTween = {
{imgId = 99, duration = 2, alpha = 1}
}
, content = 20, contentType = 2}
, 
[3] = {
imgTween = {
{imgId = 99, duration = 2, alpha = 0}
, 
{imgId = 98, duration = 2, alpha = 1}
}
, content = 30, contentType = 2}
, 
[4] = {
imgTween = {
{imgId = 98, duration = 2, alpha = 0}
, 
{imgId = 96, duration = 2, alpha = 1}
}
, content = 40, contentType = 2}
, 
[5] = {
imgTween = {
{imgId = 96, duration = 2, alpha = 0}
, 
{imgId = 97, duration = 2, alpha = 1}
}
, content = 50, contentType = 2}
, 
[6] = {content = 60, contentType = 2}
, 
[7] = {
imgTween = {
{imgId = 97, duration = 2, alpha = 0}
, 
{imgId = 98, duration = 2, alpha = 1}
, 
{imgId = 103, posId = 3, alpha = 0}
, 
{imgId = 103, alpha = 1, duration = 2}
}
, content = 70, contentType = 2}
, 
[8] = {
imgTween = {
{imgId = 104, posId = 3, alpha = 0}
, 
{imgId = 104, alpha = 1, duration = 2}
, 
{imgId = 103, alpha = 0, duration = 2}
}
, content = 80, contentType = 2}
, 
[9] = {
imgTween = {
{imgId = 98, duration = 2, alpha = 0}
, 
{imgId = 96, alpha = 1, duration = 2}
, 
{imgId = 104, alpha = 0, duration = 2}
}
, content = 90, contentType = 2}
, 
[10] = {
imgTween = {
{imgId = 96, duration = 2, alpha = 0}
, 
{imgId = 97, alpha = 1, duration = 2}
}
, content = 100, contentType = 2}
, 
[11] = {
imgTween = {
{imgId = 97, shake = true, duration = 0.2}
}
, 
audio = {
sfx = {cue = "AVG_doorknock_wood", sheet = "AVG_gf"}
}
, autoContinue = true}
, 
[12] = {
heroFace = {
{imgId = 101, faceId = 1}
}
, 
imgTween = {
{imgId = 101, posId = 3}
, 
{imgId = 101, shake = true, duration = 0.1}
}
, content = 120, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
, 
[13] = {
images = {
{imgId = 99, delete = true}
, 
{imgId = 96, delete = true}
, 
{imgId = 103, delete = true}
, 
{imgId = 104, delete = true}
}
, 
imgTween = {
{imgId = 101, duration = 1, alpha = 0}
, 
{imgId = 97, alpha = 0, duration = 1}
, 
{imgId = 98, alpha = 1, duration = 1}
}
, content = 130, contentType = 2}
, 
[14] = {
imgTween = {
{imgId = 101, duration = 0.2, delay = 0.5, alpha = 1}
, 
{imgId = 97, alpha = 0.5, duration = 1}
, 
{imgId = 98, alpha = 0.5, duration = 0}
}
, content = 140, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2, 
audio = {
sfx = {cue = "AVG_Door_Open_Close", sheet = "AVG_gf"}
}
}
, 
[15] = {
heroFace = {
{imgId = 102, faceId = 1}
}
, 
imgTween = {
{imgId = 101, duration = 0.2, alpha = 0}
, 
{imgId = 102, alpha = 0, posId = 3}
, 
{imgId = 102, alpha = 1, duration = 0.2}
}
, 
audio = {
bgm = {stop = true}
}
, content = 150, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[16] = {
imgTween = {
{imgId = 102, alpha = 0, duration = 0.2}
}
, content = 160, contentType = 2}
, 
[17] = {content = 170, contentType = 2}
, 
[18] = {
heroFace = {
{imgId = 101, faceId = 6}
}
, 
imgTween = {
{imgId = 101, duration = 0.2, alpha = 1}
}
, content = 180, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2, 
audio = {
bgm = {cue = "Mus_Story_Funny", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[19] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 0}
, 
{imgId = 102, duration = 0.2, alpha = 1}
}
, content = 190, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[20] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 0}
, 
{imgId = 102, duration = 0.2, alpha = 1}
}
, content = 200, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[23] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 1}
, 
{imgId = 102, duration = 0.2, alpha = 0}
}
, content = 230, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
, 
[24] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 0}
, 
{imgId = 102, duration = 0.2, alpha = 1}
}
, content = 240, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[26] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 1}
, 
{imgId = 102, duration = 0.5, alpha = 0, 
pos = {-250, -150, 0}
}
}
, content = 260, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2, contentShake = true}
, 
[27] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 0}
}
, content = 270, contentType = 2}
, 
[28] = {
imgTween = {
{imgId = 102, duration = 0.5, alpha = 1, 
pos = {-180, -150, 0}
}
}
, content = 280, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, contentShake = true}
, 
[30] = {content = 300, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, contentShake = true}
, 
[31] = {
imgTween = {
{imgId = 102, duration = 0.2, alpha = 0}
}
, content = 310, contentType = 2}
, 
[32] = {
imgTween = {
{imgId = 101, alpha = 1}
, 
{imgId = 101, duration = 0.2, shake = true}
}
, content = 320, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
, 
[33] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 0}
, 
{imgId = 102, duration = 0.2, alpha = 1}
}
, content = 330, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[34] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 1}
, 
{imgId = 102, duration = 0.2, alpha = 0}
}
, content = 340, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
, 
[35] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 0}
, 
{imgId = 102, duration = 0.2, alpha = 1}
}
, content = 350, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[36] = {
imgTween = {
{imgId = 102, duration = 0.2, alpha = 0}
}
, content = 360, contentType = 2}
, 
[37] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 1}
}
, content = 370, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
, 
[38] = {
imgTween = {
{imgId = 102, alpha = 1}
, 
{imgId = 102, duration = 0.2, shake = true}
, 
{imgId = 101, duration = 0.2, alpha = 0}
}
, content = 380, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[39] = {
imgTween = {
{imgId = 102, duration = 0.2, alpha = 0}
, 
{imgId = 101, duration = 0.2, alpha = 1}
}
, content = 390, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
, 
[40] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 0}
}
, content = 400, contentType = 2}
, 
[41] = {
imgTween = {
{imgId = 102, alpha = 1}
, 
{imgId = 102, duration = 0.2, shake = true}
}
, content = 410, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[42] = {
heroFace = {
{imgId = 102, faceId = 6}
}
, content = 420, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, contentShake = true}
, 
[43] = {
heroFace = {
{imgId = 102, faceId = 1}
}
, content = 430, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, contentShake = true}
, 
[44] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 1}
, 
{imgId = 102, duration = 0.2, alpha = 0}
}
, content = 440, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
, 
[45] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 0}
}
, content = 450, contentType = 2}
, 
[46] = {
heroFace = {
{imgId = 101, faceId = 0}
}
, 
imgTween = {
{imgId = 101, duration = 0.2, alpha = 1}
}
, content = 460, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
, 
[47] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 0}
, 
{imgId = 102, duration = 0.2, alpha = 1}
}
, content = 470, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[50] = {
heroFace = {
{imgId = 101, faceId = 7}
}
, 
imgTween = {
{imgId = 101, duration = 0.2, alpha = 1}
, 
{imgId = 102, duration = 0.2, alpha = 0}
}
, content = 500, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2, contentShake = true}
, 
[51] = {
heroFace = {
{imgId = 102, faceId = 4}
}
, 
imgTween = {
{imgId = 101, duration = 0.2, alpha = 0}
, 
{imgId = 102, duration = 0.2, alpha = 1}
}
, content = 510, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[52] = {
heroFace = {
{imgId = 101, faceId = 6}
}
, 
imgTween = {
{imgId = 101, duration = 0.2, alpha = 1}
, 
{imgId = 102, duration = 0.2, alpha = 0}
}
, content = 520, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
, 
[53] = {
heroFace = {
{imgId = 102, faceId = 1}
}
, 
imgTween = {
{imgId = 101, duration = 0.2, alpha = 0}
, 
{imgId = 102, duration = 0.2, alpha = 1}
}
, content = 530, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[55] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 1}
, 
{imgId = 102, duration = 0.2, alpha = 0}
}
, content = 550, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
, 
[56] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 0}
, 
{imgId = 102, duration = 0.2, alpha = 1}
}
, content = 560, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[57] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 1}
, 
{imgId = 102, duration = 0.2, alpha = 0}
}
, content = 570, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
, 
[58] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 0}
, 
{imgId = 97, duration = 0.5, alpha = 0}
, 
{imgId = 98, duration = 0.5, alpha = 1}
}
, autoContinue = true, 
audio = {
bgm = {stop = true}
}
}
, 
[59] = {content = 590, contentType = 2, 
audio = {
sfx = {cue = "AVG_AMB_Street", sheet = "AVG_gf", audioId = 59}
}
}
, 
[60] = {
imgTween = {
{imgId = 102, duration = 0.2, alpha = 1}
}
, content = 600, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[61] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 1}
, 
{imgId = 102, duration = 0.2, alpha = 0}
}
, content = 610, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
, 
[62] = {
heroFace = {
{imgId = 102, faceId = 0}
}
, 
imgTween = {
{imgId = 101, duration = 0.2, alpha = 0}
, 
{imgId = 102, duration = 0.2, alpha = 1}
}
, content = 620, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[63] = {content = 630, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[64] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 1}
, 
{imgId = 102, duration = 0.2, alpha = 0}
}
, content = 640, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
, 
[65] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 0}
, 
{imgId = 102, duration = 0.2, alpha = 1}
}
, content = 650, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
audio = {
sfx = {cue = "AVG_tele_connect", sheet = "AVG_gf"}
}
}
, 
[66] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 1}
, 
{imgId = 102, duration = 0.2, alpha = 0}
}
, content = 660, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2, contentShake = true}
, 
[67] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 0}
, 
{imgId = 102, duration = 0.2, alpha = 1}
}
, content = 670, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[68] = {content = 680, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[69] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 1}
, 
{imgId = 102, duration = 0.2, alpha = 0}
}
, content = 690, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
, 
[70] = {
imgTween = {
{imgId = 101, duration = 0.5, alpha = 0}
}
, content = 700, contentType = 2}
, 
[71] = {content = 710, contentType = 2}
, 
[72] = {
imgTween = {
{imgId = 101, duration = 0.5, alpha = 1}
}
, 
audio = {
stopAudioId = {59}
}
, content = 720, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
}
return AvgCfg_cpt03_h_03_01


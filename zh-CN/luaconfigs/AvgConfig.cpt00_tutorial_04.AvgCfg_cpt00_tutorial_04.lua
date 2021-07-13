-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt00_tutorial_04 = {
[1] = {
images = {
{imgId = 1, imgType = 3, alpha = 0, imgPath = "persicaria_avg", order = 2}
, 
{imgId = 2, imgType = 3, alpha = 0, 
rot = {0, 180, 0}
, imgPath = "croque_avg"}
}
, 
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, duration = 0.2, posId = 2}
}
, content = 10, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
heroFace = {
{imgId = 1, faceId = 4}
}
}
, 
[2] = {
imgTween = {
{imgId = 2, alpha = 0, posId = 5}
, 
{imgId = 2, alpha = 1, posId = 4, duration = 0.2}
, 
{imgId = 1, isDark = true}
}
, content = 20, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[3] = {
imgTween = {
{imgId = 2, alpha = 0, duration = 1}
, 
{imgId = 1, isDark = false}
}
, content = 30, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
heroFace = {
{imgId = 1, faceId = 5}
}
}
, 
[4] = {
imgTween = {
{imgId = 1, isDark = false}
}
, customCode = "AvgUtil.ChangeUltSkillOrder(true)", content = 40, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
heroFace = {
{imgId = 1, faceId = 4}
}
}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[6] = {customCode = "AvgUtil.ChangeUltSkillOrder(false)", autoContinue = true}
}
return AvgCfg_cpt00_tutorial_04


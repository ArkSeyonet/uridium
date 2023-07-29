Model = {}

---Request model by string
---@param m string
---@return true|false
Model.RequestModel = function(m)
  if m then
    local count = 0
    if IsModelValid(m) then
      RequestModel(m)

      repeat
        count = count + 1
        Wait(10)
      until HasModelLoaded(m) or count >= 100

      if HasModelLoaded(m) then
        return true
      end
    end
  end

  return false
end

---Check if model is freemode ped.
---@param m integer
---@return true|false
Model.IsFreemodePed = function(m)
  if m then
    if m == "mp_m_freemode_01" or m == "mp_f_freemode_01" then
      return true
    else
      return false
    end
  else
    return false
  end
end

---Get Default Ped components
---@return table components
Model.GetDefaultComponents = function()
	local components = {
		[1] = {0, 0}, [3] = {15, 0}, [4] = {28, 0}, [5] = {0, 0}, [6] = {5, 0},
		[7] = {0, 0}, [8] = {15, 0}, [9] = {0, 0}, [10] = {1, 0}, [11] = {15, 0}
	}

  return components
end

Model.UpdatePedFaceFeature = function(ped, id, value)
  SetPedFaceFeature(ped, id, value)
end

Model.UpdatePedHeadOverlay = function(ped, id, value, opacity)
  SetPedHeadOverlay(ped, id, value, opacity)
end


---Load ped skin
---@param skin table
---@param showPed boolean
---@param reloadPed boolean
---@return true|false
Model.LoadSkin = function(skin, showPed, reloadPed)
  local model = skin["model"]
  local modelHash = GetHashKey(model)

  if Model.RequestModel(modelHash) then
    SetPlayerModel(PlayerId(), modelHash)
    local ped = PlayerPedId()

    if Model.IsFreemodePed(model) then
      SetPedHeadBlendData(ped, skin["SHFID"], skin["SHSID"], skin["SHTID"], skin["SKFID"], skin["SKSID"], skin["SKTID"], skin["SHMIX"], skin["SKMIX"], skin["TMIX"], true)

      SetPedFaceFeature(ped, 0,  skin["faceFeatures"]["noseWidth"])
      SetPedFaceFeature(ped, 1,  skin["faceFeatures"]["noseHeight"])
      SetPedFaceFeature(ped, 2,  skin["faceFeatures"]["noseLength"])
      SetPedFaceFeature(ped, 3,  skin["faceFeatures"]["noseBridge"])
      SetPedFaceFeature(ped, 4,  skin["faceFeatures"]["noseTip"])
      SetPedFaceFeature(ped, 5,  skin["faceFeatures"]["noseShift"])
      SetPedFaceFeature(ped, 6,  skin["faceFeatures"]["eyebrowWidth"])
      SetPedFaceFeature(ped, 7,  skin["faceFeatures"]["eyebrowShape"])
      SetPedFaceFeature(ped, 8,  skin["faceFeatures"]["cheekboneHeight"])
      SetPedFaceFeature(ped, 9,  skin["faceFeatures"]["cheekboneWidth"])
      SetPedFaceFeature(ped, 10, skin["faceFeatures"]["cheeksWidth"])
      SetPedFaceFeature(ped, 11, skin["faceFeatures"]["eyeState"])
      SetPedFaceFeature(ped, 12, skin["faceFeatures"]["lipsWidth"])
      SetPedFaceFeature(ped, 13, skin["faceFeatures"]["jawWidth"])
      SetPedFaceFeature(ped, 14, skin["faceFeatures"]["jawHeight"])
      SetPedFaceFeature(ped, 15, skin["faceFeatures"]["chinHeight"])
      SetPedFaceFeature(ped, 16, skin["faceFeatures"]["chinLength"])
      SetPedFaceFeature(ped, 17, skin["faceFeatures"]["chinWidth"])
      SetPedFaceFeature(ped, 18, skin["faceFeatures"]["chinPosition"])
      SetPedFaceFeature(ped, 19, skin["faceFeatures"]["neckThickness"])

      SetPedComponentVariation(ped, 2, skin["hair"]["value"], 0, 2)
      SetPedHairColor(ped, skin["hair"]["color"], skin["hair"]["highlight"])

      SetPedHeadOverlayColor(ped, 1, 1, skin["beard"]["color"], skin["beard"]["highlight"])
      SetPedHeadOverlayColor(ped, 2, 1, skin["eyebrow"]["color"], skin["eyebrow"]["highlight"])
      SetPedHeadOverlayColor(ped, 4, 2, skin["makeup"]["color"], skin["makeup"]["highlight"])
      SetPedHeadOverlayColor(ped, 5, 2, skin["blush"]["color"], skin["blush"]["highlight"])
      SetPedHeadOverlayColor(ped, 8, 2, skin["lipstick"]["color"], skin["lipstick"]["highlight"])
      SetPedHeadOverlayColor(ped, 10, 1, skin["chesthair"]["color"], skin["chesthair"]["highlight"])
      SetPedEyeColor(ped, skin["eyeColor"])

      SetPedHeadOverlay(ped, 0, skin["blemishes"]["value"], skin["blemishes"]["opacity"])
      SetPedHeadOverlay(ped, 1, skin["beard"]["value"], skin["beard"]["opacity"])
      SetPedHeadOverlay(ped, 2, skin["eyebrow"]["value"], skin["eyebrow"]["opacity"])
      SetPedHeadOverlay(ped, 3, skin["aging"]["value"], skin["aging"]["opacity"])
      SetPedHeadOverlay(ped, 4, skin["makeup"]["value"], skin["makeup"]["opacity"])
      SetPedHeadOverlay(ped, 5, skin["blush"]["value"], skin["blush"]["opacity"])
      SetPedHeadOverlay(ped, 6, skin["complexion"]["value"], skin["complexion"]["opacity"])
      SetPedHeadOverlay(ped, 7, skin["sunDamage"]["value"], skin["sunDamage"]["opacity"])
      SetPedHeadOverlay(ped, 8, skin["lipstick"]["value"], skin["lipstick"]["opacity"])
      SetPedHeadOverlay(ped, 9, skin["freckles"]["value"], skin["freckles"]["opacity"])
      SetPedHeadOverlay(ped, 10, skin["chesthair"]["value"], skin["chesthair"]["opacity"])
      SetPedHeadOverlay(ped, 11, skin["bodyBlemishes"]["value"], skin["bodyBlemishes"]["opacity"])
      SetPedHeadOverlay(ped, 12, skin["moreBodyBlemishes"]["value"], skin["moreBodyBlemishes"]["opacity"])

      SetPedComponentVariation(ped, 1, skin["mask"]["variant"], skin["mask"]["value"], 1)
      SetPedComponentVariation(ped, 3, skin["torso"]["variant"], skin["torso"]["value"], 1)
      SetPedComponentVariation(ped, 4, skin["leg"]["variant"], skin["leg"]["value"], 1)
      SetPedComponentVariation(ped, 5, skin["parabag"]["variant"], skin["parabag"]["value"], 1)
      SetPedComponentVariation(ped, 6, skin["shoes"]["variant"], skin["shoes"]["value"], 1)
      SetPedComponentVariation(ped, 7, skin["accessory"]["variant"], skin["accessory"]["value"], 1)
      SetPedComponentVariation(ped, 8, skin["undershirt"]["variant"], skin["undershirt"]["value"], 1)
      SetPedComponentVariation(ped, 9, skin["kevlar"]["variant"], skin["kevlar"]["value"], 1)
      SetPedComponentVariation(ped, 10, skin["badge"]["variant"], skin["badge"]["value"], 1)
      SetPedComponentVariation(ped, 11, skin["torso2"]["variant"], skin["torso2"]["value"], 1)
      -- for componentId,component in pairs(skin["components"]) do
      --   if componentId and component[1] and component[2] then
      --     SetPedComponentVariation(ped, componentId, component[1], component[2], 1)
      --   end
      -- end
    else
      SetPedDefaultComponentVariation(ped)
    end

    SetModelAsNoLongerNeeded(modelHash)

    if showPed then
      SetEntityVisible(ped, true, false)
    end

    return true
  end

  return false
end

return Model
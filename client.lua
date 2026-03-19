Citizen.CreateThread(function()
    while true do
        -- Get player's name from client
        local playerName = GetPlayerName(PlayerId())

        -- Get player's server ID (used for identification in RP servers)
        local playerId = GetPlayerServerId(PlayerId())

        -- Get the player's ped (character)
        local playerPed = PlayerPedId()

        -- Get the player's current coordinates
        local coords = GetEntityCoords(playerPed)

        -- Get the street and crossing (intersection) hashes based on player position
        local streetHash, crossingHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)

        -- Convert hashes into readable street names
        local streetName = GetStreetNameFromHashKey(streetHash)
        local crossingName = GetStreetNameFromHashKey(crossingHash)

        -- Discord Application ID (from your Discord Developer Portal)
        local appId = 1234567890123456789

        -- Image keys from your Discord Rich Presence assets
        local smallPic = 'small'
        local bigPic = 'big'

        -- Set the Discord App ID so Rich Presence works
        SetDiscordAppId(appId)

        -- If the player is at an intersection, include both street names
        if crossingName ~= "" then
            SetRichPresence(("%s [ID: %d] | Posted on %s near %s"):format(
                playerName,
                playerId,
                streetName,
                crossingName
            ))
        else
            -- Otherwise only show the main street name
            SetRichPresence(("%s [ID: %d] | Posted on %s"):format(
                playerName,
                playerId,
                streetName
            ))
        end

        -- Set large image (big asset) and its hover text
        SetDiscordRichPresenceAsset(bigPic)
        SetDiscordRichPresenceAssetText('Big Text')

        -- Set small image (small asset) and its hover text
        SetDiscordRichPresenceAssetSmall(smallPic)
        SetDiscordRichPresenceAssetSmallText('Small Text')

        -- Wait 10 seconds before updating again (prevents spam & reduces CPU usage)
        Wait(10000)
    end
end)
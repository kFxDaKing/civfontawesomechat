function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
			
		}
	else
		return nil
	end
end

-- Local OOC (DEFAULT CHAT)
 AddEventHandler('chatMessage', function(source, name, message)
      if string.sub(message, 1, string.len("/")) ~= "/" then
		  local playerName = GetPlayerName(source)
          local name = getIdentity(source)
		TriggerClientEvent("sendProximityMessage", -1, source, playerName, message)
      end
      CancelEvent()
  end)
-- Global OOC
RegisterCommand('ooc', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw;  margin: 0.5vw; background-color: rgba(31, 31, 31, 0.8); border-radius: 3px;"><i class="fas fa-globe"style="font-size:16px;color:white"> <font color="#FFFFFF">[{0}] {1}: {2}</font></div>',
        args = { source, playerName, msg }
    })
end, false)

-- Global Help
 RegisterCommand('help', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(6)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(56, 133, 238, 0.6); border-radius: 3px;"><i class="fas fa-question-circle"style="font-size:16px;color:white"> <font color="#FFFFFF">[{0}] {1}: {2}</font></div>',
        args = { source, playerName, msg }
    })
end, false)

-- Local Me Proximity
  RegisterCommand('me', function(source, args, user)
	  local name = getIdentity(source)
      TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, name.lastname, table.concat(args, " "))
  end)

-- Local Do Proximity
  RegisterCommand('do', function(source, args, user)
	  local name = getIdentity(source)
      TriggerClientEvent("sendProximityMessageDo", -1, source, name.firstname, name.lastname, table.concat(args, " "))
  end)

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

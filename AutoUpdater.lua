--(written by ThatRobHuman)
ScriptVersion = 4
ScriptClass = 'MyUtility'

function checkForUpdate()
    WebRequest.get('yourgithubfile.json', function(res)
        if (not(res.is_error)) then
            local response = JSON.decode(res.text)
		if (response[ScriptClass] > ScriptVersion) then
			print('New Version ('..response[ScriptClass]..') of '..ScriptClass..' is available!')
			--install update?
			installUpdate()
		end
        else
            error(res)
        end
    end)
end

function installUpdate()
	print('[33ff33]Installing Upgrade to '..ScriptClass..'[-]')
	WebRequest.get('yourgithubfile.lua', function(res)
        if (not(res.is_error)) then
		self.setLuaScript(res.text)
		self.reload()
		print('[33ff33]Installation Successful[-]')
        else
            error(res)
        end
    end)
end

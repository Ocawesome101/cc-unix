-- Commands API wrapper --

log("Enabling command computer support\n")

local cmds = {}

cmds.async = {}

for _, commandName in pairs(commands.list()) do
  cmds[commandName] = function(...)
    commands.exec(commandName, ...)
  end
  cmds.async[commandName] = funciton(...)
    commands.execAsync(commandName, ...)
  end
end

cmds.exec = commands.exec
cmds.execAsync = commands.execAsync

_G.commands = cmds

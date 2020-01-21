ccefi.write("CC-UNIX Boot: Stage 1", true)
ccefi.write("Loading config from /boot/ccldr/ccldr.cfg", true)

local config = {}

if fs.exists("/boot") then
  if fs.exists("/boot/ccldr") then
    if fs.exists("/boot/ccldr/ccldr.cfg") then
      local h = fs.open("/boot/ccldr/ccldr.cfg", "r")
      local data = h.readAll()
      h.close()
      config = loadstring("=return " .. data, "@ccldr.cfg")
    else
      ccefi.write("File not found: /boot/ccldr/ccldr.cfg")
      config.kernel, config.kernelFlags = "/boot/kernel.img", {"init='/sbin/init'"}
    end
  else
    ccefi.write("No such directory: /boot/ccldr")
    config.kernel, config.kernelFlags = "/boot/kernel.img", {"init='/sbin/init'"}
  end
else
  ccefi.write("/boot does not exist, cannot continue")
  while true do
    ccefi.pullEvent()
  end
end

if not config then
  config = {
    kernel = "/boot/kernel.img",
    kernelFlags = {"init='/sbin/init'"}
  }
end

if fs.exists(config.kernel) then
  local ok, err = loadfile(config.kernel)
  if not ok then
    ccefi.write(err, true)
    while true do
      ccefi.pullEvent()
    end
  end

  pcall(function()
      ok(config.kernelFlags)
    end
  )
end

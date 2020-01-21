-- CCEmuX driver --

log("Enabling CCEmuX support\n")

peripheral.attach, peripheral.detach = ccemux.attach, ccemux.detach

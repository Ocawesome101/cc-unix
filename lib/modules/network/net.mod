-- HTTP API wrapper --

local hostname = "localhost"

_G.net = {}

function net.hostname()
  return hostname
end

function net.setHostname(newHostname)
  if type(newHostname) == "string" and #newHostname >= 1 then
    hostname = newHostname
  end
end

function net.get(url, headers)
  local h = http.get(url, headers)
  local data = h.readAll()
  h.close()
  return data
end

function net.post(url, postData, headers)
  return http.post(url, postData, headers)
end

function net.request(url, postData, headers) -- You still need to listen for "http_<success|failure>" on completion
  return http.request(url, postData, headers)
end

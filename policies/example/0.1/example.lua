local setmetatable = setmetatable

local _M = require('apicast.policy').new('Example', '0.1')
local mt = { __index = _M }


local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

function dec(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
            return string.char(c)
    end))
end

function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

function _M.new()
  print("---------------INSIDE _M.new()--------------")
  print("---------------END _M.new()--------------")
  return setmetatable({}, mt)
end

function _M:init()
  print("--------------- Inside _M:init()---------------")
  print("--------------- END _M:init()---------------")
  -- do work when nginx master process starts
end

function _M:init_worker()
  print("---------------Inside _M:init_worker()---------------")
  print("---------------END _M:init_worker()---------------")
  -- do work when nginx worker process is forked from master
end

function _M:rewrite(context)
  print("---------------Inside _M:rewrite()---------------")
  local headers = ngx.req.get_headers() or {}
  print(headers['Authorization'])
  auth_header_val = headers['Authorization']
  basic_headers = split(auth_header_val, ' ')[2]
  decoded_header = dec(basic_headers)
  userkey = split(decoded_headers,":")[1]

  print(userkey)
  print("---------------END _M:rewrite()---------------")
  -- change the request before it reaches upstream
end

function _M:log()
  -- can do extra logging
  print("logging mt")


end

function _M:balancer()
  -- use for example require('resty.balancer.round_robin').call to do load balancing
  print("Hello World from _M:balancer()")
end

return _M

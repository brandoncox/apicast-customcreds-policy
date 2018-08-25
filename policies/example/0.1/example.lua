local setmetatable = setmetatable

local _M = require('apicast.policy').new('Example', '0.1')
local mt = { __index = _M }

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
  print(headers)
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

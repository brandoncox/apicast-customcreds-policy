local setmetatable = setmetatable

local _M = require('apicast.policy').new('Example', '0.1')
local mt = { __index = _M }

function _M.new()
  print("Hello World")
  return setmetatable({}, mt)
end

function _M:init()
  print("Inside _M:init()")
  -- do work when nginx master process starts
end

function _M:init_worker()
  print("Inside _M:init_worker()")
  -- do work when nginx worker process is forked from master
end

function _M:rewrite()
  print("Inside _M:rewrite()")
  -- change the request before it reaches upstream
end

function _M:access()
  print("Inside _M:access()")
  -- ability to deny the request before it is sent upstream
end

function _M:content()
  print("Inside _M:content()")
  -- can create content instead of connecting to upstream
end

function _M:post_action()
  print("Inside _M:post_action()")
  -- do something after the response was sent to the client
end

function _M:header_filter()
  print("Inside _M:header_filter()")
  -- can change response headers
end

function _M:body_filter()
  -- can read and change response body
  -- https://github.com/openresty/lua-nginx-module/blob/master/README.markdown#body_filter_by_lua
  print("Inside _M:body_filter()")
end

function _M:log()
  -- can do extra logging
  print("Hello World _M:log()")
end

function _M:balancer()
  -- use for example require('resty.balancer.round_robin').call to do load balancing
  print("Hello World from _M:balancer()")
end

return _M

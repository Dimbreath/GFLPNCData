-- params : ...
-- function num : 0 , upvalues : _ENV
require("libtdrlua")
local m = {}
for k,v in pairs(libtdrlua) do
  m[k] = v
end
local load_metalib, load_metalib_buf, free_metalib, get_meta, table2buf, buf2table, str2table, metamaxbufsize, bufalloc, buffree, buf2str = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
load_metalib = m.load_metalib
load_metalib_buf = m.load_metalib_buf
free_metalib = m.free_metalib
get_meta = m.get_meta
table2buf = m.table2buf
buf2table = m.buf2table
str2table = m.str2table
buf2str = m.buf2str
metamaxbufsize = m.metamaxbufsize
bufalloc = m.bufalloc
buffree = m.buffree
local create_msg_pk = function(meta, buf, buf_size)
  -- function num : 0_0 , upvalues : table2buf, buf2str, _ENV
  return {buff = buf, pack = function(obj)
    -- function num : 0_0_0 , upvalues : table2buf, meta, buf, buf_size, buf2str
    local ret_code, used_size = table2buf(meta, obj, buf, buf_size, 0)
    if ret_code ~= 0 then
      return ret_code, used_size
    end
    return buf2str(buf, used_size)
  end
, unpack = function(str)
    -- function num : 0_0_1 , upvalues : _ENV, meta
    return (libtdrlua.str2table)(meta, str, 0)
  end
}
end

local create_lib = function(metalib)
  -- function num : 0_1 , upvalues : _ENV, create_msg_pk
  return setmetatable({}, {__index = function(obj, k)
    -- function num : 0_1_0 , upvalues : _ENV, metalib, create_msg_pk
    local ret_code, meta = (libtdrlua.get_meta)(metalib, k)
    if ret_code ~= 0 then
      error("libtdrlua.get_meta() failed: errno=" .. ret_code .. ",msg=" .. meta)
    end
    local ret_code, buf_size = (libtdrlua.metamaxbufsize)(metalib, k)
    if ret_code ~= 0 then
      error("libtdrlua.metamaxbufsize() failed: errno=" .. ret_code .. ",msg=" .. buf_size)
    end
    local ret_code, buf = (libtdrlua.bufalloc)(buf_size)
    if ret_code ~= 0 then
      error("libtdrlua.bufalloc() failed: errno=" .. ret_code .. ",msg=" .. buf)
    end
    local pk = create_msg_pk(meta, buf, buf_size)
    rawset(obj, k, pk)
    return pk
  end
})
end

m.from_file = function(file)
  -- function num : 0_2 , upvalues : _ENV, create_lib
  local ret_code, metalib = (libtdrlua.load_metalib)(file)
  if ret_code ~= 0 then
    error("libtdrlua.load_metalib() failed: " .. metalib)
  end
  return create_lib(metalib)
end

m.from_memory = function(str)
  -- function num : 0_3 , upvalues : _ENV, create_lib
  local ret_code, metalib = (libtdrlua.load_metalib_buf)(str)
  if ret_code ~= 0 then
    error("libtdrlua.load_metalib_buf() failed: errno=" .. ret_code .. ",msg=" .. metalib)
  end
  return create_lib(metalib)
end

return m


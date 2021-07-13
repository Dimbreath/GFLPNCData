-- params : ...
-- function num : 0 , upvalues : _ENV
import = function(moduleName, currentModuleName)
  -- function num : 0_0 , upvalues : _ENV
  local currentModuleNameParts = nil
  local moduleFullName = moduleName
  local offset = 1
  while 1 do
    if (string.byte)(moduleName, offset) ~= 46 then
      moduleFullName = (string.sub)(moduleName, offset)
      if currentModuleNameParts and #currentModuleNameParts > 0 then
        moduleFullName = (table.concat)(currentModuleNameParts, ".") .. "." .. moduleFullName
      end
      break
    end
    offset = offset + 1
    if not currentModuleNameParts then
      do
        if not currentModuleName then
          local n, v = (debug.getlocal)(3, 1)
          currentModuleName = v
        end
        currentModuleNameParts = (string.split)(currentModuleName, ".")
        ;
        (table.remove)(currentModuleNameParts, #currentModuleNameParts)
        -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out DO_STMT

        -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  return require(moduleFullName)
end

reimport = function(name)
  -- function num : 0_1 , upvalues : _ENV
  local package = package
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (package.loaded)[name] = nil
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (package.preload)[name] = nil
  return require(name)
end



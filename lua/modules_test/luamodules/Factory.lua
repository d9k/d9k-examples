local core = _G

module('Factory')

function setBaseClass(class, baseClass)
    core.assert(baseClass.metatable)
    core.setmetatable(class, baseClass.metatable);
end

function create(class, ...)
    local result = { }
    setBaseClass(result, class)
    core.print(...)
    result:construct(...)
    
    return result
end
local core = _G

module('Factory')

function setBaseClass(class, baseClass)
    core.assert(baseClass.classMetatable)
    core.setmetatable(class, baseClass.classMetatable);
end

function create(class, ...)
    local result = { }
    setBaseClass(result, class)
    core.print(...)
    result:construct(...)
    
    return result
end
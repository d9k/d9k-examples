local core = _G

module('Child')
classMetatable = { __index = _M }

local Factory = core.require('Factory')
local Base = core.require('Base')

Factory.setBaseClass(_M, Base)

function new(param1, param2)
    return Factory.create(_M, param1, param2)
end

function construct(self, param1, param2)
    Base.construct(self) -- вызов конструктора базового класса
    core.print('Child created!', param1, param2)
end

function getField(self) -- override метода
    return 'zzz'
end
local core = _G

module('Base')
metatable = { __index = _M }

-- require AFTER module() !
local Factory = core.require('Factory')

function new(a, b, c)
    return Factory.create(_M)
end

function construct(self)
    core.print('Base created!')
    self.field = 'text'
end

function setField(self, field)
    self.field = field
end

function getField(self)
    return self.field
end
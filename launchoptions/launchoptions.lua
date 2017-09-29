local M = {}

M.path = sys.get_save_file(sys.get_config("project.title"), "launchoptions.json")
M.options = {}
M.runtime_options = {}

M.serialize = function(self)

    local output = '[\n'
    for _,v in ipairs(self.options) do
        output = output .. '    {\n'
        output = output .. '        "group": "' .. v.group .. '",\n'
        -- output = output .. '        "label": "' .. v.label .. '",\n'
        output = output .. '        "options": [\n'
        for _,w in ipairs(v.options) do
            output = output .. '            {\n'
            output = output .. '                "type": "' .. w.type .. '",\n'
            output = output .. '                "id": "' .. w.id .. '",\n'
            -- output = output .. '                "label": "' .. w.label .. '",\n'
            if w.type == 'checkbox' then
                output = output .. '                "value": ' .. tostring(w.value) .. ',\n'
            elseif w.type == 'resolutions' or w.type == 'dropdown' then
                output = output .. '                "value": "' .. tostring(w.values[w.value]) .. '",\n'
                -- output = output .. '                "value": ' .. tostring(w.value) .. ',\n'
                -- output = output .. '                "values": [\n'
                -- for _,value in ipairs(w.values) do
                --     output = output .. '                    "' .. value .. '",\n'
                -- end
                -- output = output .. '                ]\n'
            end
            output = output .. '            },\n'
        end
        output = output .. '        ]\n'
        output = output .. '    },\n'
    end
    output = output .. ']\n'

    -- print(output)
    return output
end

M.save = function(self)
    local content = self:serialize()
    print(content)
    print("writing to: " .. self.path)
    local f,err = io.open(self.path, "wb")
    print(f:write(content))
    f:close()
end

M.load = function(self)
    local f,err = io.open(self.path, "rb")
    print(f, err)
    local content = f:read("*all")
    f:close()
    self.runtime_options = json.decode(content)
    pprint(self.runtime_options)
end

M.get = function(self, group, id, default)
    -- find group
    for _,v in ipairs(self.runtime_options) do
        if v.group == group then
            for _,w in ipairs(v.options) do
                if w.id == id then
                    return w.value
                end
            end
        end
    end

    return default
end

return M

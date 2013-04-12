min_updates=1

ConkyBase = {
	cs = nil,
	cr = nil,
	colors = nil,
	new = function(self)
		if conky_window == nil then return end
		--draw canvas
		cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
		cr = cairo_create(cs)
		--end draw canvas
		--just incase we might try to read to much
		local updates=tonumber(conky_parse('${updates}'))
		if updates<min_updates then return end
		call(self)
	end, --new = function(self)
	call = nil,
	__index = call,
	create = function(self)
                        local newinst = {}
                        setmetatable(newinst)
                        return newinst
        end, --create
	class = function(self)
		return new_class
	end, --class
	superClass = function(self)
		return parentClass
	end, --superClass
	isa = function(self, theClass)
		local b_isa = false
		local cur_class = new_class
		while ( nil ~= cur_class ) and ( false == b_isa ) do
			if cur_class == theClass then
				b_isa = true
			else
				cur_class = cur_class:superClass()
			end --if
		end --while
		return b_isa
	end, --isa
	inheritFrom = function( self, parentClass )
		if nil ~= parentClass then
	        	setmetatable( self, { __index = parentClass } )
		end --if
	end, --function inheritFrom( parentClass )
}

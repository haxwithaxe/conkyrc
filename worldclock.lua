require 'base'

wordlclock = {
	call = function(self)
		worldclock:all()
	end, --call
	all = function(self)
		--itterate over list
	end, --all
	clocks = {},
}
Clock = {
	tz = 'UTC',
	place = 'Universal Coordinated Time',
	font_size = 9,
	display_id = tz,
	condition = function(self) return true end, 
	new = function(self, tz, place, font_size, display_id)
		self.tz = tz or self.tz
	        self.utc_offset = utc_offset or self.utc_offset()
        	self.place = place or self.place
	        self.font_size = font_size or self.font_size
        	self.display_id = display_id or self.display_id
	end, --new
	label = function(self)
		return display_id
	end, --label
	time = function(self, format)
		format = format or '%H:%M'
		local offset_c_time = posix.mktime(posix.gmtime())+utc_offset_sec()
		return posix.strftime(format, offset_c_time)
	end, --time
	utc_offset = function(self)
	        local f = io.popen('LANG=C TZ='..tz..' date +"%z"')
        	local l = f:read("*a")
	        f:close()
        	return trim(l)
	end, --utc_offset
	utc_offset_int = function(self)
		local offset = get_offset(tz)
		local r_offset = offset.reverse()
		local sign = roffset:sub(5) or '+'
		local hour = tonumber(roffset:sub(3,4).reverse())
		local min  = tonumber(roffset:sub(1,2).reverse())
		return tonumber(sign..((hour*60)+min)*60)
	end, --utc_offset_int
}

function trim(s)
	return s:find'^%s*$' and '' or s:match'^%s*(.*%S)'
end

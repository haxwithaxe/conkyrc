--[[bargraph by mrpeachy (2010)]]
require 'cairo'

function background(cr, width, height, length, thick, hori, vert, bgr, bgg, bgb, bga, gridlines, glthick, glr, glg, glb, gla)

	if width < 0 then
		hori1=hori+(thick/2)-(length*width)
		hori2=(width*length)-((thick)+width)
	elseif width > 0 then
		hori1=hori-(thick/2)
		hori2=(width*length)+(thick-width)
	end

	if bars == 3 then
		verti=vert-height
		bghigh=height*2
	elseif bars == 2 then
		verti=vert
		bghigh=height
	elseif bars == 1 then
		verti=vert
		bghigh=-1*height
	end

	--background
	cairo_set_source_rgba (cr, bgr, bgg, bgb, bga)
	cairo_rectangle (cr, hori1, verti, hori2, bghigh)
	cairo_fill (cr)

	--gridlines
	if gridlines == 1 and bars == 3 then
		cairo_set_line_width (cr, glthick)
		cairo_set_source_rgba (cr, glr, glg, glb, gla)
		cairo_move_to (cr, hori1, vert-height)
		cairo_rel_line_to (cr, hori2, 0)
		cairo_stroke (cr)
		cairo_move_to (cr, hori1, vert-(height*0.75))
		cairo_rel_line_to (cr, hori2, 0)
		cairo_stroke (cr)
		cairo_move_to (cr, hori1, vert-(height*0.5))
		cairo_rel_line_to (cr, hori2, 0)
		cairo_stroke (cr)
		cairo_move_to (cr, hori1, vert-(height*0.25))
		cairo_rel_line_to (cr, hori2, 0)
		cairo_stroke (cr)
		cairo_move_to (cr, hori1, vert)
		cairo_rel_line_to (cr, hori2, 0)
		cairo_stroke (cr)
		cairo_move_to (cr, hori1, vert+height)
		cairo_rel_line_to (cr, hori2, 0)
		cairo_stroke (cr)
		cairo_move_to (cr, hori1, vert+(height*0.75))
		cairo_rel_line_to (cr, hori2, 0)
		cairo_stroke (cr)
		cairo_move_to (cr, hori1, vert+(height*0.5))
		cairo_rel_line_to (cr, hori2, 0)
		cairo_stroke (cr)
		cairo_move_to (cr, hori1, vert+(height*0.25))
		cairo_rel_line_to (cr, hori2, 0)
		cairo_stroke (cr)
	elseif gridlines == 1 and bars == 1 then
		cairo_set_line_width (cr, glthick)
		cairo_set_source_rgba (cr, glr, glg, glb, gla)
		cairo_move_to (cr, hori1, vert-height)
		cairo_rel_line_to (cr, hori2, 0)
		cairo_stroke (cr)
		cairo_move_to (cr, hori1, vert-(height*0.75))
		cairo_rel_line_to (cr, hori2, 0)
		cairo_stroke (cr)
		cairo_move_to (cr, hori1, vert-(height*0.5))
		cairo_rel_line_to (cr, hori2, 0)
		cairo_stroke (cr)
		cairo_move_to (cr, hori1, vert-(height*0.25))
		cairo_rel_line_to (cr, hori2, 0)
		cairo_stroke (cr)
		cairo_move_to (cr, hori1, vert)
		cairo_rel_line_to (cr, hori2, 0)
	elseif gridlines == 1 and bars == 2 then
		cairo_set_line_width (cr, glthick)
		cairo_set_source_rgba (cr, glr, glg, glb, gla)
		cairo_move_to (cr, hori1, vert)
		cairo_rel_line_to (cr, hori2, 0)
		cairo_stroke (cr)
		cairo_move_to (cr, hori1, vert+height)
		cairo_rel_line_to (cr, hori2, 0)
		cairo_stroke (cr)
		cairo_move_to (cr, hori1, vert+(height*0.75))
		cairo_rel_line_to (cr, hori2, 0)
		cairo_stroke (cr)
		cairo_move_to (cr, hori1, vert+(height*0.5))
		cairo_rel_line_to (cr, hori2, 0)
		cairo_stroke (cr)
		cairo_move_to (cr, hori1, vert+(height*0.25))
		cairo_rel_line_to (cr, hori2, 0)
		cairo_stroke (cr)
	end --if gridlines == 1 and bars == 3 then
end --function background

function linedraw(cr, num, inum, length, hori, vert, width, height, thick, dotr, dotg, dotb, dota, bars)
	modnum=(num*(height/100))
	if width < 0 then
		hori1=hori-(length*width)
	else
		hori1=hori
	end
	if bars == 3 then
		verti=vert+modnum
		barh=-1*(2*modnum)
	elseif bars == 1 then
		verti=vert
		barh=-1*modnum
	elseif bars == 2 then
		verti=vert+modnum
		barh=-1*modnum
	end
	cairo_set_source_rgba (cr, dotr, dotg, dotb, dota)
	cairo_set_line_width (cr, thick) 
	cairo_move_to (cr, hori1+(width*(inum-1)), verti)
	cairo_rel_line_to (cr, 0, barh)
	cairo_stroke (cr)
end

function conky_draw_graph()
    if conky_window == nil then return end
    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    cr = cairo_create(cs)
    local updates=tonumber(conky_parse('${updates}'))
    if updates==1 then     
        len_t=100
        t1={}   
    end
    if updates> 3 then
		--[[bar graph setup
		to change the direction of the graph
		a positive width will produce a right to left graph
		a negative width will produce a left to right graph]]--
		width=2
		hori=10
		vert=200
		height=100
		--thick=line thickness should be greater than width (width=spacing of lines)
		thick=1
		linered=0
		linegreen=1
		lineblue=1
		linealpha=1
		--bars setting below, 1=bars up, 2=bars down, 3=bars up and down
		bars=2
		--background setup
		bgr=0
		bgg=0
		bgb=1
		--below enter 0 for no background
		bga=0.5
		--bewlo enter 1 for gridlines, 0 for none
		gridlines=1
		glthick=1  
		glr=1
		glg=1
		glb=1
		gla=0.8
		--call background function
		background(cr, width, height, len_t, thick, hori, vert, bgr, bgg, bgb, bga, gridlines, glthick, glr, glg, glb, gla)

		--CALCULATIONS
		for i = 1, tonumber(len_t) do
			if t1[i+1]==nil then t1[i+1]=0 end
			t1[i]=t1[i+1]    
			if i==len_t then
				t1[len_t]=tonumber(conky_parse('${cpu}'))
            end
			--END OF CALCULATIONS

			--call line drawing function
			linedraw(cr, t1[i], i, len_t, hori, vert, width, height, thick, linered, linegreen, lineblue, linealpha, bars)
		end    
		cairo_destroy(cr)
		cairo_surface_destroy(cs)
	end
end

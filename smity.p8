pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- smity's adventure
-- 

ground = 106


function _init()
  t = 0
  
  p1 = {}
  p1.x = 0
  p1.y = ground
  p1.flipx = true
  p1.speedx = 0
  p1.speedy = 0
  p1.speedtx = 0
  p1.speedty = 0
end

function _update()
  t += 1
  p1_input()
  
  --if run off screen warp to other side
  if (p1.x>128) then p1.x=-8 end
  if (p1.x<-8) then p1.x=128 end  
end

function _draw()
  cls()
		dmap()
		dplayer()
		

  print("yy: " .. p1.speedy, 40, 10, 6)
  print("cx: " .. cellx, 40, 20, 1)
  print("cy: " .. celly, 40, 30, 1)
  print("sprt: " .. n_ground, 40, 40, 8)
end

-->8
function dmap()
  rectfill(0,0,128,128,13)
  map(0,0,0,0,32,32)
  --dcells()
end

function dplayer()
  pal(7,0)
  spr(48,p1.x,p1.y,1,1,p1.flipx)  
  pal()
  --debug_player()
end

function dcells()
  for i=0,15,1 do
   for j=0,15,1 do
    line(j*8-1,i*8-1,j*8-1,i*8-1,2)
   end
  end
end

function debug_player()
  line(
    p1.x+2,
    p1.y+7,
    p1.x+5,
    p1.y+7,
    12
  )
  line(
   p1.x,
   p1.y,
   p1.x,
   p1.y,
   14
  )
end
-->8
function p1_input()
	 p1.speedtx = 0
	 
  if btn(⬅️) then
  	p1.speedtx = -2
  	p1.flipx = false
  end
  if btn(➡️) then
  	p1.speedtx = 2
  	p1.flipx = true
 	end
 	if btn(⬆️) then 
 		if grounded() and p1.jump_released then
	 	 p1.speedy = 8
	 	 p1.jump_released = false
	 	end
	 else
	   p1.jump_released = true
 	end
 	
 	-- accel or decel on x
 	if p1.speedx > p1.speedtx then
 		p1.speedx -= 1
 	elseif p1.speedx < p1.speedtx then
 		p1.speedx += 1
 	end	
 	
 	
 	p1.x += p1.speedx
 	
  gravity()
	end
-->8
function gravity()
  p1.speedty = -9
  n_ground = nearest_ground()
  
 	if p1.speedy > p1.speedty then
 	 p1.speedy -= 1
 	end
 	
 	if grounded() and p1.speedy < 0 then
 	 p1.speedy = 0
 	end

		p1.y = min(n_ground, p1.y - p1.speedy)
end


function grounded()
  return p1.y >= n_ground
end

function cell()
		cellx = flr(p1.x / 8 +.5)
		celly = flr(p1.y / 8 +.5)		
		
		return cellx, celly
end

function nearest_ground()
 n_ground = ground
 cx,cy = cell()
 
 if p1.speedy <= 0 then
	 for i=cy,15,1 do
	 	 cell_under_p1 = mget(cx,i)
	   is_floor = fget(cell_under_p1,0)
	   
	   if is_floor then
	     n_ground = i * 8
	     return n_ground
	   end
	 end
 end

	return ground
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000033344333333333333333333333333333493333333333333300000000
0000000000000000000000000000000000000000000000000000000000000000000000003345543333333333333d33333a333a33496633333333333300000000
00700700000000000000000000000000000000000000000000000000000000000000000033f554333333333333333333a9a3a9a3493333333333333300000000
000770000000000000000000000000000000000000000000000000000000000000000000334f443333333333333333333abb3a33496633333333333300000000
000770000000000000000000000000000000000000000000000000000000000000000000344444433333333333333d33333bb333493333333636363600000000
00700700000000000000000000000000000000000000000000000000000000000000000034f444f33333333333d33333335b5333496633333636363600000000
00000000000000000000000000000000000000000000000000000000000000000000000031414143333333333333333333555333493333339999999900000000
00000000000000000000000000000000000000000000000000000000000000000000000033151533333333333333333333333333496633334444444400000000
00444400000000000044440000000000000000000000000000000000000000000000000000000000333333333333333333333333333366944444444400000000
00f5f5000000000004fffff000000000000000000000000000000000000000000000000000000000333333333a333e333e333c33333333949999999900000000
00ffff000000000004f5f5f00000000000000000000000000000000000000000000000000000000037333333a9a3eae3e9e3cac3333366946363636300000000
0f9999f00000000004fffff000000000000070000000000000000000000000000000000000000000797333733abb3e333e3bbc33333333946363636300000000
0099990000000000049999000000000000070700000000000000000000000000000000000000000036333797333bb33333bb3333333366943333333300000000
00cccc00000000000f9999f000000000000070000000000000000000000000000000000000000000b3b33363335b5333335b5333333333943333333300000000
00c00c000000000000c00c00000000000000000000000000000000000000000000000000000000033b333b3b3355533333555333333366943333333300000000
005505500000000000c00c0000000000000000000000000000000000000000000000000000000003333333b33333333333333333333333943333333300000000
00000000000000000000000000000000000000000000000000000000000000000000000000000003333337333333333300000000333333333333333300000000
4f0000f4000880000009800000000000007070000070700000000000000000000000000000000003373379733333333300000000333333333333333300000000
44f4f44400e9e800009a980000000000007770000077700000000000000000000000000000000003797336333336633300000000333333333333333300000000
04444440089a988009aaa980000000000770700007777000000000000000000000000000000000033633b3b33366663300000000333333333333333300000000
4454544408e9e880089a988000000000077770000777700000000000000000000000000000000003b3b33b3336666d5300000000333336363633333300000000
540000540088880000898800000000000077770000777700000000000000000000000000000000033b333333355dd53300000000333333363636333300000000
00000000000880000008800000000000007777700077777000000000000000000000000000000000333333333333333300000000333366999933333300000000
00000000000000000000000000000000007077700070777000000000000000000000000000000000333333333333333300000000333333944966333300000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000333366944933333300000000
00707000007070000070700000707000007070000070700000707000007070000000000000000000000000000000000000000000333333999966333300000000
00777000007770000077700000777000007770000077700000777000007770000000000000000000000000000000000000000000333363636333333300000000
07707000077070000777700007707000077070000770700007777000077070000000000000000000000000000000000000000000333333636363333300000000
07777000077770000777700007777007997770009977700099777000997770070000000000000000000000000000000000000000333333333333333300000000
00777777007777700077777700777770887777778877777088777777887777700000000000000000000000000000000000000000333333333333333300000000
00777770007777770077777000777770007777700077777700777770007777700000000000000000000000000000000000000000333333333333333300000000
00707070007070700070707000707070007070700070707000707070007070700000000000000000000000000000000000000000333333333333333300000000
0000bb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000bbbb00000bb0000b0b0000000b0b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00bbbbbb0b0bbbbbbbbbbbbbbbbbbbbb000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0b3b33b3bbb3b33bbb3b33bb3b3b33bb000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b33313333b333333b333333133333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33111313333111311311131333133313000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
31111111131111113111131131133111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111111111111111111111113111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111111115111111611100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11131011131111111111661100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111111111111116111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111131111111311661111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
15115111111511111161111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111111111111111111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d1d1d1d1d1d1d1d1d1d1d1d100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1d1d1d1d1d1d1d1d1d1d1d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
98989898000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
89898989000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636333333
33333336363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363333
33336699999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999333333
33333394444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444449663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
333333943333333333333333333333333333333333333333333d333333333333333333333333333333333333333333333a333a33333333333333333349663333
333366943333333333333333333333333333333333333333333333333333333333333333333333333333333333333333a9a3a9a3333333333333333349333333
3333339433333333333333333333333333333333333333333333333333333333333333333333333333333333333333333abb3a33333333333333333349663333
33336694333333333333333333333333333333333333333333333d333333333333333333333333333333333333333333333bb333333333333333333349333333
33333394333333333333333333333333333333333333333333d333333333333333333333333333333333333333333333335b5333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333555333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
3333339433333333333d333333333333333333333333333333333333333333333333333333333333333333333a333a3333333333333333333333333349663333
3333669433333333333333333333333333333333333333333333333333333333333333333333333333333333a9a3a9a333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333abb3a3333333333333333333333333349663333
333366943333333333333d333333333333333333333333333333333333333333333333333333333333333333333bb33333333333333333333333333349333333
333333943333333333d333333333333333333333333333333333333333333333333333333333333333333333335b533333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333355533333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333334444333333333333333333333333333333333333333333333333333333333333333349663333
3333669433333333333333333333333333333333333333333333f6f6333333333333333333333333333333333333333333333333333333333333333349333333
3333339433333333333333333333333333333333333333333333ffff333333333333333333333333333333333333333333333333333333333333333349663333
333366943333333333333333333333333333333333333333333f9999f33333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333339999333333333333333333333333333333333333333333333333333333333333333349663333
3333669433333333333333333333333333333333333333333333cccc333333333333333333333333333333333333333333333333333333333333333349333333
3333339433333333333333333333333333333333333333333333c33c333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333335535533333333333333333333333333333333333888333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333338889833333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333338888833333333333333333333333349333333
3333339433333333333333333333333333333333333d33333333333333333333330303333333333333333333333d888333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333300033333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333003033333333333333333333333333333333333333333333333333349663333
333366943333333333333333333333333333333333333d33333333333333333330000333333333333333333333333d3333333333333333333333333349333333
333333943333333333333333333333333333333333d33333333333333333333333000000333333333333333333d3333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333300000333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333303030333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
3333339433333333333333333333333333333333333333333333333333333333333333333333333333333333333d333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
333366943333333333333333333333333333333333333333333333333333333333333333333333333333333333333d3333333333333333333333333349333333
333333943333333333333333333333333333333333333333333333333333333333333333333333333333333333d3333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333d33333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
3333669433333333333333333333333333333d333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
3333339433333333333333333333333333d333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
3333339433333333333333333a333a33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
333366943333333333333333a9a3a9a3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
3333339433333333333333333abb3a33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
333366943333333333333333333bb333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
333333943333333333333333335b5333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333555333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349333333
33333394333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333349663333
33336694444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444449333333
33333399999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999663333
33336363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363333333
33333363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363633333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333

__gff__
0000000101000000000000000001010000000000000000000000000000010100000000000000000000000000000101000000000000000000000001010101010000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001010000000000000000010100000000000000000000000000000101000003000000000000000000000001010000000000000000000000010000010100
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000060600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000006060600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000006060600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4140434141434141414041414143414140430000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5050505150525050515050515050515050510000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000300000f55011550115500e550035500f4001250015400207002070020700000001990019900199001a9001a9001c9002090022900249000000000000000000000000000000000000000000000000000000000
0003060002150031500415006150081500b1500c60034100031001610000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0002000026550285502955029550255502455026550295502b5502a55029550305003350036500365003750038500385003750010500365000050000500005000050000500005000050000500005000050000500

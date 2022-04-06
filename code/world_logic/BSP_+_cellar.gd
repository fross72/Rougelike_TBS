extends Node

var canvas = []
var start = Vector2()
var rng = RandomNumberGenerator.new()
var width = 0
var hieght = 0

func _init(s,w,h,chance, mult):
	width = float(w)
	hieght = float(h)
	rng.seed = hash(OS.get_datetime()["second"] + OS.get_datetime()["minute"] + OS.get_datetime()["hour"])
	randomize()
	start = s
	for x in range(width+2):
		var tmp = []
		for y in range(hieght+2):
			if x==0 or y==0 or x==width+1 or y==hieght+1:
				tmp.append(1)
			elif pow((x-width/2),2)/pow(width/(2*mult),2) + pow((y-hieght/2),2)/pow(hieght/(2*mult),2) <=1:
				tmp.append(0)
			elif pow((x-width/2),2)/pow(width/2,2) + pow((y-hieght/2),2)/pow(hieght/2,2) <=1:
				tmp.append(int(rng.randi()%100 <= chance*100))
			else:
				tmp.append(1)
		canvas.append(tmp)

func _get_neighwalls(point, radius, ignore_center = true):
	var count = 0
	for x in range(point[0]-radius, point[0]+radius+1):
		for y in range(point[1]-radius, point[1]+radius+1):
			count+=canvas[x][y]
	if ignore_center:
		return count
	return count - canvas[point[0]][point[1]]

func fill(Q):
	if len(Q)==0:
		return
	while len(Q)>0:
		for N in Q:
			if canvas[N[0]][N[1]] == 0:
				canvas[N[0]][N[1]] = 2
				var w = [N[0]+1,N[1]]
				var e = [N[0]-1,N[1]]
				while canvas[w[0]][w[1]] == 0:
					canvas[w[0]][w[1]] = 2
					w[0]+=1
					draw()
				while canvas[e[0]][e[1]] == 0:
					canvas[e[0]][e[1]] = 2
					e[0]-=1
					draw()
				for i in range(e[0], w[0]+1):
					if canvas[i][e[1]]!=1:
						if canvas[i][e[1]-1] == 0:
							Q.append([i,e[1]-1])
						if canvas[i][e[1]+1] == 0:
							Q.append([i,e[1]+1])
			else:
				Q.erase(N)

func cellar_auto(iter_num1, iter_num2):
	for i in range(iter_num1):
		var canvas2 = canvas.duplicate()
		for x in range(1, width-1):
			for y in range(1, hieght-1):
				if _get_neighwalls([x,y], 1) >=5:
					canvas2[x][y] = 1
				else:
					canvas2[x][y] = 0
		canvas = canvas2.duplicate()
	for i in range(iter_num2):
		var canvas2 = canvas.duplicate()
		for x in range(1, width-1):
			for y in range(1, hieght-1):
				if _get_neighwalls([x,y], 2) >=17:
					canvas2[x][y] = 1
				elif _get_neighwalls([x,y], 2) <=12 or _get_neighwalls([x,y], 1) <=4:
					canvas2[x][y] = 0
		canvas = canvas2.duplicate()
	

func draw():
	for x in len(canvas):
		for y in len(canvas[x]):
			if canvas[x][y] == 2:
				find_parent("TileMap").set_cell(start.x+x, start.y+y,0)
			else:
				find_parent("TileMap").set_cell(start.x+x, start.y+y,1)
				
				





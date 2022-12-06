#0 type - тип карты: 0 - основное действие; 1 - побочное действие; 2 - реакция.
#1 atack - атака карты, если заюзать как атаку на месте
#2 spped - скорость персонажа, если заюзать карту как спринт
#3 defence - защита, если заюзать карту в обход описания защиты или если такого нет
#4 image - изображение
#5 name - название
#6 discription-1 - описание основного эффекта
#7 discription-2 - описание эффекта защиты
#8 metods_main - функции которые триггерит основное описание
#9 metods_def - функции которые триггерит описание защиты
#10 metod_1_vars
#11 metod_2_vars
#12 сard_family - тип карты, в общем смысле (сейчас не используется)
enum {
	template,
	boots_dr1,
	br_156,
	adaptiv_sheald,
}
const DATA = {
	template:
		[1, [0,0], 0, 0, "template", "Благославение Императора",
		"Солдат, зачем тебе оружие,\nесли император благославил\nтебя?",
		"",
		[],[],[],[]
		],
	boots_dr1:
		[1, [2,1], 8, 1, "boots-dr1", "Реактивные ботинки DR-1", 
		"Передвиньтесь на 5 клеток\nНанесите 2 урона в радиусе 1",
		"После получения урона\nпередвиньтесь на 3 клетки  ",
		["move", "attack"], ["move"], [[5],[2,1]], [3],
		],
	br_156:
		[0, [5,5], 4, 2, "br-156", "Плазмаган BR-156", 
		"Передвиньтесь на 2 клетки\nНанесите 3 урона в радиусе 5",
		"После получения урона\nнанесите 2 урона в ответ  ",
		["move", "attack"], ["attack"], [[2],[3,5]], [[2,-1]],
		],
	adaptiv_sheald:
		[2,[3,1], 3, 4, "adaptiv_sheald", "Адаптивный щит",
		"",
		"При получение урона к\n уменьшению урона\n прибавляется 3 ед.",
		["change_stats"],[],[["sheald",3]],[],
		],
	
}
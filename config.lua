Config = {}
Config.Locale = 'en'
Config.Setup = false -- turn to true for the first time running the script to install items on your database
Config.Visible = false -- turn to true if you'd like to show this on the esx_status

Config.Items = {
    ['bread'] = {
        label = 'Bread',
        prop = 'prop_cs_burger_01',
        action = 'onEat',
        type = 'hunger',
        amount = 200000,
    },
    
    ['bbread'] = {
        label = 'Bread',
        prop = 'prop_cs_burger_01',
        action = 'onEat',
        type = 'hunger',
        amount = 280000,
    },
    
    ['burger'] = {
        label = 'Burger',
        prop = 'prop_cs_burger_01',
        action = 'onEat',
        type = 'hunger',
        amount = 500000,
    },
    
    ['hotdog'] = {
        label = 'Hotdog',
        prop = 'prop_cs_hotdog_01',
        action = 'onEat',
        type = 'hunger',
        amount = 300000,
    },
    
    ['taco'] = {
        label = 'Taco',
        prop = 'prop_taco_01',
        action = 'onEat',
        type = 'hunger',
        amount = 300000,
    },
    
    ['sandwich'] = {
        label = 'Sandwich',
        prop = 'prop_sandwich_01',
        action = 'onEat',
        type = 'hunger',
        amount = 250000,
    },
    
    ['donut'] = {
        label = 'Chocolate Donut',
        prop = 'prop_donut_01',
        action = 'onEat',
        type = 'hunger',
        amount = 200000,
    },
    
    ['donut2'] = {
        label = 'Plain Donut',
        prop = 'prop_donut_02',
        action = 'onEat',
        type = 'hunger',
        amount = 200000,
    },
    
    ['bpie'] = {
        label = 'Pie',
        prop = 'prop_food_bs_chips',
        action = 'onEat',
        type = 'hunger',
        amount = math.random(400000,600000),
    },
    
    ['apple'] = {
        label = 'Apple',
        prop = 'prop_cs_burger_01',
        action = 'onEat',
        type = 'hunger',
        amount = 250000,
    },
    
    ['banana'] = {
        label = 'Banana',
        prop = 'prop_cs_hotdog_01',
        action = 'onEat',
        type = 'hunger',
        amount = 250000,
    },

    --Drinks
    
    ['water'] = {
        label = 'Water',
        prop = 'prop_ld_flow_bottle',
        action = 'onDrink',
        type = 'thirst',
        amount = 200000,
    },
    
    ['cola'] = {
        label = 'Coca-Cola',
        prop = 'prop_ecola_can',
        action = 'onDrink',
        type = 'thirst',
        amount = 150000,
    },
    
    ['fccola'] = {
        label = 'Coca-Cola',
        prop = 'prop_ecola_can',
        action = 'onDrink',
        type = 'thirst',
        amount = 600000,
    },

    ['mixapero'] = {
        label = 'Cruel Cola',
        prop = 'prop_ecola_can',
        action = 'onDrink',
        type = 'thirst',
        amount = math.random(150000,350000),
    },
    
    ['icoffee'] = {
        label = 'Coffee',
        prop = 'p_amb_coffeecup_01',
        action = 'onDrink2',
        type = 'thirst',
        amount = math.random(500000,700000),
    },

    ['coffee'] = {
        label = 'Coffee',
        prop = 'p_amb_coffeecup_01',
        action = 'onDrink2',
        type = 'thirst',
        amount = 100000,
    },
    
    ['bcmilk'] = {
        label = 'Milk',
        prop = 'p_amb_coffeecup_01',
        action = 'onDrink2',
        type = 'thirst',
        amount = math.random(550000,750000),
    },
    
    ['icetea'] = {
        label = 'Iced Tea',
        prop = 'prop_ld_can_01',
        action = 'onDrink',
        type = 'thirst',
        amount = 500000,
    },

    ['juice'] = {
        label = 'Juice',
        prop = 'prop_wheat_grass_glass',
        action = 'onDrink',
        type = 'thirst',
        amount = 500000,
    },

    ['beer'] = {
		label = 'Beer',
		prop = 'prop_beer_bottle',
		action = 'onDrink',
	},

	['wine'] = {
		label = 'Wine',
		prop = 'p_wine_glass_s',
		action = 'onDrink2',
	},

	['vodka'] = {
		label = 'Vodka',
		prop = 'prop_vodka_bottle',
		action = 'onDrink',
	},

	['tequila'] = {
		label = 'Tequila',
		prop = 'prop_tequila_bottle',
		action = 'onDrink',
	},

	['whisky'] = {
		label = 'Whisky',
		prop = 'p_cs_shot_glass_2_s',
		action = 'onDrink',
	},
}
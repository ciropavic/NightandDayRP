Config = Config or {}

local StringCharset = {}
local NumberCharset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(StringCharset, string.char(i)) end
for i = 97, 122 do table.insert(StringCharset, string.char(i)) end

Config.RandomStr = function(length)
	if length > 0 then
		return Config.RandomStr(length-1) .. StringCharset[math.random(1, #StringCharset)]
	else
		return ''
	end
end

Config.RandomInt = function(length)
	if length > 0 then
		return Config.RandomInt(length-1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

Config.Dealers = {
    [1] = {
        ['Name'] = 'Oma Gerda',
        ['Type'] = 'medic-dealer',
        ['Coords'] = {['X'] = 2029.69, ['Y'] = 4980.70, ['Z'] = 42.09},
        ['Products'] = {
            [1] = {
                name = "painkillers",
                price = 450,
                amount = 50,
                resetamount = 50,
                info = {},
                type = "item",
                slot = 1,
            },
            [2] = {
                name = "health-pack",
                price = 4500,
                amount = 5,
                resetamount = 5,
                info = {},
                type = "item",
                slot = 2,
            },
        },
    },
    [2] = {
        ['Name'] = 'Rachid',
        ['Type'] = 'weapon-dealer',
        ['Coords'] = {['X'] = 22.02, ['Y'] = -1106.83, ['Z'] = 29.79},
        ['Products'] = {
            [1] = {
                name = "weapon_switchblade",
                price = 750,
                amount = 10,
                resetamount = 10,
                info = {
                    quality = 100.0,
                },
                type = "weapon",
                slot = 1,
            },
            [2] = {
                name = "weapon_hatchet",
                price = 1000,
                amount = 10,
                resetamount = 10,
                info = {
                    quality = 100.0,
                },
                type = "weapon",
                slot = 2,
            },
            [3] = {
                name = "weapon_snspistol_mk2",
                price = 7500,
                amount = 10,
                resetamount = 10,
                info = {
                    quality = 100.0,
                },
                type = "weapon",
                slot = 3,
            },
            [4] = {
                name = "pistol-ammo",
                price = 150,
                amount = 100,
                resetamount = 100,
                info = {},
                type = "item",
                slot = 4,
            },
        },
    },
    [3] = {
        ['Name'] = 'Achmed',
        ['Type'] = 'weapon-dealer',
        ['Coords'] = {['X'] = 452.72, ['Y'] = -1305.67, ['Z'] = 30.12},
        ['Products'] = {
            [1] = {
                name = "weapon_wrench",
                price = 3500,
                amount = 10,
                resetamount = 10,
                info = {
                    quality = 100.0,
                },
                type = "weapon",
                slot = 1,
            },
            [2] = {
                name = "weapon_hammer",
                price = 3500,
                amount = 10,
                resetamount = 10,
                info = {
                    quality = 100.0,
                },
                type = "weapon",
                slot = 2,
            },
        },
    },
    [4] = {
        ['Name'] = 'Weapon Shop',
        ['Type'] = 'weapon-dealer',
        ['Coords'] = {['X'] = 22.46059, ['Y'] = -1107.257, ['Z'] = 29.79701},
        ['Products'] = {
            [1] = {
                name = "weapon_vintagepistol",
                price = 1000,
                amount = 500,
                resetamount = 500,
                info = {
                    serie = "",
                    quality = 100.0,
                },
                type = "weapon",
                slot = 1,
            },
            [2] = {
                name = "weapon_appistol",
                price = 5000,
                amount = 500,
                resetamount = 500,
                info = {
                    serie = "",
                    quality = 100.0,
                },
                type = "weapon",
                slot = 2,
            },
            [3] = {
                name = "weapon_snspistol_mk2",
                price = 2000,
                amount = 500,
                resetamount = 500,
                info = {
                    serie = "",
                    quality = 100.0,
                },
                type = "weapon",
                slot = 3,
            },
            [4] = {
                name = "weapon_sawnoffshotgun",
                price = 8000,
                amount = 500,
                resetamount = 500,
                info = {
                    serie = "",
                    quality = 100.0,
                },
                type = "weapon",
                slot = 4,
            },
            [5] = {
                name = "pistol-ammo",
                price = 250,
                amount = 5000,
                resetamount = 5000,
                info = {},
                type = "item",
                slot = 5,
            },
            [6] = {
                name = "shotgun-ammo",
                price = 550,
                amount = 5000,
                resetamount = 5000,
                info = {},
                type = "item",
                slot = 6,
            },
        },
    },
}

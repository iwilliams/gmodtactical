RP_MySQLConfig = {}

RP_MySQLConfig.EnableMySQL      = true
RP_MySQLConfig.Host             = "127.0.0.1"
RP_MySQLConfig.Username         = "root"
RP_MySQLConfig.Password         = ""
RP_MySQLConfig.Database_name    = "gmodtactical"
RP_MySQLConfig.Database_port    = 3306
RP_MySQLConfig.Preferred_module = "mysqloo"
RP_MySQLConfig.MultiStatements  = false


GMT.PrimaryWeapons = {
    'm9k_pkm',
    --'m9k_m3',
    --'m9k_sl8',
    'm9k_fal',
    --'m9k_ithacam37',
    --'m9k_m14sp',
    --'m9k_m61_frag',
    'm9k_mp5',
    'm9k_ak74',
    'm9k_psg1',
    'm9k_tar21',
    'm9k_dragunov',
    --'m9k_m60',
    --'m9k_orbital_strike',
    --'m9k_m79gl',
    --'m9k_m1918bar',
    --'m9k_fg42',
    --'m9k_jackhammer',
    'm9k_vector',
    --'m9k_browningauto5',
    --'m9k_ied_detonator',
    'm9k_famas',
    --'m9k_minigun',
    --'m9k_1897winchester',
    --'m9k_val',
    'm9k_kac_pdw',
    'm9k_spas12',
    'm9k_uzi',
    'm9k_bizonp19',
    'm9k_striker12',
    --'m9k_fists',
    'm9k_mp9',
    'm9k_g36',
    --'m9k_milkormgl',
    --'m9k_ex41',
    --'m9k_damascus',
    --'m9k_vikhr',
    --'m9k_smgp90',
    --'m9k_m202',
    'm9k_m4a1',
    --'m9k_auga3',
    --'m9k_nitro',
    'm9k_honeybadger',
    'm9k_rpg7',
    'm9k_mp40',
    --'m9k_suicide_bomb',
    'm9k_tec9',
    --'m9k_m98b',
    --'m9k_usas',
    --'m9k_an94',
    --'m9k_l85',
    --'m9k_m249lmg',
    'm9k_acr',
    --'m9k_davy_crockett',
    'm9k_scar',
    --'m9k_amd65',
    'm9k_thompson',
    'm9k_dbarrel',
    --'m9k_sten',
    --'m9k_harpoon',
    --'m9k_svt40',
    'm9k_ak47',
    'm9k_m416',
    --'m9k_winchester73',
    'm9k_m16a4_acog',
    --'m9k_contender',
    --'m9k_usc',
    'm9k_intervention',
    --'m9k_svu',
    --'m9k_ares_shrike',
    --'m9k_magpulpdr',
    --'m9k_1887winchester',
    'm9k_aw50',
    'm9k_m24',
    'm9k_barret_m82',
    --'m9k_proxy_mine',
    --'m9k_mossberg590',
    --'m9k_g3a3',
    --'m9k_nerve_gas',
    'm9k_mp5sd',
    'm9k_mp7',
    'm9k_f2000',
    --'m9k_remington870',
    --'m9k_ump45',
    --'m9k_machete',
    --'m9k_matador',
    --'m9k_sticky_grenade',
    --'m9k_remington7615p'
}

GMT.SecondaryWeapons = {
    'm9k_hk45',
    'm9k_colt1911',
    'm9k_coltpython',
    'm9k_deagle',
    'm9k_glock',
    'm9k_usp',
    'm9k_m29satan',
    'm9k_m92beretta',
    'm9k_luger',
    'm9k_ragingbull',
    'm9k_scoped_taurus',
    'm9k_remington1858',
    'm9k_model3russian',
    'm9k_model500',
    'm9k_model627',
    'm9k_sig_p229r'
}

GMT.OtherWeapons = {
    'm9k_knife'
}

GMT.Items = {
    'item_healthvial',
    'item_healthkit',
    'item_battery',
    'm9k_ammo_ar2',
    'm9k_ammo_pistol',
    'm9k_ammo_buckshot',
    --'m9k_ammo_frags',
    'm9k_ammo_357',
    --'m9k_ammo_proxmines',
    'm9k_ammo_smg',
    'm9k_ammo_sniper_rounds',
    --'m9k_ammo_c4',
    'sent_ball'
}

GMT.WeaponDespawn = 60*10

GMT.PossibleSkins = {
    "models/player/combine_specialforce_1.mdl",
    "models/player/tac_op1.mdl",
    "models/player/tac_op2.mdl",
    "models/player/tac_op3.mdl",
    "models/player/tac_op4.mdl",
    "models/player/tac_op5.mdl",
    "models/player/tac_op6.mdl",
    "models/player/tac_op7.mdl",
    "models/player/tac_op8.mdl",
    "models/player/tac_op9.mdl"
}


-- Add all the NPCs b/c I'm lazy
for i=1, 6 do
    for j=1, 14 do
        local num = j
        if num < 10 then
            num = "0" .. j
        end
        table.insert(GMT.PossibleSkins, "models/player/pmc_" .. i .. "/pmc__" .. num .. ".mdl")
    end
end

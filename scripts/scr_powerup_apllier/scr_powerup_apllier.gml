/*function apply_powerup(_p) {
    var player = instance_find(obj_player, 0);
    if (!instance_exists(player)) return;

    switch (global.current_class) {
        case "Fire":
            switch (_p) {
			  //escolha do jogador    o que é afetado pela escolha		como é afetado
                case "1_fire":        player.potion_regen_rate			+= 0.5; break;
                case "2_fire":        player.heal_potions				+= 1; break;
                case "3_fire":        player.potion_regen_rate			+= 0.8;  break;
                case "4_fire":		  player.heal_potions				+= 2; break;
                case "5_fire":        player.hp							= player.hp_max; break;
                case "6_fire":        player.vampire_effect				= true; break;
				case "7_fire":   if(player.hp_max <= player.total_hp_limit-5) {
									  player.hp_max						+= 5;
									  player.hp							+= 5; break;
								 }else if(player.hp_max < player.total_hp_limit){
									  player.hp_max						= 30;
									  //ensures that theres no overflow of hearts (limits it self to the total_hp_limit)
									  if (player.hp_max - player.hp >= 5){
										player.hp						+= 5; break;
									  }else{
										player.hp						= player.hp_max; break;
									  }
								 }else{
									  //ensures that theres no overflow of hearts (limits it self to the total_hp_limit)
									  if (player.hp_max - player.hp >= 5){
									  player.hp							+= 5; break;
									  }else{
									  player.hp							= player.hp_max; break;
									  }
								 }
                case "8_fire":        player.berserk_effect				= true; break;
                case "9_fire":   if(player.hp_max <= player.total_hp_limit-10) {
									  player.hp_max						+= 10;
									  player.hp							+= 10; break;
								 }else if(player.hp_max < player.total_hp_limit){
									  player.hp_max						= 30;
									  //ensures that theres no overflow of hearts (limits it self to the total_hp_limit)
									  if (player.hp_max - player.hp >= 10){
									  player.hp							+= 10; break;
									  }else{
									  player.hp							= player.hp_max; break;
									  }
								 }else{
									  //ensures that theres no overflow of hearts (limits it self to the total_hp_limit)
									  if (player.hp_max - player.hp >= 10){
									  player.hp							+= 10; break;
									  }else{
									  player.hp							= player.hp_max; break;
									  }
								 }
                case "10_fire":		  player.heal_aura					= true; break;
                case "11_fire":       player.heal_aura_damage			+= 2; break;
                case "12_fire":       player.potion_regen_rate			+= 2; break;
				case "13_fire":		  player.heal_potions				+= 5; break;
            }
            break;

        case "Water":
            switch (_p) {
                case "1_water":      if(player.shield == player.shield_max){
									  player.heal_potions				+= 1; break;	
									 }else{
										if (player.shield_max-1 >= player.shield){
									  player.shield						+= 1; break;
									  }else{
									  player.shield						= player.shield_max; break;
									  }
									 }
                case "2_water":        if(player.shield_health == player.shield_health_max){
									  player.hp							= player.hp_max; break;
									  }else{
										  if(player.shield_health > player.shield_health_max-1){
									  player.shield_health				+= 1; break;
										  }else{
									  player.shield_health				= player.shield_health_max; break;	
										  }
									  }
                case "3_water":       if(player.shield == player.shield_max){
									  player.heal_potions				+= 3; break;	
									 }else{
										if (player.shield_max-3 >= player.shield){
									  player.shield						+= 3; break;
									  }else{
									  player.shield						= player.shield_max; break;
									  }
									 }
                case "4_water":		   if(player.shield_health == player.shield_health_max){
									  player.hp							= player.hp_max; break;
									  }else{
										  if(player.shield_health > player.shield_health_max-2){
									  player.shield_health				+= 2; break;
										  }else{
									  player.shield_health				= player.shield_health_max; break;	
										  }
									  }
                case "5_water":        if(player.shield_health == player.shield_health_max){
									  player.hp							= player.hp_max; break;
									  }else{
										  if(player.shield_health > player.shield_health_max-5){
									  player.shield_health				+= 5; break;
										  }else{
									  player.shield_health				= player.shield_health_max; break;	
										  }
									  }
                case "6_water":       player.explosive_shields			= true; break;
				case "7_water":		  if(player.shield == player.shield_max){
									  player.heal_potions				+= 5; break;	
									 }else{
										if (player.shield_max-1 >= player.shield){
									  player.shield						+= 5; break;
									  }else{
									  player.shield						= player.shield_max; break;
									  }
									 }
                case "8_water":       player.shield						= player.shield_max; break;
                case "9_water":       player.reflective_shield			= true;  break;
                case "10_water":	  player.knockback_shield			= true; break;
                case "11_water":      player.invincible					= true; break;
                case "12_water":      if(player.shield_health == player.shield_health_max){
									  player.hp							= player.hp_max; break;
									  }else{
										  if(player.shield_health > player.shield_health_max-10){
									  player.shield_health				+= 10; break;
										  }else{
									  player.shield_health				= player.shield_health_max; break;	
										  }
									  }
				case "13_water":      if(player.shield == player.shield_max){
									  player.heal_potions				+= 10; break;	
									 }else{
										if (player.shield_max-1 >= player.shield){
									  player.shield						+= 10; break;
									  }else{
									  player.shield						= player.shield_max; break;
									  }
									 }
            }
            break;

        case "Air":
            switch (_p) {
                case "1_air":		  if(player.damage_limit == player.short_damage){
										if (player.hp < player.hp_max){
											player.hp += 1; break;
										}
									  }else if(player.short_damage < player.damage_limit-0.7){
										player.short_damage  += 0.7; break;
									  }else{
										player.short_damage = player.damage_limit; break;
									  }
                case "2_air":         player.combo_damage     = true; break;
                case "3_air":         if(player.damage_limit == player.long_damage){
										if (player.shield < player.shield_max){
											player.shield += 1; break;
										}
									  }else if(player.long_damage < player.damage_limit-0.7){
										player.long_damage  += 0.7; break;
									  }else{
										player.long_damage = player.damage_limit; break;
									  }
                case "4_air":		  player.slow_effect = true; break;
                case "5_air":         player.flash_damage    = true; break;
                case "6_air":         player.burn_effect    = true; break;
				case "7_air":         if(player.damage_limit == player.short_damage){
										if (player.hp < player.hp_max){
											player.hp += 3; break;
										}
									  }else if(player.short_damage < player.damage_limit-1.5){
										player.short_damage  += 1.5; break;
									  }else{
										player.short_damage = player.damage_limit; break;
									  }
                case "8_air":         player.burn_damage    += 0.25; break;
                case "9_air":         if(player.damage_limit == player.long_damage){
										if (player.shield < player.shield_max){
											player.shield += 3; break;
										}
									  }else if(player.long_damage < player.damage_limit-1.5){
										player.long_damage  += 1.5; break;
									  }else{
										player.long_damage = player.damage_limit; break;
									  }
                case "10_air":		  player.tesla_burst = true; break;
                case "11_air":        player.cooldown    -= 1; break;
                case "12_air":        player.insta_kill     = true; break;
				case "13_air":        player.tesla_damage     += 1.5; break;
            }
            break;
    }
}

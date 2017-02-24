CREATE DATABASE games;

CREATE TABLE `players` (
	`id` INT UNSIGNED NOT NULL,
	`player_and_games` JSON NOT NULL,
	`names_virtual` VARCHAR(20) GENERATED ALWAYS AS (`player_and_games` ->> '$.name') NOT NULL, 
	PRIMARY KEY (`id`)
);

INSERT INTO `players` (`id`, `player_and_games`) VALUES (1, '{
    "id": 1,  
    "name": "Sally",  
    "games_played":{    
       "Battlefield": {
          "weapon": "sniper rifle",
          "rank": "Sergeant V",
          "level": 20
        },                                                                                                                          
       "Crazy Tennis": {
          "won": 4,
          "lost": 1
        },  
       "Puzzler": {
          "time": 7
        }
      }
   }'
);

INSERT INTO `players` (`id`, `player_and_games`) VALUES (2, '{
    "id": 2,  
    "name": "Thom",  
    "games_played":{    
       "Battlefield": {
          "weapon": "carbine",
          "rank": "Major General VIII",
          "level": 127
        },                                                                                                                          
       "Crazy Tennis": {
          "won": 10,
          "lost": 30
        },    
       "Puzzler": {
          "time": 25
        }
      }
   }'
);

INSERT INTO `players` (`id`, `player_and_games`) VALUES (3, '{
    "id": 3,  
    "name": "Ali",  
    "games_played":{    
       "Battlefield": {
          "weapon": "machine gun",
          "rank": "First Sergeant II",
          "level": 37
        },                                                                                                                          
       "Crazy Tennis": {
          "won": 30,
          "lost": 21
        },  
      "Puzzler": {
        "time": 12
      }
    }
  }'
);

INSERT INTO `players` (`id`, `player_and_games`) VALUES (4, '{
    "id": 4,  
    "name": "Alfred",  
    "games_played":{    
      "Battlefield": {
          "weapon": "pistol",
          "rank": "Chief Warrant Officer Five III",
          "level": 73
        },                                                                                                                          
       "Crazy Tennis": {
          "won": 47,
          "lost": 2
        },  
       "Puzzler": {
          "time": 10
        }
      }
   }'
);

INSERT INTO `players` (`id`, `player_and_games`) VALUES (5, '{
    "id": 5,  
    "name": "Phil",  
    "games_played":{    
       "Battlefield": {
          "weapon": "assault rifle",
          "rank": "Lt. Colonel III",
          "level": 98
        },                                                                                                                          
       "Crazy Tennis": {
          "won": 130,
          "lost": 75
        },  
       "Puzzler": {
          "time": 7
        }
      }
   }'
);

INSERT INTO `players` (`id`, `player_and_games`) VALUES (6, '{
    "id": 6,  
    "name": "Henry",  
    "games_played":{    
       "Battlefield": {
          "weapon": "assault rifle",
          "rank": "Captain II",
          "level": 87
        },                                                                                                                          
       "Crazy Tennis": {
          "won": 68,
          "lost": 149
        },
        "Puzzler": {
          "time": 17
        }
      }
   }'
);

ALTER TABLE `players` ADD COLUMN `times_virtual` INT GENERATED ALWAYS AS (`player_and_games` ->> '$.games_played.Puzzler.time') NOT NULL AFTER `names_virtual`;
ALTER TABLE `players` ADD COLUMN `tennis_won_virtual` INT GENERATED ALWAYS AS (`player_and_games` ->> '$.games_played."Crazy Tennis".won') NOT NULL AFTER `times_virtual`;
ALTER TABLE `players` ADD COLUMN `tennis_lost_virtual` INT GENERATED ALWAYS AS (`player_and_games` ->> '$.games_played."Crazy Tennis".lost') NOT NULL AFTER `tennis_won_virtual`;
ALTER TABLE `players` ADD COLUMN `battlefield_level_virtual` INT GENERATED ALWAYS AS (`player_and_games` ->> '$.games_played.Battlefield.level') NOT NULL AFTER `tennis_lost_virtual`;

CREATE INDEX `times_idx` ON `players`(`times_virtual`);
CREATE INDEX `won_idx` ON `players`(`tennis_won_virtual`);
CREATE INDEX `lost_idx` ON `players`(`tennis_lost_virtual`);
CREATE INDEX `level_idx` ON `players`(`battlefield_level_virtual`);


CREATE TABLE `players_two` (
    `id` INT GENERATED ALWAYS AS (`player_and_games` ->> '$.id') STORED NOT NULL,
    `player_and_games` JSON NOT NULL,
    `names_virtual` VARCHAR(20) GENERATED ALWAYS AS (`player_and_games` ->> '$.name') NOT NULL,
    `times_virtual` INT GENERATED ALWAYS AS (`player_and_games` ->> '$.games_played.Puzzler.time') NOT NULL,
    `tennis_won_virtual` INT GENERATED ALWAYS AS (`player_and_games` ->> '$.games_played."Crazy Tennis".won') NOT NULL,
    `tennis_lost_virtual` INT GENERATED ALWAYS AS (`player_and_games` ->> '$.games_played."Crazy Tennis".lost') NOT NULL,
    `battlefield_level_virtual` INT GENERATED ALWAYS AS (`player_and_games` ->> '$.games_played.Battlefield.level') NOT NULL, 
    PRIMARY KEY (`id`),
    INDEX `times_index` (`times_virtual`),
    INDEX `names_index` (`names_virtual`),
    INDEX `won_index` (`tennis_won_virtual`),
    INDEX `lost_index` (`tennis_lost_virtual`),
    INDEX `level_index` (`battlefield_level_virtual`)
);

INSERT INTO `players_two` (`player_and_games`) VALUES ('{
    "id": 1,  
    "name": "Sally",  
    "games_played":{    
       "Battlefield": {
          "weapon": "sniper rifle",
          "rank": "Sergeant V",
          "level": 20
        },                                                                                                                          
       "Crazy Tennis": {
          "won": 4,
          "lost": 1
        },  
       "Puzzler": {
          "time": 7
        }
      }
   }'
);

INSERT INTO `players_two` (`player_and_games`) VALUES ('{
    "id": 2,  
    "name": "Thom",  
    "games_played":{    
       "Battlefield": {
          "weapon": "carbine",
          "rank": "Major General VIII",
          "level": 127
        },                                                                                                                          
       "Crazy Tennis": {
          "won": 10,
          "lost": 30
        },    
       "Puzzler": {
          "time": 25
        }
      }
   }'
);

INSERT INTO `players_two` (`player_and_games`) VALUES ('{
    "id": 3,  
    "name": "Ali",  
    "games_played":{    
       "Battlefield": {
          "weapon": "machine gun",
          "rank": "First Sergeant II",
          "level": 37
        },                                                                                                                          
       "Crazy Tennis": {
          "won": 30,
          "lost": 21
        },  
      "Puzzler": {
        "time": 12
      }
    }
  }'
);

INSERT INTO `players_two` (`player_and_games`) VALUES ('{
    "id": 4,  
    "name": "Alfred",  
    "games_played":{    
      "Battlefield": {
          "weapon": "pistol",
          "rank": "Chief Warrant Officer Five III",
          "level": 73
        },                                                                                                                          
       "Crazy Tennis": {
          "won": 47,
          "lost": 2
        },  
       "Puzzler": {
          "time": 10
        }
      }
   }'
);

INSERT INTO `players_two` (`player_and_games`) VALUES ('{
    "id": 5,  
    "name": "Phil",  
    "games_played":{    
       "Battlefield": {
          "weapon": "assault rifle",
          "rank": "Lt. Colonel III",
          "level": 98
        },                                                                                                                          
       "Crazy Tennis": {
          "won": 130,
          "lost": 75
        },  
       "Puzzler": {
          "time": 7
        }
      }
   }'
);

INSERT INTO `players_two` (`player_and_games`) VALUES ('{
    "id": 6,  
    "name": "Henry",  
    "games_played":{    
       "Battlefield": {
          "weapon": "assault rifle",
          "rank": "Captain II",
          "level": 87
        },                                                                                                                          
       "Crazy Tennis": {
          "won": 68,
          "lost": 149
        },
        "Puzzler": {
          "time": 17
        }
      }
   }'
);

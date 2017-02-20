CREATE DATABASE games;

CREATE TABLE `players` (
    `id` INT NOT NULL,
    `player_and_games` JSON,
    PRIMARY KEY (`id`)
);

INSERT INTO `players` (`id`, `player_and_games`) VALUES (1, '{  
    "name": "Sally",  
    "games_played":{    
       "Battlefield": "yes",                                                                                                                          
       "Crazy Tennis": "yes",  
       "Puzzler": {
          "time": 7
        }
      }
   }'
);

INSERT INTO `players` (`id`, `player_and_games`) VALUES (2, '{  
    "name": "Thom",  
    "games_played":{    
       "Battlefield": "yes",                                                                                                                          
       "Crazy Tennis": "no",  
       "Puzzler": {
          "time": 25
        }
      }
   }'
);

INSERT INTO `players` (`id`, `player_and_games`) VALUES (3, '{  
    "name": "Ali",  
    "games_played":{    
       "Battlefield": "no",                                                                                                                          
       "Crazy Tennis": "yes"
      }
   }'
);

INSERT INTO `players` (`id`, `player_and_games`) VALUES (4, '{  
    "name": "Alfred",  
    "games_played":{    
       "Battlefield": "no",                                                                                                                          
       "Crazy Tennis": "yes",  
       "Puzzler": {
          "time": 10
        }
      }
   }'
);

INSERT INTO `players` (`id`, `player_and_games`) VALUES (5, '{  
    "name": "Phil",  
    "games_played":{    
       "Battlefield": "yes",                                                                                                                          
       "Crazy Tennis": "yes",  
       "Puzzler": {                                                                                                                                                                                                                                                                                                                                                                                               
          "time": 7
        }
      }
   }'
);


INSERT INTO `players` (`id`, `player_and_games`) VALUES (6, '{  
    "name": "Henry",  
    "games_played":{    
       "Battlefield": "yes",                                                                                                                          
       "Crazy Tennis": "yes"
      }
   }'
);

ALTER TABLE `players` ADD COLUMN `times_virtual` INT GENERATED ALWAYS AS (`player_and_games` ->> '$.games_played.Puzzler.time') AFTER `player_and_games`;

CREATE INDEX `times_index` ON `players` (`times_virtual`);

ALTER TABLE `players` ADD COLUMN `name_virtual` VARCHAR(10) GENERATED ALWAYS AS (`player_and_games` ->> '$.name') AFTER `times_virtual`;

CREATE INDEX `name_index` ON `players` (`name_virtual`);

CREATE TABLE `players_two` (
    `player_and_games` JSON,
    `id` INT GENERATED ALWAYS AS (`player_and_games` ->> '$.id') STORED,
    `times_virtual` INT GENERATED ALWAYS AS (`player_and_games` ->> '$.games_played.Puzzler.time'),
    `names_virtual` VARCHAR(11)  GENERATED ALWAYS AS (`player_and_games` ->> '$.name'),
    PRIMARY KEY (`id`),
    INDEX `times_index` (`times_virtual`),
    INDEX `names_index` (`names_virtual`)
);

INSERT INTO `players_two` (`player_and_games`) VALUES ('{
    "id": 1,  
    "name": "Sally",  
    "games_played":{    
       "Battlefield": "yes",                                                                                                                          
       "Crazy Tennis": "yes",  
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
       "Battlefield": "yes",                                                                                                                          
       "Crazy Tennis": "no",  
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
       "Battlefield": "no",                                                                                                                          
       "Crazy Tennis": "yes"
      }
   }'
);

INSERT INTO `players_two` (`player_and_games`) VALUES ('{
    "id": 4,  
    "name": "Alfred",  
    "games_played":{    
       "Battlefield": "no",                                                                                                                          
       "Crazy Tennis": "yes",  
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
       "Battlefield": "yes",                                                                                                                          
       "Crazy Tennis": "yes",  
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
       "Battlefield": "yes",                                                                                                                          
       "Crazy Tennis": "yes"
      }
   }'
);
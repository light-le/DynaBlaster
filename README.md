Dyna50 - A final project submission for GD50 Introduction to Game Development

This game is similar to DynaBlaster, or Bomberman by Hudson Soft back in the 1900s.

It features a 2D board with outer walls and pillars and bricks. All movements are grid-locked. Currently there are monsters moving in random directions, if they collides with player, player loses a life point and return to original positions. If the player loses all his life points, game over.

The player could plant bombs (press Space) to destroy the monsters. Bombs usually take 3 seconds to explode and could destroy the player as well if fire blast hits. If the player kills all the monsters, the player wins and progress to the next level with more monsters.

There are pickups which can power up player too but have not yet been implemented in this version.

This project idea is inspired by Legend of 50 class. It has 3 game states plus multiple player/entities/bomb states. Player and monsters have to move in grid. Monsters are programed to move randomly but never hit wall, bricks or pillars. Bombs are timed before explosion and the explosion spawns fires in 4 directions that kill player/monsters, unless obstructed by wall/bricks/pillars. Therefore, it has a complexity as the games implemented in this class.

A few features to be implemented in the upcoming versions:
- Powerup items that enhance bomb stock and fire range (should start with 1)
- Other advanced powerups (life point, shield, auto-bomb, brick-overpass, bomb-kick, faster speed)
- Player should go invisible after each death
- Door that appears at the end of level (similar to the original games)
- Advanced monsters that follow players and overpass bricks.
- Level generation algorithm that not only increase in number of monsters, but in difficulty.
- Scoring system that keep counts of monsters killed.

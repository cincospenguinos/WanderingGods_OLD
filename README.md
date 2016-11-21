# Wandering Gods

The repository for my text based adventure MMO. I hope I can pull
it off the ground this time.

## ISSUES

* [This line](https://github.com/cincospenguinos/WanderingGods/blob/master/app/play_app.rb#L23)
pulls up the tutorial dungeon and gives it to the new guest player
    * Is this the best way to refer to this dungeon?
    * More importantly, should there be two separate tables? One for dungeons in play, and
    one for dungeons that are stored away and separate? If there aren't two separate sets
    of tables, then player A will play dungeon B and player C will also play the identical
    instance of dungeon B. This is a big issue that will need to be addressed later on
* The spec stuff isn't working right now, and getting it to work would greatly help figuring
out what is wrong with the exits command
* There's something wrong with the exits command
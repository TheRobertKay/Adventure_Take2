=== variables
VAR money = 0
VAR success = true
VAR intimidation = 0
VAR combatWon = false

-> innRoom


// here we should have the character creation

=== innRoom
You wake up in a bed in a tavern with a massive hangover.// expand this bit
-> lookAround

    = lookAround
    There's stuff to see: 
        + Windows
        You look out of the window and see lots of snow. 
        -> lookAround
        
        + Door
        You look at the door. 
        -> innRoomDoor
        
        + Backpack
        // here the purse-button  should be highlighted
        -> lookAround
        
        + Purse
        // here the purse-button  should be highlighted
        -> lookAround
    
    = innRoomDoor
    It's made from solid oak planks. 
    
        + listen at the door
        -> innDoorListening
        
        + look through the keyhole
        -> innDoorKeyhole
        
        + open the door
        -> innCorridor
        
        + wait
        // there should be a waiting mechanic in place, that counts down the actions taken by the player (that can be accessed from this script) and provides an option to just pass time until a certain event happens
        -> innRoomDoor
        
        + sit back on your bed
        -> innRoom
        
    = innDoorListening
    // here a skill check for listening should be performed automatically. 
    Nothing can be heard. 
    
        Steps are cominng closer towards you. 
        -> innRoomDoor
    
    = innDoorKeyhole    
    You can't really see much, except for a decrepit brick wall on the other side of the corridor. 
    -> innRoomDoor
    
    = innCorridor
    You step out of the room and find yourself in a decrepit corridor with worn dorn tapestry over brownish brickstone and a wooden floor, sticky from thing you never want to find out. 
    + go downstairs
    -> innTapRoom
    
    + go back into your room
    -> innRoom
    
    = innTapRoom
    The tap room is only lit by a few rays of morning light that fit through the closed window shutters. Underneath a table a body is lying, motionless but with an ear piercing snoring. 
     + leave
     -> innTapRoom
     
     + call for the inn keeper
     -> innTapRoom
     
     + search the tap room 
     -> innTapRoom
     
     + check on the snoring person
     -> stealFromDrunkard
     
     
     = stealFromDrunkard
     It's a tall man with a massive beer gut. 
     
     + take his purse 
     // skill check for sleight of hands or pickpocket
     {success} -> successfulThief 
     {success == false} -> caughtByInnKeeper
     
     = successfulThief
     You quickly grab his purse from his belt and hear the satisfying jingle of a dozen coins. 
     money += 15
     -> innTapRoom
     
     = caughtByInnKeeper
     ~ success = false
     "Sir, what are you doing down there?" a voice calls just as you are trying to pick the man's purse from his belt. You quickly pull yourself up, narrowly avoiding your head colliding with the table. 
     
        + "Nothing, Sir, I just checked for him being alright." (lie) //skill check on lying
        -> liar
        
        + "I am sorry Sir, I really need that money..." (truth)
        -> sadThief
        
        + Say nothing and stare menacingly.
        -> threatenInnKeeper
        
    = liar
    {success} "Oh, I'm sorry, Sir, my bad. Can't be carfeul enough these days. What can I get you for breakfast?" -> breakfast
        
    {success == false} "Oh really, is that so? I don't think so, Sir, that looks an aweful lot lilke you were up to steal that poor old drunkards money and I won't allow that in my inn. Now get the hell out of here or do I need to call the guards?" Right at that moment the sound of two pairs of heavy boots move past the window and weighing your chances against an armed patrol you decide not to make any more trouble. -> END
    
    ~ success = false
    
    = threatenInnKeeper
    {intimidation > 3} "Oh well, I guess that's none of my business. Don't want any trouble, Sir, what can I get you for breakfast?"  -> breakfast
    {intimidation <= 3} "Do you think I was afraid of you, Sir? Never. Now get the hell out of here!" -> poorDecisionMaking
    
    = breakfast
    On your order he brings you a bowl of porridge with butter and a few slices of bacon.
    -> END
    
    = sadThief
    "Well, Sir, you'd better put that back and don't you do any of that sort under my nose anymore. Anyway, given you can afford it, what can I get you for breakfast?"
    -> breakfast
    
    === poorDecisionMaking
    The inn keeper looks very little amused and you're getting the distinct impression, that he isn't joking around. Will you leave or stand your ground and see, what happens? 
    
    * Here I stand and I can't turn back. -> combat
    
    * Alright, I'll leave, but only because I wanted to do so anyway! -> END
    
    === combat
    "That was a poor decision, Sir. May I introduce: My friends the city guard."
    // enter combat screen
    
    * {combatWon == false} You died during combat. Unceremoniously you are buried in a shallow grave. Half a year later your rotten corpse is raised back to life and you walk the earth as an undead to haunt mankind and devour the flesh of the innocent. -> END
    
    * {combatWon} Victorious you plunder the inn and subsequently burn and pillage the city before declaring yourself a god. -> END
#!/usr/bin/env bash

# Non-Interactive Test
interactive=0
case $1 in
    -i | --interactive*)
        interactive=1
        ;;
esac

if [ $interactive -eq 0 ]; then
    # Set Varuabkes
    WorldPath="/app/Worlds"
    BanList="$WorldPath/banlist.txt"
    World="MyWorld"
    ServerPassword=
    MaxPlayers=8
    Difficulty=0
    WorldSize=1
else
    # Set Varuabkes
    WorldPath="/app/Worlds"
    BanList="$WorldPath/banlist.txt"

    # Read In Worldname
    echo "World Name?"
    echo "( Sets the name of the world when using autocreate )"
    read World
    if [[ $World = $NULL ]]; then
        echo "Need a World Name to generate config, please re-run the script and answer all questions!!!"
        exit
    fi

    # Read In Server Password
    echo "Server Password?"
    echo "( Set the server password - Press Enter for No Password )"
    read ServerPassword

    # Read In Max Players
    echo "Max Players?"
    echo "( Sets the max number of players allowed on a server. Value must be between 1 and 255 )"
    read MaxPlayers
    if [[ $MaxPlayers -eq $NULL ]]; then
        MaxPlayers=8
    fi

    # Read in Difficulty
    echo "Difficulty?"
    echo "( Sets world difficulty when using -autocreate. Options: 0(classic), 1(expert), 2(master), 1(journey) )"
    read Difficulty
    case $Difficulty in
    [0]*)
        echo "Selected Classic Difficulty!"
        ;;
    [1]*)
        echo "Selected Expert Difficulty!"
        ;;
    [2]*)
        echo "Selected Master Difficulty!"
        ;;
    [3]*)
        echo "Selected Journey Difficulty!"
        ;;
    *)
        echo "Selected Normal Difficulty!"
        Difficulty=0
        ;;
    esac

    # Red in World Size
    echo "World Size?"
    echo "( Creates a new world if none is found. World size is specified by: 1(small), 2(medium), and 3(large) )"
    read WorldSize
    case $WorldSize in
    [1]*)
        echo "Selected Small World Size!"
        ;;
    [2]*)
        echo "Selected Medium World Size!"
        ;;
    [3]*)
        echo "Selected Large World Size!"
        ;;
    *)
        echo "Selected Small World Size!"
        WorldSize=1
        ;;
    esac
fi

# Generate serverconfig.xml
tee << EOF > /app/Worlds/serverconfig.txt
worldpath=$WorldPath
worldname=$World
world=$WorldPath/$World.wld
port=${PORT}
banlist=$BanList
password=$ServerPassword
maxplayers=$MaxPlayers
difficulty=$Difficulty
autocreate=$WorldSize
language=en/US
EOF
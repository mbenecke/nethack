# nethack
Small docker for nethack.

# Create Folder for Saves
In order to save your game, the container stores the date in the volume /data.

Create a folder where you want to save everything. For example ~/nethacksaves

```
mkdir nethacksaves
```

Then create some files nethack needs:
```
~/nethacksaves
mkdir -p save
touch perm record logfile xlogfile
```

TODO: let the container create the files in a later revision.

# Build
```
docker build -t janhkrueger/nethack .
```

# Run
To run the game, type the following. Replacing the volume with the folder you created in the first place.
```
docker run -it -v ~/nethacksaves:/data janhkrueger/nethack
```

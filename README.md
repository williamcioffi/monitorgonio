### monitorgonio
a quick hack to display [Argos Goniometer](https://www.clsamerica.com/argos-goniometer) output in a user friendly display using `shiny`. 

**WARNING:** still very rough. use at own risk.

### feature requests
- when add a new ptt the old ptts still keep there own colors.
- color fades away so old hits eventually disapear
- ability to filter by ptt
- play a sound when there is a new hit
- should make this a package which can export the batch script automatically? is that a bad practice?

### quick guide
edit these files:
- *goniomter.bat* edit this batch script with your path if you want a double clickable start up on windows. sorry this is probably a dumb way to do it i don't know how to use windows.
- *pttkey.csv*: edit this file to include DeployID/friend names and ptt hex codes for the platforms you want to track. when you run the shiny app you can select this file and/or reload it if you make updates.

### extras
- *simulate.sh, gonio\_sim\_log.txt, gonio\_source\_log.txt*: these are testing files and a bash script for simulating message arrival for debugging, etc.


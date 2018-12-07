### monitorgonio
a quick hack to display [Argos Goniometer](https://www.clsamerica.com/argos-goniometer) output in a user friendly display using `shiny`. 

[quick guide](https://williamcioffi.gitub.io/monitorgonio) to installing and getting started.

**WARNING:** still very rough. use at own risk.

### feature requests
- when add a new ptt the old ptts still keep there own colors.
- color fades away so old hits eventually disapear
- ability to filter by ptt
- play a sound when there is a new hit
- should make this a package which can export the batch script automatically? is that a bad practice?

### ultra quick guide
install the package:

```r
devtools::install_github("monitorgonio")
```

you can run monitorgonio from an interactive r session or use ```make_bat_file()``` to make a shortcut.

```r
library(monitorgonio)
run_monitorgonio()
```

more details in the [slightly less quick guide](https://williamcioffi.github.io/monitorgonio)


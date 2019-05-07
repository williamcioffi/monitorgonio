### monitorgonio
a quick hack to display [Argos Goniometer](https://www.clsamerica.com/argos-goniometer) output in a user friendly display using `shiny`. 

[quick guide](https://williamcioffi.github.io/monitorgonio) to installing and getting started.

**WARNING:** still very rough. use at own risk.

### ultra quick guide
install the package. dependencies are `shiny`, `shinyFiles`, and `plotrix`.

```r
devtools::install_github("williamcioffi/monitorgonio")
```

you can run monitorgonio from an interactive r session or use `make_bat_file()` to make a shortcut.

```r
monitorgonio::run_monitorgonio()
```

![](docs/images/loaddata.png)


![](docs/images/inaction.gif)

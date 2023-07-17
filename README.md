BETA TEST FOR VERSION 2 OF SOFTWARE

### monitorgonio
[![DOI](https://zenodo.org/badge/126085789.svg)](https://zenodo.org/badge/latestdoi/126085789)

* a quick hack to display [Argos Goniometer](https://www.clsamerica.com/argos-goniometer) output in a user friendly display using `shiny`. 

* post questions or bugs to [issues](https://github.com/williamcioffi/monitorgonio/issues)

* see ultra quick guide and regular quick guide by scrolling down.

* interested in contributing? take a quick peak at the [guidelines](CONTRIBUTING.md).

* please cite as: 

Cioffi WR (2020). monitorgonio: visualize Argos Goniometer output in the field. R package version 0.1.0. https://github.com/williamcioffi/monitorgonio. (doi:10.5281/zenodo.3647686)

### ultra quick guide
install the package. dependencies are `shiny`, `shinyFiles`, and `plotrix`. scroll down for more details.

```r
remotes::install_github("williamcioffi/monitorgonio")
```

you can run monitorgonio from an interactive r session or use `make_bat_file()` to make a shortcut.

```r
monitorgonio::run_monitorgonio()
```

![](docs/images/loaddata.png)

![](docs/images/inaction.gif)


Details
----------------

The Woods Hole Group (formerly CLS America) rents and sells an antenna
and receiver that they call the [Argos
Goniometer](https://www.clsamerica.com/argos-Goniometer). This machine
can pick up and directionalize Argos PTTs and even downloads messages.

We set up our Goniometer to run in hyperterminal mode connected to a
laptop on the boat. Basically this spits the Goniometer log out to a
text file. There are a couple of different types of text that are
displayed in that log but it is mostly comma separated values.

The package
-----------

This package is a quick hack to display Goniometer output in a user
friendly display using `shiny`. The Goniometer’s screen is tiny, but as
mentioned above the hyperterminal mode when connected to a laptop
outputs all data to a simple text log file. The shiny app just
eavesdrops on this log and uses a key file you load in (csv) to match
PTT (hex codes) and display only your platforms of interest. In
addition, the program displays the bearing visually on a compass face
(circle) and in a table, which is easier to read than the stock
software.

Obligatory warnings
-------------------

This package is still very rough so use it at your own risk. It might
crash and then you miss an important PTT.

Quick guide
-----------

The package isn’t on cran yet so you’ll have to install it from the
github repo. Either directly or by using `remotes` (or `devtools`). The dependencies
are `shiny`, `shinyFiles`, and `plotrix`.

``` r
remotes::install_github("williamcioffi/monitorgonio")
```

You can run monitorgonio from an interactive r session:

``` r
monitorgonio::run_monitorgonio()
```

Or you can automatically generate monitorgonio.bat which will run the
shiny app for you. I hope with the right paths. Be careful for some
reason on windows ‘\~’ is interpreted as documents or the onedrive…

``` r
monitorgonio::make_bat_file("monitorgonio.bat")
```

<img src="docs/images/loaddata.png" alt="Monitorgonio's data loading screen and instructions." width="90%" />
<p class="caption">
Monitorgonio’s data loading screen and instructions.
</p>

You’ll also have to create a ptt key file (CSV) so monitor gonio knows
what to listen for. You can get an example template which comes as a
dataframe in the package and save it for editing in your favorite
editor.

``` r
# a template pttkey comes with the package
data(pttkey, package = "monitorgonio")
pttkey
```

    ##   PTT     HEX DEPLOYID
    ## 1     0A1FBF2    test1
    ## 2     D7914E1    test2

You can also construct one easily in R and save it as a csv.

``` r
pttkey <- data.frame(
    PTT = c("111111", "222222"),
    HEX = c("0A1FB2", "D7914E1"), 
    DEPLOYID = c("test1", "test2")
)

# save to file
write.table(pttkey, file = "pttkey.csv", sep = ",", row.names = FALSE)
```

Note: you don’t really need the PTT column which is for the decimal PTT,
unless you just want to keep track of it on the screen. What the
Goniometer actually receives is the hex.

Testing
-------

You can test monitorgonio a bit even if you don’t have a Goniometer
connected or a platform handy. To do this you’ll need two instances of R
open. Either start monitor gonio with the .bat script, or start it with
`run_monitorgonio()` and then open a new instance of R.

In this new instance of R first you’ll need to save the pttkey from
above. Save it anywhere you like just remember the path. Next we’ll need
a simulated log file. We’ll use a function in a moment to append to the
log file as if hits were coming in one by one on the Goniometer, but for
now you can just create an empty file:

``` r
cat("", file = "testlog")
```

Now make sure monitorgonio is running and go to the shiny window and
select both the log file and the pttkey using the buttons and navigating
to where you saved them.

Finally, run the test with:

``` r
monitorgonio::simulate_gonio("testlog")
```

…and you should see hits appearing in the monitorgonio shiny window.

One word of caution about ptts and csvs
---------------------------------------

If you are opening these csv files in excel and if your hex has an E
somewhere in the middle and all the other digits are numbers (not
letters) then excel will interpret it as scientific notation. For
example 12345E2 will be converted into 12345 ⋅ 10<sup>2</sup> by excel.
This is quite annoying and will happen every time you open the file.
It’ll look something like this:

<img src="docs/images/badhex.png" alt="The perils of excel and hex." width="90%" />
<p class="caption">
The perils of excel and hex.
</p>

The best solution is don’t use excel because it is a terrible csv
editor. But many folks are most comfortable with editing csvs in excel
so in the past I’ve added a notes column that starts with text so the
real hex can be recovered if someone accidentally edits it in excel and
saves the result.

<img src="docs/images/savedhex.png" alt="Put a notes column and copy and paste hexes back in that might get ruined by excel." width="90%" />
<p class="caption">
Put a notes column and copy and paste hexes back in that might get
ruined by excel.
</p>

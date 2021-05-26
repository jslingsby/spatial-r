###Bookdown referencing

You can label chapter and section titles using `{#label}` after them, e.g., we can reference Chapter \@ref(intro). If you do not manually label them, there will be automatic labels anyway, e.g., Chapter \@ref(methods).

Figures and tables with captions will be placed in `figure` and `table` environments, respectively.

```{r nice-fig, fig.cap='Here is a nice figure!', out.width='80%', fig.asp=.75, fig.align='center'}
par(mar = c(4, 4, .1, .1))
plot(pressure, type = 'b', pch = 19)
```

Reference a figure by its code chunk label with the `fig:` prefix, e.g., see Figure \@ref(fig:nice-fig). Similarly, you can reference tables generated from `knitr::kable()`, e.g., see Table \@ref(tab:nice-tab).

```{r nice-tab, tidy=FALSE}
knitr::kable(
  head(iris, 20), caption = 'Here is a nice table!',
  booktabs = TRUE
)
```

You can write citations, too. For example, we are using the **bookdown** package [@R-bookdown] in this sample book, which was built on top of R Markdown and **knitr** [@xie2015].




##########################

## Housekeeping

Apologies, this bit is a little long-winded, but please read it carefully as it will likely affect your ability to run the code below.

### Working directories
I usually work from a "Project" in RStudio linked to a GIT repository (see **<https://git-scm.com/>** and **<https://github.com/>**) for version control and easy code sharing/collaboration. I'm not going to go there with this tutorial, but it is worth exploring if you intend to do big projects in R. R projects set the working directory to a good place automatically. Alternatively you can use the setwd() function.

If I'm not in a GIT repo or I am working with large data sets that I don't want to replicate in every GIT repo on my hard drive I usually set separate "data", "GIS data" (i.e. biggish data) and "results" working directories by making each path an object and inserting as appropriate for different read and write functions using paste() or paste0(). These would look something like:

```
datwd = "/home/jasper/Dropbox/Teaching/SpatialR/Example/Data/"
giswd = "/home/jasper/Documents/GIS/"
reswd = "/home/jasper/Dropbox/Teaching/SpatialR/Example/Results/"
```

### Sharing code between multiple machines
If you plan run the same code on multiple machines (e.g. your laptop and a workstation) or are sharing code with a collaborator (and are not using GitHub) it's easiest to automatically detect what computer the code is being run on and set the appropriate working directories (and anything else you like).

This can be done by identifying the machine/user using Sys.getenv() and wrapping the code for setting working directories etc in an if() statement for each user, like so:


  ```{r}
Sys.getenv("USER") #Tells us the "USER" name on Mac or Linux
```

If you are on Windows you need to use `Sys.getenv("USERNAME")`. I don't know why its different...?

Then I can set up my *if()* statement. Note that each user/collaborator can set up their own *if()* statement one after the other because if the statement `Sys.getenv("USER")=='jasper'` returns `FALSE` then R doesn't run the chunk of code in the curly brackets `{ ... }`.

```
if (Sys.getenv("USER")=='jasper') {
  datwd="/home/jasper/Dropbox/Teaching/SpatialR/Example/Data/"
  giswd="/home/jasper/Dropbox/BlogData/"
  reswd="/home/jasper/Dropbox/Teaching/SpatialR/Example/Results/"}

if (Sys.getenv("USER")=='MACUseR') {datwd=""; giswd=""; reswd=""} #Change here for Mac/Linux users

if (Sys.getenv("USERNAME")=='WINDOWSUseR') {datwd=""; giswd=""; reswd=""} #Change here for Windows users
```

This way a new project member can add a new line of code without deleting anything, and it only sets the working directories (and any other settings you want) for the appropriate user - i.e. the if() statement ignores settings for all other users.

If you are running the code from this tutorial you need to set your username and working directories here. You can just set *datwd*, *giswd* and *reswd* to the same file path for the purposes of this tutorial (if you've put all the data you downloaded in the same place).

#### A quick aside on slashes
Often the reason you can't read in data is because you need to add (or delete) a "/" at the end! - Silly, but that pro tip should help.

                                                                                                                                                                                                                  Note that we generally use single forwardslashes "/" in R. Windows likes to use single backslashes, but R (and just about every other computer programme in the world) doesn't like this. You can use double backslashes on Windows if you must...

```{r, echo = F}
# dem <- getData('SRTM', lon=18, lat=-34)
#
# plot(dem)
```


___
For the sake of simplicity and file size, I have already _cropped_ the elevation and vegetation datasets to a smaller and _resampled_ the raster from 10m to 90m pixel resolution

### A quick aside on the difference between accuracy and precision! {.unlisted .unnumbered}

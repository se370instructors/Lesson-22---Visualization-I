#---SE370 AY22-2 - Lesson 22
#By: Ian Kloo
#March 2022

library(dplyr)
library(ggplot2)
library(readr)

#we will use a dataset that is built into R `mtcars`
data(mtcars)
head(mtcars)

#---Basic plotting with ggplot---#
#ggplot is the simplest and most full-featured plotting library in R
#it is based on layering - you start by making the plot work, then slowly add/remove things to make the final plot you want

#base layer - just an empty plot

#add your data and tell ggplot what to put on each axis:

#now we have to determine what type of chart we want...R calls these `geoms`...some options:
#1 . geom_histogram
#2. geom_bar
#3. geom_point
#4. geom_line
#5. geom_boxplot
#more: https://rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf

#we probably want a scatter plot = geom_point

#you can add multiple geoms...this is probably a bad choice...explain why

#and so is this...explain why

#big point: just because you *can* make a plot it doesn't mean you *should*
#go back to previous lesson on visualization to plan out what you want before you start coding!

#---Making things look nice---#
#options within the geom for changing things like color, size, etc.


#you can modify the axes by adding arguments:

#or...


#change the range of the axes


#add a title


#center it


#add better axis titles


#recommendation: use `themes` as a shortcut to get to better looking plots faster


#---More advanced plotting---#
#let's add a 3rd variable to the analysis:


#cyl is being coded as a continuous variable, but it is discrete!  can't have 1.2 cylinders...


#another option is to separate the plots by a variable


#works nicely with histograms and density plots



#---ggplot exercise---#
#-1.create a histogram showing how much money movies make (use the adjusted column).

#make decent looking x and x axes, add a centered title, and apply a theme that isn't theme_bw()


#-2. now separate your histogram into different plots for each rating



#-3. make a scatterplot of rt_freshness against earnings (adjusted)

#use geom_smooth to add a fit line and analyze your results

#now change `adjusted` to `imdb_rating` to see the relationship between critic scores on the different websites


#-4. use dplyr to find the average earnings (adjusted) for each rating.  then plot the result using a barplot.  order should be G -> PG -> PG-13 -> R







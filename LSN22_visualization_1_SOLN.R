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
ggplot()

#add your data and tell ggplot what to put on each axis:
ggplot(data = mtcars, aes(x = mpg, y = hp))

#now we have to determine what type of chart we want...R calls these `geoms`...some options:
#1 . geom_histogram
#2. geom_bar
#3. geom_point
#4. geom_line
#5. geom_boxplot
#more: https://rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf

#we probably want a scatter plot = geom_point
ggplot(data = mtcars, aes(x = mpg, y = hp)) + geom_point()

#you can add multiple geoms...this is probably a bad choice...explain why
ggplot(data = mtcars, aes(x = mpg, y = hp)) + geom_point() + geom_line()
#and so is this...explain why
ggplot(data = mtcars, aes(x = mpg, y = hp)) + geom_bar(stat = 'identity')

#big point: just because you *can* make a plot it doesn't mean you *should*
#go back to previous lesson on visualization to plan out what you want before you start coding!

#---Making things look nice---#
#options within the geom for changing things like color, size, etc.
ggplot(data = mtcars, aes(x = mpg, y = hp)) + geom_point(size = 2, color = 'steelblue')

#you can modify the axes by adding arguments:
ggplot(data = mtcars, aes(x = mpg, y = hp)) + geom_point() +
  scale_x_continuous(breaks = c(0, 10, 20, 30))
#or...
ggplot(data = mtcars, aes(x = mpg, y = hp)) + geom_point() +
  scale_x_continuous(breaks = 1:35)

#change the range of the axes
ggplot(data = mtcars, aes(x = mpg, y = hp)) + geom_point() +
  scale_x_continuous(breaks = c(0, 10, 20, 30)) +
  ylim(c(0, 400))

#add a title
ggplot(data = mtcars, aes(x = mpg, y = hp)) + geom_point() +
  scale_x_continuous(breaks = c(0, 10, 20, 30)) +
  ylim(c(0, 400)) + ggtitle('Are Efficient Cars Slow?')

#center it
ggplot(data = mtcars, aes(x = mpg, y = hp)) + geom_point() +
  scale_x_continuous(breaks = c(0, 10, 20, 30)) +
  ylim(c(0, 400)) + ggtitle('Are Efficient Cars Slow?') +
  theme(plot.title = element_text(hjust = 0.5))

#add better axis titles
ggplot(data = mtcars, aes(x = mpg, y = hp)) + geom_point() +
  scale_x_continuous(breaks = c(0, 10, 20, 30)) +
  ylim(c(0, 400)) + ggtitle('Are Efficient Cars Slow?') +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab('Miles per Gallon') + ylab('Horsepower')

#recommendation: use `themes` as a shortcut to get to better looking plots faster
ggplot(data = mtcars, aes(x = mpg, y = hp)) + geom_point() + theme_bw(base_size = 14) + 
  scale_x_continuous(breaks = c(0, 10, 20, 30)) +
  ylim(c(0, 400)) + ggtitle('Are Efficient Cars Slow?') +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab('Miles per Gallon') + ylab('Horsepower')

#---More advanced plotting---#
#let's add a 3rd variable to the analysis:
ggplot(data = mtcars, aes(x = mpg, y = hp, color = cyl)) + geom_point() + theme_bw(base_size = 14)

#cyl is being coded as a continuous variable, but it is discrete!  can't have 1.2 cylinders...
ggplot(data = mtcars, aes(x = mpg, y = hp, color = factor(cyl))) + geom_point() + theme_bw(base_size = 14)

#another option is to separate the plots by a variable
ggplot(data = mtcars, aes(x = mpg, y = hp)) + geom_point() + theme_bw(base_size = 14) +
  facet_wrap(~cyl, ncol = 1)

#works nicely with histograms and density plots
ggplot(data = mtcars, aes(x = mpg)) + geom_histogram(bins = 20) + theme_bw(base_size = 14) +
  facet_wrap(~cyl, ncol = 1)

ggplot(data = mtcars, aes(x = mpg)) + geom_density() + theme_bw(base_size = 14) +
  facet_wrap(~cyl, ncol = 1)

#---ggplot exercise---#
#-1.create a histogram showing how much money movies make (use the adjusted column).
ggplot(movies, aes(x = adjusted)) + geom_histogram()

#make decent looking x and x axes, add a centered title, and apply a theme that isn't theme_bw()
ggplot(movies, aes(x = adjusted)) + geom_histogram() + theme_minimal() +
  xlab('Adjusted Revenue ($Millions)') + ylab('Count of Movies') +
  ggtitle('Distribution of Movie Earnings') + theme(plot.title = element_text(hjust = 0.5))

#lifehack for dollar formats!
ggplot(movies, aes(x = adjusted)) + geom_histogram() + theme_minimal() +
  xlab('Adjusted Revenue ($Millions)') + ylab('Count of Movies') +
  ggtitle('Distribution of Movie Earnings') + theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(labels = scales::dollar_format())

#-2. now separate your histogram into different plots for each rating
ggplot(movies, aes(x = adjusted)) + geom_histogram() + theme_minimal() +
  xlab('Adjusted Revenue ($Millions)') + ylab('Count of Movies') +
  ggtitle('Distribution of Movie Earnings') + theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(labels = scales::dollar_format()) +
  facet_wrap(~rating, ncol = 1)

#-3. make a scatterplot of rt_freshness against earnings (adjusted)
ggplot(movies, aes(x = rt_freshness, y = adjusted)) + theme_minimal() + geom_point() + 
  scale_y_continuous(labels = scales::dollar_format()) 

#use geom_smooth to add a fit line and analyze your results
ggplot(movies, aes(x = rt_freshness, y = adjusted)) + theme_minimal() + geom_point() + 
  scale_y_continuous(labels = scales::dollar_format()) + geom_smooth()

#now change `adjusted` to `imdb_rating` to see the relationship between critic scores on the different websites
ggplot(movies, aes(x = rt_freshness, y = imdb_rating)) + theme_minimal() + geom_point() + 
  geom_smooth()


#-4. use dplyr to find the average earnings (adjusted) for each rating.  then plot the result using a barplot.  order should be G -> PG -> PG-13 -> R
earnings_by_rating <- movies %>%
  drop_na(rating) %>%
  group_by(rating) %>%
  summarize(avg_earnings = mean(adjusted)) %>%
  arrange(-avg_earnings)

ggplot(earnings_by_rating, aes(x = factor(rating, levels = c('G','PG','PG-13','R'), ordered = TRUE), y = avg_earnings)) + geom_bar(stat = 'identity') +
  theme_minimal() + scale_y_continuous(labels = scales::dollar_format()) +
  xlab('Movie Rating') + ylab('Average Earnings')




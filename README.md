# dataProducts

A Project for the John Hopkins Coursera Data Product Class
Prepared by Marcel Merchat
April 3, 2016

Purpose:

This project produced an interactive website which permitted
the user to select a desired exploratory plot as Figure-1. 
The user was provided with a slider to adjust the sunspot count
to define high spot years.


This website explores possible explanations and relationships
of water level fluctuations of Lake Huron which lies 
between the United States and Canada. It also includes
Lake Michigan because the two lakes are joined near Mackinac
Island. The common level of these very large lakes is more like
an ocean than a river or typical lake because they 
do not seem to be related to the amount of rain. The lake level 
can only change about a foot over a period of many months.
There are short term fluctuations of up to 10-feet or more due
to high wind and waves but these average to zero when the
weather returns to calm conditions.'),
                
Raw Data for Analysis
The basic R program is distributed with three standard 
datasets that we use to analyze and predict the level
of Lake Huron. We use the following datasets for our analysis
                
LakeHuron - Annual Lake Levels starting in 1875
sunspot.month - Monthly sunspot count starting in 1749
nhtemp - Annual temperatures in New Haven, CT from 1912-1971
                
        
Raw Data for the Analysis
                
In order to expore the fluctuations of Lake Huron, we built a data frame for
the 58 years from 1914-1971 using the R datasets described in the left column.
The derived data frame lists the temperature, sunspot, and lake level data for
direct comparison and analysis. The three-year running averages of the temperature
and sunspot counts taken from the raw R datasets are listed in the new
data frame. The code for this is part of the server program.
                
Exploratory Plots
                
Running Three-Year Average Temperature
Sunspot Activity
Temperature and sunspot levels

plotOutput('plot1')
                

Regression Analysis
                
In order to expore the level fluctuations of Lake Huron,
we built a regression model using the lm function
in an attempt to predict the lake level from the three-year
running temperature and sunspot counts. Our model includes
an interactive term data frame for joint sunspot-temperature interaction.
                
Regression Model
                
The model is based on temperature dependance with adjustment for sunspot level. 
The level is represented as a binary high or low variable.
                
Conditioning Effect of Temperature

High lake levels coincided with high sunspot counts for
both high and low temperatures. The lake level was about
average for sunspot levels greater than the 75th percentile. 
Low lake levels only occurred when sunspot counts were low.'),
                
Figure-2
plotOutput('plot2')
                
The highest sunspot levels corresponded to above average 
temperatures and high lake levels. To see the effect of the
highest sunspot counts of 1375 or more, adjust the slider
to 300 at the right side. The red line in Figure-2 indicates
the expected lake level increases with temperature
in this case.
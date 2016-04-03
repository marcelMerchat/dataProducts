library(shiny)

shinyUI(pageWithSidebar(
        headerPanel("Predicting the Level of Lake Huron"),
        sidebarPanel(
                #sliderInput('mu', 'Guess at the mean',value = 70, min = 62, max = 74, step = 0.05)
                h4('A Project for the John Hopkins Coursera Data Product Class'),
                h5('Prepared by Marcel Merchat'),
                h5('April 3, 2016'),
                h3('Purpose:'),
                h5('This website explores possible explanations and relationships
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
                
                h3('Raw Data for Analysis'),
                h5('The basic R program is distributed with three standard 
                datasets that we use to analyze and predict the level
                of Lake Huron. We use the following datasets for our analysis.'), 
                
                h5('A. LakeHuron - Annual Lake Levels starting in 1875'),
                h5('B. sunspot.month - Monthly sunspot count starting in 1749'),
                h5('C. nhtemp - Annual temperatures in New Haven, CT
                from 1912-1971.')
                ),
        
        mainPanel(
                h3('Raw Data for the Analysis'),
                
                h5('In order to expore the fluctuations 
                of Lake Huron, we built a data frame for
                the 58 years from 1914-1971 using
                the R datasets described in the left column.
                The derived data frame lists the temperature, sunspot, 
                and lake level data for direct comparison and analysis. The 
                three-year running averages of the temperature and sunspot
                counts taken from the raw R datasets are listed in the new
                data frame. The code for this is part of the server program.'),
                
                h3('Exploratory Plots:'),
                
                h4('Running Three-Year Average Temperature'),
                h5('Figure-1 below shows that the lake levels were often high
                when the three-year running average temperature was low
                as was the case just before 1920, but the reverse did not hold
                when the temperature later increased during the period
                from 1940-1954.'),
                
                h5('Enter 1 into the box below to see a plot of the effect
                   of temperature.'),
                
                h4('Sunspot Activity:'),
                h5('High lake levels coincided with high sunspot counts and the
                level peaked with sunspot activity in the period before 1935
                and after 1965, but this did not hold as the temperature
                increased during the years from 1940-1954.'),
                
                h5('Enter 2 into the box below to see a plot of the effect
                   of sunspot activity. To compare temperature and sunspot 
                   levels, enter 3 into the box.'),
                
                h3('Choose Desired Plot:'),
                
                h5('Enter 1, 2, or three as follows:'),
                h5('1 - Lake Level and New Haven Temperature'),
                h5('2 - Lake Level and Sunspot Count'),
                h5('3 - Sunspot Count and New Haven Temperature'),
                
                numericInput('id1', 'Choose Desired Plot, labeled id1',
                             1, min = 1, max = 3, step = 1),
                
                h2('Figure-1'),
                plotOutput('plot1'),
                
                h3('Regression Analysis:'),
                
                h5('In order to expore the level fluctuations of Lake Huron,
                we built a regression model using the lm function
                in an attempt to predict the lake level from
                the three-year running temperature and sunspot counts.
                Our model includes an interactive term data frame for joint
                   sunspot-temperature interaction.'),
                
                h3('Regression Model'),
                
                h5('The model is based on temperature dependance with 
                adjustment for sunspot level. The sunspot level is 
                represented as a binary high or low variable.'),
                
                h5('Red dots in Figure-2 below represent high sunspot  
                   years when the level was higher than the 75th percentile
                   which corresponded 1075 sunspots per year. Black dots indicate
                   average and sunspot levels below 1075.
                   The limit of 1075 sunspots that defines high and low sunspot
                   years can be adjusted using the slider below.'),
                
                h4('Conditioning Effect of Temperature'), 
                
                h5('High lake levels coincided with high sunspot counts for
                 both high and low temperatures. The lake level was about
                 average for sunspot levels greater than the 75th percentile. 
                 Low lake levels only occurred when sunspot counts were low.'),
                
                h5('The red line in Figure-2 is the best fit line for
                 high sunspot years when the level was higher than
                 the 75th percentile which corresponded 1075 sunspots per year.
                 The black line is the best fit line for average and lower
                 sunspot levels. The limit of 1075 sunspots that defines high
                and low sunspot years can be adjusted using the slider below.'),
                
                h4('Adjust High-Count Sunspot Detection Limit'),
                
                h5('Use the the slider below to raise the limit
                   for inclusion as a high sunspot year.'),
                
                sliderInput('spotadjust', 'Adjust high spot limit',
                            value = 0, min = 0, max = 300, step = 50),
                
                h2('Figure-2'),
                plotOutput('plot2'),
                
                h5('The highest sunspot levels corresponded to above average 
                 temperatures and high lake levels. To see the effect of the
                 highest sunspot counts of 1375 or more, adjust the slider
                 to 300 at the right side. The red line in Figure-2 indicates
                 the expected lake level increases with temperature
                 in this case.')

                )))




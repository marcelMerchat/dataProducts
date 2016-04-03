library(shiny)

shinyServer(
         
        function(input, output) {
                x <- reactive({
                        
                library(UsingR)
                data(LakeHuron)
                data(sunspot.month)
                data(nhtemp)

                datyear <- c(1749:2012)
                year <- c(1912:1971)

                m <- as.matrix(sunspot.month)[1:len,]
                m1 <- matrix(m,ncol=12,byrow = TRUE)
                df <- data.frame(datyear,m1)

                sunSpotsMonthly <- df[df$datyear > 1911 & df$datyear < 1972,]
                years <- c(1912:1971)
                sunSpots <- apply(sunSpotsMonthly[,c(2:13)],1,sum)

                ## Lake Huron
                Huron_Lake_Level <- LakeHuron[c(38:97)]  
                
                nhtemperature <- nhtemp[1:60]
                
                running2yeartemp <- nhtemperature[3:60]
                running2yearspots <- sunSpots[3:60]
                
                for(i in c(1:58)){
                        running2yeartemp[i] <-
                                (nhtemp[i] + nhtemp[i + 1] + nhtemp[i + 2]) / 3
                        running2yearspots[i] <-
                                (sunSpots[i] + sunSpots[i + 1] + sunSpots[i + 2]) / 3
                }

                meanTemp <- mean(running2yeartemp)
                summ <- summary(running2yeartemp)
                summ[[2]]
                summ[[5]]
                
                weather <- ifelse(running2yeartemp > summ[[5]] + 0.4,"hot","not hot")

                model_data2 <- 
                        data.frame(year[3:60],running2yeartemp[1:58],running2yearspots[1:58],
                                   weather[1:58],Huron_Lake_Level[3:60])
                colnames(model_data2) <- c("year","running_2_year_temp","running_2_year_spots","weather","Huron_Lake_Level")
                

                model_data2$spotWeather <- 
                        (ifelse(model_data2$running_2_year_spots < meanSpots,"Low_Spots","High_Spots"))
                model_data2$weather <- factor(model_data2$weather, levels = c("not hot","hot"))
                
                if(input$id1==1){   
                        par(mar = c(5,5,2,5))
                        plot(year[3:60],model_data2$Huron_Lake_Level,col="blue",type="l",xlab="Year", 
                             ylab="Lake Level (feet above Sea Level)",
                             main = "Figure-1: Lake Huron Level and New Haven Temperature",lwd=2)
                        
                        par(new=T)
                        plot(year[3:60],running2yeartemp,col="darkgreen",xlab=NA, ylab=NA,type="l",axes=F,lwd=3)
                        axis(side = 4)
                        mtext(side = 4, line = 3, "Temperature (Degrees F)")
                        legend("topleft",
                               legend=c("Lake Huron Level", "New Haven Temperature Degrees F"),
                               lty=c(1,1), pch=c(NA, NA), col=c("blue", "darkgreen"))}
                
                if(input$id1==2){ par(mar = c(5,5,2,5))
                        plot(year[3:60],model_data2$Huron_Lake_Level,col="blue",type="l",xlab="Year",
                             ylab="Lake Level (feet above Sea Level)",
                             main = "Figure-1: Lake Huron Level and Sunspot Count",lwd=3)
                        par(new=T)
                        plot(year[3:60],log10(sunSpots[3:60]),col="red",type="l",xlab=NA,ylab=NA,
                             axes=F,lwd=2)
                        axis(side = 4)
                        mtext(side = 4, line = 3, "log10(Sunspot Count)")
                        legend("topleft",
                               legend=c("Lake Huron Level", "Sunspot Count"),
                               lty=c(1,1), pch=c(NA, NA), col=c("blue", "red3"))}
                
                if(input$id1==3){
                        par(mar = c(5,5,2,5))
                
                 plot(year[3:60],log10(sunSpots[3:60]),col="red",type="l",xlab="Year",
                        ylab="log10(sunspots)",
                        main = "Figure-1: Sunspots and New Haven Temperature",lwd=2)
                        par(new=T)
                        plot(year[3:60],running2yeartemp,col="darkgreen",xlab=NA, ylab=NA,type="l",axes=F,lwd=3)
                        axis(side = 4)
                        mtext(side = 4, line = 3, "Temperature (Degrees F)")
                        legend("topleft",
                        legend=c("Sunspot Count", "Temperature Degrees F"),
                        lty=c(1,1), pch=c(NA, NA), col=c("red3", "darkgreen")) 
                        }
                })                ## End of First Reactive Part
                
                # plot Manipulated
        y <- reactive({
                datyear <- c(1749:2012)
                year <- c(1912:1971)
                
                m <- as.matrix(sunspot.month)[1:len,]
                m1 <- matrix(m,ncol=12,byrow = TRUE)
                df <- data.frame(datyear,m1)
                sunSpotsMonthly <- df[df$datyear > 1911 & df$datyear < 1972,]
                years <- c(1912:1971)
                
                sunSpots <- apply(sunSpotsMonthly[,c(2:13)],1,sum)
                
                ###########################################################
                
                ## Lake Huron
                Huron_Lake_Level <- LakeHuron[c(38:97)]  
                
                nhtemperature <- nhtemp[1:60]
                
                running2yeartemp <- nhtemperature[3:60]
                running2yearspots <- sunSpots[3:60]
                
                for(i in c(1:58)){
                        running2yeartemp[i] <-
                                (nhtemp[i] + nhtemp[i + 1] + nhtemp[i + 2]) / 3
                        running2yearspots[i] <-
                                (sunSpots[i] + sunSpots[i + 1] + sunSpots[i + 2]) / 3
                }
                
                ########################################################################
                
                meanTemp <- mean(running2yeartemp)
                
                summ <- summary(running2yeartemp)
                
                meanSpots <- mean(running2yearspots)
                
                spotSumm <- summary(running2yearspots)
                spotSumm[[2]]
                spotSumm[[5]]
                
                ##########################################################################
                
                weather <- ifelse(running2yeartemp > summ[[5]] + 0.4,"hot","not hot")
                
                spot_detect_level <- spotSumm[[4]] + input$spotadjust
                
                spotWeather <- ifelse(running2yearspots > spot_detect_level,"spots","quiet")
                
                model_data2 <- 
                        data.frame(year[3:60],running2yeartemp[1:58],running2yearspots[1:58],
                                   weather[1:58],spotWeather[1:58],Huron_Lake_Level[3:60])
                colnames(model_data2) <- c("year","running_2_year_temp","running_2_year_spots",
                                           "weather","spotWeather","Huron_Lake_Level")
                
                model_data2$weather <- factor(model_data2$weather, levels = c("not hot","hot"))
                model_data2$spotWeather <- factor(model_data2$spotWeather, levels = c("quiet","spots"))
                
                fit1 <- lm(Huron_Lake_Level ~ running_2_year_temp * spotWeather,data=model_data2)
                
                alpha_0 <- fit1$coefficients[1]
                alpha_1 <- fit1$coefficients[2]
                alpha_2 <- fit1$coefficients[3]
                alpha_3 <- fit1$coefficients[4]
                
                interact_intercept <- alpha_0 + alpha_2
                interact_slope <- alpha_1 + alpha_3
                
                linear_intercept <- alpha_0
                linear_slope <- alpha_1
                
                model_data2$intercept_interact <- interact_intercept
                model_data2$slope_interact <- interact_slope
                
                model_data2$intercept_linear <- linear_intercept
                model_data2$slope_linear <- linear_slope
                
                plot(model_data2$running_2_year_temp,model_data2$Huron_Lake_Level,
                     col=model_data2$spotWeather,
                     xlab="New Haven Temperature",
                     ylab="Lake Level (feet above Sea Level)",
                     main = "Figure-2: Lake Huron Level and New Haven Temperature",
                     lwd=2,pch=19,cex=3)
                abline(model_data2[1,"intercept_interact"],
                       model_data2[1,"slope_interact"],lwd=3,col="red") 
                abline(model_data2[1,"intercept_linear"],
                       model_data2[1,"slope_linear"],lwd=3,col="black")
                legend("topleft",
                       legend=c("High Sunspot Activity", "Low Sunspot Activity"),
                       lty=c(1,1), pch=c(NA, NA), col=c("red3", "black")) 
                
                })
        ## End of Second Reactive Part
                output$plot1 <- renderPlot({x()})
                output$plot2 <- renderPlot({y()})
                }
        #end of function
) #end of server
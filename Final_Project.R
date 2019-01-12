#CSV File 

toyota.df<- read.csv("ToyotaCorolla_R.csv")

str(toyota.df)

#Year as categorical variable converted to factor to enable its conversion to dummy variables
toyota.df$Mfg_Year <- factor(toyota.df$Mfg_Year)


#Install required packages 

install.packages("dummies")
install.packages("GGally")
install.packages("gplots")
library(dummies)
library(GGally)
library(gplots)


#Creating Dummy variables
#excluding ID,Model,Mfg_month,Mfg_Year,color,Cylinders
#Model and color were not converted into Dummy variable to avoid too many variables
#Age in months is similar to keeping Mfg_Month and Mfg_Year

toyotadummy.df <- dummy.data.frame(toyota.df[,-c(1,2,5,6,11,15)])
toyotadummy.df


#Correlation Matrix
Cor_Matrix <- round(cor(toyotadummy.df),2)
Cor_Matrix



#Variables which are not relevant seeing the Correlation matrix excluded- Radio_Cassette,Tow_Bar, Parking_Assistant,Mettalic_Rim, Backseat_Divider
#Sports_Model,Mistlamps,BOVAG_Guarantee, Mfr_Guarantee, Gears,Doors,CC, Automatic, Met_Color
#Radio and radio_cassette have 0.99 correlation so only radio is considered

Toyota_Reduction.df <- toyotadummy.df[,-c(29,30,31,32,33,34,35,15,16,12,11,10,9,8)]
Toyota_Reduction.df

#Further dropping of columns after analysing data to Analyse significantly  Correalted variables
#Fuel_Type CNG,Radio,GuaranteePeriod,Airbag_1,PowerSteering

Toyota_Analyse.df <- Toyota_Reduction.df[,-c(4,10,12,20,21)]
Toyota_Analyse.df


#Heat Map to Analyse
heatmap.2(cor(Toyota_Analyse.df), Rowv = FALSE, Colv = FALSE, dendrogram = "none",
          cellnote = round(cor(Toyota_Analyse.df),2),
          notecol = "black", key = FALSE, trace = 'none', margins = c(10,10))



#CODING TO ANSWER Q5
#Only relevant continuous variable considered (Doors,CC,Gears and Guarantee Period not considered)
Toyota_Cont.df <- Toyota_Analyse.df[,c(1,2,3,6,7,8)]

#Scatter Plot using Continuous variable - Price,Age,KM,Quaterly_Tax,Weight
ggpairs(Toyota_Cont.df)


#Correlation Matrix and HeatMap using continuous variable 
Cor_Matrix <- round(cor(Toyota_Cont.df),2)
Cor_Matrix

heatmap.2(Cor_Matrix, Rowv = FALSE, Colv = FALSE, dendrogram = "none",
          cellnote = Cor_Matrix,
          notecol = "black", key = FALSE, trace = 'none', margins = c(10,10))

#The End






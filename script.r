#install.packages("magrittr")
#install.packages("DescTools")
#install.packages("ggplot2")
#install.packages("countrycode")
#install.packages("gridExtra")
library(magrittr)
library(DescTools)
library(ggplot2)
library(countrycode)
library(gridExtra)

ds<-read.csv("datasets/BigmacPrice.csv")
head(ds, n=10)

class(ds$date)
ds$date<-as.Date(ds$date)
class(ds$date)
class(ds$currency_code)
class(ds$name)
class(ds$local_price)
class(ds$dollar_ex)
ds$dollar_ex
class(ds$dollar_price)

nrow(ds)

#RECORDS BY YEAR
recordsByYear<-Year(ds$date) %>%
  table() %>%
  data.frame()
recordsByYear
ggplot(recordsByYear, aes(x=., y=Freq)) +
  geom_bar(stat="identity", width=0.6, fill="indianred1") +
  theme_minimal() +
  labs(title="Number of records by year", x="Year", y="Frequetion")
ggsave("results/recordsByYear.png",
        width=600,
        height=400,
        bg="white",
        dpi=72,
        units="px")

#BIGMAC PRICE AROUND THE WORLD ALL IN ONE POINTS
ds[, c("date", "dollar_price")]
ggplot(ds, aes(x=Year(date), y=dollar_price)) +
  geom_point() +
  geom_smooth() +
  theme_light() +
  labs(title="Bigmac price around the world", x="Year", y="Price (dollar)") +
  theme(text=element_text(size = 16))
ggsave("results/bigmacPriceAroundTheWorld.png",
       width=600,
       height=500,
       dpi=72,
       units="px")

#BIGMAC PRICE AROUND THE WORLD BY YEAR
tapply(ds$dollar_price, Year(ds$date), FUN=summary, na.rm=T)
ggplot(ds, aes(x=dollar_price, y=factor(Year(date)), fill=factor(Year(date)))) +
  geom_boxplot(outlier.shape=NA) +
  theme_light() +
  theme(text=element_text(size=15), legend.position="none") +
  labs(title="Boxplot Bigmac price around the world by year", x="", y="") +
  xlim(0,7)
ggsave("results/boxplotPriceAroundTheWorldByYear.png",
       width=1000,
       height=700,
       dpi=72,
       units="px")

#BIGMAC PRICE AROUND THE WORLD
with(ds, {
  ds$group<-"World";
  summary(ds$dollar_price)
  ggplot(ds, aes(x=group, y=dollar_price, fill=group)) +
    geom_boxplot(outlier.colour="indianred1") +
    theme_light() +
    theme(text=element_text(size=18), legend.position="none") +
    labs(title="Boxplot Bigmac price around the world", y="Price (dollar)", x="")
  ggsave("results/boxplotPriceAroundTheWorld.png",
         width=500,
         height=400,
         dpi=72,
         units="px")
})

unique(ds$name)

USAData<-ds[ds$name=="United States", c("date", "name","dollar_price")]
USAData

#BIGMAC PRICE IN USA BOXPLOT
summary(USAData$dollar_price)
ggplot(USAData, aes(x=dollar_price, y=name, fill=name)) +
  theme_light() +
  geom_boxplot() +
  theme(legend.position="none") +
  labs(title="Bigmac price in USA", x="Price (dollar)", y="Country")
ggsave("results/boxplotPricesInUSA.png",
       width=600,
       height=400,
       units="px",
       dpi=72)

#BIGMAC PRICE IN USA POINTS
USAData[, c("date", "dollar_price")]
ggplot(USAData, aes(x=Year(date), y=dollar_price)) +
  geom_point() +
  theme_light() +
  labs(title="Bigmac price in USA", x="Year", y="Price (dollar)") +
  geom_smooth()
ggsave("results/bigmacPriceInUSA.png",
       width=600,
       height=400,
       units="px",
       dpi=72)

polandAndNeigh<-ds$name=="Poland" | ds$name=="Russia" | ds$name=="Germany" | ds$name=="Ukraine" | ds$name=="Lithuania" | ds$name=="Czech Republic" | ds$name=="Belarus"  | ds$name=="Slovakia"
polandAndNeighDS<-ds[polandAndNeigh, c("date", "name", "dollar_price")]
names(polandAndNeighDS)<-c("Date", "Country", "dollarPrice")
polandAndNeighDS

#BIGMAC PRICES IN POLAND AND ITS NEIGHBORS
tapply(polandAndNeighDS$dollarPrice, polandAndNeighDS$Country, FUN=summary)
ggplot(polandAndNeighDS, aes(x=Country, y=dollarPrice, fill=Country)) +
  geom_boxplot() +
  labs(title="Bigmac price in Poland and its neighbors", x="Country", y="Price (dollar)") +
  theme_light() +
  theme(legend.position="left")
ggsave("results/pricesInPolandAndItsNeighbors.png",
       width=800,
       height=500,
       bg="white",
       dpi=72,
       units="px")

#BIGMAC PRICE IN EASTERN EUROPE BY YEAR
polandAndNeighDS
ggplot(polandAndNeighDS, aes(x=Year(Date),y=dollarPrice, shape=Country, color=Country)) +
  geom_point(size=2.2) +
  scale_shape_manual(values=c(4, 8, 15, 16, 17, 18, 25)) +
  scale_color_manual(values=c("red", "green", "gray", "purple", "steelblue", "orange", "violet")) +
  labs(title="Bigmac price in eastern Europe by year", x="Year", y="Price (dollar)") +
  theme_light() +
  theme(text=element_text(size=16))
ggsave("results/bigmacPriceInEasternEurope.png",
       width=600,
       height=400,
       dpi=72,
       units="px")

#HEATMAP OF BIGMAC PRICES IN RECENT YEARS
completeData<-polandAndNeighDS[Year(polandAndNeighDS$Date)>=2018,]
completeData
ggplot(completeData, aes(x=Country, y=Year(Date), fill=dollarPrice)) +
  scale_fill_gradient(low = "green", high = "darkgreen") +
  geom_tile() +
  labs(title="Heatmap of Bigmac prices in recent years", y="Year") +
  theme_light() +
  theme(legend.position="none")
ggsave("results/heatmapPricesInRecentYears.png",
       width=600,
       height=600,
       units="px",
       dpi=72)

colnames(ds)
prices2021<-ds[Year(ds$date)==2021, c("name", "dollar_price")]
nrow(prices2021)
table(prices2021$name)

#BIGMAC PRICE IN 2021
summary(prices2021)
ggplot(prices2021, aes(x=dollar_price)) +
  geom_boxplot(fill="violet") +
  theme_light() +
  xlim(0, 7) + 
  theme(axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        text=element_text(size=16)) +
  labs(title="Bigmac price in 2021", x="Price (dollar)")
ggsave("results/boxplotBigmacPriceIn2021.png",
       width=600,
       height=400,
       dpi=72,
       units="px")

?countrycode
ds$continent<-countrycode(ds$name, origin = "country.name", destination="continent")
ds[is.na(ds$continent),]
is.na(ds$continent) %>%
  sum()
dsByContinent<-ds[!is.na(ds$continent), c("date", "name", "dollar_price", "continent")]
head(dsByContinent, n=10)

unique(dsByContinent$continent) %>%
  length()

continental<-table(dsByContinent$continent) %>%
  data.frame()

colnames(continental)<-c("Continent", "Records")
#NUMBER OF RECORDS BY CONTINENTS
head(continental)
firstplot<-ggplot(continental, aes(x=Continent, y=Records, fill=Continent)) +
  geom_bar(stat="identity") +
  theme_light() +
  theme(legend.position="none", text=element_text(size=20)) +
  labs(title="Number of records by continents") +
  geom_text(aes(label=Records), vjust=1.6, color="white", size=5.5)

dsByContinent

#BIGMAC PRICES BY CONTINENTS BOXPLOT
tapply(dsByContinent$dollar_price, dsByContinent$continent, FUN=summary, na.rm=T)
secondplot<-ggplot(dsByContinent, aes(x=continent, y=dollar_price, fill=continent)) +
  theme_light() +
  geom_boxplot(outlier.shape=NA) +
  ylim(0,8) +
  labs(title="Bigmac prices by continents", x="Continent", y="Price (dollar)") +
  theme(legend.position="none", text=element_text(size=20))

g<-grid.arrange(firstplot, secondplot, nrow=2)
g
ggsave("resultS/listOfPricesAndContinents.png",
       plot=g,
       width=1000,
       height=800,
       dpi=72,
       units="px")

condition<-dsByContinent$continent=="Americas"
dsByContinent[condition, "name"] %>%
  unique() %>%
  length()

#BIGMAC PRICES IN AMERICAS
americasds<-dsByContinent[condition, c("date", "name", "dollar_price")]
head(americasds)
tapply(americasds$dollar_price, americasds$name, FUN=summary, na.rm=T)
ggplot(americasds, aes(x=dollar_price, y=name, fill=name)) +
  theme_light() +
  geom_boxplot(outlier.shape=NA) +
  theme(text=element_text(size=16)) +
  labs(title="Bigmac price in Americas", x="Price (dollar)", y="Country") +
  guides(fill=guide_legend(title="Countries"))
ggsave("results/bigmacPricesInAmericas.png",
       width=600,
       height=400,
       dpi=72,
       units="px")

#DOTPLOT BIGMAC PRICES IN AMERICAS GROUPED
ggplot(americasds, aes(x=Year(date), y=dollar_price, color=name)) +
  geom_point() +
  theme_light() +
  theme(text=element_text(size=16)) +
  labs(title="Grouped Bigmac prices in Americas", x="Year", y="Price (dollar)") +
  geom_smooth(method="loess", se=F, size=0.5)
ggsave("results/pricesInAmericaGrouped.png",
       width=700,
       height=500,
       dpi=72,
       units="px")

table(dsByContinent$name) %>%
  sort(decreasing=T)

chinaPrices<-dsByContinent[dsByContinent$name == "China",]
head(chinaPrices)

duplicated<-!duplicated(Year(chinaPrices$date))
chinaPrices<-chinaPrices[duplicated,]
#BIGMAC PRICES IN CHINA LINE AND POINT
chinaPrices
ggplot(chinaPrices, aes(x=Year(date),y=dollar_price)) +
  theme_light() +
  geom_line(colour="purple", size=0.8) +
  geom_point(colour="purple", size=2.5) +
  labs(title="Bigmac price in China", x="Year", y="Price (dollar)") +
  theme(text=element_text(size=16))
ggsave("results/bigmacPriceinChina.png",
       width=600,
       height=400,
       dpi=72,
       units="px")
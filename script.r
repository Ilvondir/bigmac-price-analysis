#install.packages("magrittr")
#install.packages("DescTools")
#install.packages("ggplot2")
library(magrittr)
library(DescTools)
library(ggplot2)

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


ggplot(ds, aes(x=dollar_price, y=factor(Year(date)), fill=factor(Year(date)))) +
  geom_boxplot() +
  theme_light() +
  theme(text=element_text(size=15), legend.position="none")

unique(ds$name)

USAData<-ds[ds$name=="United States", c("date", "name","dollar_price")]
USAData

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

head(USAData)

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

ggplot(polandAndNeighDS, aes(x=Country, y=dollarPrice, fill=Country)) +
  geom_boxplot() +
  labs(title="Big Mac prices in Poland and its neighbors", x="Country", y="Price (dollar)") +
  theme_light() +
  theme(legend.position="left")

ggsave("results/pricesInPolandAndItsNeighbors.png",
       width=800,
       height=500,
       bg="white",
       dpi=72,
       units="px")

completeData<-polandAndNeighDS[Year(polandAndNeighDS$Date)>=2018,]

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
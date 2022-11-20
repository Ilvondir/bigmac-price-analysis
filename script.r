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

ggplot(recordsByYear, aes(x=., y=Freq)) + geom_bar(stat="identity",
                                                   width=0.6,
                                                   fill="indianred1") + theme_minimal() + labs(title="Number of records by year",
                                                                                         x="Year", y="Frequetion")
ggsave("results/recordsByYear.png",
        width=600,
        height=400,
        bg="white",
        dpi=72,
        units="px")

unique(ds$name)
polandAndNeigh<-ds$name=="Poland" | ds$name=="Russia" | ds$name=="Germany" | ds$name=="Ukraine" | ds$name=="Lithuania" | ds$name=="Czech Republic" | ds$name=="Belarus"  | ds$name=="Slovakia"
polandAndNeighDS<-ds[polandAndNeigh, c("date", "name", "dollar_price")]
names(polandAndNeighDS)<-c("Date", "Country", "dollarPrice")
polandAndNeighDS

ggplot(polandAndNeighDS, aes(x=Country, y=dollarPrice, fill=Country)) + geom_boxplot() + labs(title="Big Mac prices in Poland and its neighbors",
                                                                              x="Country",
                                                                              y="Price (dollar)") + theme_light() + theme(legend.position="left")
ggsave("results/pricesInPolandAndItsNeighbors.png",
       width=800,
       height=500,
       bg="white",
       dpi=72,
       units="px")

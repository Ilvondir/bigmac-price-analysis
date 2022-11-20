#install.packages("magrittr")
library(magrittr)

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
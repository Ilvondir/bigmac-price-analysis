#install.packages("draw")
library(draw)

drawSettings(pageWidth=12, pageHeight=10, units="inches")
drawPage()

drawBox(x=5.9,
        y=4.9,
        width=12.4,
        height=10.4,
        fillColor="#BD9460")

drawExport("results/Bigmac.png")

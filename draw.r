#install.packages("draw")
library(draw)

drawSettings(pageWidth=12, pageHeight=10, units="inches")
drawPage()

#Background
drawBox(x=5.9,
        y=4.9,
        width=12.4,
        height=10.4,
        fillColor="#005A00")

#Title
drawText(6, 9,
         text="My Bigmac",
         color="#009A00",
         face="bold",
         size=92)

drawBox(6, 2,
        width=6,
        height=1,
        fillColor="#C68958",
        lineColor="#C68958",
        radius=0.2)

drawExport("results/Bigmac.png")

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

#Down roll
drawBox(6, 2,
        width=6,
        height=1,
        fillColor="#C68958",
        lineColor="#C68958",
        radius=0.2)

#Down lettuce
drawBox(6, 2.5,
        width=6.21,
        height=0.05,
        fillColor="green",
        lineColor="green",
        radius=0.05)

#Down cheese
drawBox(6, 2.58,
        width=5.9,
        height=0.1,
        fillColor="#FBDB65",
        lineColor="#FBDB65",
        radius=0.05)

#Down meat
drawBox(6, 2.925,
        width=5.9,
        height=0.6,
        fillColor="#562807",
        lineColor="#562807",
        radius=0.2)

#Center roll
drawBox(6, 3.65,
        width=6,
        height=0.85,
        fillColor="#C68958",
        lineColor="#C68958",
        radius=0.2)

#Upper lettuce
drawBox(6, 4.1,
        width=6.05,
        height=0.05,
        fillColor="green",
        lineColor="green",
        radius=0.05)

#Upper cheese
drawBox(6, 4.175,
        width=5.9,
        height=0.1,
        fillColor="#FBDB65",
        lineColor="#FBDB65",
        radius=0.05)

#Upper meat
drawBox(6, 4.526,
        width=5.9,
        height=0.6,
        fillColor="#562807",
        lineColor="#562807",
        radius=0.2)

#Upper roll
drawBox(6, 5.3,
        width=6,
        height=1,
        fillColor="#C68958",
        lineColor="#C68958",
        radius=0.3)
drawBox(6, 5.5,
        width=6,
        height=1,
        fillColor="#C68958",
        lineColor="#C68958",
        radius=0.5)

#Seeds
drawBox(6, 5.5,
        width=0.2,
        height=0.1,
        fillColor="lightyellow",
        lineColor="lightyellow",
        radius=0.05)

drawExport("results/Bigmac.png")
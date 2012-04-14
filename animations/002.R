library('NRart')
png('002-%03d.png')

nr.movie((x^3 - 1) * (1-cos(t)) + (x^5 - 1) * (1+cos(t)),
         't', seq(0, 2*pi, length=121)[-1],
         steps=30, points=400, zoom=3,
         col=rainbow(256), zlim=c(-pi, pi))

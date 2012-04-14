library('NRart')
png('001-%03d.png')

nr.movie(x^3 + .28 * tan(x + t) + cos(x + 2*t)*.3i - 0.7,
         't', seq(0, pi, length=121)[-1],
         extent=1, steps=3, points=400,
         col=rainbow(256), zlim=c(-pi, pi))

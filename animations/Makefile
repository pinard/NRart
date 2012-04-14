all: $(addsuffix .mpg, $(basename $(wildcard *.R)))

%.mpg: %.R
	R < $<
	convert -delay 4 $*-*.png $@
	convert -resize 120x120 -delay 20 $*-*[05].png thumb-$*.gif
	convert $*-001.mpg -resize 120x120 thumb-$*.png
	rm $*-*.png
	xine >/dev/null 2>&1 --no-logo --no-splash --hide-gui --loop $@ &

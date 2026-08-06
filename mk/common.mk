.DELETE_ON_ERROR:
.NOTPARALLEL:

GNUPLOT = gnuplot
FLATTEN_TO_PNG = zsh $(realpath ../bin/flatten-to-png)

%.svg: %.gp
	$(GNUPLOT) $(<)

%.png: %.svg
	$(FLATTEN_TO_PNG) $(<)

.PHONY: default all clean
default: all
all:: $(VISUALIZATIONS:%=%.svg)
all:: $(VISUALIZATIONS:%=%.png)
clean::
	-rm -f $(VISUALIZATIONS:%=%.svg)
clean::
	-rm -f $(VISUALIZATIONS:%=%.png)

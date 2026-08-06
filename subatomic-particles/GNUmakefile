.DELETE_ON_ERROR:
.DEFAULT_GOAL := default

GNUPLOT = gnuplot
FLATTEN_TO_PNG = zsh $(realpath ../bin/flatten-to-png)

%.svg: %.gp
	$(GNUPLOT) $(<)

%.png: %.svg
	$(FLATTEN_TO_PNG) $(<)

VISUALIZATIONS =
VISUALIZATIONS += electron_core
VISUALIZATIONS += proton_core
VISUALIZATIONS += neutron_core

.PHONY: default all clean
default: all
all:: $(VISUALIZATIONS:%=%.svg)
all:: $(VISUALIZATIONS:%=%.png)
clean::
	-rm -f $(VISUALIZATIONS:%=%.svg)
clean::
	-rm -f $(VISUALIZATIONS:%=%.png)

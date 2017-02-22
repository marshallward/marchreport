IMGEXT=png
IMGS=$(shell find figs -name "*.svg")
ODT_IMGS=$(addsuffix .png,$(basename $(IMGS)))

all: mom5_arch.docx mom5_pio.docx cm2_scaling.docx

html: march2017.txt
	rst2html $< out.html

pdf: march2017.txt
	pandoc -f rst -t latex -o out.pdf $<

%.odt: %.txt $(ODT_IMGS)
	# Modify graphics extensions
	sed -re "s/(^\.\. image:: .*).svg/\1.$(IMGEXT)/g" $< > tmp.txt
	rst2odt --no-sections --create-links --stylesheet=nci.odt tmp.txt out.odt && \
		rm -f tmp.txt

%.docx: %.txt $(ODT_IMGS)
	sed -re "s/(^\.\. image:: .*).svg/\1.$(IMGEXT)/g" $< > tmp.txt
	pandoc -f rst -t docx --reference-docx=fujistu.docx -o $@ tmp.txt && \
		rm -rf tmp.txt

%.$(IMGEXT): %.svg
	convert $^ $(basename $^).$(IMGEXT)

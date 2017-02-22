IMGEXT=png
IMGS=$(shell find figs -name "*.svg")
DOCIMGS=$(addsuffix .png,$(basename $(IMGS)))

html: march2017.txt
	rst2html $< out.html

pdf: march2017.txt
	pandoc -f rst -t latex -o out.pdf $<

docx: march2017.txt
	pandoc -f rst -t docx -o ben.docx $<

odt: cm2_scaling.txt $(DOCIMGS)
	# Modify graphics extensions
	sed -re "s/(^\.\. image:: .*).svg/\1.$(IMGEXT)/g" $< > tmp.txt
	rst2odt --create-links --stylesheet=nci.odt tmp.txt out.odt

%.$(IMGEXT): %.svg
	convert $^ $(basename $^).$(IMGEXT)

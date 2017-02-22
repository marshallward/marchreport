IMGEXT=png
IMGS=$(shell find figs -name "*.svg")
ODT_IMGS=$(addsuffix .png,$(basename $(IMGS)))

html: march2017.txt
	rst2html $< out.html

pdf: march2017.txt
	pandoc -f rst -t latex -o out.pdf $<

docx: march2017.txt
	pandoc -f rst -t docx -o ben.docx $<

odt: cm2_scaling.txt $(ODT_IMGS)
	# Modify graphics extensions
	sed -re "s/(^\.\. image:: .*).svg/\1.$(IMGEXT)/g" $< > tmp.txt
	rst2odt --no-sections --create-links --stylesheet=nci.odt tmp.txt out.odt

docx: cm2_scaling.txt $(ODT_IMGS)
	sed -re "s/(^\.\. image:: .*).svg/\1.$(IMGEXT)/g" $< > tmp.txt
	pandoc -f rst -t docx --reference-docx=fujistu.docx -o out.docx tmp.txt

%.$(IMGEXT): %.svg
	convert $^ $(basename $^).$(IMGEXT)

html: march2017.txt
	rst2html $< out.html

pdf: march2017.txt
	pandoc -f rst -t latex -o out.pdf $<

docx: march2017.txt
	pandoc -f rst -t docx -o ben.docx $<

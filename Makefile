quick:
	lualatex -shell-escape --output-directory=auxiliary dossier.tex
	mv auxiliary/dossier.pdf .

dossier:
	lualatex -shell-escape --output-directory=auxiliary dossier.tex
	biber auxiliary/dossier
	#bibtex auxiliary/dossier.aux
	#bibtex auxiliary/journaux.aux
	#bibtex auxiliary/conferences.aux
	#bibtex auxiliary/ouvrages.aux
	#bibtex auxiliary/review.aux
	lualatex -shell-escape --output-directory=auxiliary dossier.tex
	lualatex -shell-escape --output-directory=auxiliary dossier.tex
	mv auxiliary/dossier.pdf .

clean:
	rm -f auxiliary/*

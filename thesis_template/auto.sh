ls *.tex *.sty | entr -s "rm thesis.aux; timeout 5 pdflatex --shell-escape thesis.tex"
#ls *.tex *.sty | entr -s "timeout 10 make"

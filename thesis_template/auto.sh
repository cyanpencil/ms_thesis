ls *.tex *.sty | entr -s "timeout 5 pdflatex --shell-escape thesis.tex"
#ls *.tex *.sty | entr -s "timeout 10 make"

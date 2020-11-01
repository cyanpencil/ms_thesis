ls *.tex *.sty | entr -s "timeout 5 pdflatex --shell-escape thesis.tex"

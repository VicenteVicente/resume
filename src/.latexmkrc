# latexmk settings, read when latexmk runs in src/ (the Makefile, CI and
# editors all do). A bare `latexmk` builds both CVs; resume.tex and preamble.tex
# are not standalone documents, so they are never compiled on their own.
@default_files = ('Vicente_Calisto_Resume_EN.tex', 'Vicente_Calisto_Resume_ES.tex');
$pdf_mode = 1;           # pdfLaTeX
$out_dir  = '../build';  # PDFs and auxiliary files go to build/, keeping src/ clean

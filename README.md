# Vicente Calisto — Resume

My resume in English and Spanish, built from one LaTeX source.

**Latest PDF:**
[English](https://github.com/VicenteVicente/resume/releases/download/latest/Vicente_Calisto_Resume_EN.pdf) ·
[Español](https://github.com/VicenteVicente/resume/releases/download/latest/Vicente_Calisto_Resume_ES.pdf)

## Editing

All the content is in [`src/resume.tex`](src/resume.tex). Each piece of text is written in both languages side by side:

```latex
\tr{English text}{Texto en español}
```

## Building

Install LaTeX (Debian/Ubuntu):

```bash
sudo apt install make latexmk texlive-latex-extra texlive-lang-spanish lmodern
```

Then:

```bash
make            # build both PDFs into build/
make en         # English only
make es         # Spanish only
make watch      # rebuild English on every save (make watch LANG_=ES for Spanish)
make check      # build, then fail if either PDF is longer than one page
make clean      # remove auxiliary files, keep the PDFs
make distclean  # remove build/
```

## Automatic builds

Every push to `main` builds both PDFs on GitHub Actions and updates the download links above.
The build fails if either resume is longer than one page.

## Credits

Layout based on [Jake Gutierrez's resume template](https://github.com/jakegut/resume) (MIT).

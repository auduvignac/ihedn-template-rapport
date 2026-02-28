# latexmkrc
$interaction = 'nonstopmode';
$halt_on_error = 1;

# This template is XeLaTeX-only (fontspec + system fonts).
# If LATEXMK_ENGINE is provided, only "xelatex" is accepted.
my $engine = $ENV{'LATEXMK_ENGINE'};
if (defined $engine && $engine ne 'xelatex') {
  die "ERROR: This project only supports XeLaTeX.\n" .
      "Set LATEXMK_ENGINE=xelatex (or unset it) and rerun latexmk.\n";
}

$xelatex = 'xelatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
$pdf_mode = 5;
# Compatibility: `latexmk -pdf` still runs XeLaTeX.
$pdflatex = $xelatex;

# Fail fast with a clear message if XeLaTeX is missing.
if (system('xelatex --version > /dev/null 2>&1') != 0) {
  die "ERROR: XeLaTeX is required but 'xelatex' was not found in PATH.\n" .
      "Install TeX Live XeTeX and retry (example: texlive-xetex).\n";
}

# Nettoyage additionnel
$clean_ext .= ' synctex.gz';

# Dossier de sortie (optionnel)
# $out_dir = 'build';

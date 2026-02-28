# latexmkrc
$interaction = 'nonstopmode';
$halt_on_error = 1;

# This template is XeLaTeX-only (fontspec + system fonts), regardless of
# latexmk command-line engine switches.
my @forbidden_switches = grep {
  /^-(?:pdflua|lualatex|pdfdvi|pdfps|dvi|ps)\b/
} @ARGV;
if (@forbidden_switches) {
  warn "WARNING (ihedn): XeLaTeX-only template.\n" .
       "Ignoring latexmk switch(es): " . join(', ', @forbidden_switches) . "\n" .
       "Forcing XeLaTeX configuration from latexmkrc.\n";
}

# This template is XeLaTeX-only (fontspec + system fonts).
# If LATEXMK_ENGINE is provided, only "xelatex" is accepted.
my $engine = $ENV{'LATEXMK_ENGINE'};
if (defined $engine && $engine ne 'xelatex') {
  warn "WARNING (ihedn): XeLaTeX-only template.\n" .
       "Ignoring LATEXMK_ENGINE='$engine' and forcing XeLaTeX.\n";
  $ENV{'LATEXMK_ENGINE'} = 'xelatex';
}

my $shell_escape = $ENV{'LATEXMK_SHELL_ESCAPE'} // '1';
my $shell_escape_flag = '';
if ($shell_escape =~ /^(?:1|true|yes|on)$/i) {
  $shell_escape_flag = '-shell-escape ';
}
elsif ($shell_escape =~ /^(?:0|false|no|off)$/i) {
  warn "WARNING (ihedn): LATEXMK_SHELL_ESCAPE disabled; SVG logos require shell escape.\n";
}
else {
  warn "WARNING (ihedn): Unrecognized LATEXMK_SHELL_ESCAPE='$shell_escape'; defaulting to enabled.\n";
  $shell_escape_flag = '-shell-escape ';
}

$xelatex = "xelatex ${shell_escape_flag}-synctex=1 -file-line-error %O %S";
$pdf_mode = 5;
# Compatibility: `latexmk -pdf` still runs XeLaTeX.
$pdflatex = $xelatex;
# Compatibility: if tooling forces LuaLaTeX modes/switches, still run XeLaTeX.
$lualatex = $xelatex;

# Fail fast with a clear message if XeLaTeX is missing.
sub cover_has_xelatex {
  my $pid = open(my $fh, '-|', 'xelatex', '--version');
  return 0 if !defined $pid;
  while (<$fh>) { } # consume output quietly
  close $fh;
  return $? == 0;
}

if (!cover_has_xelatex()) {
  die "ERROR: XeLaTeX is required but 'xelatex' was not found in PATH.\n" .
      "Install TeX Live XeTeX and retry (example: texlive-xetex).\n";
}

# Nettoyage additionnel
$clean_ext .= ' synctex.gz';

# Dossier de sortie (optionnel)
# $out_dir = 'build';

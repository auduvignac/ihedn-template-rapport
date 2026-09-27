# ihedn-template-rapport

Template relatif à la rédaction d'un rapport de comité IHEDN

## Arborescence

- `main.tex` : démonstration complète et document de validation du template ;
- `cover-template.tex` : définition partagée de la page de garde du template ;
- `cover-example.tex` : document autonome générant l'exemple de page de garde ;
- `ihedn-cover.sty` : mise en forme de la couverture ;
- `ihedn-report.sty` : mise en forme commune des rapports ;
- `Figures/` : ressources graphiques ;
- `reference/` : documents méthodologiques et rendus de référence ;
- `documents/crises-majeures/` : rapport « Crises majeures » et ses ressources ;
- `vendor/biblatex-sciences-po-fr/` : style bibliographique externe.

## Compilation

### Template

La page de garde autonome est compilée en premier, puis réutilisée par le
document principal :

```bash
LATEXMK_SHELL_ESCAPE=0 latexmk -pdf -outdir=reference \
  -jobname=page-de-garde cover-example.tex
LATEXMK_SHELL_ESCAPE=0 latexmk -pdf main.tex
```

Ces commandes produisent respectivement `reference/page-de-garde.pdf` et
`main.pdf`. `main.tex` et `cover-example.tex` utilisent tous deux la définition
de `cover-template.tex` ; la page incluse dans la démonstration est donc la
couverture exacte du template, sans dépendance circulaire.

### Rapport « Crises majeures »

Depuis la racine du dépôt :

```bash
cd documents/crises-majeures
LATEXMK_SHELL_ESCAPE=0 latexmk -pdf crises_majeures.tex
```

Le rapport utilise les liens symboliques présents dans son répertoire pour
accéder à `ihedn-cover.sty`, `ihedn-report.sty`, `latexmkrc` et `vendor/`,
partagés avec le
template. Le PDF est généré dans
`documents/crises-majeures/crises_majeures.pdf`.

## Nettoyage des fichiers temporaires

Pour le template :

```
LATEXMK_SHELL_ESCAPE=0 latexmk -c main.tex
```

Pour le rapport « Crises majeures », depuis son répertoire :

```bash
LATEXMK_SHELL_ESCAPE=0 latexmk -c crises_majeures.tex
```

## Dépendance bibliographique

`biblatex-sciences-po-fr` est intégré sous forme de **Git subtree** avec un
historique condensé (`--squash`). Ses fichiers sont donc inclus dans le dépôt :
un clone classique suffit, sans initialisation de sous-module.

Pour rapatrier la dépendance dans une nouvelle arborescence :

```bash
git subtree add --prefix=vendor/biblatex-sciences-po-fr \
  https://github.com/auduvignac/biblatex-sciences-po-fr.git main --squash
```

Pour mettre à jour la copie déjà présente :

```bash
git subtree pull --prefix=vendor/biblatex-sciences-po-fr \
  https://github.com/auduvignac/biblatex-sciences-po-fr.git main --squash
```

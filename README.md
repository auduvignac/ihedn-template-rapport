# ihedn-template-rapport

Template relatif à la rédaction d'un rapport de comité IHEDN

## Arborescence

- `main.tex` : document principal ;
- `ihedn-cover.sty` : mise en forme de la couverture ;
- `Figures/` : ressources graphiques ;
- `reference/` : document de référence ;
- `vendor/biblatex-sciences-po-fr/` : style bibliographique externe.

## Compilation

```
LATEXMK_SHELL_ESCAPE=0 latexmk -pdf main.tex
```

## Nettoyage des fichiers temporaires

```
LATEXMK_SHELL_ESCAPE=0 latexmk -c main.tex
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

Vous pouvez aussi accéder l'exercice à partir de mon GitHub :

https://github.com/luisanb/workonXML


#### CONSIGNES DE L'EXERCICE :

A partir du fichier (tournesol.xml) contenant des informations statistiques sur les surfaces, productions et rendements en tournesol par département en France, vous devez établir un tableau synthétique des chiffres cumulés par régions et pour le pays pour l'année 2022.

Les chiffres du fichier sont exprimées dans les unités suivantes
- pour les surfaces: en hectare
- pour la production: en tonnes
- pour les rendements: en quintaux par hectare (une tonne = 10 quintaux). Attention on ne dispose pas cette information pour tous les départements mais dans tous les cas cette information peut être déduite des informations surfaces et production

Les liens entre les départements et les régions sont à chercher dans le fichier correspondancesDepartementRegion.xml

- Les régions (lignes du tableau) doivent être triées par ordre décroissant du chiffre de leur production
- La ligne de la région de meilleure rendement doit être écrite en gras
- Les lignes des régions dont le rendement a progressé depuis 2021 doivent être surlignées de couleur lightgreen
- Les lignes  des régions dont le rendement a diminué depuis 2021 doivent être surlignées de couleur lightpink

Quelques conseils:
- n'hésitez pas à définir des variables intermédiaires pour vous faciliter les calculs
- séparez le code pour le calcul des cumuls par région du code pour la création du tableau présentant ces chiffres
- donner des noms explicites aux variables et aux templates
- si vous devez faire le même calcul pour une année et pour une autre, isolez le code du calcul dans une fonction ou une template et passez l'année en paramètre

Le tableau synthétique à produire devra être formaté en HTML

Région               | Surface (ha) | Production (tonne) | Rendement (tonne/ha)
-------------------- | ------------ | ------------------ | ---------------------
Auvergne-Rhône-Alpes | 112812       | 44215              | 25.51
Pays de la Loire     |
...
-----------------
Total National       |

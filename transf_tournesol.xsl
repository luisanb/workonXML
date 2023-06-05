<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>
  
  
  <!-- Création des variables pour le doc secondaire -->
  <xsl:variable name="doc2" select="document('correspondancesDepartementRegion.xml')"/>
  <xsl:key name="region-key" match="ligne" use="@region" />


  <!-- Template principal qui va contenir la table et qui va
   récupérer les données et les calculs dans d'autres templates -->
  <xsl:template match="/">
    
    <!-- Table HTML et ses spécifications -->
    <html>
      <head>
        <title>Tableau synthétique des chiffres cumulés de la production de tournesol par région en
          France en 2022</title>
        <style>
          table {
          width: 50%;
          }
          th, td {
          text-align: left;
          padding: 10px;
          }
          th {
          background-color: #fce4ec;
          }
          <!-- Dans les prochaines lignes les surlignés effectués 
            sur la comparaison entre les chiffres de 2022 et 2021 -->
          .diminution {
          background-color: lightpink;
          }
          .progression {
          background-color: lightgreen;
          }
        </style>
      </head>
      <body>
        <h2>Chiffres cumulés de tournesol par région française en 2022</h2>
        <table>
          <tr>
            <th>Région</th>
            <th>Production (tonne)</th>
            <th>Surface (ha)</th>
            <th>Rendement (quintaux/ha)</th>
          </tr>
          
          
          <!-- Application du template où les calculs ont été faits -->
          <xsl:apply-templates select="//departement">
            <!-- Organisation de la table en ordre décroissant -->
            <xsl:sort select="tournesol[@annee = '2022']/production" order="descending"
              data-type="number"/>
          </xsl:apply-templates>
          

          <tr>
            <!-- Calcul des chiffres totaux pour la France en 2022 -->
            <th>Total France</th>
            <td>
              <xsl:value-of select="sum(//departement/tournesol[@annee = '2022']/production)"/>
            </td>
            <td>
              <xsl:value-of select="sum(//departement/tournesol[@annee = '2022']/surface)"/>
            </td>
            <td>
              <xsl:value-of select="sum(//departement/tournesol[@annee = '2022']/rendement)"/>
            </td>
          </tr>
        </table>
      </body>
    </html>
  </xsl:template>
  

  <!-- Template des calculs -->
  <xsl:template match="departement">
    
    <!-- Création des variables -->
    <xsl:variable name="departement" select="."/>
    <xsl:variable name="region" select="$doc2//ligne[@code_departement = $departement/@code]/@region"/>
    <xsl:variable name="rendement" select="(tournesol[@annee = '2022']/rendement)"/>
    <xsl:variable name="rendement2021" select="(tournesol[@annee = '2021']/rendement)"/>
    <xsl:variable name="production" select="(tournesol[@annee = '2022']/production)"/>
    <xsl:variable name="producao2021" select="(tournesol[@annee = '2021']/production)"/>
    <xsl:variable name="surface" select="(tournesol[@annee = '2022']/surface)"/>

    <!-- Rassemblement des lignes qui parlent de la même région -->
    <xsl:for-each select="//ligne[generate-id() = generate-id(key('region-key', @region)[1])]">      
      <tr>
        <!-- Calculs effectués sur le rendement de 2022 :
        1. mettre en gras la région de plus grand rendement
        2. mettre en lightpink la région qui a eu une diminution par rapport à 2021
        3. mettre en lightgreen la région qui a eu une hausse. -->
        <xsl:choose>
          <xsl:when
            test="$rendement = //departement/tournesol[@annee = '2022']/rendement[not(. &lt; //departement/tournesol[@annee = '2022']/rendement)]">
            <xsl:attribute name="style">font-weight: bold;</xsl:attribute>
          </xsl:when>
          <xsl:when test="$rendement &lt; $rendement2021">
            <xsl:attribute name="class">diminution</xsl:attribute>
          </xsl:when>
          <xsl:when test="$rendement &gt; $rendement2021">
            <xsl:attribute name="class">progression</xsl:attribute>
          </xsl:when>
        </xsl:choose>
        
        <td>
          <xsl:value-of select="$region"/>
        </td>
        <td>
          <xsl:value-of select="sum($production)"/>
        </td>
        <td>
          <xsl:value-of select="sum($surface)"/>
        </td>
        <td>
          <!-- Lorsque le rendement n'est pas présent dans le fichier
          On le calcule à partir de la formule : 10 x tonnes (quintaux) par hectare -->
          <xsl:choose>
            <xsl:when test="sum($rendement)">
              <xsl:value-of select="sum($rendement)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:variable name="newrendement" select="10 * $production div $surface"/>
              <xsl:value-of select="sum($newrendement + $rendement)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
      </tr>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>

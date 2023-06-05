<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes" />
  
  <xsl:key name="departement-key" match="departement" use="@code" />
  <xsl:key name="region-key" match="ligne" use="@region" />
  <xsl:variable name="doc2" select="document('correspondancesDepartementRegion.xml')"/>
  
  <xsl:template match="/">
    <html>
      <head>
        <title>Tableau synthétique des chiffres cumulés de la production de tournesol par région en France en 2022</title>
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
          		.dim {
            		background-color: lightpink;
          		}
          		.prog {
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
	  
          <xsl:apply-templates select="//departement">
  		<xsl:sort select="tournesol[@annee='2022']/production" order="descending" data-type="number" />
	  </xsl:apply-templates>
          
          <tr>
            <th>Total France</th>
            <td>
              <xsl:value-of select="sum(//departement/tournesol[@annee='2022']/production)" />
            </td>
            <td>
              <xsl:value-of select="sum(//departement/tournesol[@annee='2022']/surface)" />
            </td>
            <td>
              <xsl:value-of select="sum(//departement/tournesol[@annee='2022']/rendement)" />
            </td>
          </tr>
        </table>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="departement">
    <xsl:variable name="departement" select="." />
    <xsl:variable name="region" select="$doc2//ligne[@code_departement=$departement/@code]/@region" />    
    <xsl:variable name="rendement" select="(tournesol[@annee='2022']/rendement)" />
    <xsl:variable name="rendement2021" select="(tournesol[@annee='2021']/rendement)" />
    <xsl:variable name="production" select="(tournesol[@annee='2022']/production)" />
    <xsl:variable name="producao2021" select="(tournesol[@annee='2021']/production)" />
    <xsl:variable name="surface" select="(tournesol[@annee='2022']/surface)" />
  
    
    <tr>
      <xsl:choose>
	<xsl:when test="$rendement=//departement/tournesol[@annee='2022']/rendement[not(. &lt; //departement/tournesol[@annee='2022']/rendement)]">
      	     <xsl:attribute name="style">font-weight: bold;</xsl:attribute>
	</xsl:when>
	<xsl:when test="$rendement &lt; $rendement2021">
             <xsl:attribute name="class">dim</xsl:attribute>
	</xsl:when>
	<xsl:when test="$rendement &gt; $rendement2021">
             <xsl:attribute name="class">prog</xsl:attribute>
	</xsl:when>
      </xsl:choose>
      <td>
        <xsl:value-of select="$region" />
      </td>
      <td>
        <xsl:value-of select="$production" />
      </td>
      <td>
        <xsl:value-of select="$surface" />
      </td>
      <td>
	<xsl:choose>
        	<xsl:when test="$rendement">
    			<xsl:value-of select="$rendement" /> 
                </xsl:when>
                <xsl:otherwise>
		    <xsl:variable name="newrendement" select="10 * $production div $surface" />
                    <xsl:value-of select="$newrendement" />
            </xsl:otherwise>
         </xsl:choose>
      </td>
    </tr>
   
  </xsl:template>
  
</xsl:stylesheet>
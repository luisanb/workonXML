<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/">        
        
        <!-- On récupere les informations concernant la production, la surface et le rendement en 2022 -->
        <xsl:variable name="doc2_code" select="document('correspondancesDepartementRegion.xml')//ligne"/>
            
            <xsl:for-each select="//departement/tournesol[@annee='2022']">
                <xsl:variable name="infos" select="."/>
                
                <!-- Rassembler les départements dans les régions -->
                <xsl:choose>
                    <xsl:when test="$doc2_code = @code">
                        <xsl:value-of select="@region"/>
                    </xsl:when>
                </xsl:choose>
                
                
                
                
                
                
                
                <!-- On met les données en ordre décroissante, on veut le plus rentable d'abord -->
                <xsl:sort select="rendement" order="descending"/>
                
                <!-- Pour les cas où le rendement n'apparaît pas, on fait des calculs -->
                <xsl:choose>
                    <xsl:when test="rendement">
                     
                    </xsl:when>                    
                </xsl:choose>
                
                                           
                
                <tr>
                    <td><xsl:value-of select="tableau/ligne[@code_departement=current()/@code]/@region" /></td>
                    <td><xsl:value-of select="tournesol[@annee='2022']/surface"/></td>
                    <td><xsl:value-of select="tournesol[@annee='2022']/production"/></td>
                    <td><xsl:value-of select="tournesol[@annee='2022']/rendement"/></td>
                </tr>
                
            </xsl:for-each>
            
       
        
        
        
        <!-- Affichage en HTML -->
        <html>
            <head>
                <meta charset="utf-8"/>
                <title>Table du rendement de tournesol dans les régions françaises en 2022</title>
            </head>
            
            <body>
                <h1>Table du rendement de tournesol dans les régions françaises en 2022</h1>
                
                    <table border="1" style="width:100%;">
                        <tr>
                            <th>Régions</th>
                            <th>Production (tonne)</th>                                
                            <th>Surface (ha)</th>                                
                            <th>Rendement (tonne/ha)</th>
                        </tr>
                        <xsl:for-each select="/data/departement/tournesol">
                            <tr>
                                <td><xsl:value-of select="../departement"/></td>                              
                                <td><xsl:value-of select="surface"/></td>
                                <td><xsl:value-of select="production"/></td>                                
                                <td><xsl:value-of select="rendement"/></td>
                            </tr>
                        </xsl:for-each>
                    </table>
                
            </body>
            
        </html>
        
    </xsl:template>
    
   
    
</xsl:stylesheet>

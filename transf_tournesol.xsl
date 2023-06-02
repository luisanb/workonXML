<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <xsl:output method="html" indent="yes"/>
    
    <xsl:template match="/">        
        
        <!-- Affichage en HTML -->
        <html>
            <head>
                <meta charset="utf-8"/>
                <title>Table du rendement de tournesol dans les régions françaises en 2022</title>
            </head>
            
            <body>
                <h1>Table du rendement de tournesol dans les régions françaises en 2022</h1>
                
                <table border="1" style="width:50%;">
                    <tr>
                        <th>Régions</th>
                        <th>Production (tonne)</th>                                
                        <th>Surface (ha)</th>                                
                        <th>Rendement (tonne/ha)</th>
                    </tr>  
                    
                    <!-- On récupere les informations concernant la production, la surface et le rendement en 2022 -->
                    <xsl:variable name="doc2" select="document('correspondancesDepartementRegion.xml')//ligne"/>
                    
                    <xsl:for-each select="//departement[@code]">                            
                        <tr>
                            <xsl:variable name="code" select="."/>
                            
                            <!-- Rassembler les départements dans les régions -->
                            <xsl:choose>
                                <xsl:when test="$doc2[@code_departement] = $code">
                                    <td><xsl:value-of select="@region"/></td>
                                </xsl:when>
                            </xsl:choose>
                            
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

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    version="2.0">
    
    <xsl:output indent="yes" method="html"/>
    <xsl:variable name="term" select="'chant'"/>
	<xsl:variable name="max" select="40"/>
    
    <xsl:template match="/">
        
        <!-- Tokenisation de toutes les lignes -->
        <xsl:variable name="tokens">
            <xsl:for-each select="//tei:text//tei:p/lower-case(.)[contains(., $term)]">
                <xsl:variable name="str" select="normalize-space(.)"/>
                <xsl:for-each select="tokenize($str, '\.')[not(.='')]">
                    <phrase>
                       <xsl:for-each select="tokenize(., '[\W]')[not(.='')]">
                           <mot>
                               <xsl:value-of select="."/>
                           </mot>
                       </xsl:for-each>
                   </phrase>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        
        <!-- Contextes des occurrences -->
        <xsl:variable name="contextes">
            <xsl:for-each select="distinct-values($tokens//mot[starts-with(., $term)])">
                <xsl:variable name="w" select="."/>
                <xsl:for-each select="$tokens//phrase/mot[.=$w]">
                    <occurrence left="{preceding-sibling::mot}" pivot="{$w}" right="{following-sibling::mot}"/>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        

        <!-- Tri des occurrences -->
        <xsl:variable name="concordancier">
            <xsl:for-each select="$contextes/occurrence">
                <xsl:sort select="@pivot"/>
                <xsl:sort select="@right"/>
                <xsl:sort select="codepoints-to-string(reverse(string-to-codepoints(@left)))"/>
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </xsl:variable>
                 
        <!-- Affichage en HTML -->
       <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>Titre</title>
            </head>
            <body>
                <table>
                    <xsl:for-each select="$concordancier/occurrence">
                        <tr>
                            <td style="text-align:right"><xsl:value-of select="substring(@left, string-length(@left)-$max)"/></td>
                            <td><xsl:value-of select="@pivot"/></td>
                            <td><xsl:value-of select="substring(@right, 1, $max)"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
        
    </xsl:template>
</xsl:stylesheet>
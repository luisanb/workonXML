<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:variable name="elements"/>
    <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
            <title>Tournesol</title>
        </head>
        <body>
            <table>
                <xsl:for-each select="$nom">
                    <tr>
                        <td><xsl:value-of select="$nom"/></td>
                    </tr>
                </xsl:for-each>
            </table>
        </body>
    </html>
</xsl:stylesheet>
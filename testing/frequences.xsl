<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    version="2.0">
    
    <xsl:output indent="yes" method="xml"/>
    
    <xsl:template match="/">
        
        <!-- Tokenisation en caractères -->
        <xsl:variable name="tokens">
            <xsl:for-each select="//tei:text//tei:p">
                <xsl:for-each select="tokenize(lower-case(.), '\W')">
                    <xsl:for-each select="string-to-codepoints(.)">
                        <token>
                            <xsl:value-of select=" codepoints-to-string(.) "/>
                        </token>
                    </xsl:for-each>
                </xsl:for-each>
             </xsl:for-each>
        </xsl:variable>
       
        <!-- Liste des caracteres avec leurs comptages -->
        <xsl:variable  name="chars">
            <xsl:for-each select="distinct-values($tokens/token)">
                <xsl:variable name="c" select="."/>
                <char count="{count($tokens//token[.=$c])}" label="{.}"/>
            </xsl:for-each>
        </xsl:variable>
        
        <!-- Tri -->
        <xsl:variable name="total" select="sum($chars/char/@count)"/>
        <xsl:variable  name="chars_tries">
            <xsl:for-each select="$chars/char">
                <xsl:sort order="descending" select="@count" data-type="number"/>
                <char>
                    <xsl:copy-of select="@*"/>
                    <xsl:attribute name="frequence" select="format-number(@count div $total * 100, '#9.99')"/>
                    <xsl:value-of select="."/>
                </char>
            </xsl:for-each>
        </xsl:variable>
        
        <result><xsl:copy-of select="$chars_tries"/><total><xsl:value-of select="$total"/></total></result>
    </xsl:template>
</xsl:stylesheet>
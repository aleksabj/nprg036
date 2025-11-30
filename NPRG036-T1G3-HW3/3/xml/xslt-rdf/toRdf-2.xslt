<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output method="text" encoding="UTF-8"/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="/">
@prefix ex:      &lt;http://example.org/vocabulary/&gt; .
@prefix data:    &lt;http://example.org/data/&gt; .
@prefix rdf:     &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#&gt; .
@prefix rdfs:    &lt;http://www.w3.org/2000/01/rdf-schema#&gt; .
@prefix xsd:     &lt;http://www.w3.org/2001/XMLSchema#&gt; .
@prefix schema:  &lt;http://schema.org/&gt; .

<xsl:text>&#10;</xsl:text>
<xsl:apply-templates select="people/person"/>
  </xsl:template>

  <xsl:template match="person">
&lt;<xsl:value-of select="@iri"/>&gt; a ex:<xsl:value-of select="substring-after(type, 'http://example.org/vocabulary/')"/> ;
  schema:name "<xsl:value-of select="name"/>"@en ;
  ex:birthYear "<xsl:value-of select="birthYear"/>"^^xsd:gYear ;
  ex:phone &lt;<xsl:value-of select="phone"/>&gt; ;
<xsl:choose>
  <xsl:when test="actsIn/movie">
  ex:actsIn &lt;<xsl:value-of select="actsIn/movie"/>&gt; .
  </xsl:when>
  <xsl:when test="directed/movie">
  ex:directs &lt;<xsl:value-of select="directed/movie"/>&gt; .
  </xsl:when>
</xsl:choose>

<xsl:text>&#10;&#10;</xsl:text>
  </xsl:template>

</xsl:stylesheet>

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
<xsl:apply-templates select="
  festivalSchedule/movies/movie |
  festivalSchedule/screenings/screening |
  festivalSchedule/places/place |
  festivalSchedule/awards/award"/>
  </xsl:template>

  <xsl:template match="movie">
&lt;<xsl:value-of select="@iri"/>&gt; a schema:Movie ;
  schema:name "<xsl:value-of select="name"/>"@<xsl:value-of select="name/@xml:lang"/> ;
  rdfs:label "<xsl:value-of select="label"/>"@<xsl:value-of select="label/@xml:lang"/> ;
  ex:durationMinutes <xsl:value-of select="durationMinutes"/> ;
  schema:datePublished "<xsl:value-of select="datePublished"/>"^^xsd:gYear .

<xsl:text>&#10;&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="screening">
&lt;<xsl:value-of select="@iri"/>&gt; a schema:ScreeningEvent ;
  schema:name "<xsl:value-of select="name"/>"@<xsl:value-of select="name/@xml:lang"/> ;
  rdfs:label "<xsl:value-of select="label"/>"@<xsl:value-of select="label/@xml:lang"/> ;
  schema:startDate "<xsl:value-of select="startDate"/>"^^xsd:dateTime ;
  schema:location &lt;<xsl:value-of select="locationRef/@iri"/>&gt; ;
  ex:showsFilm &lt;<xsl:value-of select="movieRef/@iri"/>&gt; .

<xsl:text>&#10;&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="place">
&lt;<xsl:value-of select="@iri"/>&gt; a schema:Place ;
  rdfs:label "<xsl:value-of select="label"/>"@<xsl:value-of select="label/@xml:lang"/> .

<xsl:text>&#10;&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="award">
&lt;<xsl:value-of select="@iri"/>&gt; a ex:Award ;
  schema:name "<xsl:value-of select="name"/>"@<xsl:value-of select="name/@xml:lang"/> ;
  rdfs:label "<xsl:value-of select="label"/>"@<xsl:value-of select="label/@xml:lang"/> ;
  ex:prizeMoney "<xsl:value-of select="prizeMoney"/>"^^xsd:decimal ;
  ex:awardedTo &lt;<xsl:value-of select="movieRef/@iri"/>&gt; .

&lt;<xsl:value-of select="movieRef/@iri"/>&gt; ex:hasAward &lt;<xsl:value-of select="@iri"/>&gt; .

<xsl:text>&#10;&#10;</xsl:text>
  </xsl:template>

</xsl:stylesheet>

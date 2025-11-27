<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">

    <xsl:output method="html" indent="yes" encoding="UTF-8" />

    <xsl:key name="kAwardsByMovie" match="award" use="movieRef/@iri" />
    <xsl:key name="kScreeningsByMovie" match="screening" use="movieRef/@iri" />
    <xsl:key name="kPlacesByIri" match="place" use="@iri" />

    <xsl:template match="/festivalSchedule">
        <html>
            <head>
                <title>Festival Program</title>
                <style>
                    body {
                    font-family: Times New Roman, sans-serif;
                    margin: 20px;
                    }
                    h1 {
                    color: #333;
                    }
                    table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-top: 20px;
                    }
                    th {
                    background-color: #ddd;
                    padding: 8px;
                    text-align: left;
                    border: 1px solid #999;
                    }
                    td {
                    border: 1px solid #999;
                    padding: 8px;
                    vertical-align: top;
                    }
                    ul {
                    margin: 0;
                    padding-left: 20px;
                    }
                    li {
                    margin-bottom: 4px;
                    }
                </style>
            </head>
            <body>
                <h1>Festival Program Schedule</h1>
                <p>Movie Screenings and Awards</p>

                <table>
                    <thead>
                        <tr>
                            <th>Movie</th>
                            <th>Details</th>
                            <th>Awards Won</th>
                            <th>Screenings</th>
                            <th>Place</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:apply-templates select="movies/movie">
                            <xsl:sort select="name" />
                        </xsl:apply-templates>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="movie">
        <tr>
            <td>
                <xsl:value-of select="name" />
            </td>
            <td>
                <xsl:value-of select="datePublished" />
                <br />
                <xsl:value-of select="durationMinutes" />
                mins </td>
            <td>
                <xsl:variable name="currentMovieIri" select="@iri" />
                <xsl:choose>
                    <xsl:when test="key('kAwardsByMovie', $currentMovieIri)">
                        <ul>
                            <xsl:apply-templates select="key('kAwardsByMovie', $currentMovieIri)" />
                        </ul>
                    </xsl:when>
                    <xsl:otherwise>
                        No awards
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td>
                <xsl:variable name="currentMovieIri" select="@iri" />
                <xsl:choose>
                    <xsl:when test="key('kScreeningsByMovie', $currentMovieIri)">
                        <ul>
                            <xsl:apply-templates
                                select="key('kScreeningsByMovie', $currentMovieIri)" mode="date" />
                        </ul>
                    </xsl:when>
                    <xsl:otherwise>
                        Not scheduled
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td>
                <xsl:variable name="currentMovieIri" select="@iri" />
                <xsl:choose>
                    <xsl:when test="key('kScreeningsByMovie', $currentMovieIri)">
                        <ul>
                            <xsl:apply-templates
                                select="key('kScreeningsByMovie', $currentMovieIri)" mode="place" />
                        </ul>
                    </xsl:when>
                    <xsl:otherwise>
                        -
                    </xsl:otherwise>
                </xsl:choose>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="award">
        <li>
            <xsl:value-of select="name" />
        </li>
    </xsl:template>

    <xsl:template match="screening" mode="date">
        <li>
            <xsl:value-of select="substring(startDate, 1, 10)" /> (<xsl:value-of
                select="substring(startDate, 12, 5)" />) </li>
    </xsl:template>

    <xsl:template match="screening" mode="place">
        <li>
            <xsl:value-of select="key('kPlacesByIri', locationRef/@iri)/label" />
        </li>
    </xsl:template>

</xsl:stylesheet>
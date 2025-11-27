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
                <title>Festival Program Dashboard</title>
                <style>
                    body {
                    font-family: 'Times New Roman';
                    margin: 2rem;
                    background: #f4f4f9;
                    color: #333;
                    }
                    h1 {
                    color: #2c3e50;
                    border-bottom: 3px solid #3498db;
                    padding-bottom: 10px;
                    display: inline-block;
                    }
                    .container {
                    background: white;
                    padding: 20px;
                    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                    border-radius: 8px;
                    }
                    table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-top: 20px;
                    }
                    th {
                    background-color: #2c3e50;
                    color: white;
                    padding: 12px;
                    text-align: left;
                    }
                    td {
                    border-bottom: 1px solid #ddd;
                    padding: 12px;
                    vertical-align: top;
                    }
                    tr:hover {
                    background-color: #f1f1f1;
                    }
                    .badge {
                    display: inline-block;
                    padding: 3px 8px;
                    border-radius: 12px;
                    font-size: 0.8em;
                    font-weight: bold;
                    }
                    .badge-year {
                    background-color: #e2e6ea;
                    color: #555;
                    }
                    .badge-money {
                    background-color: #d4edda;
                    color: #155724;
                    }
                    ul {
                    margin: 0;
                    padding-left: 20px;
                    }
                    li {
                    margin-bottom: 4px;
                    }
                    .screening-date {
                    font-weight: bold;
                    color: #e67e22;
                    }
                    .location {
                    font-style: italic;
                    color: #7f8c8d;
                    }
                </style>
            </head>
            <body>
                <div class="container">
                    <h1>Festival Program Schedule</h1>
                    <p>Generated Report: Movie Screenings and Awards</p>

                    <table>
                        <thead>
                            <tr>
                                <th style="width: 25%">Movie</th>
                                <th style="width: 15%">Details</th>
                                <th style="width: 30%">Awards Won</th>
                                <th style="width: 30%">Upcoming Screenings</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:for-each select="movies/movie">
                                <xsl:sort select="name" />

                                <tr>
                                    <td>
                                        <strong>
                                            <xsl:value-of select="name" />
                                        </strong>
                                        <br />
                                        <span style="color: #666; font-size: 0.9em;">
                                            <xsl:value-of select="label" />
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge badge-year">
                                            <xsl:value-of select="datePublished" />
                                        </span>
                                        <br />
                                        <span style="font-size: 0.9em;">
                                            <xsl:value-of select="durationMinutes" /> mins </span>
                                    </td>
                                    <td>
                                        <xsl:variable name="currentMovieIri" select="@iri" />
                                        <xsl:choose>
                                            <xsl:when test="key('kAwardsByMovie', $currentMovieIri)">
                                                <ul>
                                                    <xsl:for-each
                                                        select="key('kAwardsByMovie', $currentMovieIri)">
                                                        <li>
                                                            <xsl:value-of select="name" />
                                                            <br />
                                                            <span class="badge badge-money"> €<xsl:value-of
                                                                    select="prizeMoney" />
                                                            </span>
                                                        </li>
                                                    </xsl:for-each>
                                                </ul>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <em style="color: #aaa">No awards listed</em>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </td>
                                    <td>
                                        <xsl:choose>
                                            <xsl:when
                                                test="key('kScreeningsByMovie', $currentMovieIri)">
                                                <ul>
                                                    <xsl:for-each
                                                        select="key('kScreeningsByMovie', $currentMovieIri)">
                                                        <li>
                                                            <span class="screening-date">
                                                                <xsl:value-of
                                                                    select="substring(startDate, 1, 10)" />
                                                                (<xsl:value-of
                                                                    select="substring(startDate, 12, 5)" />
                                                                ) </span>
                                                            <br />
                                                            <span class="location"> @ <xsl:value-of
                                                                    select="key('kPlacesByIri', locationRef/@iri)/label" />
                                                            </span>
                                                        </li>
                                                    </xsl:for-each>
                                                </ul>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <em style="color: #aaa">Not scheduled</em>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </tbody>
                    </table>
                </div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
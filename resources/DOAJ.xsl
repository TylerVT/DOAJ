<?xml version="1.0" encoding="UTF-8"?>


<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="xsl">


    <xsl:output method="xml"
        indent="yes"
        encoding="UTF-8"
        omit-xml-declaration="no"/>


    <xsl:variable name="doi" select="article/front/article-meta/article-id[@pub-id-type='doi']"/>

    <xsl:template match="/">
        <xsl:call-template name="make-records"/>
    </xsl:template>


    <xsl:template name="make-records">
        <records>
            <xsl:call-template name="make-record"/>
        </records>
    </xsl:template>

    <xsl:template name="make-record">
        <record>
            <xsl:call-template name="language"/>
            <xsl:call-template name="publisher"/>
            <xsl:call-template name="journal-title"/>
            <xsl:call-template name="issn"/>
            <xsl:call-template name="publication-date"/>
            <xsl:call-template name="doi"/>
            <xsl:call-template name="publisher-record-id"/>
            <xsl:call-template name="document-type"/>
            <xsl:call-template name="title"/>
            <xsl:call-template name="authors"/>
            <xsl:call-template name="abstract"/>
            <xsl:call-template name="full-text-url"/>
            <xsl:call-template name="keywords"/>
        </record>
    </xsl:template>

    <xsl:template name="language">
        <language>eng</language>
    </xsl:template>

    <xsl:template name="publisher">
        <publisher>BioOne</publisher>
    </xsl:template>

    <xsl:template name="journal-title">
        <journalTitle>Elementa</journalTitle>
    </xsl:template>

    <xsl:template name="publication-date">
        <xsl:variable name="year" select="article/front/article-meta/pub-date/year"/>
        <xsl:variable name="month" select="article/front/article-meta/pub-date/month"/>
        <xsl:variable name="day" select="article/front/article-meta/pub-date/day"/>

        <xsl:choose>
            <xsl:when test="string-length(article/front/article-meta/pub-date/day) = 1">
                <publicationDate><xsl:value-of select="concat($year, '-', $month, '-0', $day)"/></publicationDate>
            </xsl:when>
            <xsl:otherwise>
                <publicationDate><xsl:value-of select="concat($year, '-', $month, '-',  $day)"/></publicationDate>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="issn">
        <issn>2325-1026</issn>
    </xsl:template>

    <xsl:template name="doi">
        <doi><xsl:value-of select="$doi"></xsl:value-of></doi>
    </xsl:template>

    <xsl:template name="publisher-record-id">
        <publisherRecordId>ELEMENTA-D-14-00003</publisherRecordId>
    </xsl:template>

    <xsl:template name="document-type">
        <documentType>article</documentType>
    </xsl:template>

    <xsl:template name="title">
        <title language="eng"><xsl:value-of select="normalize-space(article/front/article-meta/title-group/article-title)"></xsl:value-of></title>
    </xsl:template>

    <xsl:template name="authors">
        <authors>
            <xsl:for-each select="article/front/article-meta/contrib-group/contrib[@contrib-type='author']">
                <xsl:call-template name="author"/>
            </xsl:for-each>
        </authors>
    </xsl:template>

    <xsl:template name="author">
        <author>
            <xsl:call-template name="name"/>
        </author>
    </xsl:template>

    <xsl:template name="name">
        <xsl:variable name="initials" select="name/given-names"/>
        <xsl:variable name="last-name" select="name/surname"/>
        <name><xsl:value-of select="concat($initials, ' ', $last-name)"/></name>
    </xsl:template>

    <xsl:template name="abstract">
        <abstract><xsl:value-of select="normalize-space(article/front/article-meta/abstract)"></xsl:value-of></abstract>
    </xsl:template>

    <xsl:template name="keywords">
        <keywords language="eng">
            <xsl:for-each select="article/front/article-meta/kwd-group/kwd">
                <xsl:call-template name="keyword"/>
            </xsl:for-each>
        </keywords>
    </xsl:template>

    <xsl:template name="keyword">
        <keyword><xsl:value-of select="."/> </keyword>
    </xsl:template>

    <xsl:template name="full-text-url">
        <fullTextUrl format="html">http://elementascience.org/article/info:doi/<xsl:value-of select="$doi"/></fullTextUrl>
    </xsl:template>




</xsl:stylesheet>
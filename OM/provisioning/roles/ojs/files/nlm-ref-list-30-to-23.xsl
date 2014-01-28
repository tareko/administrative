<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink">
	<!-- Elements to be copied unchanged (shallow copy): -->
	<xsl:template match="ref-list|ref|label|article-title|source|year|month|day|volume|issue|season|edition|series|supplement|conf-name|conf-date|conf-loc|conf-sponsor|institution|fpage|lpage|publisher-loc|publisher-name|isbn|issn|uri|comment|pub-id|annotation">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	
	<!-- Elements to be copied unchanged (deep copy): -->
	<xsl:template match="person-group">
		<xsl:copy-of select="."/>
	</xsl:template>
	
	<!-- Elements to be changed -->
	<xsl:template match="element-citation">
		<xsl:element name="nlm-citation">
			<xsl:attribute name="citation-type">
				<xsl:choose>
					<xsl:when test="@publication-type='conf-proc'">
						<xsl:text>confproc</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@publication-type"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="date-in-citation[@content-type='access-date']">
		<xsl:element name="access-date">
			<xsl:value-of select="year"/>
			<xsl:if test="month!=''">
				<xsl:text>-</xsl:text>
				<xsl:if test="string-length(month)=1">
					<xsl:text>0</xsl:text>
				</xsl:if>
				<xsl:value-of select="month"/>
				<xsl:if test="day!=''">
					<xsl:text>-</xsl:text>
					<xsl:if test="string-length(day)=1">
						<xsl:text>0</xsl:text>
					</xsl:if>
					<xsl:value-of select="day"/>
				</xsl:if>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="chapter-title">
		<xsl:element name="article-title">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

        <xsl:template match="uri">
                <xsl:element name="comment">
			<ext-link>
				<xsl:attribute name="ext-link-type">
					<xsl:text>uri</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="xlink:type">
					<xsl:text>simple</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="xlink:href">
        	        		<xsl:value-of select="."/>
				</xsl:attribute>
				<xsl:value-of select="."/>
			</ext-link>
                </xsl:element>
        </xsl:template>

        <xsl:template match="year">
                <xsl:copy-of select="."/>
        </xsl:template>
        <xsl:template match="month">
                <xsl:copy-of select="."/>
        </xsl:template>
        <xsl:template match="day">
                <xsl:copy-of select="."/>
        </xsl:template>

        <xsl:template match="volume">
                <xsl:copy-of select="."/>
        </xsl:template>
        <xsl:template match="issue">
                <xsl:copy-of select="."/>
        </xsl:template>

	<!-- Elements to be discarded -->
	<xsl:template match="size"/>
	<xsl:template match="issn"/>
</xsl:stylesheet>

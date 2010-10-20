<?xml version="1.0" encoding="iso-8859-1"?>
<iso:schema    xmlns="http://purl.oclc.org/dsdl/schematron" 
           xmlns:iso="http://purl.oclc.org/dsdl/schematron" 
           xmlns:sch="http://www.ascc.net/xml/schematron"
           xmlns:dp ="http://www.dpawson.co.uk/ns#"
           xmlns:pc="http://example.com/pc/type"
           queryBinding='xslt2'
           schemaVersion="ISO19757-3">
  <iso:title>TouK Schematron test harness</iso:title>

  <iso:ns prefix="pc" uri="http://example.com/pc/types" />  


<iso:pattern id="pc.getMigrationOffers">
  <iso:title>checking GetMigrationOffers</iso:title>
  <iso:rule context="pc:getMigrationOffersResponse">
    <iso:report test="true()">Report date.<iso:value-of select="current-dateTime()"/></iso:report>
    <iso:assert test="count(//@offerId[. = current()/@offerId]) = 1" >Unique offers allowed.</iso:assert>
    <iso:assert test="count(//@asb) = 1">Each offer has to have an @abc attribute </iso:assert>
  </iso:rule>
  <iso:rule context="pc:offer">
    <iso:assert test="count(pc:tariff) = 1">Each offer has to have a tariff</iso:assert>
    <iso:assert test="count(pc:offerPromotion) = 1">Each offer has to have a promotion</iso:assert>
  </iso:rule>
</iso:pattern>

<iso:pattern id="pc.getAllPhones">
  <iso:title>checking GetAllPhones</iso:title>
  <iso:rule context="pc:tac">
    <iso:assert test="count(parent::node()/pc:tac[. = current()]) = 1">
        TACs should be unique. TAC: <iso:value-of select="."/>, 
        handsetId: <iso:value-of select="parent::node()/@handsetId"/>
        offerId: <iso:value-of select="parent::node()/@offerId"/>
    </iso:assert>
  </iso:rule>
</iso:pattern>

</iso:schema>


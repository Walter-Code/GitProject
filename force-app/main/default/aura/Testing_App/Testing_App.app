<aura:application extends="force:slds" implements="force:appHostable">
    <aura:handler name="init" value="{!this}" action="{!c.doinit}" />
    <c:createOpportunity />
</aura:application>
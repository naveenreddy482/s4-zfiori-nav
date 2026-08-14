@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GasLine: Actual Revenues by Orders'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCO_I_GS_R_ACTUAL_REV_BYORDER
    as select from ZCO_I_GS_R_ORDER_ACTUAL_COST as _OrdRevenue
{
    key _OrdRevenue.OrderID,
        _OrdRevenue.OrderIDShortDescription as OrderDescription,
        _OrdRevenue.FiscalYear,
        _OrdRevenue.FiscalYearPeriod,
        _OrdRevenue.CompanyCode,
        _OrdRevenue.auart as OrderType,
        _OrdRevenue.aufex as ExternalOrderId,
        _OrdRevenue.pspid as ProjectID,
        _OrdRevenue.ProjectIDShortDescription as ProjectDescription,
        _OrdRevenue.posid as WBSElementID,
        _OrdRevenue.WBSElementIDShortDescription as WBSElementDescription,
        _OrdRevenue.user2 as PersonResponsible,
        _OrdRevenue.erdat as CreatedOnDate,
        _OrdRevenue.user0 as Applicant,
        _OrdRevenue.GLAccount,
        _OrdRevenue.GlobalCurrency as CompanyCodeCurrency,
        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
        sum(_OrdRevenue.AmountInGlobalCurrency) as TotalActualRevenue,
        'Actual Revenues'                         as DataCategory,
        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
        cast('0.00' as abap.curr( 23, 2 ))        as TotalActualCost,
        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
        cast('0.00' as abap.curr( 23, 2 ))        as TotalCommitment
}
group by
        _OrdRevenue.OrderID,
        _OrdRevenue.OrderIDShortDescription,
        _OrdRevenue.FiscalYear,
        _OrdRevenue.FiscalYearPeriod,
        _OrdRevenue.CompanyCode,
        _OrdRevenue.auart,
        _OrdRevenue.aufex,
        _OrdRevenue.pspid,
        _OrdRevenue.ProjectIDShortDescription,
        _OrdRevenue.posid,
        _OrdRevenue.WBSElementIDShortDescription,
        _OrdRevenue.user2,
        _OrdRevenue.erdat,
        _OrdRevenue.user0,
        _OrdRevenue.GLAccount,
        _OrdRevenue.GlobalCurrency

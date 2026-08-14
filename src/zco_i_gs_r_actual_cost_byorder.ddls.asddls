@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GasLine: Actual Costs by Orders'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCO_I_GS_R_ACTUAL_COST_BYORDER
  as select from ZCO_I_GS_R_ORDER_ACTUAL_COST as _OrdCost
{
  key _OrdCost.OrderID,
      _OrdCost.OrderIDShortDescription as OrderDescription,
      _OrdCost.FiscalYear,
      _OrdCost.FiscalYearPeriod,
      _OrdCost.CompanyCode,
      _OrdCost.auart as OrderType,
      _OrdCost.aufex as ExternalOrderID,
      _OrdCost.pspid as ProjectID,
      _OrdCost.ProjectIDShortDescription as ProjectDescription,
      _OrdCost.posid as WBSElementID,
      _OrdCost.WBSElementIDShortDescription as WBSElementDescription,
      _OrdCost.user2 as PersonResponsible,
      _OrdCost.erdat as CreatedOnDate,
      _OrdCost.user0 as Applicant,
      _OrdCost.GLAccount,
      _OrdCost.GlobalCurrency as CompanyCodeCurrency,
//      cast('EUR' as abap.cuky( 5 ))             as TransactionCurrency,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(_OrdCost.AmountInGlobalCurrency) as TotalActualCost,
      'Actual Costs'                            as DataCategory,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      cast('0.00' as abap.curr( 23, 2 )) as TotalCommitment,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      cast('0.00' as abap.curr( 23, 2 )) as TotalActualRevenue
}
group by
  _OrdCost.OrderID,
  _OrdCost.OrderIDShortDescription,
  _OrdCost.FiscalYear,
  _OrdCost.FiscalYearPeriod,
  _OrdCost.CompanyCode,
  _OrdCost.auart,
  _OrdCost.aufex,
  _OrdCost.pspid,
  _OrdCost.ProjectIDShortDescription,
  _OrdCost.posid,
  _OrdCost.WBSElementIDShortDescription,
  _OrdCost.user2,
  _OrdCost.erdat,
  _OrdCost.user0,
  _OrdCost.GLAccount,
  _OrdCost.GlobalCurrency

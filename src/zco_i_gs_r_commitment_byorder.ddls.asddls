@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GasLine: Commitments by Orders'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCO_I_GS_R_COMMITMENT_BYORDER
  as select from ZCO_I_GS_R_COMMITMENT_ORD_MAP as _OrdCommit
{
  key _OrdCommit.OrderID,
      _OrdCommit.OrderShortDescription as OrderDescription,
      _OrdCommit.FiscalYear,
      _OrdCommit.FiscalYearPeriod,
      _OrdCommit.CompanyCode,
      _OrdCommit.OrderType,
      _OrdCommit.ExternalOrderID,
      _OrdCommit.ProjectID,
      _OrdCommit.ProjectDescription,
      _OrdCommit.WBSElementID,
      _OrdCommit.WBSElementDescription,
      _OrdCommit.PersonResponsible,
      _OrdCommit.CreatedOnDate,
      _OrdCommit.Applicant,
      _OrdCommit.CostElement,
      _OrdCommit.CompanyCodeCurrency,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      @DefaultAggregation: #SUM
      sum(_OrdCommit.AmountInCtrlgAreaCrcy)    as TotalCommitment,
      'Total Commitment'                       as DataCategory,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      cast('0.00' as abap.curr( 23, 2 )) as TotalActualCost,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      cast('0.00' as abap.curr( 23, 2 )) as TotalActualRevenue
}
where
  (
        _OrdCommit.OrderID     is not null

  )
group by
  _OrdCommit.OrderID,
  _OrdCommit.OrderShortDescription,
  _OrdCommit.FiscalYear,
  _OrdCommit.FiscalYearPeriod,
  _OrdCommit.CompanyCode,
  _OrdCommit.OrderType,
  _OrdCommit.ExternalOrderID,
  _OrdCommit.ProjectID,
  _OrdCommit.ProjectDescription,
  _OrdCommit.WBSElementID,
  _OrdCommit.WBSElementDescription,
  _OrdCommit.PersonResponsible,
  _OrdCommit.CreatedOnDate,
  _OrdCommit.Applicant,
  _OrdCommit.CostElement,
  _OrdCommit.CompanyCodeCurrency

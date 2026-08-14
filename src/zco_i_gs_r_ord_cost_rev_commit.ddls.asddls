@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GasLine: Report Order cost rev commit'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCO_I_GS_R_ORD_COST_REV_COMMIT
  as select from ZCO_I_GS_R_ACTUAL_COST_BYORDER as _OrdCost
{
  key _OrdCost.OrderID,
      _OrdCost.OrderDescription,
      _OrdCost.FiscalYear,
      _OrdCost.FiscalYearPeriod,
      _OrdCost.CompanyCode,
      _OrdCost.OrderType,
      _OrdCost.ExternalOrderID,
      _OrdCost.ProjectID,
      _OrdCost.ProjectDescription,
      _OrdCost.WBSElementID,
      _OrdCost.WBSElementDescription,
      _OrdCost.PersonResponsible,
      _OrdCost.CreatedOnDate,
      _OrdCost.Applicant,
      _OrdCost.CompanyCodeCurrency,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(_OrdCost.TotalActualCost) as TotalActualCost,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(_OrdCost.TotalCommitment) as TotalCommitment,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(_OrdCost.TotalActualRevenue) as TotalActualRevenue
}
group by
  _OrdCost.OrderID,
  _OrdCost.OrderDescription,
  _OrdCost.FiscalYear,
  _OrdCost.FiscalYearPeriod,
  _OrdCost.CompanyCode,
  _OrdCost.OrderType,
  _OrdCost.ExternalOrderID,
  _OrdCost.ProjectID,
  _OrdCost.ProjectDescription,
  _OrdCost.WBSElementID,
  _OrdCost.WBSElementDescription,
  _OrdCost.PersonResponsible,
  _OrdCost.CreatedOnDate,
  _OrdCost.Applicant,
  _OrdCost.CompanyCodeCurrency,
  _OrdCost.TotalActualCost,
  _OrdCost.TotalCommitment,
  _OrdCost.TotalActualRevenue

union all

select from ZCO_I_GS_R_COMMITMENT_BYORDER as _OrdCommitment
{
  key _OrdCommitment.OrderID,
      _OrdCommitment.OrderDescription,
      _OrdCommitment.FiscalYear,
      _OrdCommitment.FiscalYearPeriod,
      _OrdCommitment.CompanyCode,
      _OrdCommitment.OrderType,
      _OrdCommitment.ExternalOrderID,
      _OrdCommitment.ProjectID,
      _OrdCommitment.ProjectDescription,
      _OrdCommitment.WBSElementID,
      _OrdCommitment.WBSElementDescription,
      _OrdCommitment.PersonResponsible,
      _OrdCommitment.CreatedOnDate,
      _OrdCommitment.Applicant,
      _OrdCommitment.CompanyCodeCurrency,
      sum(_OrdCommitment.TotalActualCost) as TotalActualCost,
      sum(_OrdCommitment.TotalCommitment) as TotalCommitment,
      sum(_OrdCommitment.TotalActualRevenue)   as TotalActualRevenue
}
group by
  _OrdCommitment.OrderID,
  _OrdCommitment.OrderDescription,
  _OrdCommitment.FiscalYear,
  _OrdCommitment.FiscalYearPeriod,
  _OrdCommitment.CompanyCode,
  _OrdCommitment.OrderType,
  _OrdCommitment.ExternalOrderID,
  _OrdCommitment.ProjectID,
  _OrdCommitment.ProjectDescription,
  _OrdCommitment.WBSElementID,
  _OrdCommitment.WBSElementDescription,
  _OrdCommitment.PersonResponsible,
  _OrdCommitment.CreatedOnDate,
  _OrdCommitment.Applicant,
  _OrdCommitment.CompanyCodeCurrency,
  _OrdCommitment.TotalActualCost,
  _OrdCommitment.TotalCommitment,
  _OrdCommitment.TotalActualRevenue

union all

select from ZCO_I_GS_R_ACTUAL_REV_BYORDER as _OrdRevenue
{
  key _OrdRevenue.OrderID,
      _OrdRevenue.OrderDescription,
      _OrdRevenue.FiscalYear,
      _OrdRevenue.FiscalYearPeriod,
      _OrdRevenue.CompanyCode,
      _OrdRevenue.OrderType,
      _OrdRevenue.ExternalOrderId,
      _OrdRevenue.ProjectID,
      _OrdRevenue.ProjectDescription,
      _OrdRevenue.WBSElementID,
      _OrdRevenue.WBSElementDescription,
      _OrdRevenue.PersonResponsible,
      _OrdRevenue.CreatedOnDate,
      _OrdRevenue.Applicant,
      _OrdRevenue.CompanyCodeCurrency,
      sum(_OrdRevenue.TotalActualCost)      as TotalActualCost,
      sum(_OrdRevenue.TotalCommitment)      as TotalCommitment,
      sum(_OrdRevenue.TotalActualRevenue)   as TotalActualRevenue
}
group by
    _OrdRevenue.OrderID,
    _OrdRevenue.OrderDescription,
    _OrdRevenue.FiscalYear,
    _OrdRevenue.FiscalYearPeriod,
    _OrdRevenue.CompanyCode,
    _OrdRevenue.OrderType,
    _OrdRevenue.ExternalOrderId,
    _OrdRevenue.ProjectID,
    _OrdRevenue.ProjectDescription,
    _OrdRevenue.WBSElementID,
    _OrdRevenue.WBSElementDescription,
    _OrdRevenue.PersonResponsible,
    _OrdRevenue.CreatedOnDate,
    _OrdRevenue.Applicant,
    _OrdRevenue.CompanyCodeCurrency

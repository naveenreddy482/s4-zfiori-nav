@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GasLine: Orders across all periods'
define view entity ZCO_I_GS_R_ORDER_SIBLINGS
  as select from ZCO_I_GS_R_ORD_COST_REV_COMMIT
{
  key OrderID,
      OrderDescription,
      CompanyCode,
      OrderType,
      ExternalOrderID,
      PersonResponsible,
      CreatedOnDate,
      Applicant,
      CompanyCodeCurrency,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(TotalActualCost) as TotalActualCostAllTime
}
group by
  OrderID,
  OrderDescription,
  CompanyCode,
  OrderType,
  ExternalOrderID,
  PersonResponsible,
  CreatedOnDate,
  Applicant,
  CompanyCodeCurrency

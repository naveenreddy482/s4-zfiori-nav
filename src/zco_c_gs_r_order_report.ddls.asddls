@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GasLine - Consumption Report for Orders'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #CONSUMPTION
//@Analytics.query: true
define view entity ZCO_C_GS_R_ORDER_REPORT

  with parameters
  @EndUserText.label: 'GJ/Periode von'
    p_fiscper_from : fiscalyearperiod,
  @EndUserText.label: 'GJ/Periode bis'
    p_fiscper_to   : fiscalyearperiod
  as select from ZCO_I_GS_R_ORDER_REPORT
                   (
                 p_fiscper_from:$parameters.p_fiscper_from,
                 p_fiscper_to:$parameters.p_fiscper_to )

  association [0..*] to ZCO_C_GS_R_ORDER_SIBLINGS as _SimilarOrders
    on  $projection.CompanyCode = _SimilarOrders.CompanyCode
    and $projection.OrderID    <> _SimilarOrders.OrderID
{
  /* ===== ROW AXIS =====*/
//  @AnalyticsDetails.query.axis: #ROWS
  key OrderID,
//  @AnalyticsDetails.query.axis: #ROWS
  OrderDescription,
//  @AnalyticsDetails.query.axis: #FREE
  CompanyCode,
//  @AnalyticsDetails.query.axis: #ROWS
  OrderType,
//  @AnalyticsDetails.query.axis: #ROWS
  ExternalOrderID,
//  @AnalyticsDetails.query.axis: #ROWS
  cast( ProjectID    as abap.char(24) )            as ProjectDefinition,
//  @AnalyticsDetails.query.axis: #ROWS
  ProjectDescription,
//  @AnalyticsDetails.query.axis: #ROWS
  cast( WBSElementID    as abap.char(24) )            as PSPElement,
//  @AnalyticsDetails.query.axis: #ROWS
  WBSElementDescription,
//  @AnalyticsDetails.query.axis: #ROWS
  PersonResponsible,
//  @AnalyticsDetails.query.axis: #ROWS
  CreatedOnDate,
//  @AnalyticsDetails.query.axis: #ROWS
  Applicant,
  /* ===== COLUMN AXIS (MEASURES) =====*/
//  @AnalyticsDetails.query.axis: #COLUMNS

  CompanyCodeCurrency,
//  @AnalyticsDetails.query.axis: #COLUMNS
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  TotalActualCost,
    case
    when TotalActualCost >= 80 then 2
    when TotalActualCost >= 50 then 3
    when TotalActualCost <= 10 then 1
    else 0
end as TotalActualCostcriticallity,
//  @AnalyticsDetails.query.axis: #COLUMNS
  TotalActualRevenue,
//  @AnalyticsDetails.query.axis: #COLUMNS
  ActualBalance,
//  @AnalyticsDetails.query.axis: #COLUMNS
  TotalActualCostSum,
//  @AnalyticsDetails.query.axis: #COLUMNS
  TotalActualRevenueSum,
//  @AnalyticsDetails.query.axis: #COLUMNS
  ActualBalanceSum,
//  @AnalyticsDetails.query.axis: #COLUMNS
  TotalCommitment,

  /* Associations */
  _SimilarOrders
}

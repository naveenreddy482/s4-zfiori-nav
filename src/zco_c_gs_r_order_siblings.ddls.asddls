@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GasLine - Sibling Orders'
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #CONSUMPTION
define view entity ZCO_C_GS_R_ORDER_SIBLINGS
  as select from ZCO_I_GS_R_ORDER_SIBLINGS
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
      TotalActualCostAllTime
}

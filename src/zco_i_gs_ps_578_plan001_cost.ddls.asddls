@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gasline: Prognose by Budgetposition'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCO_I_GS_PS_578_PLAN001_COST
  as select from ZCO_I_GS_PS_578_PLAN001_COST_T as _plan
  inner join ZCO_I_GS_BUDGITEM_WBS_HIER as _Hier on _Hier.ChildNodeExternalID = _plan.WBSElement
{
  key _Hier.ChildNodeExternalID as PSPElement,
  key _plan.CalendarYear        as FiscalYear,
      _plan.TransactionCurrency,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      _plan.TotalPlanAmount     as Prognose
}

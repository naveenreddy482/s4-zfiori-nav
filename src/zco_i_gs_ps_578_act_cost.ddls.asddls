@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gasline: Istkosten by Budgetposition'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCO_I_GS_PS_578_ACT_COST
  as select from ZCO_I_GS_PS_578_ACT_COST_TOTAL as _act
  inner join ZCO_I_GS_BUDGITEM_WBS_HIER as _Hier on _Hier.ChildNodeExternalID = _act.WBSElementDerived
{
  key _Hier.ChildNodeExternalID as PSPElement,
  key _act.FiscalYear,
      _act.TransactionCurrency,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum(_act.TotalAmount)     as IstKosten
}
group by
  _Hier.ChildNodeExternalID,
  _act.FiscalYear,
  _act.TransactionCurrency

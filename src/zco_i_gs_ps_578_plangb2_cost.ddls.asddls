@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gasline: GB CR on WBS Element'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCO_I_GS_PS_578_PLANGB2_COST
  as select from ZCO_I_GS_BUDGITEM_WBS_HIER as _Hier
  inner join ZPS_I_PRPS as _psp  on _Hier.ChildNodeExternalID = _psp.Posid
  inner join ZPS_I_BPJA as _BPJA on _BPJA.ObjectNumber = _psp.Objnr
{
  key _Hier.ChildNodeExternalID as PSPElement,
  key _psp.Objnr                as Objectnumber,
  key _BPJA.FiscalYear,
      _BPJA.TransactionCurrency,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      cast(sum(_BPJA.ValueYearTransCurrency) as bp_wgt preserving type ) as GBCR
}
where
      _BPJA.PlanBudgetVersion = 'GB2'
  and _BPJA.ValueType         = '01'
group by
  _Hier.ChildNodeExternalID,
  _psp.Objnr,
  _BPJA.FiscalYear,
  _BPJA.TransactionCurrency

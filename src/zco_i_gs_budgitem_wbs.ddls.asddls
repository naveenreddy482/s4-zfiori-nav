@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gasline: Budgetitem and WBS Nodes'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCO_I_GS_BUDGITEM_WBS
  as select from ZCO_I_GS_PS_BUDGITEM_HIER as _Hier
  inner join ZPS_I_PRPS as _prps on _prps.Zzgsbudgetpos = _Hier.BudgetpositionInternalID
{
  key _Hier.BudgetpositionInternalID,
  key _prps.Pspnr                    as WBSElementInternalID,
      _Hier.BudgetpostionchildNodeID as Budgetposition,
      _prps.Posid                    as WBSElement,
      _prps.Post1                    as Description
}

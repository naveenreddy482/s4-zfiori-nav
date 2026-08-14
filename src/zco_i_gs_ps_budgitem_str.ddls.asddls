@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gasline: Budgetitem Hierarachy Nodes structure'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCO_I_GS_PS_BUDGITEM_STR
  as select from ZPS_I_PRPS as _prps
  association [1..1] to I_WBSElementStructure as _prhi on _prhi.WBSElementInternalID = _prps.Pspnr
{
  key _prps.Pspnr                      as BudgetpositionInternalID,
      _prps.Posid                      as BudgetpositionExternalID,
      _prhi.WBSElementParentInternalID as BudgetpositionParentInternalID,
      _prhi._WBSElementParent.WBSElement as BudgetpositionParentExternalID,
      _prps.Post1                      as BudgetpositionDescription
}

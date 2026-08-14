@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gasline: Budgetitem Nodes Recursive'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCO_I_GS_PS_BUDGITEM_REC
  as select from ZCO_I_GS_PS_BUDGITEM_STR as _node
  association [0..*] to ZCO_I_GS_PS_BUDGITEM_REC as _rec
    on $projection.BudgetpositionParentExternalID = _rec.BudgetpositionExternalID
{
  key _node.BudgetpositionParentExternalID,
  key _node.BudgetpositionExternalID,
      _node.BudgetpositionParentInternalID,
      _node.BudgetpositionInternalID,
      _node.BudgetpositionDescription,
      _rec
}

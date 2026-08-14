@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gasline: Budgetitem and WBS Nodes str'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCO_I_GS_BUDGITEM_WBS_STR
  as select from ZCO_I_GS_PS_BUDGITEM_HIER as _budpos
{
  key BudgetPostionParentNodeID          as ParentNodeExternalID,
  key BudgetpostionchildNodeID           as ChildNodeExternalID,
      BudgetpositionParentInternalID     as ParentNodeInternalID,
      BudgetpositionInternalID           as ChildNodeInternalID,
      BudgetpositionDescription          as Description,
      cast('Budgetposition' as abap.char( 20 )) as Nodegroup
}
union all select from ZCO_I_GS_BUDGITEM_WBS as _wbs
{
  key _wbs.Budgetposition                as ParentNodeExternalID,
  key _wbs.WBSElement                    as ChildNodeExternalID,
      _wbs.BudgetpositionInternalID      as ParentNodeInternalID,
      _wbs.WBSElementInternalID          as ChildNodeInternalID,
      _wbs.Description                   as Description,
      cast('WBSElement' as abap.char( 20 ))     as Nodegroup
}

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gasline: BudgetItem Dimension'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.representativeKey: 'PSPElement'
@Analytics.dataCategory: #DIMENSION
define view entity ZCO_I_GS_BUDGITEM_DIM
  as select from ZCO_I_GS_BUDGITEM_WBS_NODE_R
  association [1..*] to ZCO_I_GS_BUDGITEM_WBS_HIER as _Hierarchy
    on $projection.PSPElement = _Hierarchy.ChildNodeExternalID
{
      @ObjectModel.text.element: ['Description']
      @ObjectModel.hierarchy.association: '_Hierarchy'
  key ChildNodeExternalID  as PSPElement,
      ParentNodeExternalID as Budgetposition,
      Description,
//      Nodegroup,
      /* Associations */
      _Hierarchy
}

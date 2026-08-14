@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gasline: Budget/WBS Nodes Recursive'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCO_I_GS_BUDGITEM_WBS_NODE_R
  as select from ZCO_I_GS_BUDGITEM_WBS_STR as _node
  association [0..*] to ZCO_I_GS_BUDGITEM_WBS_NODE_R as _rec
    on $projection.ParentNodeExternalID = _rec.ChildNodeExternalID
{
  key _node.ChildNodeExternalID,
      _node.ParentNodeExternalID,
      _node.ParentNodeInternalID,
      _node.ChildNodeInternalID,
      _node.Description,
      _node.Nodegroup,
      _rec
}

define hierarchy ZCO_I_GS_BUDGITEM_WBS_HIER
  as parent child hierarchy(
    source ZCO_I_GS_BUDGITEM_WBS_NODE_R
    child to parent association _rec
    start where
//      ParentNodeExternalID is null
      ChildNodeExternalID = 'GV-000'
    siblings order by
      ChildNodeExternalID
  )
{
  key ChildNodeExternalID,
      ParentNodeExternalID,
      Description,
      ParentNodeInternalID,
      ChildNodeInternalID,
      $node.parent_id             as ParentNode,
      $node.node_id               as ChildNode,
      $node.hierarchy_is_orphan   as HierarchyisOrphan,
      $node.hierarchy_level       as HierarchyLevel,
      $node.hierarchy_rank        as HierarchyRank,
      $node.hierarchy_parent_rank as HierarchyParentRank,
      $node.hierarchy_tree_size   as HierarchyTreeSize
}

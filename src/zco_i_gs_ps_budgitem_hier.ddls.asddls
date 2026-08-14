define hierarchy ZCO_I_GS_PS_BUDGITEM_HIER
  as parent child hierarchy(
    source ZCO_I_GS_PS_BUDGITEM_REC
    child to parent association _rec
    start where
      BudgetpositionExternalID = 'GV-000'
//      BudgetpositionParentExternalID is null
    siblings order by
      BudgetpositionExternalID
    // multiple parents allowed
  )
{
  key BudgetpositionParentExternalID  as BudgetPostionParentNodeID,
  key BudgetpositionExternalID        as BudgetpostionchildNodeID,
      BudgetpositionDescription,
      BudgetpositionParentInternalID,
      BudgetpositionInternalID,

      $node.parent_id                 as ParentNode,
      $node.node_id                   as ChildNode,
      $node.hierarchy_is_orphan       as HierarchyisOrphan,
      $node.hierarchy_level           as HierarcyLevel,
      $node.hierarchy_rank            as HierarcyRank,
      $node.hierarchy_parent_rank     as HierarchyParentRank,
      $node.hierarchy_tree_size       as HierarchyTreeSize
}

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gasline: Total Actual Cost on WBS and Order'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCO_I_GS_PS_578_ACT_COST_TOTAL
  as select from    I_GLAccountLineItemRawData   as acdoca
    left outer join ZCO_I_GS_PS_ORDER_WBS        as _map  on acdoca.OrderID = _map.OrderID
{
  key acdoca.SourceLedger,
  key acdoca.CompanyCode,
  key acdoca.FiscalYear,
  key acdoca.AccountingDocument,
  key acdoca.LedgerGLLineItem,
      acdoca.GLAccount,
      acdoca.GlobalCurrency              as TransactionCurrency,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum(acdoca.AmountInGlobalCurrency) as TotalAmount,
      acdoca.OrderID,
      acdoca.OrderCategory,
      acdoca.WBSElementInternalID,
      acdoca.WBSElement,
      case
      when acdoca.WBSElement is initial
      then _map.posid
      else acdoca.WBSElement
      end                                as WBSElementDerived,
      acdoca.ProjectInternalID,
      acdoca.Project,
      case
      when acdoca.Project is initial
      then _map.pspid
      else acdoca.Project
      end                                as ProjectDerived
}
//where
//       acdoca.SourceLedger               =       '0L'
//  and  acdoca.CompanyCode                =       '0048'
//  and  acdoca.ControllingDebitCreditCode <>      'A'
//  and(
//       acdoca.BusinessTransactionType    between 'AAAA' and 'KAFC'
//    or acdoca.BusinessTransactionType    =       'KAFD'
//    or acdoca.BusinessTransactionType    between 'KAFE' and 'KAZA'
//    or acdoca.BusinessTransactionType    between 'KAZZ' and 'SDOQ'
//    or acdoca.BusinessTransactionType    between 'SDOS' and 'ZZZZ'
//  )
//  and  not(
//     acdoca.BusinessTransactionType      like    'KOA%'
//   )
group by
  acdoca.SourceLedger,
  acdoca.CompanyCode,
  acdoca.FiscalYear,
  acdoca.AccountingDocument,
  acdoca.LedgerGLLineItem,
  acdoca.GLAccount,
  acdoca.GlobalCurrency,
  acdoca.OrderID,
  acdoca.OrderCategory,
  acdoca.WBSElementInternalID,
  acdoca.WBSElement,
  acdoca.ProjectInternalID,
  acdoca.Project,
  _map.posid,
  _map.pspid
having
  sum(acdoca.AmountInGlobalCurrency) <> 0

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gasline: Total Prognose on WBS Element'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCO_I_GS_PS_578_PLAN001_COST_T
  as select from I_FinancialPlanningEntryItem as Acdocp
  association [0..1] to ZPS_I_PROJECT as ProjectInfo on ProjectInfo.ProjectId = Acdocp.Project
{
  key ProjectInfo.ProjectId                as ProjectID,
  key Acdocp.WBSElement,
  key Acdocp._CalendarDate.CalendarYear,
      Acdocp.CompanyCodeCurrency           as TransactionCurrency,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum(Acdocp.AmountInCompanyCodeCurrency) as TotalPlanAmount
}
//where
//      Acdocp.PlanningCategory              = 'PK001'
//  and Acdocp.Ledger                        = '0L'
//  and Acdocp.ControllingDebitCreditCode    = 'S'
//  and Acdocp.WBSElement                    is not null
//  and Acdocp.WBSElement                    is not initial
group by
  ProjectInfo.ProjectId,
  Acdocp.WBSElement,
  Acdocp._CalendarDate.CalendarYear,
  Acdocp.CompanyCodeCurrency
having
  sum(Acdocp.AmountInCompanyCodeCurrency) <> 0

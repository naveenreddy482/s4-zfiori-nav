@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GasLine: Report for Orders'
//@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCO_I_GS_R_ORDER_REPORT
  with parameters
   @EndUserText.label: 'GJ-Per.(JJJJMMM)von'
    p_fiscper_from : fiscalyearperiod,
   @EndUserText.label: 'GJ-Per.(JJJJMMM)bis'
    p_fiscper_to   : fiscalyearperiod
  as select from ZCO_I_GS_R_ORD_COST_REV_COMMIT as _OrderUnionAll
{
  key OrderID,
      OrderDescription,
      CompanyCode,
      OrderType,
      ExternalOrderID,
      ProjectID,
      ProjectDescription,
      WBSElementID,
      WBSElementDescription,
      PersonResponsible,
      CreatedOnDate,
      Applicant,
      CompanyCodeCurrency,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(
          case
              when FiscalYearPeriod between $parameters.p_fiscper_from and $parameters.p_fiscper_to
              then cast(TotalActualCost as abap.dec( 23, 2 ))
              else cast(0 as abap.dec( 23, 2 ))
          end
      ) as TotalActualCost,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(
          case
              when FiscalYearPeriod between $parameters.p_fiscper_from and $parameters.p_fiscper_to
              then cast(TotalActualRevenue as abap.dec( 23, 2 ))
              else cast(0 as abap.dec( 23, 2 ))
          end
      ) as TotalActualRevenue,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(
          case
              when FiscalYearPeriod between $parameters.p_fiscper_from and $parameters.p_fiscper_to
              then cast(TotalActualCost as abap.dec( 23, 2 )) + cast(TotalActualRevenue as abap.dec( 23, 2 ))
              else cast(0 as abap.dec( 23, 2 ))
          end
      ) as ActualBalance,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(
          case
              when FiscalYearPeriod between '1900001' and $parameters.p_fiscper_to
              then cast(TotalActualCost as abap.dec( 23, 2 ))
              else cast(0 as abap.dec( 23, 2 ))
          end
      ) as TotalActualCostSum,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(
          case
              when FiscalYearPeriod between '1900001' and $parameters.p_fiscper_to
              then cast(TotalActualRevenue as abap.dec( 23, 2 ))
              else cast(0 as abap.dec( 23, 2 ))
          end
      ) as TotalActualRevenueSum,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(
          case
              when FiscalYearPeriod between '1900001' and $parameters.p_fiscper_to
              then cast(TotalActualCost as abap.dec( 23, 2 )) + cast(TotalActualRevenue as abap.dec( 23, 2 ))
              else cast(0 as abap.dec( 23, 2 ))
          end
      ) as ActualBalanceSum,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(
          case
              when FiscalYearPeriod between $parameters.p_fiscper_from and $parameters.p_fiscper_to
              then cast(TotalCommitment as abap.dec( 23, 2 ))
              else cast(0 as abap.dec( 23, 2 ))
          end
      ) as TotalCommitment
}
group by
  OrderID,
  OrderDescription,
  CompanyCode,
  OrderType,
  ExternalOrderID,
  ProjectID,
  ProjectDescription,
  WBSElementID,
  WBSElementDescription,
  PersonResponsible,
  CreatedOnDate,
  Applicant,
  CompanyCodeCurrency

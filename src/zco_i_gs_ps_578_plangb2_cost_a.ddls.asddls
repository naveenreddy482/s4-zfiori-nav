@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gasline: Aggregated GB CR'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCO_I_GS_PS_578_PLANGB2_COST_A
  with parameters
    p_fiscalyear : gjahr
  as select from ZCO_I_GS_PS_578_PLANGB2_COST
{
  key PSPElement,
      TransactionCurrency,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum(case when FiscalYear = $parameters.p_fiscalyear
               then cast(GBCR as abap.dec( 23, 2 )) else 0 end)                                   as GBCR_plus_0,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum(case when cast(FiscalYear as abap.int4) = cast($parameters.p_fiscalyear as abap.int4) + 1
               then cast(GBCR as abap.dec( 23, 2 )) else 0 end)                                   as GBCR_plus_1,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum(case when cast(FiscalYear as abap.int4) = cast($parameters.p_fiscalyear as abap.int4) + 2
               then cast(GBCR as abap.dec( 23, 2 )) else 0 end)                                   as GBCR_plus_2,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum(case when cast(FiscalYear as abap.int4) = cast($parameters.p_fiscalyear as abap.int4) + 3
               then cast(GBCR as abap.dec( 23, 2 )) else 0 end)                                   as GBCR_plus_3,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum(case when cast(FiscalYear as abap.int4) = cast($parameters.p_fiscalyear as abap.int4) + 4
               then cast(GBCR as abap.dec( 23, 2 )) else 0 end)                                   as GBCR_plus_4,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum(case when cast(FiscalYear as abap.int4) = cast($parameters.p_fiscalyear as abap.int4) + 5
               then cast(GBCR as abap.dec( 23, 2 )) else 0 end)                                   as GBCR_plus_5
}
group by
  PSPElement,
  TransactionCurrency

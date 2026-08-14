@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gasline: BPJA Basic Interface View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPS_I_BPJA
  as select from bpja
{
  key lednr as Ledger,
  key objnr as ObjectNumber,
  key posit as BudgetPosition,
  key trgkz as TargetIndicator,
  key wrttp as ValueType,
  key gjahr as FiscalYear,
  key geber as Fund,
  key versn as PlanBudgetVersion,
  key vorga as BudgetTransaction,
  key twaer as TransactionCurrency,
  key subvo as SubTransaction,
  key gnjhr as YearOfCreation,
  key farea as FunctionalArea,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      wtjhr as ValueYearTransCurrency,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      wljhr as ValueYearObjectCurrency
}

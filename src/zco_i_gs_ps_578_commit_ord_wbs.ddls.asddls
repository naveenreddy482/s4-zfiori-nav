@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GasLine: Mapping Commitment with Orders & WBS Elements'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCO_I_GS_PS_578_COMMIT_ORD_WBS
as select from ZCO_I_GS_R_COOI as Cooi
  association [0..*] to ZPS_C_ORDERBYPROJECTNR as _OrdersToProjects on $projection.ControllingObject = _OrdersToProjects.OrderObj
  association [0..1] to I_Supplier             as _Supplier         on _Supplier.Supplier = $projection.Supplier
  association [0..*] to ZPS_I_AUFK             as _AUFK             on $projection.ControllingObject = _AUFK.ControllingObject
{
  key Cooi.PurchasingDocument, //Bestellung: refbn
  key Cooi.ControllingCommitmentCategory, // Kategorie: refbt === 020 oder ==010
  key Cooi.PurchasingDocumentItem, //Bestellposition: rfpos
  key Cooi.RefDocAccountAssignment,
  key Cooi.ReferenceDocumentScheduleLine,
  key Cooi.CommitmentDocumentType,
  key Cooi.Supplier, //Dienstleister: lifnr
  key Cooi.ControllingLedger,
  key Cooi.ControllingObject,
  key Cooi.ControllingKeySubNumber,
  key Cooi.ReferenceDocumentContext,
  key Cooi.SourceReferenceDocumentType,
  key Cooi.SourceRefDocLogicalSystem,
      _AUFK.OrderID                                      as OrderID,
      _AUFK.ControllingObject                            as OrderObj,
      cast(_OrdersToProjects.Psphi as abap.numc( 8 ))    as ParentProject,
      cast(_OrdersToProjects.Pspnr as abap.numc( 8 ))    as PspNr,
      _OrdersToProjects.Posid                            as WBSElementID,
      _OrdersToProjects.Post1 as WBSElementDescription,
      _OrdersToProjects.ProjectID,
      _OrdersToProjects.ProjectDescription,
      Cooi.FiscalYear                                    as CalendarYear,
      cast(right(Cooi.FiscalPeriod, 2) as calendarmonth) as CalendarMonth,
      Cooi.PurchasingDocumentItemText, //Positionsbezeichnung
      Cooi.TransactionCurrency,
       @Semantics.amount.currencyCode: 'TransactionCurrency'
      Cooi.AmountInTransactionCurrency,
       @Semantics.amount.currencyCode: 'TransactionCurrency'
      Cooi.AmountInCtrlgAreaCrcy, //Restobligo: wkgbtr
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      Cooi.OrderAmount,           //Bestellwert : orgwtk
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      Cooi.AmountInObjectCurrency,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      Cooi.AmountInCompanyCodeCurrency
}
where
  (
       Cooi.ControllingCommitmentCategory = 'POrd'
    or Cooi.ControllingCommitmentCategory = 'PReq'
  )

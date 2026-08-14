@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GasLine: Mapping Commitment with Orders'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCO_I_GS_R_COMMITMENT_ORD_MAP
  as select from ZCO_I_GS_R_COOI as _Cooi
  association [0..*] to ZPS_C_ORDERBYPROJECTNR   as _OrdersToProjects on $projection.ControllingObject = _OrdersToProjects.OrderObj
  association [0..1] to I_Supplier               as _Supplier         on _Supplier.Supplier = $projection.Supplier
  association [0..*] to ZCO_I_GS_R_ORDERZUORDPSP as _OrdersToWBS       on $projection.ControllingObject = _OrdersToWBS.ControllingObject
{
  key _OrdersToWBS.aufnr                                   as OrderID,
      _Cooi.PurchasingDocument,
      _Cooi.ControllingCommitmentCategory,
      _Cooi.PurchasingDocumentItem,
      _Cooi.RefDocAccountAssignment,
      _Cooi.ReferenceDocumentScheduleLine,
      _Cooi.CommitmentDocumentType,
      _Cooi.Supplier,
      _Cooi.ControllingLedger,
      _Cooi.ControllingObject,
      _Cooi.ControllingKeySubNumber,
      _Cooi.ReferenceDocumentContext,
      _Cooi.SourceReferenceDocumentType,
      _Cooi.SourceRefDocLogicalSystem,
      _OrdersToWBS.OrderIDShortDescription                   as OrderShortDescription,
      _OrdersToWBS.ControllingObject                         as OrderObj,
      _OrdersToWBS.auart                                     as OrderType,
      _OrdersToWBS.aufex                                     as ExternalOrderID,
      _OrdersToWBS.user2                                     as PersonResponsible,
      _OrdersToWBS.erdat                                     as CreatedOnDate,
      _OrdersToWBS.user0                                     as Applicant,
      cast(_OrdersToProjects.Psphi as abap.numc( 8 )) as ParentProject,
      cast(_OrdersToProjects.Pspnr as abap.numc( 8 )) as PspNr,
      _OrdersToProjects.Posid                         as WBSElementID,
      _OrdersToWBS.WBSElementIDShortDescription       as WBSElementDescription,
      _OrdersToProjects.ProjectID                     as ProjectID,
      _OrdersToProjects.ProjectDescription            as ProjectDescription,
      _Cooi.PurchasingDocumentItemText,
      _Cooi.FiscalYear,
      _Cooi._CostCenter.CostCenter,
      _Cooi.ControllingValueType,
      _Cooi.CostElement,
      _Cooi.DocumentDate,
      _Cooi.PostingDate,
      _Cooi.FiscalPeriod,
      _Cooi._FiscalPeriod.FiscalYearPeriod,
      _Cooi.CompanyCode,
      _Cooi.ControllingArea,
      _Cooi.Material,
      _Cooi.UnitOfMeasure,
      _Cooi.TransactionCurrency                       as CompanyCodeCurrency,
      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      @Aggregation.default: #SUM
      _Cooi.TotalQuantity,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      @DefaultAggregation: #SUM
      _Cooi.AmountInTransactionCurrency,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      @DefaultAggregation: #SUM
      _Cooi.OrderAmount,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      @DefaultAggregation: #SUM
      _Cooi.AmountInCtrlgAreaCrcy,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      @DefaultAggregation: #SUM
      _Cooi.AmountInObjectCurrency,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      @DefaultAggregation: #SUM
      _Cooi.AmountInCompanyCodeCurrency,
      _Cooi.SupplierName,
      _Cooi._BaseUnit,
      _Cooi._CompanyCode,
      _Cooi._ControllingArea,
      _Cooi._ControllingValueType,
      _Cooi._CostCenter,
      _Cooi._CostElement,
      _Cooi._FiscalPeriod,
      _Cooi._FiscalYear,
      _Cooi._Material,
      _Cooi._Product,
      _Cooi._PurchaseOrderStatus,
      _Cooi._PurchasingDocumentItem,
      _Cooi._Supplier,
      _Cooi._TransactionCurrency
}
where
  (
       _Cooi.ControllingCommitmentCategory = 'POrd'
    or _Cooi.ControllingCommitmentCategory = 'PReq'
  )


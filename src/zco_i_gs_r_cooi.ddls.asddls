@AbapCatalog.sqlViewName: 'ZCOIGSRCOOI'
@AbapCatalog.compiler.compareFilter: true
@ClientHandling.algorithm: #SESSION_VARIABLE
@AccessControl.authorizationCheck: #NOT_REQUIRED
@AccessControl.personalData.blocking:#NOT_REQUIRED
@AbapCatalog.preserveKey: true
@EndUserText.label: 'GasLine: Copy of I_ControllingCommitment + Extras'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #BASIC
@ObjectModel.usageType:{
    serviceQuality: #D,
    sizeCategory: #XL,
    dataClass: #TRANSACTIONAL
}
define view ZCO_I_GS_R_COOI
  as select from cooi
  association [0..*] to I_CostCenter                   as _CostCenter             on  $projection.ControllingArea   = _CostCenter.ControllingArea
                                                                                  and $projection.ControllingObject = _CostCenter.ObjectInternalID
  association [0..1] to I_ControllingArea              as _ControllingArea        on  $projection.ControllingArea = _ControllingArea.ControllingArea

  association [0..1] to I_CompanyCode                  as _CompanyCode            on  $projection.CompanyCode = _CompanyCode.CompanyCode

  association [0..1] to I_UnitOfMeasure                as _BaseUnit               on  $projection.UnitOfMeasure = _BaseUnit.UnitOfMeasure
  association [0..1] to I_Product                      as _Product                on  $projection.Material = _Product.Product

  association [0..1] to I_FiscalYearForCompanyCode     as _FiscalYear             on  $projection.FiscalYear  = _FiscalYear.FiscalYear
                                                                                  and $projection.CompanyCode = _FiscalYear.CompanyCode

  association [0..1] to I_Currency                     as _TransactionCurrency    on  $projection.TransactionCurrency = _TransactionCurrency.Currency

  association [1]    to I_CostElement                  as _CostElement            on  _CostElement.ControllingArea = $projection.ControllingArea
                                                                                  and _CostElement.CostElement     = $projection.CostElement

  association [0..1] to I_PurchaseOrderStatus          as _PurchaseOrderStatus    on  _PurchaseOrderStatus.PurchaseOrder = $projection.PurchasingDocument
  association [0..1] to I_PurchasingDocumentItem       as _PurchasingDocumentItem on  $projection.PurchasingDocument     = _PurchasingDocumentItem.PurchasingDocument
                                                                                  and $projection.PurchasingDocumentItem = _PurchasingDocumentItem.PurchasingDocumentItem

  association [0..1] to I_Supplier                     as _Supplier               on  $projection.Supplier = _Supplier.Supplier
  association [0..1] to I_Material                     as _Material               on  $projection.Material = _Material.Material
  association [0..1] to I_ControllingValueType         as _ControllingValueType   on  $projection.ControllingValueType = _ControllingValueType.ControllingValueType

  association [0..1] to I_FiscalYearPeriodForCmpnyCode as _FiscalPeriod           on  $projection.FiscalYear   = _FiscalPeriod.FiscalYear
                                                                                  and $projection.FiscalPeriod = _FiscalPeriod.FiscalPeriod
                                                                                  and $projection.CompanyCode  = _FiscalPeriod.CompanyCode

{
         @ObjectModel.foreignKey.association: '_PurchaseOrderStatus'
  key    refbn                  as PurchasingDocument, // Purchasing Document Number

  key    case
       when refbt = '010' then 'PReq'
       when refbt = '020' then 'POrd'
       when refbt = '030' then 'MatR'
       when refbt = '100' then 'EFnd'
       when refbt = '200' then 'TPAg'
      end                       as ControllingCommitmentCategory,
         @ObjectModel.foreignKey.association: '_PurchasingDocumentItem'
  key    rfpos                  as PurchasingDocumentItem,

  key    rfknt                  as RefDocAccountAssignment,
  key    rftrm                  as ReferenceDocumentScheduleLine,
  key    rfart                  as CommitmentDocumentType, //PurchasingDocumentType,
         @ObjectModel.foreignKey.association: '_Supplier'
         @ObjectModel.text.element: ['SupplierName']
  key    lifnr                  as Supplier,
  key    lednr                  as ControllingLedger,
  key    objnr                  as ControllingObject,
  key    hrkft                  as ControllingKeySubNumber,
  key    rforg                  as ReferenceDocumentContext,
  key    rftyp                  as SourceReferenceDocumentType,
  key    rfsys                  as SourceRefDocLogicalSystem,

         _PurchasingDocumentItem.PurchasingDocumentItemText,

         @ObjectModel.foreignKey.association: '_FiscalYear'
         @Semantics.fiscal.year: true
         gjahr                  as FiscalYear,
         @ObjectModel.foreignKey.association: '_ControllingValueType'
         wrttp                  as ControllingValueType,
         @ObjectModel.foreignKey.association: '_CostElement'
         sakto                  as CostElement,

         bldat                  as DocumentDate,

         budat                  as PostingDate, //Posting Date
         @ObjectModel.foreignKey.association: '_FiscalPeriod'
         perio                  as FiscalPeriod,
         @ObjectModel.foreignKey.association: '_CompanyCode'
         bukrs                  as CompanyCode,
         @ObjectModel.foreignKey.association: '_ControllingArea'
         kokrs                  as ControllingArea, //Derive Fiscal Year Variant...
         @ObjectModel.foreignKey.association: '_Material'
         matnr                  as Material,
         @ObjectModel.foreignKey.association: '_BaseUnit'
         @Semantics.unitOfMeasure:true
         meinh                  as UnitOfMeasure,
         @ObjectModel.foreignKey.association: '_TransactionCurrency'
         @Semantics.currencyCode: true
         twaer                  as TransactionCurrency,
         @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
         @Aggregation.default: #SUM
         megbtr                 as TotalQuantity,
         @Semantics.amount.currencyCode: 'TransactionCurrency'
         @DefaultAggregation: #SUM
         wtgbtr                 as AmountInTransactionCurrency,
         @Semantics.amount.currencyCode: 'TransactionCurrency'
         @DefaultAggregation: #SUM
         orgwtk                 as OrderAmount,
         @Semantics.amount.currencyCode: 'TransactionCurrency'
         @DefaultAggregation: #SUM
         wkgbtr                 as AmountInCtrlgAreaCrcy,
         wogbtr                 as AmountInObjectCurrency,
         whgbtr                 as AmountInCompanyCodeCurrency,
         _ControllingValueType,
         _BaseUnit,
         _TransactionCurrency,
         _Material,
         _ControllingArea,
         _CompanyCode,
         _FiscalPeriod,
         _CostElement,
         _FiscalYear,
         _Supplier,
         _Supplier.SupplierName as SupplierName,
         _PurchaseOrderStatus,
         _PurchasingDocumentItem,
         _Product,
         _CostCenter
}

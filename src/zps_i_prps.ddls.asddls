@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gasline: PRPS Basic Interface View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPS_I_PRPS
  as select from prps
{
  key pspnr         as Pspnr,
      posid         as Posid,
      post1         as Post1,
      psphi         as Psphi,
      objnr         as Objnr,
      zzgsbudgetpos as Zzgsbudgetpos
}

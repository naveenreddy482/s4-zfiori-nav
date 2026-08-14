@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order by Project Number'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPS_I_ORDERBYPROJECTNR
  as select distinct from prps as PRPS
  association [0..*] to aufk as _AUFK on $projection.Pspnr = _AUFK.pspel
{
  key PRPS.pspnr           as Pspnr,
      PRPS.posid           as Posid,
      PRPS.post1           as Post1,
      PRPS.objnr           as Objnr,
      PRPS.psphi           as Psphi,
      _AUFK.aufnr          as OrderNr,
      _AUFK.objnr          as OrderObj,
      _AUFK
}

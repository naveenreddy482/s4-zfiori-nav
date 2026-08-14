@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order Assignment to WBS'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCO_I_GS_R_ORDERZUORDPSP
  as select from prps as _prps
  right outer join ZCO_I_GS_R_ORDERZUORDKNA as _aufk on _prps.pspnr = _aufk.pspel
  association [0..*] to proj as _proj on $projection.psphi = _proj.pspnr
{
  key _prps.pspnr,
  key _aufk.aufnr,
  key _proj.pspid,
  key _prps.psphi,
      _prps.posid,
      _prps.post1 as WBSElementIDShortDescription,
      _proj.post1 as ProjectIDShortDescription,
      _aufk.ControllingObject,
      _aufk.OrderIDShortDescription,
      _aufk.auart,
      _aufk.aufex,
      _aufk.erdat,
      _aufk.user0,
      _aufk.user2,
      _aufk.kokrs
}

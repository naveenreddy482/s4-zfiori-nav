@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GasLine: Mapping Orders & WBS-Elements'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCO_I_GS_PS_ORDER_WBS
  as select from prps as _prps
  inner join ZPS_I_AUFK as _aufk on  _prps.pspnr = _aufk.WBSElementInternalID
  association [0..*] to proj as _proj on $projection.psphi = _proj.pspnr
{
  key _prps.pspnr,
  key _aufk.OrderID,
  key _proj.pspid,
  key _prps.psphi,
      _prps.posid,
      _prps.post1 as WBSElementIDShortDescription,
      _proj.post1 as ProjectIDShortDescription,
      _aufk.ControllingObject,
      _aufk.OrderShortDescription,
      _aufk.OrderType,
      _aufk.ExternalOrderID,
      _aufk.CreatedOnDate,
      _aufk.UserField0,
      _aufk.UserField2,
      _aufk.ControllingArea
}
where
  _aufk.ControllingArea = '0048'

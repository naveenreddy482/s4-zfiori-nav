@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order Status'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCO_I_GS_R_ORDERSTATUS
  as select from jest
  association [0..1] to I_SystemStatusText as _SystemStatusText on  _SystemStatusText.SystemStatus = jest.stat
                                                                and _SystemStatusText.Language     = 'D'
  association [0..1] to ZPS_I_AUFK       as _Order       on  _Order.ControllingObject = jest.objnr
{
  key jest.objnr as ControllingObject,
  key jest.stat  as ControllingObjectStatus,
      _SystemStatusText.SystemStatusName,
      _SystemStatusText.SystemStatusShortName,
      jest.inact as StatusIsInactive,
      jest.chgnr as StatusObjectStatusChangeNumber,
      _Order
}
where
  jest.inact = ' '

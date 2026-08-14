@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order Assignment'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCO_I_GS_R_ORDERZUORDKNA
  as select from ZPS_I_AUFK as _aufk
    left outer join ZCO_I_GS_R_ORDERSTATUS as stat on  stat.ControllingObject = _aufk.ControllingObject
                                              and (stat.SystemStatusShortName  = 'ABGS'
                                              or stat.SystemStatusShortName = 'LÖVM' )
{
  key _aufk.OrderID                    as aufnr,
      _aufk.ControllingObject          as ControllingObject,
      _aufk.OrderShortDescription      as OrderIDShortDescription,
      _aufk.WBSElementInternalID       as pspel,
      _aufk.OrderType                  as auart,
      _aufk.ExternalOrderID            as aufex,
      _aufk.CreatedOnDate              as erdat,
      _aufk.UserField0                 as user0,
      _aufk.UserField2                 as user2,
      _aufk.ControllingArea            as kokrs
}
where

stat.ControllingObject is null

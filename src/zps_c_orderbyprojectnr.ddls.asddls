@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order by Project Number'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPS_C_ORDERBYPROJECTNR
  as select from ZPS_I_ORDERBYPROJECTNR
  association [0..1] to I_Project as _Project on $projection.Psphi = _Project.ProjectInternalID
{
  key Pspnr,
      Posid,
      Post1,
      Objnr,
      Psphi,
      OrderNr,
      OrderObj,
      _Project.Project as ProjectID,
      _Project.ProjectDescription,
      /* Associations */
      _AUFK,
      _Project
}


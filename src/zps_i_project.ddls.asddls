@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gasline: Project Basic Interface View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPS_I_PROJECT
  as select from I_Project as _proj
{
  key _proj.Project            as ProjectId,
      _proj.ProjectInternalID  as ProjectInternalID,
      _proj.ProjectObject      as ProjectObject,
      _proj.ProjectDescription as ProjectDescription
}

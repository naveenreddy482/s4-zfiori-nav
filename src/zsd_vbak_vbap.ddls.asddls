@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales header/item join VBAK-VBAP'
@Analytics.dataExtraction.enabled: true
@Metadata.allowExtensions: true
define view entity ZSD_VBAK_VBAP
//  with parameters
//    P_vbeln : vbeln
  as select from vbak
    inner join   vbap on vbak.vbeln = vbap.vbeln
{
  key vbak.vbeln as vbeln,
  key vbap.posnr as posnr,
      vbak.erdat as erdat,
      vbak.ernam as ernam,
      vbap.matnr as matnr,
      vbap.matkl as matkl
}
//where
//  vbak.vbeln = $parameters.P_vbeln

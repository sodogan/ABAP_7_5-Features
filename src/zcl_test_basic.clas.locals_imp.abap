*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations


CLASS lcl_db_access IMPLEMENTATION.

  METHOD lif_db_access~select_carrier_details.
   select * from scarr
   INTO TABLE rt_carriers
   where carrid = carrier_id
   .
  ENDMETHOD.

ENDCLASS.

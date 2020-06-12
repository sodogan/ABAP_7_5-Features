CLASS zcl_test_basic DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: tt_carriers TYPE SORTED TABLE OF scarr WITH UNIQUE KEY carrid.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS:select_carrier_details IMPORTING if_db_access TYPE REF TO lif_db_access OPTIONAL
                                             carrier_id         TYPE sflight-carrid
                                   RETURNING VALUE(rt_carriers) TYPE tt_carriers.
    DATA: lif_db_access TYPE REF TO lif_db_access.
ENDCLASS.



CLASS zcl_test_basic IMPLEMENTATION.
  METHOD select_carrier_details.
  lif_db_access = cond #( when if_db_access is BOUND then if_db_access
                          else new  lcl_db_access(  )
                          ).

  rt_carriers = lif_db_access->select_carrier_details( carrier_id =  carrier_id ).

  ENDMETHOD.

ENDCLASS.

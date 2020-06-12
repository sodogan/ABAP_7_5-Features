*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section


INTERFACE lif_db_access.
  METHODS:select_carrier_details IMPORTING carrier_id         TYPE sflight-carrid
                                 RETURNING VALUE(rt_carriers) TYPE zcl_test_basic=>tt_carriers.

ENDINTERFACE.

CLASS lcl_db_access DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_db_access.
ENDCLASS.

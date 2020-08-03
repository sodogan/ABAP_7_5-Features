CLASS zcl_abap_internal_table_new DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC INHERITING FROM zcl_abstract_abap_new_features.

  PUBLIC SECTION.

    METHODS:internal_table_new REDEFINITION.
    METHODS: query_with_carrid_carrname IMPORTING carrid       TYPE scarr-carrid OPTIONAL
                                                  carrname     TYPE scarr-carrname OPTIONAL
                                                    PREFERRED PARAMETER carrid
                                        RETURNING VALUE(scarr) TYPE scarr
                                        .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abap_internal_table_new IMPLEMENTATION.

  METHOD internal_table_new.
    TYPES tt_index_table TYPE INDEX TABLE OF scarr.
    TYPES tt_string TYPE STANDARD TABLE OF string WITH EMPTY KEY.
    TYPES tt_int TYPE STANDARD TABLE OF i WITH EMPTY KEY.

    DATA(int_values) = VALUE tt_int( LET max = 10 IN FOR i = 0 THEN i + 1 UNTIL i > max ( i ) ).
    int_values = VALUE tt_int( LET max = 10 IN FOR i = 0 THEN i + 1 WHILE i > max ( i ) ).
    "find
    DATA(test) = VALUE tt_int(  FOR j = 1 THEN j + 1 UNTIL j > lines( int_values ) ( int_values[ j ] ) ).

    DATA(words) = `Hello guys from here`.
    DATA(characters) = VALUE tt_string(  FOR i = 0  THEN   i + 1 UNTIL i > 10  ( words+i(1) )  ).

*   SELECT DISTINCT * FROM @characters AS characters INTO TABLE @DATA(unique_characters).



    DATA(basedon_carrid) = query_with_carrid_carrname( 'AA' ).

    DATA(basedon_carrname) = query_with_carrid_carrname( carrname = 'American Airlines' ).


  ENDMETHOD.



  METHOD query_with_carrid_carrname.
    TYPES:tt_scarr_hashed_table TYPE HASHED TABLE OF scarr WITH UNIQUE  KEY carrid
                                     WITH NON-UNIQUE SORTED KEY name  COMPONENTS carrname.
    DATA: scarr_hashed_table TYPE tt_scarr_hashed_table.

    SELECT * FROM scarr
    INTO TABLE @scarr_hashed_table.


    IF carrid IS SUPPLIED.
* read table-Notice that its doing a search on Primary Key
      READ TABLE scarr_hashed_table INTO scarr
      WITH TABLE KEY carrid = carrid.
      RETURN.
    ENDIF.

    IF carrname IS SUPPLIED.
* read table-Notice that its doing a search on Primary Key
      READ TABLE scarr_hashed_table INTO scarr
      WITH KEY name COMPONENTS carrname = carrname.
      RETURN.
    ENDIF.


  ENDMETHOD.

ENDCLASS.

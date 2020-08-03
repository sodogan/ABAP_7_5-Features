CLASS zcl_abap_select_new DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC INHERITING FROM zcl_abstract_abap_new_features.

  PUBLIC SECTION.
    CONSTANTS: expensive TYPE string VALUE 'Expensive',
               medium    TYPE string VALUE 'Medium',
               cheap     TYPE string VALUE 'Cheap'.

    TYPES:ty_carrid_range TYPE RANGE OF scarr-carrid.
    METHODS:select_new REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS: get_carrid_range RETURNING VALUE(carrid_ranges) TYPE ty_carrid_range.
    METHODS:can_query_buffered.
ENDCLASS.



CLASS ZCL_ABAP_SELECT_NEW IMPLEMENTATION.


  METHOD can_query_buffered.
    DATA: lt_test TYPE STANDARD TABLE OF t000 WITH UNIQUE SORTED KEY pk COMPONENTS ort01.
*buffered table
    SELECT * FROM t000
      INTO TABLE @lt_test
      WHERE ort01 = 'Walldorf'
      .

    SELECT * FROM t000
      INTO TABLE @data(lt_bypass)
      WHERE ort01 = 'Walldorf'
      .

  ENDMETHOD.


  METHOD get_carrid_range.
*New features
    SELECT  FROM scarr
   FIELDS 'I' AS sign,
          'EQ' AS option,
          carrid AS low,
          ' ' AS high
    WHERE currcode = 'USD'
    INTO TABLE @DATA(lr_carrid).
    carrid_ranges = lr_carrid.
  ENDMETHOD.


  METHOD select_new.
    out->begin_section(`Starting SELECT_NEW:` ).

*or same as above can be achieved
    DATA(lr_carriers) = get_carrid_range( ).



* Based on the range select the flights
    DATA(upper_range) = 800.

    SELECT carrid,
           connid,
      CASE
      WHEN price > @upper_range THEN 'Expensive'
      WHEN price > 600 AND price < 800 THEN 'Medium'
      ELSE     'Cheap'
      END AS cost,
      currency
      FROM   sflight
     WHERE carrid IN @lr_carriers
     INTO TABLE @DATA(lt_flights).

    DATA: lt_flights_new TYPE STANDARD TABLE OF scarr WITH DEFAULT KEY.


** select with case
*    CONSTANTS: lc_scary1 TYPE string VALUE 'SLIGHTLY SCARY',
*               lc_scary2 TYPE string VALUE 'REALLY SCARY',
*               lc_scary3 TYPE string VALUE 'NORMAL'.

*    SELECT monster_name, monster_number
*    CASE
*    when sanity <= 10 AND strength >= 75 THEN @lc_scary2
*    WHEN sanity <= 25 AND strength >= 50 THEN @lc_scary1
*    ELSE @lc_scary3
*    END AS scariness_string
*    FROM zt_monsters
*    WHERE monster_number = @ld_monster_number
*    INTO CORRESPONDING FIELDS of @lt_monsters

    out->write( lt_flights ).


    out->end_section( ).
  ENDMETHOD.
ENDCLASS.

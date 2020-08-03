CLASS zcl_abap_inline_ref DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC INHERITING FROM zcl_abstract_abap_new_features .

  PUBLIC SECTION.
    METHODS:inline_ref REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abap_inline_ref IMPLEMENTATION.
  METHOD inline_ref.
    DATA:lr_ref_old TYPE REF TO data.
    out->begin_section(`Starting INLINE_REF:` ).

*create a ref object
    CREATE DATA lr_ref_old TYPE ('SCARR').
    ASSIGN lr_ref_old->* TO  FIELD-SYMBOL(<lfs_ref_old>).
    IF sy-subrc EQ 0.
      <lfs_ref_old> = VALUE scarr( carrid = 'AA' carrname = 'American Airlines'  ).
    ENDIF.

*Directly with New-but lose the type as its type ref to data
    lr_ref_old = NEW scarr( carrid = 'AA' carrname = 'American Airlines'  ).

*Inline way-type saved
    DATA(lr_scarr_new) = NEW scarr( carrid = 'AA' carrname = 'American Airlines'  ).


*if need to cast-type ref to data USE CAST!
    CAST  scarr( lr_ref_old )->carrid = 'AA'.

* Use of the Get reference ..
    DATA(ls_scarr) = VALUE scarr( carrid = 'BB' carrname ='Bulgarian Airlines' ).
    GET REFERENCE OF ls_scarr INTO DATA(lr_scarr_ref_old).

*New syntax
    DATA(lr_scarr_ref_new) = REF #( lr_scarr_new ).


*quit is marked as NO otherwise it will throw an exception
* Use it just carefully!
    IF cl_abap_unit_assert=>assert_equals( msg = 'The two should be equal'
                                        exp = 5
                                        act = 5
                                        quit = if_aunit_constants=>no ) EQ abap_true.

      out->write( |The two are diffrent: { xsdbool( 1 = 1 ) }| ).
    ELSE.
      out->write( |The two are the same: { xsdbool( 1 = 1 ) }| ).

    ENDIF.
    out->end_section( ).
  ENDMETHOD.

ENDCLASS.

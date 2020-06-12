*"* use this source file for your ABAP unit test classes

CLASS lcl_test DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.
  PUBLIC SECTION.
    METHODS test_assert_boolc FOR TESTING RAISING cx_static_check.

  PRIVATE SECTION.
    METHODS test_assert_xsdbool FOR TESTING RAISING cx_static_check.
    METHODS test_assert_true FOR TESTING RAISING cx_static_check.
    METHODS test_assert_false FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS lcl_test IMPLEMENTATION.

*/
* boolc( 1 = 2 ) will not return abap_false but ` ` a string type
* So do not use boolc for abap_bool types-Use xsdbool instead!
*/
  METHOD test_assert_boolc.


* Abap_false is any length char as you see abap_false = ' '
    IF ( '' <> abap_false ) OR ( '  ' <> abap_false ).
      cl_abap_unit_assert=>fail( |Basic test on abap_false | ).
    ENDIF.



* THis statement will fail as comparing string with char1 like boolc
    IF ( ` ` <> abap_false ) ." '' equals to ``
*      cl_abap_unit_assert=>fail( | Compare string versus char1 | ).
    ENDIF.


* Funny things about boolc-this will work
    IF boolc( 1 = 1 ) <> abap_true.
      cl_abap_unit_assert=>fail( | Working: {  boolc( 1 = 1 ) } should be equal to { abap_true }| ).
    ENDIF.

*Negate-would not work
*Do not use boolc as it converts into string then char-use xsdbool instead
    IF boolc( 1 = 2 ) <> abap_false."boolc( 1 = 2 ) returns actually ` ` not ``
      cl_abap_unit_assert=>fail( | Failing: {  boolc( 1 = 2 ) } should be equal to { abap_false }| ).
    ENDIF.

*    cl_abap_unit_assert=>assert_equals( msg = 'msg' exp = exp act = act ).

*    cl_abap_unit_assert=>assert_true(
*      act              = lv_boolean_true
*      msg              = |is_bar Method fails with Input { lv_boolean_true } |
*  ).


  ENDMETHOD.


  METHOD test_assert_xsdbool.


* xsdbool has no issues like boolc
    IF xsdbool( 1 = 1 ) <> abap_true.
      cl_abap_unit_assert=>fail( |{  xsdbool( 1 = 1 ) } should be equal to { abap_true }| ).
    ENDIF.

*Negate-would work
    IF xsdbool( 1 = 2 ) <> abap_false."boolc( 1 = 2 ) returns actually ` ` not ``
      cl_abap_unit_assert=>fail( |{  xsdbool( 1 = 2 ) } should be equal to { abap_false }| ).
    ENDIF.

  ENDMETHOD.


  METHOD test_assert_true.

    cl_abap_unit_assert=>assert_true(
        act              =  COND #( WHEN xsdbool( 1 = 1 ) = abap_true THEN abap_true
                                 ELSE abap_false )                           " Actual value
        msg              = |xsdbool checks are  always true|                             " Description
   ).

    DATA(lv_flag) = abap_true.
    DATA(ls_scarr) = VALUE scarr( carrid = Cond #( when lv_flag EQ abap_false then 'AA' ) ).

    cl_abap_unit_assert=>assert_true(
        act              =  COND #( WHEN ls_scarr is INITIAL THEN abap_true
                                 ELSE abap_false )                           " Actual value
        msg              = |xsdbool checks are  always true|                             " Description
   ).


  ENDMETHOD.



  METHOD test_assert_false.

    DATA(lv_false) = COND #( WHEN boolc( 1 = 1 ) = abap_true THEN abap_true
                                 ELSE abap_false ).


    cl_abap_unit_assert=>assert_false(
        act              =  COND #( WHEN xsdbool( 1 = 2 ) = abap_false THEN abap_false
                                 ELSE abap_false )                           " Actual value
        msg              = |xsdbool checks are  always true|                             " Description
   ).
  ENDMETHOD.




ENDCLASS.

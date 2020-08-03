CLASS zcl_abstract_abap_new_features DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    INTERFACES zif_abstract_abap_new_features.
    ALIASES: main FOR if_oo_adt_classrun~main.
    ALIASES: inline_ref FOR zif_abstract_abap_new_features~inline_ref.
    ALIASES: inline_data FOR zif_abstract_abap_new_features~inline_data.
    ALIASES: for_statement FOR zif_abstract_abap_new_features~for_statement.
    ALIASES: switch_cond_statement FOR zif_abstract_abap_new_features~switch_cond_statement.
    ALIASES: table_statement FOR zif_abstract_abap_new_features~table_statement.
    ALIASES: select_new FOR zif_abstract_abap_new_features~select_new.
    ALIASES: internal_table_new FOR zif_abstract_abap_new_features~internal_table_new.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abstract_abap_new_features IMPLEMENTATION.


  METHOD main.
    " Call the abstract methods one by one.
    out->begin_section( `Executing the main:... ` ).
    internal_table_new( out = out ).
    select_new( out = out ).
    inline_ref( out = out ).
    inline_data( out = out ).
    for_statement( out = out ).
    switch_cond_statement( out = out ).
    table_statement( out = out ).
    out->begin_section( `End of  the main:... ` ).

  ENDMETHOD.

ENDCLASS.

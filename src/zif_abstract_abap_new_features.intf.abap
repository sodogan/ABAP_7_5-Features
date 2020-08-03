
INTERFACE zif_abstract_abap_new_features
  PUBLIC .
  METHODS: inline_data DEFAULT IGNORE  IMPORTING out TYPE REF TO if_oo_adt_intrnl_classrun.
  METHODS: inline_ref DEFAULT IGNORE  IMPORTING out TYPE REF TO if_oo_adt_intrnl_classrun.
  METHODS: internal_table_new DEFAULT IGNORE  IMPORTING out TYPE REF TO if_oo_adt_intrnl_classrun.
  METHODS: select_new DEFAULT IGNORE  IMPORTING out TYPE REF TO if_oo_adt_intrnl_classrun.
  METHODS: for_statement  DEFAULT IGNORE  IMPORTING out TYPE REF TO if_oo_adt_intrnl_classrun.
  METHODS: switch_cond_statement DEFAULT IGNORE IMPORTING out TYPE REF TO if_oo_adt_intrnl_classrun.
  METHODS: table_statement   DEFAULT IGNORE  IMPORTING out TYPE REF TO if_oo_adt_intrnl_classrun.

ENDINTERFACE.

CLASS zcl_att_trace_transaction DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        i_root_span TYPE REF TO zcl_att_span.
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA root_span TYPE REF TO zcl_att_span.

ENDCLASS.



CLASS zcl_att_trace_transaction IMPLEMENTATION.

  METHOD constructor.

    root_span = NEW #( ).

  ENDMETHOD.

ENDCLASS.

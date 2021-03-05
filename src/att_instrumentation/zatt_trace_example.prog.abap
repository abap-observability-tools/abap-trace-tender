*&---------------------------------------------------------------------*
*& Report zatt_trace_example
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zatt_trace_example.

START-OF-SELECTION.

  DATA(trace_transaction) = NEW zcl_att_trace_transaction( ).

  DATA(root_span) = trace_transaction->get_root_span( ).

  root_span->add_span( ).

  root_span->add_span( ).

  trace_transaction->push_trace( ).

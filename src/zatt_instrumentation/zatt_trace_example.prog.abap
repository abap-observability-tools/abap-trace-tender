*&---------------------------------------------------------------------*
*& Report zatt_trace_example
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zatt_trace_example.

START-OF-SELECTION.

  DATA(trace_transaction) = NEW zcl_att_trace_transaction( 'root_span' ).

  DATA(root_span) = trace_transaction->get_root_span( ).

  DATA(span1) = root_span->add_span( 'span1' ).
  span1->start( ).
  WAIT UP TO 2 SECONDS.
  span1->end( ).

  DATA(span2) = root_span->add_span( 'span2' ).
  span2->start( ).
  WAIT UP TO 4 SECONDS.
  span2->end( ).

  trace_transaction->push_trace( ).

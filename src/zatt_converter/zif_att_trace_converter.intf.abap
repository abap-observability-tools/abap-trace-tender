INTERFACE zif_att_trace_converter
  PUBLIC.

  TYPES: BEGIN OF ty_converted_trace,
           trace_id TYPE sysuuid_c32,
           json     TYPE string,
         END OF ty_converted_trace.

  METHODS convert
    IMPORTING trace                  TYPE REF TO zcl_att_trace_transaction
              customizing            TYPE REF TO zcl_att_customizing
    RETURNING VALUE(converted_trace) TYPE ty_converted_trace.

ENDINTERFACE.

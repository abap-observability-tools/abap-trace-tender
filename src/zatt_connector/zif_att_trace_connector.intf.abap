INTERFACE zif_att_trace_connector
  PUBLIC.

  METHODS connect
    IMPORTING converted_trace TYPE zif_att_trace_converter=>ty_converted_trace
              customizing     TYPE REF TO zcl_att_customizing.

ENDINTERFACE.

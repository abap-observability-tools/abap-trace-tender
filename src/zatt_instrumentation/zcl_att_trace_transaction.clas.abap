CLASS zcl_att_trace_transaction DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES ty_trace_id TYPE sysuuid_c32.

    METHODS constructor
      IMPORTING name TYPE string.
    METHODS get_trace_id RETURNING VALUE(trace_id) TYPE ty_trace_id.
    METHODS get_root_span
      RETURNING VALUE(span) TYPE REF TO zcl_att_span.
    METHODS push_trace.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA root_span TYPE REF TO zcl_att_span.
    DATA trace_id TYPE ty_trace_id.

ENDCLASS.



CLASS zcl_att_trace_transaction IMPLEMENTATION.

  METHOD constructor.

    TRY.
        me->trace_id = cl_system_uuid=>create_uuid_c32_static( ).
      CATCH cx_uuid_error.
        ASSERT 1 = 2.
    ENDTRY.

    me->root_span = NEW #( name ).
    me->root_span->start( ).

  ENDMETHOD.

  METHOD get_trace_id.
    trace_id = me->trace_id.
  ENDMETHOD.

  METHOD get_root_span.
    span = root_span.
  ENDMETHOD.

  METHOD push_trace.

    me->root_span->end( ).

    DATA(customizing) = NEW zcl_att_customizing_base( scenario = 'example' ).
    DATA(converter) = customizing->get_converter_class( ).

    DATA(converted_trace) = converter->convert( trace = me
                                                customizing = customizing ).
  ENDMETHOD.

ENDCLASS.

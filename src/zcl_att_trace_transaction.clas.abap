CLASS zcl_att_trace_transaction DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES ty_trace_id TYPE sysuuid_c32.

    METHODS constructor.
    METHODS get_trace_id RETURNING VALUE(trace_id) TYPE ty_trace_id.

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

    me->root_span = NEW #( ).

  ENDMETHOD.

  METHOD get_trace_id.
    trace_id = me->trace_id.
  ENDMETHOD.

ENDCLASS.

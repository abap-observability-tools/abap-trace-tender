CLASS zcl_att_trace_transaction DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor.
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA root_span TYPE REF TO zcl_att_span.
    DATA trace_id TYPE sysuuid_c32.

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

ENDCLASS.

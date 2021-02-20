CLASS zcl_att_span DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_att_trace_transaction.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING parent_span_id TYPE sysuuid_x16 OPTIONAL.

    METHODS add_span
      IMPORTING
                parent_span_id TYPE sysuuid_x16
      RETURNING VALUE(span)    TYPE REF TO zcl_att_span.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA span_id TYPE sysuuid_x16.

ENDCLASS.



CLASS zcl_att_span IMPLEMENTATION.

  METHOD constructor.

    TRY.
        me->span_id = cl_system_uuid=>create_uuid_x16_static( ).
      CATCH cx_uuid_error.
        ASSERT 1 = 2.
    ENDTRY.

  ENDMETHOD.

  METHOD add_span.

    span = NEW #( me->span_id ).

  ENDMETHOD.

ENDCLASS.

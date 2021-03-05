CLASS zcl_att_span DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_att_trace_transaction.

  PUBLIC SECTION.

    TYPES ty_span_id TYPE sysuuid_x16.

    TYPES: BEGIN OF ty_span_child,
             span_id TYPE ty_span_id,
             span    TYPE REF TO zcl_att_span,
           END OF ty_span_child.

    TYPES ty_span_childs TYPE STANDARD TABLE OF ty_span_child WITH KEY span_id.

    METHODS constructor.
    METHODS get_span_id
      RETURNING VALUE(span_id) TYPE  ty_span_id.
    METHODS add_span.
    METHODS get_span_childs
      RETURNING VALUE(span_childs) TYPE ty_span_childs.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA span_id TYPE ty_span_id.
    DATA span_childs TYPE ty_span_childs.

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

    DATA(span) = NEW zcl_att_span( ).

    span_childs = VALUE #( BASE span_childs ( span_id = span->get_span_id( )
                                              span = span ) ).

  ENDMETHOD.

  METHOD get_span_id.
    span_id = me->span_id.
  ENDMETHOD.

  METHOD get_span_childs.
    span_childs = me->span_childs.
  ENDMETHOD.

ENDCLASS.

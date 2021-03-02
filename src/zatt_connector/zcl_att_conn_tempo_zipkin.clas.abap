CLASS zcl_att_conn_tempo_zipkin DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_att_trace_connector.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_att_conn_tempo_zipkin IMPLEMENTATION.
  METHOD zif_att_trace_connector~connect.

    DATA xjson TYPE xstring.
    DATA text TYPE string.

    DATA(tempo_zipkin_url) = customizing->get_connector_url( ).


    cl_http_client=>create_by_url( EXPORTING
                                      url                = CONV #( tempo_zipkin_url )
                                    IMPORTING
                                      client             = DATA(client)
                                    EXCEPTIONS
                                      argument_not_found = 1
                                      plugin_not_active  = 2
                                      internal_error     = 3
                                      OTHERS             = 4 ).
      IF sy-subrc <> 0.
        ASSERT 1 = 2.
      ENDIF.

      client->request->set_method( 'POST' ).
      client->request->set_content_type( 'application/json' ).

      text = converted_trace-json.

      CALL FUNCTION 'SCMS_STRING_TO_XSTRING'
        EXPORTING
          text   = text
*         mimetype = SPACE
*         encoding =
        IMPORTING
          buffer = xjson
        EXCEPTIONS
          failed = 1
          OTHERS = 2.
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                   WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.

      client->request->set_data( xjson ).

      client->send(
        EXCEPTIONS
          http_communication_failure = 1
          http_invalid_state         = 2
          http_processing_failed     = 3
          http_invalid_timeout       = 4
          OTHERS                     = 5 ).
      IF sy-subrc <> 0.
        ASSERT 1 = 2.
      ENDIF.

      client->receive(
        EXCEPTIONS
          http_communication_failure = 1
          http_invalid_state         = 2
          http_processing_failed     = 3
          OTHERS                     = 4 ).
      IF sy-subrc <> 0.
        client->response->get_status( IMPORTING
                                          code   = DATA(http_code)
                                          reason = DATA(reason) ).
        ASSERT 1 = 2.
      ENDIF.


  ENDMETHOD.

ENDCLASS.

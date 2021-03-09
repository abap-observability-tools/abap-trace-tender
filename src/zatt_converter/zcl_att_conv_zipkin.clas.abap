CLASS zcl_att_conv_zipkin DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_att_trace_converter.

  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS compose_json_from_span
      IMPORTING
                trace_id    TYPE zcl_att_trace_transaction=>ty_trace_id
                span        TYPE REF TO zcl_att_span
      RETURNING VALUE(json) TYPE string.
    METHODS convert_timestamp
      IMPORTING
        timestamp                  TYPE timestamp
      RETURNING
        VALUE(converted_timestamp) TYPE string.

ENDCLASS.



CLASS zcl_att_conv_zipkin IMPLEMENTATION.



  METHOD zif_att_trace_converter~convert.

    DATA(trace_id) = trace->get_trace_id( ).
    DATA(root_span) = trace->get_root_span( ).

    DATA(span_json) = compose_json_from_span( trace_id = trace_id
                                              span = root_span ).

    DATA(zipkin_json) = |[ { span_json } ]|.

    converted_trace-trace_id = trace_id.
    converted_trace-json = zipkin_json.


  ENDMETHOD.

  METHOD compose_json_from_span.

    DATA(spans) = span->get_span_childs( ).

    LOOP AT spans ASSIGNING FIELD-SYMBOL(<span>).
      DATA(json_tmp) = compose_json_from_span( trace_id = trace_id
                                               span = <span>-span ).
      json = json && json_tmp.
    ENDLOOP.

    span->get_start_and_end(
      IMPORTING
        timestamp_start = DATA(timestamp_start)
        timestamp_end   = DATA(timestamp_end)
    ).
    DATA(span_id) = span->get_span_id( ).
    DATA(timestamp_converted) = convert_timestamp( timestamp_start ).
    DATA(duration) = timestamp_end - timestamp_start.
    DATA(name) = span->get_name( ).


    json = json && |\{ "span_id": "{ span_id }",| &&
                   |   "traceId": "{ trace_id }",| &&
                   |   "timestamp": "{ timestamp_converted }",| &&
                   |   "duration": "{ duration }",| &&
                   |   "name": "{ name }"\},|.

*  [{
* "id": "11123456",
* "traceId": "0123456789abcdef",
* "timestamp": 1608239395286533,
* "duration": 100000,
* "name": "span from ABAPTAG1!",
* "description": "description",
* "tags": {
*    "http.method": "GET",
*    "http.path": "/dummy",
*    "tag1": "tag1",
*    "tag2": "tag2"
*  },
*  "localEndpoint": {
*    "serviceName": "shell script"
*  }
*},
*{
* "id": "111234567",
* "traceId": "0123456789abcdef",
* "timestamp": 1608239495287533,
* "duration": 100000,
* "name": "span from ABAPTAG2!",
* "kind": "SERVER",
* "tags": {
*    "http.method": "GET",
*    "http.path": "/dummy",
*    "tag1": "tag1",
*    "tag2": "tag2"
*  },
*  "localEndpoint": {
*    "serviceName": "shell script"
*  }
*},
*{
*    "id": "352bff9a74ca9ad2",
*    "traceId": "0123456789abcdef",
*    "parentId": "111234567",
*    "name": "get /api",
*    "timestamp": 1556604172355737,
*    "duration": 1431,
*    "kind": "SERVER",
*    "localEndpoint": {
*      "serviceName": "backend",
*      "ipv4": "192.168.99.1",
*      "port": 3306
*    },
*    "remoteEndpoint": {
*      "ipv4": "172.19.0.2",
*      "port": 58648
*    },
*    "tags": {
*      "http.method": "GET",
*      "http.path": "/api"
*    }
*  }]

  ENDMETHOD.


  METHOD convert_timestamp.

    TRY.
        DATA(seconds) = cl_abap_timestamp_util=>get_instance( )->tstmpl_seconds_between( iv_timestamp0 = '19700101000000'
                                                                                         iv_timestamp1 = CONV #( timestamp ) ).

        converted_timestamp = seconds * 1000.

      CATCH cx_parameter_invalid_range.
        ASSERT 1 = 2.
    ENDTRY.

  ENDMETHOD.

ENDCLASS.

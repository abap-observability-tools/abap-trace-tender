CLASS zcl_att_conv_zipkin DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_att_trace_converter.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_att_conv_zipkin IMPLEMENTATION.



  METHOD zif_att_trace_converter~convert.

    DATA(trace_id) = trace->get_trace_id( ).

    DATA(zipkin_json) = |[\{| &&
                           |"id": "dummy",| &&
                           |"traceId": "{ trace_id }",| &&
                           |\}]|.

    converted_trace-trace_id = trace_id.
    converted_trace-json = zipkin_json.

*  [{
* "id": "11123456",
* "": "0123456789abcdef",
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

ENDCLASS.

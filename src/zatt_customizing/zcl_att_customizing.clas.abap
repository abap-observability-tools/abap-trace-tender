CLASS zcl_att_customizing DEFINITION PUBLIC ABSTRACT.
  PUBLIC SECTION.

    METHODS constructor
      IMPORTING scenario TYPE zatt_config-trace_scenario.

    METHODS get_converter_class ABSTRACT
      RETURNING VALUE(converter_class) TYPE REF TO zif_att_trace_converter.

    METHODS get_connector_class ABSTRACT
      RETURNING VALUE(connector_class) TYPE REF TO zif_att_trace_connector.

    METHODS get_connector_url ABSTRACT
      RETURNING VALUE(connector_url) TYPE zatt_config-connector_url.

  PROTECTED SECTION.

    DATA scenario TYPE zatt_config-trace_scenario.
    DATA configuration TYPE zatt_config.

  PRIVATE SECTION.

    METHODS set_scenario
      IMPORTING scenario TYPE zatt_config-trace_scenario.

ENDCLASS.

CLASS zcl_att_customizing IMPLEMENTATION.
  METHOD constructor.

    me->set_scenario( scenario ).

  ENDMETHOD.

  METHOD set_scenario.

    me->scenario = scenario.

    SELECT SINGLE *
      FROM zatt_config
      INTO @configuration
      WHERE trace_scenario = @scenario.
    IF sy-subrc <> 0.
      ASSERT 1 = 2.
    ENDIF.

  ENDMETHOD.

ENDCLASS.

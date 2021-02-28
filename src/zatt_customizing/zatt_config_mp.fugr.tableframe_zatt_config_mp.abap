*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZATT_CONFIG_MP
*   generation date: 28.02.2021 at 09:53:07
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZATT_CONFIG_MP     .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.

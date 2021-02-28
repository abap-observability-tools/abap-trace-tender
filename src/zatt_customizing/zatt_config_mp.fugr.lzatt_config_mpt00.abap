*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 28.02.2021 at 09:53:08
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZATT_CONFIG.....................................*
DATA:  BEGIN OF STATUS_ZATT_CONFIG                   .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZATT_CONFIG                   .
CONTROLS: TCTRL_ZATT_CONFIG
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZATT_CONFIG                   .
TABLES: ZATT_CONFIG                    .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .

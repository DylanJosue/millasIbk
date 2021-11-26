@allConsultCustomer
Feature: Consult customer Bim

  @Automated @Happy_path @functional_testing
  Scenario Outline: Valida consulta cliente con numero de documento DNI, CE y PASAPORTE
    Given que el cliente accede a la aplicacion
    When el cliente consulta <status>, <flgConsent>, <searchKey>, <startDate>, <endDate>, <page>, <size> y <direction>
    Then valida la consulta es satisfactorio

    Examples: Consulta con numero de documento DNI
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          | 50501680  | 2018-01-01 | 2021-06-14 | null | null | ASC       |

    Examples: Consulta con numero de documento CE
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          | CE100004  | 2018-01-01 | 2021-06-14 | null | null | ASC       |

    Examples: Consulta con numero de documento PASAPORTE
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          | AD100004  | 2018-01-01 | 2021-06-14 | null | null | ASC       |

  @Automated @Happy_path @functional_testing
  Scenario Outline: Valida Consulta cliente con codigo unico
    Given que el cliente accede a la aplicacion
    When el cliente consulta <status>, <flgConsent>, <searchKey>, <startDate>, <endDate>, <page>, <size> y <direction>
    Then valida consulta con codigo unico

    Examples: Consulta con codigo unico
      | status | flgConsent | searchKey  | startDate  | endDate    | page | size | direction |
      | 1      | S          | 0060102457 | 2018-01-01 | 2021-06-14 | null | null | ASC       |

  @Automated @Happy_path @functional_testing
  Scenario Outline: Valida filtrar por correo electrónico del cliente
    Given que el cliente accede a la aplicacion
    When el cliente consulta <status>, <flgConsent>, <searchKey>, <startDate>, <endDate>, <page>, <size> y <direction>
    Then valida consulta con correo electronico

    Examples: Filtrar por correo del cliente
      | status | flgConsent | searchKey                     | startDate  | endDate    | page | size | direction |
      | 1      | S          | PRUEBA.BENNI.EVERIS@GMAIL.COM | 2018-01-01 | 2021-06-14 | null | null | ASC       |

  @Automated @Happy_path @functional_testing
  Scenario Outline: Valida filtrar cliente con id bim
    Given que el cliente accede a la aplicacion
    When el cliente consulta <status>, <flgConsent>, <searchKey>, <startDate>, <endDate>, <page>, <size> y <direction>
    Then valida la consulta con id bim

    Examples: Consulta con id bim
      | status | flgConsent | searchKey                            | startDate  | endDate    | page | size | direction |
      | 1      | S          | 26AFB926-BFC9-4A78-84AA-7531EC882017 | 2018-01-01 | 2021-06-14 | null | null | ASC       |

  @Automated @Happy_path @functional_testing
  Scenario Outline: Valida filtrar por primer y segunda nombre del cliente
    Given que el cliente accede a la aplicacion
    When el cliente consulta <status>, <flgConsent>, <searchKey>, <startDate>, <endDate>, <page>, <size> y <direction>
    Then valida consulta por primer y segunda nombre del cliente

    Examples: Filtrar primer nombre del cliente
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          | RYU       | 2018-01-01 | 2021-06-14 | null | null | ASC       |

    Examples: Filtrar segundo nombre del cliente
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          | VICENTE   | 2018-01-01 | 2021-06-14 | null | null | ASC       |

  @Automated @Happy_path @functional_testing
  Scenario Outline: Valida filtrar por primer y segunda apellido del cliente
    Given que el cliente accede a la aplicacion
    When el cliente consulta <status>, <flgConsent>, <searchKey>, <startDate>, <endDate>, <page>, <size> y <direction>
    Then valida consulta por primer y segunda apellido del cliente

    Examples: Filtrar primer apellido del cliente
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          | CORREA    | 2018-01-01 | 2021-06-14 | null | null | ASC       |

    Examples: Filtrar segunda apellido del cliente
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          | EVERIS    | 2018-01-01 | 2021-06-14 | null | null | ASC       |

  @Automated @Happy_path @functional_testing
  Scenario Outline: Valida filtrar por nombre y apellido completo del cliente
    Given que el cliente accede a la aplicacion
    When el cliente consulta <status>, <flgConsent>, <searchKey>, <startDate>, <endDate>, <page>, <size> y <direction>
    Then valida consulta por nombre y apellido completo del cliente

    Examples: Filtrar nombre completo del cliente
      | status | flgConsent | searchKey                 | startDate  | endDate    | page | size | direction |
      | 1      | S          | RYU VICENTE CORREA EVERIS | 2018-01-01 | 2021-06-14 | null | null | ASC       |

    Examples: Filtrar apellido completo del cliente (Lista vacio)
      | status | flgConsent | searchKey     | startDate  | endDate    | page | size | direction |
      | 1      | S          | CORREA EVERIS | 2018-01-01 | 2021-06-14 | null | null | ASC       |

  @Automated @Happy_path @functional_testing
  Scenario Outline: Valida filtrar valores coincidencias
    Given que el cliente accede a la aplicacion
    When el cliente consulta <status>, <flgConsent>, <searchKey>, <startDate>, <endDate>, <page>, <size> y <direction>
    Then valida consulta valores coincidencias

    Examples: SEARCHKEY VALUE - VAS
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          | VAS       | 2018-01-01 | 2021-06-14 | null | null | ASC       |

    Examples: SEARCHKEY VALUE - CAT
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          | CAT       | 2018-01-01 | 2021-06-14 | null | null | ASC       |

    Examples: SEARCHKEY VALUE - CH
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          | CH        | 2018-01-01 | 2021-06-14 | null | null | ASC       |

    Examples: SEARCHKEY VALUE - 5050
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          | 5050      | 2018-01-01 | 2021-06-14 | null | null | ASC       |

    Examples: SEARCHKEY VALUE - Genero (M)
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          | M         | 2018-01-01 | 2021-06-14 | null | null | ASC       |

    Examples: SEARCHKEY VALUE - Genero (F)
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          | F         | 2018-01-01 | 2021-06-14 | null | 300  | ASC       |

  @Automated @Unhappy_path @functional_testing
  Scenario Outline: Valida consulta cliente con numero documento DNI no existe
    Given que el cliente accede a la aplicacion
    When el cliente consulta <status>, <flgConsent>, <searchKey>, <startDate>, <endDate>, <page>, <size> y <direction>
    Then valida consulta con numero documento DNI no existe

    Examples: Consulta con numero documento DNI no existe
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          | 01010101  | 2018-01-01 | 2021-06-14 | null | null | ASC       |

  @Automated @Unhappy_path @functional_testing
  Scenario Outline: Valida consulta cliente con numero documento DNI vacío
    Given que el cliente accede a la aplicacion
    When el cliente consulta <status>, <flgConsent>, <searchKey>, <startDate>, <endDate>, <page>, <size> y <direction>
    Then valida consulta con numero documento valor vacio

    Examples: Consulta con numero documento DNI vacío
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          |           | 2018-01-01 | 2021-06-14 | null | null | ASC       |

  @Automated @Happy_path @functional_testing
  Scenario Outline: Valida consulta cliente con fecha de cambio de contraseña con numero de documento PASAPORTE
    Given que el cliente accede a la aplicacion
    When el cliente consulta <status>, <flgConsent>, <searchKey>, <startDate>, <endDate>, <page>, <size> y <direction>
    Then valida consulta con fecha de cambio de password

    Examples: Consulta con fecha de cambio de contraseña
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      |            | PS201702  | 2018-01-01 | 2021-06-14 | null | null | ASC       |

#  Valida campo status
  @Automated @Happy_path @functional_testing
  Scenario Outline: Valida consulta cliente con estados son (0=Bloqueado), (1=Activo) y (2=Suspendido)
    Given que el cliente accede a la aplicacion
    When el cliente consulta <status>, <flgConsent>, <searchKey>, <startDate>, <endDate>, <page>, <size> y <direction>
    Then valida consulta con estados

    Examples: Consulta cliente con estado (0=Bloqueado)
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 0      | S          | 50501729  | 2018-01-01 | 2021-06-16 | null | null | ASC       |

    Examples: Consulta cliente con estado (1=Activo)
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          | 50501680  | 2018-01-01 | 2021-06-14 | null | null | ASC       |

    Examples: Consulta cliente con estado (2=Suspendido)
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 2      | S          | 50501609  | 2018-01-01 | 2021-06-16 | null | null | ASC       |

    Examples: Consulta cliente con estado valor (vacío)
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      |        |            |           | 2018-01-01 | 2021-06-14 | null | null | ASC       |

#  Valida campo flgConsent
  @Automated @Happy_path @functional_testing
  Scenario Outline: Valida consulta cliente con autorización de tratamiento de datos (S=Si acepta) y (N= no acepta)
    Given que el cliente accede a la aplicacion
    When el cliente consulta <status>, <flgConsent>, <searchKey>, <startDate>, <endDate>, <page>, <size> y <direction>
    Then valida consulta con autorizacion de tratamiento de datos

    Examples: Consulta cliente con autorización de tratamiento de datos (S=Si acepta)
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          | 50501680  | 2018-01-01 | 2021-06-14 | null | null | ASC       |

    Examples: Consulta cliente con autorización de tratamiento de datos (N= no acepta)
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | N          | 99101251  | 2018-01-01 | 2021-06-14 | null | null | ASC       |

    Examples: Consulta cliente con autorización de tratamiento de datos enviando valor (vacío)
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      |            |           | 2018-01-01 | 2021-06-14 | null | null | ASC       |

#  Valida campo rango de fechas (startDate - endDate)
  @Automated @Happy_path @functional_testing
  Scenario Outline: Valida consulta cliente por rango de fechas
    Given que el cliente accede a la aplicacion
    When el cliente consulta <status>, <flgConsent>, <searchKey>, <startDate>, <endDate>, <page>, <size> y <direction>
    Then valida consulta por rango de fechas

    Examples: Consulta cliente por rango fecha de tres meses
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          |           | 2019-01-01 | 2019-03-30 | null | 500  | ASC       |

    Examples: Consulta cliente por rango fecha de sais meses
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          |           | 2019-01-01 | 2019-06-30 | null | 500  | ASC       |

    Examples: Consulta cliente por rango fecha de un año
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          |           | 2019-01-01 | 2019-12-30 | null | 500  | ASC       |

#  Valida campos paginable
  @Automated @Happy_path @functional_testing
  Scenario Outline: Valida consulta cliente de forma paginable
    Given que el cliente accede a la aplicacion
    When el cliente consulta <status>, <flgConsent>, <searchKey>, <startDate>, <endDate>, <page>, <size> y <direction>
    Then valida consulta de forma paginable

    Examples: Consulta cliente de forma paginable con página 1 y elemento 1
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          |           | 2018-01-01 | 2021-06-14 | 1    | 1    | ASC       |

    Examples: Consulta cliente de forma paginable con página 1 y elementos 10
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          |           | 2018-01-01 | 2021-06-14 | 1    | 10   | ASC       |

    Examples: Consulta cliente de forma paginable con página 2 y elemento 30
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          |           | 2018-01-01 | 2021-06-14 | 2    | 30   | ASC       |

    Examples: Consulta cliente de forma paginable con null página 300 elementos
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          |           | 2018-01-01 | 2021-06-14 | null | 300  | ASC       |

    Examples: Consulta cliente de forma paginable con 1 página y elementos null
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          |           | 2018-01-01 | 2021-06-14 | 1    | null | ASC       |

    Examples: Consulta cliente de forma paginable con null página null elementos
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          |           | 2018-01-01 | 2021-06-14 | null | null | ASC       |

#  Valida campo direction
  @Automated @Happy_path @functional_testing
  Scenario Outline: Valida ordenar consulta cliente de forma ascendente y descendente
    Given que el cliente accede a la aplicacion
    When el cliente consulta <status>, <flgConsent>, <searchKey>, <startDate>, <endDate>, <page>, <size> y <direction>
    Then valida consulta de forma ascendente y descendente

    Examples: Consulta cliente de forma de forma ascendente
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          |           | 2019-01-01 | 2019-12-30 | 1    | 10   | ASC       |

    Examples: Consulta cliente de forma de forma descendente
      | status | flgConsent | searchKey | startDate  | endDate    | page | size | direction |
      | 1      | S          |           | 2019-01-01 | 2019-12-30 | 1    | 10   | DESC      |


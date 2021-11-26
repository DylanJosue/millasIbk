@allConsultMiles
Feature: Consulta saldo de millas de shopstar

  @Automated @Happy_path @functional_testing @SHOP_CONSULT_01
  Scenario Outline: [HAPPY PATH] Valida consulta de millas con diferentes clientes habilitados
    Given que el cliente accede a la aplicacion
    When se ingresa código unico <customerId> para generar el token
    Then se valida la generacíon de token shoptar con satisfactorio con valores: tipo documento <documentType>, número de documento <documentNumber>, código único <customerId> y el status <status>
    And ingresa numero de orden <orderNumber> del cliente
    Then verificamos el código de respuesta <statusCode>
    And validamos que el response contenga los siguientes datos: tipo documento <documentType>, número de documento <documentNumber>, código único <customerId> y el mensaje <message>

    Examples: Valida consulta de millas con cliente habilitado - DNI
      | customerId | orderNumber | documentType | documentNumber | status | message | statusCode |
      | 0060102625 | 1020304050  | 1            | 50501822       | 1      | OK      | 200        |

    Examples: Valida consulta de millas con cliente habilitado - CE
      | customerId | orderNumber | documentType | documentNumber | status | message | statusCode |
      | 0060058604 | 1020304050  | 3            | CE201701       | 1      | OK      | 200        |

    Examples: Valida consulta de millas con cliente habilitado - PASAPORTE
      | customerId | orderNumber | documentType | documentNumber | status | message | statusCode |
      | 0060106724 | 1020304050  | 5            | AD100004       | 1      | OK      | 200        |

  @Automated @Happy_path @functional_testing @SHOP_CONSULT_02
  Scenario Outline: [HAPPY PATH] Valida consulta con saldo para cliente con 0 de millas
    Given que el cliente accede a la aplicacion
    When se ingresa código unico <customerId> para generar el token
    Then se valida la generacíon de token shoptar con satisfactorio con valores: tipo documento <documentType>, número de documento <documentNumber>, código único <customerId> y el status <status>
    And ingresa numero de orden <orderNumber> del cliente
    Then verificamos el código de respuesta <statusCode>
    And validamos que el response contenga los siguientes datos: tipo documento <documentType>, número de documento <documentNumber>, código único <customerId> y el mensaje <message>
    Examples: Cliente con saldo 0 de millas - DNI
      | customerId | orderNumber | documentType | documentNumber | status | message | statusCode |
      | 0060102336 | 1020304050  |      1        |       50501528         |  1      |   OK      |     200       |

  @Automated @Happy_path @functional_testing @SHOP_CONSULT_03
  Scenario Outline: [HAPPY PATH] Valida consulta con saldo de cliente con millas negativo
    Given que el cliente accede a la aplicacion
    When se ingresa código unico <customerId> para generar el token
    Then se valida la generacíon de token shoptar con satisfactorio con valores: tipo documento <documentType>, número de documento <documentNumber>, código único <customerId> y el status <status>
    And ingresa numero de orden <orderNumber> del cliente
    Then verificamos el código de respuesta <statusCode>
    And validamos que el response contenga los siguientes datos: tipo documento <documentType>, número de documento <documentNumber>, código único <customerId> y el mensaje <message>
    Examples: Cliente con saldo negativo de millas - DNI
      | customerId | orderNumber |documentType | documentNumber | status | message | statusCode |
      | 0060102547 | 1020304050  |        1     |     50501744           |  1      |     OK    | 200           |

  @Automated @Unhappy_path @functional_testing @SHOP_CONSULT_04
  Scenario Outline: [UNHAPPY PATH] Valida consulta millas con cliente cuenta que no participa en el programa
    Given que el cliente accede a la aplicacion
    When se ingresa código unico <customerId> para generar el token
    Then se valida la generacíon de token shoptar con satisfactorio con valores: tipo documento <documentType>, número de documento <documentNumber>, código único <customerId> y el status <status>
    And ingresa numero de orden <orderNumber> del cliente
    Then verificamos el código de respuesta <statusCode>
    And validamos el mensaje de error <mensaje> de la consulta

    Examples: Cliente no participa en el programa
      | customerId | orderNumber |documentType | documentNumber | status | mensaje | statusCode |
      | 0060538690 | 1020304050  |        1     |       26669401         |     1   |   NO PARTICIPA EN EL PROGRAMA DE BENEFICIOS Y/O NO ACUMULA MILLAS      |     403       |

  @Automated @Unhappy_path @functional_testing @SHOP_CONSULT_05
  Scenario Outline: [UNHAPPY PATH] Valida consulta millas con cliente cuenta cancelada
    Given que el cliente accede a la aplicacion
    When se ingresa código unico <customerId> para generar el token
    Then se valida la generacíon de token shoptar con satisfactorio con valores: tipo documento <documentType>, número de documento <documentNumber>, código único <customerId> y el status <status>
    And ingresa numero de orden <orderNumber> del cliente
    Then verificamos el código de respuesta <statusCode>
    And validamos el mensaje de error <mensaje> de la consulta

    Examples: Valida cliente con cuenta cancelada
      | customerId | orderNumber |documentType | documentNumber | status | mensaje | statusCode |
      | 0060104252 | 1020304050  |1            |50503452        |     1   |NO PARTICIPA EN EL PROGRAMA DE BENEFICIOS Y/O NO ACUMULA MILLAS|403|

  @Automated @Unhappy_path @functional_testing @SHOP_CONSULT_06
  Scenario Outline: [UNHAPPY PATH] Valida consulta millas con cliente cuenta dada de baja
    Given que el cliente accede a la aplicacion
    When se ingresa código unico <customerId> para generar el token
    Then valida cliente con cuenta dada de baja

    Examples: Valida cliente con cuenta dada de baja
      | customerId |
      | 0060334563 |

  @Automated @Unhappy_path @functional_testing @SHOP_CONSULT_07
  Scenario Outline: [UNHAPPY PATH] Valida consulta millas con cliente no registrado en Benefit
    Given que el cliente accede a la aplicacion
    When se ingresa código unico <customerId> para generar el token
    Then valida cliente no esta registrado en benefit

    Examples: Cliente no esta registrado en Benefit - TC INTERBANK PREMIA
      | customerId |
      | 0060135832 |

  #Valida campo orderNumber
  @Automated @Alternative_path @functional_testing @SHOP_CONSULT_09
  Scenario Outline: [HAPPY PATH] Valida consulta millas campo numero de orden
    Given que el cliente accede a la aplicacion
    When se ingresa código unico <customerId> para generar el token
    Then se valida la generacíon de token shoptar con satisfactorio con valores: tipo documento <documentType>, número de documento <documentNumber>, código único <customerId> y el status <status>
    And ingresa numero de orden <orderNumber> del cliente
    Then verificamos el código de respuesta <statusCode>
    And validamos que el response contenga los siguientes datos: tipo documento <documentType>, número de documento <documentNumber>, código único <customerId> y el mensaje <message>

    Examples: Valida consulta millas campo numero de orden con menor valor longitud caracteres - CE
      | customerId | orderNumber |documentType | documentNumber | status | message | statusCode |
      | 0060538904 | 5           |       3      |       CE277062         | 1       |  OK       |    200        |

    Examples: Valida consulta millas campo numero de orden con valor alfanumérico - CE
      | customerId | orderNumber          |documentType | documentNumber | status | message | statusCode |
      | 0060538904 | YW55IGNhcm5hbCBwbGVh |    3      |       CE277062         | 1       |  OK       |    200        |

  @Automated @Alternative_path @functional_testing @SHOP_CONSULT_10
  Scenario Outline: [UNHAPPY PATH] Valida consulta millas campo numero de orden enviando valor null
    Given que el cliente accede a la aplicacion
    When se ingresa código unico <customerId> para generar el token
    Then se valida la generacíon de token shoptar con satisfactorio con valores: tipo documento <documentType>, número de documento <documentNumber>, código único <customerId> y el status <status>
    And ingresa numero de orden <orderNumber> del cliente
    Then verificamos el código de respuesta <statusCode>
    And validamos el mensaje de error <mensaje> de la consulta

    Examples: Valida consulta millas campo numero de orden con valor null - CE
      | customerId | orderNumber |documentType | documentNumber | status | mensaje | statusCode |
      | 0060538904 |             | 3      |       CE277062         | 1       |  El campo orderNumber debe ser obligatorio.       |    403        |

  @Automated @Alternative_path @functional_testing @SHOP_CONSULT_11
  Scenario Outline: [UNHAPPY PATH] Valida consulta millas campo numero de orden con mayor valor longitud caracteres
    Given que el cliente accede a la aplicacion
    When se ingresa código unico <customerId> para generar el token
    Then se valida la generacíon de token shoptar con satisfactorio con valores: tipo documento <documentType>, número de documento <documentNumber>, código único <customerId> y el status <status>
    And ingresa numero de orden <orderNumber> del cliente
    Then verificamos el código de respuesta <statusCode>
    And validamos el mensaje de error <mensaje> de la consulta

    Examples: Valida consulta millas campo numero de orden con mayor valor longitud caracteres - CE
      | customerId | orderNumber                                                                      |documentType | documentNumber | status | mensaje | statusCode |
      | 0060538904 | 43534435344353443534435344353443534435344353443534435344353443534435344353443534 |3      |       CE277062         | 1       |  El campo orderNumber debe tener un tamaño máximo de 50 caracteres.     |    403        |


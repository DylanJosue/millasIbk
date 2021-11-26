@allExchangeMiles
Feature: Valida canje de millas

  @Automated @Happy_path @functional_testing @TEST_EXCHANGE1
  Scenario Outline: Valida canje de millas con satisfactorio
    Given que el cliente accede a la aplicacion
    And el cliente ingresa su codigo unico <customerId>
    When el ingresa <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount>, <currencyIdTwo> numero de orden trx <orderNumber>
    Then valida el canje de millas es satisfactorio

    Examples: Valida canje de millas con satisfactorio - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060102625 | 4700       | 150         | 001           | 300           | 64.72     | 012        | RappiCreditos | 1        | 150    | 001           | 3000104063  |

    Examples: Valida canje de millas con satisfactorio - CE
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060058604 | 4700       | 150         | 001           | 300           | 64.72     | 012        | RappiCreditos | 1        | 150    | 001           | 3001104064  |

    Examples: Valida canje de millas con satisfactorio - PASAPORTE
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060106724 | 4700       | 150         | 001           | 300           | 64.72     | 012        | RappiCreditos | 1        | 150    | 001           | 3002104065  |

  @Automated @Unhappy_path @functional_testing #@TEST_EXCHANGE
  Scenario Outline: Valida cliente canjeando con saldo 0 de millas
    Given que el cliente accede a la aplicacion
    And el cliente ingresa su codigo unico <customerId>
    When el ingresa <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount>, <currencyIdTwo> numero de orden trx <orderNumber>
    Then valida canje con cliente saldo cero de millas

    Examples: Valida cliente canjeando con saldo 0 de millas - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060102336 | 4700       | 150         | 001           | 500           | 64.85     | 012        | RappiCreditos | 1        | 150    | 001           | 3003104051  |

  @Automated @Unhappy_path @functional_testing #@TEST_EXCHANGE
  Scenario Outline: Valida cliente canjeando con saldo negativo de millas
    Given que el cliente accede a la aplicacion
    And el cliente ingresa su codigo unico <customerId>
    When el ingresa <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount>, <currencyIdTwo> numero de orden trx <orderNumber>
    Then valida canje cliente con saldo negativo de millas

    Examples: Valida cliente canjeando con saldo negativo de millas - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060102547 | 4700       | 150         | 001           | 600           | 64.85     | 012        | RappiCreditos | 1        | 150    | 001           | 3004104051  |

  @Automated @Unhappy_path @functional_testing #@TEST_EXCHANGE
  Scenario Outline: Valida cliente canjeando con cuenta bloqueada
    Given que el cliente accede a la aplicacion
    And el cliente ingresa su codigo unico <customerId>
    When el ingresa <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount>, <currencyIdTwo> numero de orden trx <orderNumber>
    Then valida canje cliente con cuenta bloqueada

    Examples: Valida cliente canjeando con cuenta bloqueada - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060538690 | 4700       | 150         | 001           | 1000          | 64.85     | 012        | RappiCreditos | 1        | 150    | 001           | 3005104051  |

  @Automated @Unhappy_path @functional_testing #@TEST_EXCHANGE
  Scenario Outline: Valida cliente canjeando con cuenta cancelada
    Given que el cliente accede a la aplicacion
    And el cliente ingresa su codigo unico <customerId>
    When el ingresa <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount>, <currencyIdTwo> numero de orden trx <orderNumber>
    Then valida canje cliente con cuenta cancelada

    Examples: Valida cliente canjeando con cuenta cancelada - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060104252 | 4700       | 150         | 001           | 1000          | 64.85     | 012        | RappiCreditos | 1        | 150    | 001           | 3006104051  |

  #Valida campo netMiles
  #Se puede canjear - Introduzcando un número mayor o igual que 0.
  @Automated @Happy_path @functional_testing #@TEST_EXCHANGE
  Scenario Outline: Valida campo netMiles ingresando 0 millas
    Given que el cliente accede a la aplicacion
    And el cliente ingresa su codigo unico <customerId>
    When el ingresa <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount>, <currencyIdTwo> numero de orden trx <orderNumber>
    Then valida campo netMiles ingresando cero millas

    Examples: Valida campo netMiles ingresando 0 millas - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           | 0             | 64.85     | 012        | RappiCreditos | 1        | 150    | 001           | 3007104051  |

  @Automated @Unhappy_path @functional_testing #@TEST_EXCHANGE
  Scenario Outline: Valida campo netMiles ingresando milla negativo
    Given que el cliente accede a la aplicacion
    And el cliente ingresa su codigo unico <customerId>
    When el ingresa <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount>, <currencyIdTwo> numero de orden trx <orderNumber>
    Then valida campo netMiles ingresando milla negativo

    Examples: Valida campo netMiles ingresando milla negativo - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           | -1000         | 64.85     | 012        | RappiCreditos | 1        | 150    | 001           | 3008104051  |

  @Automated @Alternative_path @functional_testing #@TEST_EXCHANGE
  Scenario Outline: Valida campo netMiles ingresando valor caracteres y alfanumérico
    Given que el cliente accede a la aplicacion
    And el cliente ingresa su codigo unico <customerId>
    When el ingresa <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount>, <currencyIdTwo> numero de orden trx <orderNumber>
    Then valida campo netMiles ingresando valor caracteres y alfanumerico

    Examples: Valida campo netMiles ingresando valor caracteres - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           | 1;0;0         | 64.85     | 012        | RappiCreditos | 1        | 150    | 001           | 3009104051  |

    Examples: Valida campo netMiles ingresando valor alfanumérico - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           | 6W550IGNh     | 64.85     | 012        | RappiCreditos | 1        | 150    | 001           | 3010104051  |

  @Automated @Alternative_path @functional_testing #@TEST_EXCHANGE
  Scenario Outline: Valida campo netMiles enviando con valor Null
    Given que el cliente accede a la aplicacion
    And el cliente ingresa su codigo unico <customerId>
    When el ingresa <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount>, <currencyIdTwo> numero de orden trx <orderNumber>
    Then valida campo netMiles enviando con valor null

    Examples: Valida campo netMiles enviando con valor null - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           |               | 64.85     | 012        | RappiCreditos | 1        | 150    | 001           | 3011104051  |

  #Valida campo identifier
  #identificador único del producto canjeado generado por el canal
  @Automated @Alternative_path @functional_testing #@TEST_EXCHANGE
  Scenario Outline: Valida campo identificador único del producto
    Given que el cliente accede a la aplicacion
    And el cliente ingresa su codigo unico <customerId>
    When el ingresa <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount>, <currencyIdTwo> numero de orden trx <orderNumber>
    Then se valida campo identificador unico del producto

    Examples: Valida campo identifier enviando valor con menor longitud caracteres - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           | 0             | 64.85     | 1          | RappiCreditos | 1        | 150    | 001           | 3012104051  |

    Examples: Valida campo identifier enviando valor alfanumérico - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier                                         | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           | 0             | 64.85     | YW55IGNhcm5hbCBwbGVhYW55IGNhcm5hbCBwbGVh5hbCBwbGVh | RappiCreditos | 1        | 150    | 001           | 3013104051  |

    Examples: Valida campo identifier enviando con valor Null - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           | 0             | 64.85     |            | RappiCreditos | 1        | 150    | 001           | 3014104051  |

  @Automated @Alternative_path @functional_testing #@TEST_EXCHANGE
  Scenario Outline: Valida campo identificador enviando valor con mayor longitud caracteres
    Given que el cliente accede a la aplicacion
    And el cliente ingresa su codigo unico <customerId>
    When el ingresa <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount>, <currencyIdTwo> numero de orden trx <orderNumber>
    Then se valida campo identificador enviando valor con mayor longitud caracteres

    Examples: Valida campo identifier enviando valor con mayor longitud caracteres - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier                                              | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           | 0             | 64.85     | 0120120120120120120120120120120120120120120120120101201 | RappiCreditos | 1        | 150    | 001           | 3015104051  |

  #Valida campo description
  #descripción del producto canjeado
  @Automated @Alternative_path @functional_testing #@TEST_EXCHANGE
  Scenario Outline: Valida campo descripción del producto canjeado
    Given que el cliente accede a la aplicacion
    And el cliente ingresa su codigo unico <customerId>
    When el ingresa <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount>, <currencyIdTwo> numero de orden trx <orderNumber>
    Then se valida campo descripcion del producto canjeado

    Examples: Valida campo descripcion enviando valor con menor longitud caracteres - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description | quantity | amount | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           | 0             | 64.85     | 012        | R           | 1        | 150    | 001           | 3016104051  |

    Examples: Valida campo descripcion enviando valor alfanumérico - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description                                                                                                                                            | quantity | amount | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           | 0             | 64.85     | 012        | YW55IGNhcm5hbCBwbGVhYW55IGNhcm5hbCBwbGVh5hbCBwbGVhYW55IGNhcm5hbCBwbGVhYW55IGNhcm5hbCBwbGVh5hbCBwbGVhYW55IGNhcm5hbCBwbGVhYW55IGNhcm5hbCBwbGVh5hbCBwbGVh | 1        | 150    | 001           | 3017104051  |

    Examples: Valida campo descripcion enviando con valor Null - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description | quantity | amount | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           | 0             | 64.85     | 012        |             | 1        | 150    | 001           | 3018104051  |

  @Automated @Alternative_path @functional_testing #@TEST_EXCHANGE
  Scenario Outline: Valida campo descripcion enviando valor con mayor longitud caracteres
    Given que el cliente accede a la aplicacion
    And el cliente ingresa su codigo unico <customerId>
    When el ingresa <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount>, <currencyIdTwo> numero de orden trx <orderNumber>
    Then se valida campo descripcion enviando valor con mayor longitud caracteres

    Examples: Valida campo descripcion enviando valor con mayor longitud caracteres - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description                                                                                                                                                  | quantity | amount | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           | 0             | 64.85     | 012        | RappiCreditosRappiCreditosRappiCreditosRappiCreditosRappiCreditosRappiCreditosRappiCreditosRappiCreditosRappiCreditosRappiCreditosRappiCreditosRappiCreditos | 1        | 150    | 001           | 3019104051  |

  #Valida campo quantity
  #cantidad canjeada del producto
  @Automated @Alternative_path @functional_testing #@TEST_EXCHANGE
  Scenario Outline: Valida campo cantidad canjeada del producto
    Given que el cliente accede a la aplicacion
    And el cliente ingresa su codigo unico <customerId>
    When el ingresa <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount>, <currencyIdTwo> numero de orden trx <orderNumber>
    Then se valida campo cantidad canjeada del producto

    Examples: Valida campo cantidad enviando valor con menor longitud caracteres - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           | 0             | 64.85     | 012        | RappiCreditos | 0        | 150    | 001           | 3020104051  |

    Examples: Valida campo cantidad enviando con valor Null - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           | 0             | 64.85     | 012        | RappiCreditos |          | 150    | 001           | 3021104051  |

  @Automated @Alternative_path @functional_testing #@TEST_EXCHANGE
  Scenario Outline: Valida campo cantidad enviando valor con mayor longitud caracteres
    Given que el cliente accede a la aplicacion
    And el cliente ingresa su codigo unico <customerId>
    When el ingresa <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount>, <currencyIdTwo> numero de orden trx <orderNumber>
    Then valida campo cantidad enviando valor con mayor longitud caracteres

    Examples: Valida campo cantidad enviando valor con mayor longitud caracteres - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity        | amount | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           | 0             | 64.85     | 012        | RappiCreditos | 112121212121121 | 150    | 001           | 3022104051  |

    Examples: Valida campo cantidad enviando valor alfanumérico - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity   | amount | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           | 0             | 64.85     | 012        | RappiCreditos | YW55IGNhcm | 150    | 001           | 3023104051  |

  #Valida campo amount
  #costo del producto
  @Automated @Alternative_path @functional_testing #@TEST_EXCHANGE
  Scenario Outline: Valida campo costo del producto
    Given que el cliente accede a la aplicacion
    And el cliente ingresa su codigo unico <customerId>
    When el ingresa <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount>, <currencyIdTwo> numero de orden trx <orderNumber>
    Then se valida campo costo del producto

    Examples: Valida campo costo enviando valor con menor longitud caracteres - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           | 1             | 64.85     | 012        | RappiCreditos | 1        | 0      | 001           | 3024104051  |

    Examples: Valida campo costo enviando con valor Null - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           | 1             | 64.85     | 012        | RappiCreditos | 1        |        | 001           | 3025104051  |

    Examples: Valida campo costo enviando con valor decimal - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount              | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           | 1             | 64.85     | 012        | RappiCreditos | 1        | 899.123456789123456 | 001           | 3026104051  |

  @Automated @Alternative_path @functional_testing #@TEST_EXCHANGE
  Scenario Outline: Valida campo costo enviando mayor valor longitud caracteres y alfanumérico
    Given que el cliente accede a la aplicacion
    And el cliente ingresa su codigo unico <customerId>
    When el ingresa <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount>, <currencyIdTwo> numero de orden trx <orderNumber>
    Then valida campo costo enviando mayor valor longitud caracteres y alfanumerico

    Examples: Valida campo costo enviando mayor valor longitud caracteres - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount          | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           | 1             | 64.85     | 012        | RappiCreditos | 1        | 303030303030303 | 001           | 3027104051  |

    Examples: Valida campo costo enviando valor alfanumérico - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount         | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           | 1             | 64.85     | 012        | RappiCreditos | 1        | YW55IGNhcm55IG | 001           | 3028104051  |

  #Valida campo orderNumber
  #número de orden de la trx que se comparte con el cliente
  @Automated @Alternative_path @functional_testing #@TEST_EXCHANGE
  Scenario Outline: Valida campo numero de orden de la trx
    Given que el cliente accede a la aplicacion
    And el cliente ingresa su codigo unico <customerId>
    When el ingresa <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount>, <currencyIdTwo> numero de orden trx <orderNumber>
    Then se valida campo numero de orden

    Examples: Valida campo numero de orden con menor valor longitud caracteres - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           | 1             | 64.85     | 012        | RappiCreditos | 3        | 99.123 | 001           | 18          |

    Examples: Valida campo numero de orden con valor alfanumérico - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber                               |
      | 0060102532 | 4700       | 150         | 001           | 1             | 64.85     | 012        | RappiCreditos | 1        | 15.67  | 001           | YW164IGNhcm5hbCBwbGVhYW55IGNhcm5hbCBwbGV8 |

  @Automated @Alternative_path @functional_testing #@TEST_EXCHANGE
  Scenario Outline: Valida campo numero de orden enviando valor null
    Given que el cliente accede a la aplicacion
    And el cliente ingresa su codigo unico <customerId>
    When el ingresa <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount>, <currencyIdTwo> numero de orden trx <orderNumber>
    Then se valida campo numero de orden enviando valor null debe ser obligatorio

    Examples: Valida campo numero de orden con valor null - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060102532 | 4700       | 150         | 001           | 1             | 64.85     | 012        | RappiCreditos | 1        | 15.67  | 001           |             |

  @Automated @Alternative_path @functional_testing #@TEST_EXCHANGE
  Scenario Outline: Valida campo numero de orden enviando valor con mayor longitud caracteres
    Given que el cliente accede a la aplicacion
    And el cliente ingresa su codigo unico <customerId>
    When el ingresa <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount>, <currencyIdTwo> numero de orden trx <orderNumber>
    Then valida campo numero de orden debe tener un tamano maximo

    Examples: Valida campo numero de orden enviando valor con mayor longitud caracteres - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber                                                                      |
      | 0060102532 | 4700       | 150         | 001           | 1             | 64.85     | 012        | RappiCreditos | 3        | 47.67  | 001           | 23232222323222232322223232222323222232322223232222323222232322223232222323222232 |

  @Automated @Alternative_path @functional_testing #@TEST_EXCHANGE
  Scenario Outline: Valida campo numero de orden enviando valor duplicado
    Given que el cliente accede a la aplicacion
    And el cliente ingresa su codigo unico <customerId>
    When el ingresa <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount>, <currencyIdTwo> numero de orden trx <orderNumber>
    Then valida campo numero de orden enviando valor <duplicado>

    Examples: Valida campo numero de orden enviando valor con mayor longitud caracteres - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber | duplicado |
      | 0060102532 | 4700       | 150         | 001           | 1             | 64.85     | 012        | RappiCreditos | 3        | 47.67  | 001           | 3029104051  | NO        |
      | 0060102532 | 4700       | 150         | 001           | 1             | 64.85     | 012        | RappiCreditos | 3        | 47.67  | 001           | 3029104051  |           |


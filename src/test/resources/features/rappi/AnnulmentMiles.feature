@allAnnulmentMiles
Feature: Anulacion canje de millas

  @Automated @Happy_path @functional_testing @TEST_ANNULMENT1
  Scenario Outline: Valida anulación canje de millas por tipo de documento
    Given que el cliente accede a la aplicacion
    When se ingresa su codigo unico <customerId> del cliente
    And el ingresa <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount>, <currencyIdTwo> numero de orden de la trx <orderNumber>
    Then valida el canje de millas es satisfactorio
    And el cliente anula la operacion del canje de millas con numero de orden es <orderNumber>
    Then se valida anulacion canje es satisfactorio

    Examples: Valida anulación canje de millas con satisfactorio - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060102625 | 4700       | 30.76       | 001           | 250           | 64.72     | 012        | RappiCreditos | 1        | 30.76  | 001           | 1000726365  |

    Examples: Valida anulación canje de millas con satisfactorio - CE
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060058604 | 4700       | 305         | 001           | 300           | 64.72     | 012        | RappiCreditos | 1        | 305    | 001           | 1001726366  |

    Examples: Valida anulación canje de millas con satisfactorio - PASAPORTE
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | orderNumber |
      | 0060106724 | 4700       | 17.76       | 001           | 1000          | 64.72     | 012        | RappiCreditos | 1        | 17.76  | 001           | 1002726367  |

  #Valida campo authorizationCode
  #Nro de autorización del canje realizado.
  @Automated @Alternative_path @functional_testing #@TEST_ANNULMENT
  Scenario Outline: Valida anulación canje de millas con authorizationCode inválido
    Given que el cliente accede a la aplicacion
    When se ingresa su codigo unico 0060102532 del cliente
    And el ingresa 4700, 150, 001, 10, 64.71 items 012, RappiCreditos, 1, 150, 001 numero de orden de la trx <orderNumber>
    Then valida el canje de millas es satisfactorio
    And el cliente anula la operacion del canje con <authorizationCode>, <orderNumber> y fecha de operacion <operationDate>
    Then se valida anulacion canje con authorizationCode invalido

    Examples: Valida anulación canje de millas con authorizationCode inválido - DNI
      | authorizationCode | orderNumber | operationDate  |
      | 123456            | 1003726354  | 20210913111922 |

    Examples: Valida campo authorizationCode enviando valor con menor longitud caracteres - DNI
      | authorizationCode | orderNumber | operationDate  |
      | 6                 | 1004726354  | 20210913111922 |

    Examples: Valida campo authorizationCode enviando valor con mayor longitud caracteres - DNI
      | authorizationCode | orderNumber | operationDate  |
      | 667467667467      | 1005726354  | 20210913111922 |

    Examples: Valida campo authorizationCode enviando valor alfanumérico - DNI
      | authorizationCode | orderNumber | operationDate  |
      | Nhcm6h            | 1006726354  | 20210913111922 |

  @Automated @Alternative_path @functional_testing #@TEST_ANNULMENT
  Scenario Outline: Valida campo authorizationCode enviando con valor Null
    Given que el cliente accede a la aplicacion
    When se ingresa su codigo unico 0060102532 del cliente
    And el ingresa 4700, 150, 001, 10, 64.71 items 012, RappiCreditos, 1, 150, 001 numero de orden de la trx <orderNumber>
    Then valida el canje de millas es satisfactorio
    And el cliente anula la operacion del canje con <authorizationCode>, <orderNumber> y fecha de operacion <operationDate>
    Then se valida campo authorizationCode enviando con valor null

    Examples: Valida campo authorizationCode enviando con valor Null - DNI
      | authorizationCode | orderNumber | operationDate  |
      |                   | 1007726354  | 20210913122510 |

  #Número de orden de la trx generado por el canal que se comparte con el cliente para que pueda identificar la compra
  @Automated @Alternative_path @functional_testing #@TEST_ANNULMENT
  Scenario Outline: Valida campo numero de orden de la trx no existe operación para anulacion
    Given que el cliente accede a la aplicacion
    When se ingresa su codigo unico 0060102532 del cliente
    And el ingresa 4700, 100, 001, 10, 64.71 items 012, RappiCreditos, 1, 100, 001 numero de orden de la trx <orderNumberOne>
    Then valida el canje de millas es satisfactorio
    And el cliente anula la operacion del canje de millas con numero de orden es <orderNumberTwo>
    Then se valida anulacion campo order number no existe operacion para anulacion

    Examples: Valida campo numero de orden de la trx no existe operación para anulacion - DNI
      | orderNumberOne | orderNumberTwo |
      | 1008726354     | 120            |

  @Automated @Alternative_path @functional_testing #@TEST_ANNULMENT
  Scenario Outline: Valida campo numero de orden enviando con valor alfanumérico
    Given que el cliente accede a la aplicacion
    When se ingresa su codigo unico 0060102532 del cliente
    And el ingresa 4700, 100, 001, 10, 64.71 items 012, RappiCreditos, 1, 100, 001 numero de orden de la trx <orderNumberOne>
    Then valida el canje de millas es satisfactorio
    And el cliente anula la operacion del canje de millas con numero de orden es <orderNumberTwo>
    Then se valida anulacion campo order number enviando con valor alfanumerico

    Examples: Valida campo numero de orden enviando con valor alfanumérico - DNI
      | orderNumberOne | orderNumberTwo                           |
      | 1009726354     | YW55IGNhcm5hbCBwbGVhYW55IGNhcm5hbCBwbGVh |

  @Automated @Alternative_path @functional_testing #@TEST_ANNULMENT
  Scenario Outline: Valida campo numero de orden enviando con valor null
    Given que el cliente accede a la aplicacion
    When se ingresa su codigo unico 0060102532 del cliente
    And el ingresa 4700, 100, 001, 10, 64.71 items 012, RappiCreditos, 1, 100, 001 numero de orden de la trx <orderNumberOne>
    Then valida el canje de millas es satisfactorio
    And el cliente anula la operacion del canje de millas con numero de orden es <orderNumberTwo>
    Then se valida anulacion campo order number enviando con valor null

    Examples: Valida campo numero de orden enviando con valor null - DNI
      | orderNumberOne | orderNumberTwo |
      | 1010726354     |                |

  @Automated @Alternative_path @functional_testing #@TEST_ANNULMENT
  Scenario Outline: Valida campo numero de orden enviando valor con mayor longitud caracteres
    Given que el cliente accede a la aplicacion
    When se ingresa su codigo unico 0060102532 del cliente
    And el ingresa 4700, 100, 001, 10, 64.71 items 012, RappiCreditos, 1, 100, 001 numero de orden de la trx 1011726354
    Then valida el canje de millas es satisfactorio
    And el cliente anula la operacion del canje de millas con numero de orden es <orderNumber>
    Then se valida anulacion campo numero de orden trx enviando valor con mayor longitud caracteres

    Examples: Valida campo numero de orden enviando valor con mayor longitud caracteres
      | orderNumber                                                                      |
      | 23232222323222232322223232222323222232322223232222323222232322223232222323222232 |

  #Valida campo operationDate
  #Fecha de operación del canje en formato yyyyMMddHHmmss. Hace referencia al campo operationDate en el response del canje
  @Automated @Alternative_path @functional_testing #@TEST_ANNULMENT
  Scenario Outline: Valida campo fecha de operación
    Given que el cliente accede a la aplicacion
    When se ingresa su codigo unico 0060102532 del cliente
    And el ingresa 4700, 190, 001, 10, 64.71 items 012, RappiCreditos, 1, 190, 001 numero de orden de la trx <orderNumber>
    Then valida el canje de millas es satisfactorio
    And el cliente anula la operacion del canje con <authorizationCode>, <orderNumber> y fecha de operacion <operationDate>
    Then se valida campo fecha de operacion del canje

    Examples: Valida campo operationDate enviando valor con menor longitud caracteres - DNI
      | authorizationCode | orderNumber | operationDate |
      | 217432            | 1012726354  | 20210917      |

    Examples: Valida campo operationDate enviando valor alfanumérico - DNI
      | authorizationCode | orderNumber | operationDate |
      | 217432            | 1013726354  | W55IGNhcm5hb  |

    Examples: Valida campo operationDate con valor null - DNI
      | authorizationCode | orderNumber | operationDate |
      | 217432            | 1014726354  |               |


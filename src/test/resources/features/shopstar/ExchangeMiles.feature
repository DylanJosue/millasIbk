@allExchangeMiles
Feature: Valida canje millas para shopstar

  @Automated @Happy_path @functional_testing @EXCHANGE_SHOPSTAR_01
  Scenario Outline: [HAPPY PATH] Valida canje de millas con satisfactorio
    Given que el cliente accede a la aplicacion
    When el usuario ingresa su código unico <customerId> para obtener el token
    And realiza el canje de millas ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 200
    And validamos el canje de millas es satisfactorio con el mensaje OK
    And validamos el response con datos del cliente: tipo documento <documentType>, número documento <documentNumber> y el código único <customerId>

    Examples: Valida canje de millas con satisfactorio - DNI
      | customerId | documentType | documentNumber | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo |
      | 0060102625 | 1            | 50501822       | 4700       | 150         | 001           | 300           | 64.72     | 012        | ShopStart Creditos | 1        | 150    | 001           |

    Examples: Valida canje de millas con satisfactorio - CE
      | customerId | documentType | documentNumber | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo |
      | 0060058604 | 3            | CE201701       | 4700       | 150         | 001           | 300           | 64.72     | 012        | ShopStart Creditos | 1        | 150    | 001           |

    Examples: Valida canje de millas con satisfactorio - PASAPORTE
      | customerId | documentType | documentNumber | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo |
      | 0060106724 | 5            | AD100004       | 4700       | 150         | 001           | 300           | 64.72     | 012        | ShopStart Creditos | 1        | 150    | 001           |

  @Automated @Unhappy_path @functional_testing @EXCHANGE_SHOPSTAR_02
  Scenario Outline: [UNHAPPY PATH] Valida cliente canjeando con saldo 0 de millas
    Given que el cliente accede a la aplicacion
    When el usuario ingresa su código unico <customerId> para obtener el token
    And realiza el canje de millas ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 403
    And se valida el mensaje de error del canje <mensaje>

    Examples: Valida cliente canjeando con saldo 0 de millas - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo |mensaje|
      | 0060102336 |  4700       | 150         | 001           | 500           | 64.85     | 012        | Shopstar Creditos | 1        | 150    | 001           |  La operación ha sido rechazada.    |

  @Automated @Unhappy_path @functional_testing @EXCHANGE_SHOPSTAR_03
  Scenario Outline: [UNHAPPY PATH] Valida cliente canjeando con saldo negativo de millas
    Given que el cliente accede a la aplicacion
    When el usuario ingresa su código unico <customerId> para obtener el token
    And realiza el canje de millas ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 403
    And se valida el mensaje de error del canje <mensaje>

    Examples: Valida cliente canjeando con saldo negativo de millas - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | mensaje |
      | 0060102547 | 4700       | 150         | 001           | 600           | 64.85     | 012        | Shopstar Creditos | 1        | 150    | 001           | La operación ha sido rechazada.  |

  @Automated @Unhappy_path @functional_testing @EXCHANGE_SHOPSTAR_04
  Scenario Outline: [UNHAPPY PATH] Valida cliente canjeando con millas de tarjetas que no participan en el programa
    Given que el cliente accede a la aplicacion
    When el usuario ingresa su código unico <customerId> para obtener el token
    And realiza el canje de millas ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 403
    And se valida el mensaje de error del canje <mensaje>

    Examples: Valida cliente canjeando con cuenta bloqueada - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | mensaje |
      | 0060538690 | 4700       | 150         | 001           | 1000          | 64.85     | 012        | Shopstar Creditos | 1        | 150    | 001           | NO PARTICIPA EN EL PROGRAMA DE BENEFICIOS Y/O NO ACUMULA MILLAS  |

  @Automated @Unhappy_path @functional_testing @EXCHANGE_SHOPSTAR_05
  Scenario Outline: [UNHAPPY PATH] Valida cliente canjeando con cuenta cancelada
    Given que el cliente accede a la aplicacion
    When el usuario ingresa su código unico <customerId> para obtener el token
    And realiza el canje de millas ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 403
    And se valida el mensaje de error del canje <mensaje>

    Examples: Valida cliente canjeando con cuenta cancelada - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | mensaje |
      | 0060104252 | 4700       | 150         | 001           | 1000          | 64.85     | 012        | Shopstar Creditos  | 1        | 150    | 001           | NO PARTICIPA EN EL PROGRAMA DE BENEFICIOS Y/O NO ACUMULA MILLAS  |

  #Valida campo netMiles
  #Se puede canjear - Introduzcando un número mayor o igual que 0.
  @Automated @Happy_path @functional_testing @EXCHANGE_SHOPSTAR_06
  Scenario Outline: [HAPPY PATH] Valida campo netMiles ingresando 0 millas
    Given que el cliente accede a la aplicacion
    When el usuario ingresa su código unico <customerId> para obtener el token
    And realiza el canje de millas ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 200
    And validamos el canje de millas es satisfactorio con el mensaje OK
    And validamos el response con datos del cliente: tipo documento <documentType>, número documento <documentNumber> y el código único <customerId>

    Examples: Valida campo netMiles ingresando 0 millas - DNI
      | customerId |documentType | documentNumber | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo |
      | 0060102532 |1            | 50501729       | 4700       | 150         | 001           | 0             | 64.85     | 012        | Shopstar Creditos | 1        | 150    | 001           |

  @Automated @Unhappy_path @functional_testing @EXCHANGE_SHOPSTAR_07
  Scenario Outline: [UNHAPPY PATH] Valida campo netMiles ingresando milla negativo
    Given que el cliente accede a la aplicacion
    When el usuario ingresa su código unico <customerId> para obtener el token
    And realiza el canje de millas ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 403
    And se valida el mensaje de error del canje <mensaje>

    Examples: Valida campo netMiles ingresando milla negativo - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | mensaje |
      | 0060102532 | 4700       | 150         | 001           | -1000         | 64.85     | 012        | Shopstar Creditos | 1        | 150    | 001           | No se pueden redimir puntos en negativo.|

  @Automated @Alternative_path @functional_testing @EXCHANGE_SHOPSTAR_08
  Scenario Outline: [UNHAPPY PATH] Valida campo netMiles ingresando valor caracteres y alfanumérico
    Given que el cliente accede a la aplicacion
    When el usuario ingresa su código unico <customerId> para obtener el token
    And realiza el canje de millas ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 500
    And se valida el mensaje de error del canje <mensaje>

    Examples: Valida campo netMiles ingresando valor caracteres - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | mensaje |
      | 0060102532 | 4700       | 150         | 001           | 1;0;0         | 64.85     | 012        | Shopstar Creditos | 1        | 150    | 001           | Lo sentimos, algo salió mal, por favor inténtalo nuevamente.  |

    Examples: Valida campo netMiles ingresando valor alfanumérico - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | mensaje |
      | 0060102532 | 4700       | 150         | 001           | 6W550IGNh     | 64.85     | 012        | Shopstar Creditos | 1        | 150    | 001           | Lo sentimos, algo salió mal, por favor inténtalo nuevamente.  |

  @Automated @Alternative_path @functional_testing  @EXCHANGE_SHOPSTAR_09
  Scenario Outline: [UNHAPPY PATH] Valida campo netMiles enviando con valor Null
    Given que el cliente accede a la aplicacion
    When el usuario ingresa su código unico <customerId> para obtener el token
    And realiza el canje de millas ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 403
    And se valida el mensaje de error del canje <mensaje>

    Examples: Valida campo netMiles enviando con valor null - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | mensaje |
      | 0060102532 | 4700       | 150         | 001           |               | 64.85     | 012        | Shopstar Creditos | 1        | 150    | 001           | Debes ingresar un valor de millas a canjear.  |

  #Valida campo identifier
  #identificador único del producto canjeado generado por el canal
  @Automated @Alternative_path @functional_testing @EXCHANGE_SHOPSTAR_10
  Scenario Outline: [HAPPY PATH] Valida campo identificador único del producto
    Given que el cliente accede a la aplicacion
    When el usuario ingresa su código unico <customerId> para obtener el token
    And realiza el canje de millas ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 200
    And validamos el canje de millas es satisfactorio con el mensaje OK
    And validamos el response con datos del cliente: tipo documento <documentType>, número documento <documentNumber> y el código único <customerId>

    Examples: Valida campo identifier enviando valor con menor longitud caracteres - DNI
      | customerId | documentType | documentNumber | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo |
      | 0060102532 | 1            | 50501729       | 4700       | 150         | 001           | 0             | 64.85     | 1          | Shopstar Creditos | 1        | 150    | 001           |

    Examples: Valida campo identifier enviando valor alfanumérico - DNI
      | customerId | documentType | documentNumber | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier                                         | description   | quantity | amount | currencyIdTwo |
      | 0060102532 |1            | 50501729         | 4700       | 150         | 001           | 0             | 64.85     | YW55IGNhcm5hbCBwbGVhYW55IGNhcm5hbCBwbGVh5hbCBwbGVh | Shopstar Creditos | 1        | 150    | 001           |

    Examples: Valida campo identifier enviando con valor Null - DNI
      | customerId | documentType | documentNumber | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo |
      | 0060102532 | 1            | 50501729        |4700       | 150         | 001           | 0             | 64.85     |            | Shopstar Creditos | 1        | 150    | 001           |

  @Automated @Alternative_path @functional_testing @EXCHANGE_SHOPSTAR_11
  Scenario Outline: [UNHAPPY PATH] Valida campo identificador enviando valor con mayor longitud caracteres
    Given que el cliente accede a la aplicacion
    When el usuario ingresa su código unico <customerId> para obtener el token
    And realiza el canje de millas ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 403
    And se valida el mensaje de error del canje <mensaje>

    Examples: Valida campo identifier enviando valor con mayor longitud caracteres - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier                                              | description   | quantity | amount | currencyIdTwo | mensaje |
      | 0060102532 | 4700       | 150         | 001           | 0             | 64.85     | 0120120120120120120120120120120120120120120120120101201 | Shopstar Creditos | 1        | 150    | 001           | Lo sentimos, algo salió mal, por favor inténtalo nuevamente.  |

  #Valida campo description
  #descripción del producto canjeado
  @Automated @Alternative_path @functional_testing @EXCHANGE_SHOPSTAR_12
  Scenario Outline: [HAPPY PATH] Valida campo descripción del producto canjeado
    Given que el cliente accede a la aplicacion
    When el usuario ingresa su código unico <customerId> para obtener el token
    And realiza el canje de millas ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 200
    And validamos el canje de millas es satisfactorio con el mensaje OK
    And validamos el response con datos del cliente: tipo documento <documentType>, número documento <documentNumber> y el código único <customerId>

    Examples: Valida campo descripcion enviando valor con menor longitud caracteres - DNI
      | customerId | documentType | documentNumber |totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description | quantity | amount | currencyIdTwo |
      | 0060102532 |  1            | 50501729       |4700       | 150         | 001           | 0             | 64.85     | 012        | R           | 1        | 150    | 001           |

    Examples: Valida campo descripcion enviando valor alfanumérico - DNI
      | customerId |documentType | documentNumber | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description                                                                                                                                            | quantity | amount | currencyIdTwo |
      | 0060102532 |  1            | 50501729       |4700       | 150         | 001           | 0             | 64.85     | 012        | YW55IGNhcm5hbCBwbGVhYW55IGNhcm5hbCBwbGVh5hbCBwbGVhYW55IGNhcm5hbCBwbGVhYW55IGNhcm5hbCBwbGVh5hbCBwbGVhYW55IGNhcm5hbCBwbGVhYW55IGNhcm5hbCBwbGVh5hbCBwbGVh | 1        | 150    | 001           |

    Examples: Valida campo descripcion enviando con valor Null - DNI
      | customerId | documentType | documentNumber |totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description | quantity | amount | currencyIdTwo |
      | 0060102532 | 1            | 50501729       | 4700       | 150         | 001           | 0             | 64.85     | 012        |             | 1        | 150    | 001           |

  @Automated @Alternative_path @functional_testing @EXCHANGE_SHOPSTAR_13
  Scenario Outline: [UNHAPPY PATH] Valida campo descripcion enviando valor con mayor longitud caracteres
    Given que el cliente accede a la aplicacion
    When el usuario ingresa su código unico <customerId> para obtener el token
    And realiza el canje de millas ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 403
    And se valida el mensaje de error del canje <mensaje>
    Examples: Valida campo descripcion enviando valor con mayor longitud caracteres - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description                                                                                                                                                  | quantity | amount | currencyIdTwo | mensaje |
      | 0060102532 | 4700       | 150         | 001           | 0             | 64.85     | 012        | Shopstar CreditosShopstar CreditosShopstar CreditosShopstar CreditosShopstar CreditosShopstar CreditosShopstar CreditosShopstar CreditosShopstar CreditosShopstar CreditosShopstar CreditosShopstar CreditosShopstar CreditosShopstar Creditos | 1        | 150    | 001           | Lo sentimos, algo salió mal, por favor inténtalo nuevamente.  |


  #Valida campo orderNumber

  @Automated @Alternative_path @functional_testing @EXCHANGE_SHOPSTAR_14
  Scenario Outline: [UNHAPPY PATH] Valida campo numero de orden enviando valor null
    Given que el cliente accede a la aplicacion
    When el usuario ingresa su código unico <customerId> para obtener el token
    And realiza el canje de millas ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 403
    And se valida el mensaje de error del canje <mensaje>

    Examples: Valida campo numero de orden con valor null - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | mensaje |
      | 0060102532 | 4700       | 150         | 001           | 1             | 64.85     | 012        | Shopstar CreditosShopstar  | 1        | 15.67  | 001           |       El campo orderNumber debe ser obligatorio.      |

  @Automated @Alternative_path @functional_testing @EXCHANGE_SHOPSTAR_15
  Scenario Outline: [UNHAPPY PATH] Valida campo numero de orden enviando valor con mayor longitud caracteres
    Given que el cliente accede a la aplicacion
    When el usuario ingresa su código unico <customerId> para obtener el token
    And realiza el canje de millas ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 403
    And se valida el mensaje de error del canje <mensaje>

    Examples: Valida campo numero de orden enviando valor con mayor longitud caracteres - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo | mensaje                                                                      |
      | 0060102532 | 4700       | 150         | 001           | 1             | 64.85     | 012        | Shopstar CreditosShopstar  | 3        | 47.67  | 001           | El campo orderNumber debe tener un tamaño máximo de 50 caracteres. |

  @Automated @Alternative_path @functional_testing @EXCHANGE_SHOPSTAR_16
  Scenario Outline: [UNHAPPY PATH] Valida campo numero de orden enviando valor duplicado
    Given que el cliente accede a la aplicacion
    When el usuario ingresa su código unico <customerId> para obtener el token
    And realiza el canje de millas ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 403
    And se valida el mensaje de error del canje <mensaje>

    Examples: Valida campo numero de orden enviando valor con mayor longitud caracteres - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo |  mensaje |
      | 0060102532 | 4700       | 150         | 001           | 1             | 64.85     | 012        | Shopstar CreditosShopstar  | 3        | 47.67  | 001           | EXISTE UNA OPERACION CON EL CAMPO ORDER_NUMBER        |


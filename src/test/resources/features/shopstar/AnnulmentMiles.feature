@allAnnulmentMiles
Feature: Anulacion canje de millas shopstar

  @Automated @Happy_path @functional_testing @ANNULMENT_SHOPSTAR_01
  Scenario Outline: [HAPPY PATH] Valida anulación canje de millas por tipo de documento
    Given que el cliente accede a la aplicacion
    When el usuario ingresa su código unico <customerId> para obtener el token
    And realiza el canje de millas ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 200
    And validamos el canje de millas es satisfactorio con el mensaje OK
    And el usuario anula la operacion del canje de millas
    Then se valida anulacion canje es satisfactorio

    Examples: Valida anulación canje de millas con satisfactorio - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo |
      | 0060102625 | 4700       | 30.76       | 001           | 1             | 64.72     | 012        | ShopStart Creditos | 1        | 30.76  | 001           |

    Examples: Valida anulación canje de millas con satisfactorio - CE
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo |
      | 0060058604 | 4700       | 305         | 001           | 1             | 64.72     | 012        | ShopStart Creditos | 1        | 305    | 001           |

    Examples: Valida anulación canje de millas con satisfactorio - PASAPORTE
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo |
      | 0060106724 | 4700       | 17.76       | 001           | 10            | 64.72     | 012        | ShopStart Creditos | 1        | 17.76  | 001           |

  #Valida campo authorizationCode
  #Nro de autorización del canje realizado.
  @Automated @Happy_path @functional_testing @ANNULMENT_SHOPSTAR_02
  Scenario Outline: [UNHAPPY PATH] Valida anulación canje de millas enviando valores direfentes en authorizationCode
    Given que el cliente accede a la aplicacion
    When el usuario ingresa su código unico <customerId> para obtener el token
    And realiza el canje de millas ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 200
    And validamos el canje de millas es satisfactorio con el mensaje OK
    And el usuario anula la operacion enviando autorización code invalidos <authorizationCode>
    Then validamos el código de respuesta http es 403
    And se valida el mensaje de error del canje <mensaje>

    Examples: Valida anulación canje de millas con authorizationCode inválido - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo |authorizationCode|mensaje|
      | 0060102532 | 4700       | 30.76       | 001           | 1             | 64.72     | 012        | ShopStart Creditos | 1        | 30.76  | 001           |    123456        |AUTHORIZATION_CODE DE CANJE INVÁLIDO |

    Examples: Valida campo authorizationCode enviando valor con menor longitud caracteres - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo |authorizationCode|mensaje|
      | 0060058604 | 4700       | 305         | 001           | 1             | 64.72     | 012        | ShopStart Creditos | 1        | 305    | 001           |     6       |  AUTHORIZATION_CODE DE CANJE INVÁLIDO   |

    Examples: Valida campo authorizationCode enviando valor con mayor longitud caracteres - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo |authorizationCode|mensaje|
      | 0060106724 | 4700       | 17.76       | 001           | 10            | 64.72     | 012        | ShopStart Creditos | 1        | 17.76  | 001           |     667467667467       |AUTHORIZATION_CODE DE CANJE INVÁLIDO|
    Examples: Valida campo authorizationCode enviando valor alfanumérico - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo |authorizationCode|mensaje|
      | 0060106724 | 4700       | 17.76       | 001           | 10            | 64.72     | 012        | ShopStart Creditos | 1        | 17.76  | 001           |      Nhcm6h      | AUTHORIZATION_CODE DE CANJE INVÁLIDO|

  @Automated @Happy_path @functional_testing @ANNULMENT_SHOPSTAR_03
  Scenario Outline: [UNHAPPY PATH]  Valida anulación canje de millas enviando authorizationCode vacio
    Given que el cliente accede a la aplicacion
    When el usuario ingresa su código unico <customerId> para obtener el token
    And realiza el canje de millas ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 200
    And validamos el canje de millas es satisfactorio con el mensaje OK
    And el usuario anula la operacion enviando autorización code invalidos <authorizationCode>
    Then validamos el código de respuesta http es 403
    And se valida el mensaje de error del canje <mensaje>
    Examples: Valida campo authorizationCode enviando con valor Null - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo |authorizationCode|mensaje|
      | 0060106724 | 4700       | 17.76       | 001           | 10            | 64.72     | 012        | ShopStart Creditos | 1        | 17.76  | 001           |      Nhcm6h      | AUTHORIZATION_CODE DE CANJE INVÁLIDO|


  #Valida campo orderNumber - falta corriger en lado de desarrollo
  #Número de orden de la trx generado por el canal que se comparte con el cliente para que pueda identificar la compra
  @Automated @Happy_path @functional_testing @ANNULMENT_SHOPSTAR_04
  Scenario Outline:[UNHAPPY PATH] Valida anulación canje de millas por tipo de documento
    Given que el cliente accede a la aplicacion
    When el usuario ingresa su código unico <customerId> para obtener el token
    And realiza el canje de millas ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 200
    And validamos el canje de millas es satisfactorio con el mensaje OK
    And el usuario anula la operacion enviando order number invalidos <orderNumber>
    Then validamos el código de respuesta http es 403
    And se valida el mensaje de error del canje <mensaje>

    Examples: Valida campo numero de orden con valor alfanumérico - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo |orderNumber|mensaje|
      | 0060058604 | 4700       | 305         | 001           | 1             | 64.72     | 012        | ShopStart Creditos | 1        | 305    | 001           |     ABVFDCDFDS       |  NO EXISTE OPERACION PARA ANULACION |
    Examples: Valida campo numero de orden con valor numérico - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo |orderNumber|mensaje|
      | 0060058604 | 4700       | 305         | 001           | 1             | 64.72     | 012        | ShopStart Creditos | 1        | 305    | 001           |     123456789099090       |  NO EXISTE OPERACION PARA ANULACION |

    Examples: Valida campo numero de orden con valor null - DNI
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo |orderNumber|mensaje|
      | 0060106724 | 4700       | 17.76       | 001           | 10            | 64.72     | 012        | ShopStart Creditos | 1        | 17.76  | 001           |            |El campo orderNumber debe ser obligatorio.|
    Examples: Valida campo numero de orden enviando valor con mayor longitud caracteres
      | customerId | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description   | quantity | amount | currencyIdTwo |orderNumber|mensaje|
      | 0060106724 | 4700       | 17.76       | 001           | 10            | 64.72     | 012        | ShopStart Creditos | 1        | 17.76  | 001           |      23232222323222232322223232222323222232322223232222323222232322223232222323222232      | El campo orderNumber debe tener un tamaño máximo de 50 caracteres.|

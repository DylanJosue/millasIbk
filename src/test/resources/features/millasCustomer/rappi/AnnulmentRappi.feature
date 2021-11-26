@allAnnulmentMiles
Feature: Anulacion canje de millas con documentos - RAPPI

  @Automated @Happy_path @functional_testing @ANNULMENT_DOCUMENT
  Scenario Outline: [HAPPY PATH] Valida anulación canje de millas por tipo de documento
    Given que el cliente accede a la aplicacion
    When ingresamos el codigo unico <customerId> para generar token con el cliente <cliente>
    Then validamos la generacion de token satisfactorio para el usuario con tipo de documento <documentType> y numero de documento <documentNumber>
    And se realiza el canje de millas para cliente ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 200
    And validamos el canje de millas es satisfactorio con el mensaje OK
    And el usuario realiza la operacion de anulación del canje de millas del cliente <cliente>
    Then validamos el código de respuesta http es 200
    And validamos la anulacion satisfactorio del canje

    Examples: Valida anulación canje de millas con satisfactorio - DNI
      | customerId | documentType | documentNumber | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description        | quantity | amount | currencyIdTwo | cliente |
      | 0060102625 | 1            | 50501822       | 4700       | 30.76       | 001           | 1             | 64.72     | 012        | ShopStart Creditos | 1        | 30.76  | 001           | RAPPI   |

    Examples: Valida anulación canje de millas con satisfactorio - CE
      | customerId | documentType | documentNumber | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description        | quantity | amount | currencyIdTwo | cliente |
      | 0060058604 | 3            | CE201701       | 4700       | 305         | 001           | 1             | 64.72     | 012        | ShopStart Creditos | 1        | 305    | 001           | RAPPI   |

    Examples: Valida anulación canje de millas con satisfactorio - PASAPORTE
      | customerId | documentType | documentNumber | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description        | quantity | amount | currencyIdTwo | cliente |
      | 0060106732 | 5            | AD100006       | 4700       | 17.76       | 001           | 10            | 64.72     | 012        | ShopStart Creditos | 1        | 17.76  | 001           | RAPPI   |

  #Valida campo authorizationCode
  #Nro de autorización del canje realizado.
  @Automated @Happy_path @functional_testing @ANNULMENT_DOCUMENT
  Scenario Outline: [UNHAPPY PATH] Valida anulación canje de millas enviando valores direfentes en authorizationCode
    Given que el cliente accede a la aplicacion
    When ingresamos el codigo unico <customerId> para generar token con el cliente <cliente>
    Then validamos la generacion de token satisfactorio para el usuario con tipo de documento <documentType> y numero de documento <documentNumber>
    And se realiza el canje de millas para cliente ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 200
    And validamos el canje de millas es satisfactorio con el mensaje OK
    And el usuario anula la operacion enviando autorización code invalidos <authorizationCode>
    Then validamos el código de respuesta http es 403
    And se valida el mensaje de error del canje <mensaje>

    Examples: Valida anulación canje de millas con authorizationCode inválido - DNI
      | customerId | documentType | documentNumber | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description        | quantity | amount | currencyIdTwo | authorizationCode | mensaje                              | cliente |
      | 0060102625 | 1            | 50501822       | 4700       | 30.76       | 001           | 1             | 64.72     | 012        | ShopStart Creditos | 1        | 30.76  | 001           | 123456            | AUTHORIZATION_CODE DE CANJE INVÁLIDO | RAPPI   |

    Examples: Valida campo authorizationCode enviando valor con menor longitud caracteres - DNI
      | customerId | documentType | documentNumber | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description        | quantity | amount | currencyIdTwo | authorizationCode | mensaje                              | cliente |
      | 0060058604 | 3            | CE201701       | 4700       | 305         | 001           | 1             | 64.72     | 012        | ShopStart Creditos | 1        | 305    | 001           | 6                 | AUTHORIZATION_CODE DE CANJE INVÁLIDO | RAPPI   |

    Examples: Valida campo authorizationCode enviando valor con mayor longitud caracteres - DNI
      | customerId | documentType | documentNumber | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description        | quantity | amount | currencyIdTwo | authorizationCode | mensaje                              | cliente |
      | 0060102625 | 1            | 50501822       | 4700       | 17.76       | 001           | 10            | 64.72     | 012        | ShopStart Creditos | 1        | 17.76  | 001           | 667467667467      | AUTHORIZATION_CODE DE CANJE INVÁLIDO | RAPPI   |
    Examples: Valida campo authorizationCode enviando valor alfanumérico - DNI
      | customerId | documentType | documentNumber | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description        | quantity | amount | currencyIdTwo | authorizationCode | mensaje                              | cliente |
      | 0060102625 | 1            | 50501822       | 4700       | 17.76       | 001           | 10            | 64.72     | 012        | ShopStart Creditos | 1        | 17.76  | 001           | Nhcm6h            | AUTHORIZATION_CODE DE CANJE INVÁLIDO | RAPPI   |

  @Automated @Happy_path @functional_testing @ANNULMENT_DOCUMENT
  Scenario Outline: [UNHAPPY PATH]  Valida anulación canje de millas enviando authorizationCode vacio
    Given que el cliente accede a la aplicacion
    When ingresamos el codigo unico <customerId> para generar token con el cliente <cliente>
    Then validamos la generacion de token satisfactorio para el usuario con tipo de documento <documentType> y numero de documento <documentNumber>
    And se realiza el canje de millas para cliente ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 200
    And validamos el canje de millas es satisfactorio con el mensaje OK
    And el usuario anula la operacion enviando autorización code invalidos <authorizationCode>
    Then validamos el código de respuesta http es 403
    And se valida el mensaje de error del canje <mensaje>
    Examples: Valida campo authorizationCode enviando con valor Null - DNI
      | customerId | documentType | documentNumber | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description        | quantity | amount | currencyIdTwo | authorizationCode | mensaje                              | cliente |
      | 0060102625 | 1            | 50501822       | 4700       | 17.76       | 001           | 10            | 64.72     | 012        | ShopStart Creditos | 1        | 17.76  | 001           | Nhcm6h            | AUTHORIZATION_CODE DE CANJE INVÁLIDO | RAPPI   |


  #Valida campo orderNumber - falta corriger en lado de desarrollo
  #Número de orden de la trx generado por el canal que se comparte con el cliente para que pueda identificar la compra
  @Automated @Happy_path @functional_testing @ANNULMENT_DOCUMENT
  Scenario Outline:[UNHAPPY PATH] Valida anulación canje de millas por tipo de documento - número de orden diferentes
    Given que el cliente accede a la aplicacion
    When ingresamos el codigo unico <customerId> para generar token con el cliente <cliente>
    Then validamos la generacion de token satisfactorio para el usuario con tipo de documento <documentType> y numero de documento <documentNumber>
    And se realiza el canje de millas para cliente ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 200
    And validamos el canje de millas es satisfactorio con el mensaje OK
    And el usuario anula la operacion enviando order number invalidos <orderNumber>
    Then validamos el código de respuesta http es 403
    And se valida el mensaje de error del canje <mensaje>

    Examples: Valida campo numero de orden con valor alfanumérico - DNI
      | customerId | documentType | documentNumber | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description        | quantity | amount | currencyIdTwo | orderNumber | mensaje                            | cliente |
      | 0060102625 | 1            | 50501822       | 4700       | 305         | 001           | 1             | 64.72     | 012        | ShopStart Creditos | 1        | 305    | 001           | ABVFDCDFDS  | NO EXISTE OPERACION PARA ANULACION | RAPPI   |
    Examples: Valida campo numero de orden con valor numérico - DNI
      | customerId | documentType | documentNumber | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description        | quantity | amount | currencyIdTwo | orderNumber     | mensaje                            | cliente |
      | 0060102625 | 1            | 50501822       | 4700       | 305         | 001           | 1             | 64.72     | 012        | ShopStart Creditos | 1        | 305    | 001           | 123456789099090 | NO EXISTE OPERACION PARA ANULACION | RAPPI   |

    Examples: Valida campo numero de orden con valor null - DNI
      | customerId | documentType | documentNumber | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description        | quantity | amount | currencyIdTwo | orderNumber | mensaje                                    | cliente |
      | 0060102625 | 1            | 50501822       | 4700       | 17.76       | 001           | 10            | 64.72     | 012        | ShopStart Creditos | 1        | 17.76  | 001           |             | El campo orderNumber debe ser obligatorio. | RAPPI   |
    Examples: Valida campo numero de orden enviando valor con mayor longitud caracteres
      | customerId | documentType | documentNumber | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description        | quantity | amount | currencyIdTwo | orderNumber                                                                      | mensaje                                                            | cliente |
      | 0060102625 | 1            | 50501822       | 4700       | 17.76       | 001           | 10            | 64.72     | 012        | ShopStart Creditos | 1        | 17.76  | 001           | 23232222323222232322223232222323222232322223232222323222232322223232222323222232 | El campo orderNumber debe tener un tamaño máximo de 50 caracteres. | RAPPI   |


  @Automated @Happy_path @functional_testing @ANNULMENT_DOCUMENT
  Scenario Outline: [UNHAPPY PATH] Valida anulación canje de millas con client_credentials
    Given que el cliente accede a la aplicacion
    When ingresamos el codigo unico <customerId> para generar token con el cliente <cliente>
    Then validamos la generacion de token satisfactorio para el usuario con tipo de documento <documentType> y numero de documento <documentNumber>
    And se realiza el canje de millas para cliente ingresando <totalMiles>, <totalAmount>, <currencyIdOne>, <quantityMiles>, <netAmount> items <identifier>, <description>, <quantity>, <amount> y <currencyIdTwo>
    Then validamos el código de respuesta http es 200
    And validamos el canje de millas es satisfactorio con el mensaje OK
    When ingresamos al servicio de generar token para cliente <cliente>
    And el usuario realiza la operacion de anulación del canje de millas del cliente <cliente>
    Then validamos el código de respuesta http es 500
    And se valida el mensaje de error del canje <mensaje>

    Examples: Valida anulación canje de millas con satisfactorio - DNI
      | customerId | documentType | documentNumber | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description        | quantity | amount | currencyIdTwo | cliente  |mensaje|
      | 0060102625 | 1            | 50501822       | 4700       | 30.76       | 001           | 1             | 64.72     | 012        | ShopStart Creditos | 1        | 30.76  | 001           | RAPPI |Lo sentimos, algo salió mal, por favor inténtalo nuevamente.     |

    Examples: Valida anulación canje de millas con satisfactorio - CE
      | customerId | documentType | documentNumber | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description        | quantity | amount | currencyIdTwo | cliente  |mensaje|
      | 0060058604 | 3            | CE201701       | 4700       | 305         | 001           | 1             | 64.72     | 012        | ShopStart Creditos | 1        | 305    | 001           | RAPPI |Lo sentimos, algo salió mal, por favor inténtalo nuevamente.     |

    Examples: Valida anulación canje de millas con satisfactorio - PASAPORTE
      | customerId | documentType | documentNumber | totalMiles | totalAmount | currencyIdOne | quantityMiles | netAmount | identifier | description        | quantity | amount | currencyIdTwo | cliente  |mensaje|
      | 0060106732 | 5            | AD100006       | 4700       | 17.76       | 001           | 10            | 64.72     | 012        | ShopStart Creditos | 1        | 17.76  | 001           | RAPPI |Lo sentimos, algo salió mal, por favor inténtalo nuevamente.     |

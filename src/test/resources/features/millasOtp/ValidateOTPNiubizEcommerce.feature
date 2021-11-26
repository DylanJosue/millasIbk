@allValidateOTP
Feature: Validate code OTP - Niubiz Ecommerce

  @Automated @Happy_path @functional_testing @VALIDATE_OTP
  Scenario Outline: [HAPPY PATH] Valida código OTP con satisfactorio
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And genera codigo otp ingresando tipo de documento <documentType> y <documentNumber>
    Then validamos el código de respuesta http es 200
    And ingresa tipo de documento <documentType> numero de documento <documentNumber> y codigo activacion <activationCode>
    Then validamos el código de respuesta http es 200
    And se valida codigo otp satisfactorio para cliente <customerId> con mensaje <message>

    Examples: Valida código OTP con satisfactorio - DNI
      | cliente           | documentType | documentNumber | activationCode | customerId | message |
      | NIUBIZ-E-COMMERCE | 1            | 27679503       | 500000         | 0060555674 | OK      |

    Examples: Valida código OTP con satisfactorio - CE
      | cliente           | documentType | documentNumber | activationCode | customerId | message |
      | NIUBIZ-E-COMMERCE | 3            | CE201701       | 500000         | 0060058604 | OK      |

    Examples: Valida código OTP con satisfactorio - PASAPORTE
      | cliente           | documentType | documentNumber | activationCode | customerId | message |
      | NIUBIZ-E-COMMERCE | 5            | AD100004       | 500000         | 0060106724 | OK      |

  @Automated @Unhappy_path @functional_testing #@VALIDATE_OTP
  Scenario Outline: [UNHAPPY PATH] Valida ingresando código OTP incorrecto
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And genera codigo otp ingresando tipo de documento <documentType> y <documentNumber>
    Then validamos el código de respuesta http es 200
    And ingresa tipo de documento <documentType> numero de documento <documentNumber> y codigo activacion <activationCode>
    Then validamos el código de respuesta http es 403
    And se valida mensaje de error <message> del generar otp con codigo de identificacion <code>

    Examples: Valida ingresando código OTP incorrecto - CE
      | cliente           | documentType | documentNumber | activationCode | message                                                           | code     |
      | NIUBIZ-E-COMMERCE | 3            | CE201701       | 500100         | El código ingresado es incorrecto. Por favor, intenta nuevamente. | 01.01.05 |

  @Automated @Unhappy_path @functional_testing #@VALIDATE_OTP
  Scenario Outline: [UNHAPPY PATH] Valida ingresando código OTP expirado
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And genera codigo otp ingresando tipo de documento <documentType> y <documentNumber>
    Then validamos el código de respuesta http es 200
    And ingresa tipo de documento <documentType> numero de documento <documentNumber> y codigo activacion <activationCode>
    Then validamos el código de respuesta http es 403
    And se valida mensaje de error <message> del generar otp con codigo de identificacion <code>

    Examples: Valida ingresando código OTP expirado - CE
      | cliente           | documentType | documentNumber | activationCode | message                                                             | code     |
      | NIUBIZ-E-COMMERCE | 3            | CE201701       | 500200         | El código ha expirado. Genera un nuevo código e intenta nuevamente. | 01.01.06 |

  @Automated @Unhappy_path @functional_testing #@VALIDATE_OTP
  Scenario Outline: [UNHAPPY PATH] Valida ingresando código OTP incorrecta 3 veces
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And genera codigo otp ingresando tipo de documento <documentType> y <documentNumber>
    Then validamos el código de respuesta http es 200
    And ingresa tipo de documento <documentType> numero de documento <documentNumber> y codigo activacion <activationCode>
    Then validamos el código de respuesta http es 403
    And se valida mensaje de error <message> del generar otp con codigo de identificacion <code>

    Examples: Valida ingresando código OTP incorrecta 3 veces - CE
      | cliente           | documentType | documentNumber | activationCode | message                                                                                         | code     |
      | NIUBIZ-E-COMMERCE | 3            | CE201701       | 500300         | Ingresaste tu código de manera incorrecta 3 veces. Genera un nuevo código e intenta nuevamente. | 01.01.07 |


  #Valida campo activationCode
  @Automated @Unhappy_path @functional_testing #@VALIDATE_OTP
  Scenario Outline: [UNHAPPY PATH] Valida código OTP ingresando con mayor valor longitud caracteres
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And genera codigo otp ingresando tipo de documento <documentType> y <documentNumber>
    Then validamos el código de respuesta http es 200
    And ingresa tipo de documento <documentType> numero de documento <documentNumber> y codigo activacion <activationCode>
    Then validamos el código de respuesta http es 500
    And se valida mensaje de error <message> del generar otp con codigo de identificacion <code>

    Examples: Valida código OTP ingresando con mayor valor longitud caracteres - CE
      | cliente           | documentType | documentNumber | activationCode | message                                                      | code |
      | NIUBIZ-E-COMMERCE | 3            | CE201701       | 208041208041   | Lo sentimos, algo salió mal, por favor inténtalo nuevamente. | 500  |

  #Valida campos documentType and documentNumber
  @Automated @Alternative_path @functional_testing #@VALIDATE_OTP
  Scenario Outline: [UNHAPPY PATH] Valida código OTP campos del parametro tipo de documento y numero de documento
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And genera codigo otp ingresando tipo de documento 1 y 27679503
    Then validamos el código de respuesta http es 200
    And ingresa tipo de documento <documentType> numero de documento <documentNumber> y codigo activacion <activationCode>
    Then validamos el código de respuesta http es 500
    And se valida mensaje de error <message> del generar otp con codigo de identificacion <code>

    Examples: Valida campo tipo de documento con mayor valor longitud caracteres
      | cliente           | documentType | documentNumber | activationCode | message                                                      | code |
      | NIUBIZ-E-COMMERCE | 20170        | CE201701       | 500000         | Lo sentimos, algo salió mal, por favor inténtalo nuevamente. | 500  |

    Examples: Valida campo tipo de documento con valor alfanumérico
      | cliente           | documentType | documentNumber | activationCode | message                                                      | code |
      | NIUBIZ-E-COMMERCE | YW55IGNhcm   | CE201701       | 500000         | Lo sentimos, algo salió mal, por favor inténtalo nuevamente. | 500  |

    Examples: Valida campo numero de documento con mayor valor longitud caracteres
      | cliente           | documentType | documentNumber           | activationCode | message                                                      | code |
      | NIUBIZ-E-COMMERCE | 3            | CE201701CE201701CE201701 | 500000         | Lo sentimos, algo salió mal, por favor inténtalo nuevamente. | 500  |

    Examples: Valida campo numero de documento con menor valor longitud caracteres
      | cliente           | documentType | documentNumber | activationCode | message                                                      | code |
      | NIUBIZ-E-COMMERCE | 3            | CE20           | 500000         | Lo sentimos, algo salió mal, por favor inténtalo nuevamente. | 500  |

    Examples: Valida campo numero de documento con valor alfanumérico
      | cliente           | documentType | documentNumber | activationCode | message                                                      | code |
      | NIUBIZ-E-COMMERCE | 3            | YW55IGNh       | 500000         | Lo sentimos, algo salió mal, por favor inténtalo nuevamente. | 500  |

  @Automated @Alternative_path @functional_testing #@VALIDATE_OTP
  Scenario Outline:[UNHAPPY PATH] Valida código OTP campos del parametro enviando con valor Null
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And genera codigo otp ingresando tipo de documento 3 y CE201701
    Then validamos el código de respuesta http es 200
    And ingresa tipo de documento <documentType> numero de documento <documentNumber> y codigo activacion <activationCode>
    Then validamos el código de respuesta http es 404
    And se valida mensaje de error <message> del generar otp

    Examples: Valida campo tipo de documento enviando con valor null
      | cliente           | documentType | documentNumber | activationCode | message            |
      | NIUBIZ-E-COMMERCE |              | CE201701       | 500000         | Resource not found |

    Examples: Valida campo numero de documento enviando con valor null
      | cliente           | documentType | documentNumber | activationCode | message            |
      | NIUBIZ-E-COMMERCE | 3            |                | 500000         | Resource not found |

@allGenerateOTP
Feature: Generate OTP - Shopstar

  @Automated @Happy_path @functional_testing @GENERATE_OTP
  Scenario Outline: [HAPPY PATH] Valida generar OTP con satisfactorio
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And genera codigo otp ingresando tipo de documento <documentType> y <documentNumber>
    Then validamos el código de respuesta http es 200
    And se valida generar otp con satisfactorio: operador <operator>, celular <cellPhone>, nombre de operador <operatorName>, codigo unico <customerId> y el mensaje exitoso <message>

    Examples: Ingresa con documento DNI
      | cliente  | documentType | documentNumber | operator | cellPhone | operatorName | customerId | message                    |
      | SHOPSTAR | 1            | 27679503       | C        | 929···100 | Claro        | 0060555674 | Hemos reenviado el código. |

    Examples: Ingresa con documento CE
      | cliente  | documentType | documentNumber | operator | cellPhone | operatorName | customerId | message                    |
      | SHOPSTAR | 3            | CE201701       | M        | 951···898 | Movistar     | 0060058604 | Hemos reenviado el código. |

    Examples: Ingresa con documento PASAPORTE
      | cliente  | documentType | documentNumber | operator | cellPhone | operatorName | customerId | message                    |
      | SHOPSTAR | 5            | AD100004       | M        | 962···491 | Movistar     | 0060106724 | Hemos reenviado el código. |

  @Automated @Unhappy_path @functional_testing @GENERATE_OTP
  Scenario Outline: [UNHAPPY PATH] Valida generar OTP ingresando tipo de documento y número de documento diferentes
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And genera codigo otp ingresando tipo de documento <documentType> y <documentNumber>
    Then validamos el código de respuesta http es 403
    And se valida mensaje de error <message> del generar otp con codigo de identificacion <code>

    Examples:  Ingresa con tipo documento 3 y número documento DNI
      | cliente  | documentType | documentNumber | message                                                                 | code     |
      | SHOPSTAR | 3            | 27679503       | Los datos no están registrados. ¿No tienes una cuenta? Crea una cuenta. | 01.01.10 |
    Examples:  Ingresa con tipo documento 5 y número documento CE
      | cliente  | documentType | documentNumber | message                                                                 | code     |
      | SHOPSTAR | 5            | CE201701       | Los datos no están registrados. ¿No tienes una cuenta? Crea una cuenta. | 01.01.10 |
    Examples:  Ingresa con tipo documento 1 y número documento PASAPORTE
      | cliente  | documentType | documentNumber | message                                                                 | code     |
      | SHOPSTAR | 1            | AD100004       | Los datos no están registrados. ¿No tienes una cuenta? Crea una cuenta. | 01.01.10 |

  @Automated @Unhappy_path @functional_testing @GENERATE_OTP
  Scenario Outline: [UNHAPPY PATH] Valida generar OTP ingresando numero de documento sin afiliar a SMS
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And genera codigo otp ingresando tipo de documento <documentType> y <documentNumber>
    Then validamos el código de respuesta http es 403
    And se valida mensaje de error <message> del generar otp con codigo de identificacion <code>

    Examples:  Cliente no afiliado a Banca SMS
      | cliente  | documentType | documentNumber | message                                                               | code     |
      | SHOPSTAR | 1            | 50502463       | Error al momento de generar SMS. Porfavor, Inténtelo en otro momento. | 01.01.11 |

  @Automated @Unhappy_path @functional_testing @GENERATE_OTP
  Scenario Outline: [UNHAPPY PATH] Valida generar OTP ingresando número de documento sin registrar en Interbank Benefit
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And genera codigo otp ingresando tipo de documento <documentType> y <documentNumber>
    Then validamos el código de respuesta http es 403
    And se valida mensaje de error <message> del generar otp con codigo de identificacion <code>

    Examples: Cliente no registrado en Interbank Benefit
      | cliente  | documentType | documentNumber | message                                                                 | code     |
      | SHOPSTAR | 1            | 10112233       | Los datos no están registrados. ¿No tienes una cuenta? Crea una cuenta. | 01.01.10 |

  #Valida campos documentType and documentNumber
  @Automated @Alternative_path @functional_testing @GENERATE_OTP
  Scenario Outline: [ALTERNATIVE PATH] Valida campos del parametro tipo de documento y numero de documento
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And genera codigo otp ingresando tipo de documento <documentType> y <documentNumber>
    Then validamos el código de respuesta http es 403
    And se valida mensaje de error <message> del generar otp con codigo de identificacion <code>

    Examples: Valida campo tipo de documento con mayor valor longitud caracteres
      | cliente  | documentType     | documentNumber | message                                                                 | code     |
      | SHOPSTAR | 2017011011223344 | 27679503       | Los datos no están registrados. ¿No tienes una cuenta? Crea una cuenta. | 01.01.10 |

    Examples: Valida campo tipo de documento con valor alfanumérico
      | cliente  | documentType | documentNumber | message                                                                 | code     |
      | SHOPSTAR | YW55IGNhcm   | 27679503       | Los datos no están registrados. ¿No tienes una cuenta? Crea una cuenta. | 01.01.10 |

    Examples: Valida campo numero de documento con mayor valor longitud caracteres
      | cliente  | documentType | documentNumber   | message                                                                 | code     |
      | SHOPSTAR | 1            | 2767950327679503 | Los datos no están registrados. ¿No tienes una cuenta? Crea una cuenta. | 01.01.10 |

    Examples: Valida campo numero de documento con menor valor longitud caracteres
      | cliente  | documentType | documentNumber | message                                                                 | code     |
      | SHOPSTAR | 1            | 2767           | Los datos no están registrados. ¿No tienes una cuenta? Crea una cuenta. | 01.01.10 |

    Examples: Valida campo numero de documento con valor alfanumérico
      | cliente  | documentType | documentNumber | message                                                                 | code     |
      | SHOPSTAR | 1            | YW55IGNh       | Los datos no están registrados. ¿No tienes una cuenta? Crea una cuenta. | 01.01.10 |

  @Automated @Alternative_path @functional_testing @GENERATE_OTP
  Scenario Outline: [ALTERNATIVE PATH] Valida campos del parametro enviando con valor Null
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And genera codigo otp ingresando tipo de documento <documentType> y <documentNumber>
    Then validamos el código de respuesta http es 404
    And se valida mensaje de error <message> del generar otp

    Examples: Valida campo tipo de documento enviando con valor null
      | cliente  | documentType | documentNumber | message            |
      | SHOPSTAR |              | 27679503       | Resource not found |

    Examples: Valida campo numero de documento enviando con valor null
      | cliente  | documentType | documentNumber | message            |
      | SHOPSTAR | 1            |                | Resource not found |

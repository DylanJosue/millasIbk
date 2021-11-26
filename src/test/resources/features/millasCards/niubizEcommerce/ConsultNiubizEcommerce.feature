@ConsultMillasCards
Feature: Consultar saldo de millas con tarjeta - NIUBIZ-E-COMMERCE

  @Automated @Happy_path @CONSULT_NIUBIZ_ECOMMERCE1
  Scenario Outline: [HAPPY PATH] Consultar saldo de millas de tarjetas
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When el usuario con tipo de documento <documentType> y numero de documento <documentNumber> consulta su tarjeta <cardNumber>
    Then validamos el código de respuesta http es <codigo>
    And la consulta de millas de su tarjeta es satisfactoria <mensaje>
    And validamos que el response contenga sus datos y su codigo único <codUnico>

#    #4222240010041552
#    Examples: TC Visa Platinum
#      | cardNumber       | codigo | documentType | documentNumber | codUnico   | mensaje |cliente|
  #      | 422224******1552 | 200    | 1            | 50501822       | 0060102625 | OK      |  NIUBIZ-E-COMMERCE   |
#
#    #4110905020038781
#    Examples: TC Visa Signature
#      | cardNumber       | codigo | documentType | documentNumber | codUnico   | mensaje |cliente|
#      | 411090******8781 | 200    | 1            | 50502464       | 0060103262 | OK      |NIUBIZ-E-COMMERCE   |
#
#    #5491610370036163
#    Examples: TC Mastercard Platinum
#      | cardNumber       | codigo | documentType | documentNumber | codUnico   | mensaje |cliente|
#      | 549161******6163 | 200    | 1            | 50502307       | 0060103106 | OK      |NIUBIZ-E-COMMERCE   |
#
#    #5444021730057295
#    Examples: TC Mastercard Clasica
#      | cardNumber       | codigo | documentType | documentNumber | codUnico   | mensaje |cliente|
#      | 544402******7295 | 200    | 1            | 50502319       | 0060104326 | OK      |NIUBIZ-E-COMMERCE   |
#
#    #377754800113265
#    Examples: TC Amex - American Express® Black
#      | cardNumber      | codigo | documentType | documentNumber | codUnico   | mensaje |cliente|
#      | 377754*****3265 | 200    | 1            | 50501730       | 0060102533 | OK      |NIUBIZ-E-COMMERCE   |
#
#    #377753002480589
#    Examples: TC Amex - American Express®
#      | cardNumber      | codigo | documentType | documentNumber | codUnico   | mensaje |cliente|
#      | 377753*****0589 | 200    | 1            | 50501739       | 0060102542 | OK      |NIUBIZ-E-COMMERCE   |
#
#    #377754000353299
#    Examples: TC Amex - American Express® Blue
#      | cardNumber      | codigo | documentType | documentNumber | codUnico   | mensaje |cliente|
#      | 377754*****3299 | 200    | 1            | 50501742       | 0060102545 | OK      |NIUBIZ-E-COMMERCE   |
#
#    #4110740057040115
#    Examples: TD Débito
#      | cardNumber       | codigo | documentType | documentNumber | codUnico   | mensaje |cliente|
#      | 411074******0115 | 200    | 1            | 50501625       | 0060102433 | OK      |NIUBIZ-E-COMMERCE   |
#
#    #4110740057000101
#    Examples: TD Joven
#      | cardNumber       | codigo | documentType | documentNumber | codUnico   | mensaje |cliente|
#      | 411074******0101 | 200    | 1            | 50501639       | 0060102445 | OK      |NIUBIZ-E-COMMERCE   |

    #4110740000077511
    Examples: TD Cuenta corriente
      | cardNumber       | codigo | documentType | documentNumber | codUnico   | mensaje | cliente           |
      | 411074******7511 | 200    | 1            | 08819568       | 0060047641 | OK      | NIUBIZ-E-COMMERCE |

    #377754498001731
    Examples: TC American Express® Blue - PASAPORTE
      | cardNumber      | codigo | documentType | documentNumber | codUnico   | mensaje | cliente           |
      | 377754*****1731 | 200    | 5            | AD100005       | 0060106731 | OK      | NIUBIZ-E-COMMERCE |

    #377753998003106
    Examples: TC American Express® Gold - PASAPORTE
      | cardNumber      | codigo | documentType | documentNumber | codUnico   | mensaje | cliente           |
      | 377753*****3106 | 200    | 5            | AD100004       | 0060106724 | OK      | NIUBIZ-E-COMMERCE |

    #4222240057015394
    Examples: TC Visa Platinum - Carné de extranjería
      | cardNumber       | codigo | documentType | documentNumber | codUnico   | mensaje | cliente           |
      | 422224******5394 | 200    | 3            | CE277062       | 0060538904 | OK      | NIUBIZ-E-COMMERCE |

  @Automated @Unhappy_path @CONSULT_NIUBIZ_ECOMMERCE
  Scenario Outline:[UNHAPPY PATH] Consultar saldo de millas con tarjeta débito e incorrecto número de documento
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When el usuario con tipo de documento <documentType> y numero de documento <documentNumber> consulta su tarjeta <cardNumber>
    Then validamos el código de respuesta http es <codigo>
    And validamos el mensaje de error <mensaje> de la consulta

    #4110740057040115
    Examples: TD Débito
      | cardNumber       | codigo | documentType | documentNumber | mensaje                     | cliente           |
      | 411074******0115 | 403    | 1            | 50501822       | TARJETA DE DEBITO NO EXISTE | NIUBIZ-E-COMMERCE |

    #4222240010041552
    Examples: TC Visa Platinum
      | cardNumber       | codigo | documentType | documentNumber | mensaje                      | cliente           |
      | 422224******1552 | 403    | 1            | 50502464       | TARJETA DE CREDITO NO EXISTE | NIUBIZ-E-COMMERCE |

  @Automated @Unhappy_path @CONSULT_NIUBIZ_ECOMMERCE
  Scenario Outline:[UNHAPPY PATH] Consultar saldo de millas con tarjeta en plano
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When el usuario con tipo de documento <documentType> y numero de documento <documentNumber> consulta su tarjeta <cardNumber>
    Then validamos el código de respuesta http es <codigo>
    And validamos el mensaje de error <mensaje> de la consulta

    #4222240010041552
    Examples: TC Visa Oro
      | cardNumber       | codigo | documentType | documentNumber | mensaje                            | cliente           |
      | 4222240010041552 | 403    | 1            | 50501822       | REVISAR FORMATO TARJETA ENCRIPTADA | NIUBIZ-E-COMMERCE |

  @Automated @Unhappy_path @CONSULT_NIUBIZ_ECOMMERCE
  Scenario Outline:[UNHAPPY PATH] Consultar saldo de millas tarjetas que no participan en el programa
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When el usuario con tipo de documento <documentType> y numero de documento <documentNumber> consulta su tarjeta <cardNumber>
    Then validamos el código de respuesta http es <codigo>
    And validamos el mensaje de error <mensaje> de la consulta

    #4110939980029241
    Examples: Tarjeta Premia
      | cardNumber       | codigo | documentType | documentNumber | mensaje                                                                    | cliente           |
      | 411093******9241 | 403    | 1            | 45619220       | LA TARJETA NO PARTICIPA EN EL PROGRAMA DE BENEFICIOS Y/O NO ACUMULA MILLAS | NIUBIZ-E-COMMERCE |

  @Automated @Unhappy_path @CONSULT_NIUBIZ_ECOMMERCE
  Scenario Outline: [UNHAPPY PATH] Consulta saldo de millas con tarjeta cuenta de baja y cuenta bloqueada
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When el usuario con tipo de documento <documentType> y numero de documento <documentNumber> consulta su tarjeta <cardNumber>
    Then validamos el código de respuesta http es <codigo>
    And validamos el mensaje de error <mensaje> de la consulta

    #4222240010042006
    Examples: TC Visa Platinum - DNI
      | cardNumber       | codigo | documentType | documentNumber | mensaje             | cliente           |
      | 422224******2006 | 403    | 1            | 50502452       | CUENTA DADA DE BAJA | NIUBIZ-E-COMMERCE |

    #377754000353281
    Examples: TC American Express® Blue - DNI
      | cardNumber      | codigo | documentType | documentNumber | mensaje             | cliente           |
      | 377754*****3281 | 403    | 1            | 50501728       | CUENTA DADA DE BAJA | NIUBIZ-E-COMMERCE |

    #5443590450043678
    Examples: TC Mastercard Oro
      | cardNumber       | codigo | documentType | documentNumber | mensaje          | cliente           |
      | 544359******3678 | 403    | 1            | 50502306       | CUENTA BLOQUEADA | NIUBIZ-E-COMMERCE |

    #377754500179681
    Examples: TC Amex - American Express® Platinum
      | cardNumber      | codigo | documentType | documentNumber | mensaje          | cliente           |
      | 377754*****9681 | 403    | 1            | 50501743       | CUENTA BLOQUEADA | NIUBIZ-E-COMMERCE |

    #377752610032360
    Examples: TC Amex - The Platinum Card®
      | cardNumber      | codigo | documentType | documentNumber | mensaje             | cliente           |
      | 377752*****2360 | 403    | 1            | 50501741       | CUENTA DADA DE BAJA | NIUBIZ-E-COMMERCE |

    #4913370720094965
    Examples: TC Visa Oro - CE
      | cardNumber       | codigo | documentType | documentNumber | mensaje          | cliente           |
      | 491337******4965 | 403    | 3            | CE100002       | CUENTA BLOQUEADA | NIUBIZ-E-COMMERCE |

  @Automated @Unhappy_path @CONSULT_NIUBIZ_ECOMMERCE
  Scenario Outline: [UNHAPPY PATH] Consultar millas con numero de tarjeta valor no existe
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When el usuario con tipo de documento <documentType> y numero de documento <documentNumber> consulta su tarjeta <cardNumber>
    Then validamos el código de respuesta http es <codigo>
    And validamos el mensaje de error <mensaje> de la consulta

    #4323250158013525
    Examples: Numero de tarjeta valor no existe
      | cardNumber       | codigo | documentType | documentNumber | mensaje                      | cliente           |
      | 432325******3525 | 403    | 1            | 50501728       | TARJETA DE CREDITO NO EXISTE | NIUBIZ-E-COMMERCE |

  @Automated @Unhappy_path @CONSULT_NIUBIZ_ECOMMERCE
  Scenario Outline: [UNHAPPY PATH] Valida consultar millas ingresando numero tarjeta incorrecto
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When el usuario con tipo de documento <documentType> y numero de documento <documentNumber> consulta su tarjeta <cardNumber>
    Then validamos el código de respuesta http es <codigo>
    And validamos el mensaje de error <mensaje> de la consulta

  #41107400000775123655
    Examples: Ingresa numero de tarjeta valor incorrecto
      | cardNumber           | codigo | documentType | documentNumber | mensaje                            | cliente           |
      | 411074000******23655 | 403    | 1            | 50501728       | REVISAR FORMATO TARJETA ENCRIPTADA | NIUBIZ-E-COMMERCE |

  @Automated @Unhappy_path @CONSULT_NIUBIZ_ECOMMERCE
  Scenario Outline: [UNHAPPY PATH] Valida consultar millas error servicio de tarjeta
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When el usuario con tipo de documento <documentType> y numero de documento <documentNumber> consulta su tarjeta <cardNumber>
    Then validamos el código de respuesta http es <codigo>
    And validamos el mensaje de error <mensaje> de la consulta

    #491337072009333023
    Examples: ERROR SERVICIO DE TARJETA
      | cardNumber        | codigo | documentType | documentNumber | mensaje                            | cliente           |
      | 491337*******3023 | 403    | 1            | 50501728       | REVISAR FORMATO TARJETA ENCRIPTADA | NIUBIZ-E-COMMERCE |

  @Automated @Unhappy_path @CONSULT_NIUBIZ_ECOMMERCE
  Scenario Outline: [UNHAPPY PATH] Valida consultar ingresando valores vacios e valores incorrectos
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When el usuario con tipo de documento <documentType> y numero de documento <documentNumber> consulta su tarjeta <cardNumber>
    Then validamos el código de respuesta http es <codigo>
    And validamos el mensaje de error <mensaje> de la consulta

    Examples: Ingresando numero tarjeta con valor Null
      | cardNumber | codigo | documentType | documentNumber | mensaje            | cliente           |
      |            | 404    | 1            | 50501728       | Resource not found | NIUBIZ-E-COMMERCE |

    Examples: Ingresando tipo documento con valor Null
      | cardNumber       | codigo | documentType | documentNumber | mensaje                           | cliente           |
      | 422224******1552 | 403    |              | 50502464       | ERROR EN TIPO/NUMERO DE DOCUMENTO | NIUBIZ-E-COMMERCE |

    Examples: Ingresando numero documento con valor Null
      | cardNumber       | codigo | documentType | documentNumber | mensaje                           | cliente           |
      | 422224******1552 | 403    | 1            |                | ERROR EN TIPO/NUMERO DE DOCUMENTO | NIUBIZ-E-COMMERCE |

    Examples: Ingresando tipo documento no correspondiente al numero de documento - TC
      | cardNumber       | codigo | documentType | documentNumber | mensaje                        | cliente           |
      | 422224******1552 | 403    | 2            | 50502464       | ERROR EN DATOS DE ENTRADA A TC | NIUBIZ-E-COMMERCE |

    Examples: Ingresando tipo documento no correspondiente al numero de documento - TD
      | cardNumber       | codigo | documentType | documentNumber | mensaje                        | cliente           |
      | 411074******0115 | 403    | 2            | 50501625       | ERROR EN DATOS DE ENTRADA A TD | NIUBIZ-E-COMMERCE |

  @Automated @Happy_path @CONSULT_NIUBIZ_ECOMMERCE
  Scenario Outline: [UNHAPPY PATH] Consultar saldo de millas de tarjetas sin enviar orderNumber
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When el usuario consulta sin enviar valor en orderNumber, cliente con tipo de documento <documentType> y numero de documento <documentNumber> consulta su tarjeta <cardNumber>
    Then validamos el código de respuesta http es <codigo>
    And validamos el mensaje de error <mensaje> de la consulta

    #4222240010041552
    Examples: TC Visa Platinum
      | cardNumber       | codigo | documentType | documentNumber | mensaje                                    | cliente           |
      | 422224******1552 | 403    | 1            | 50501822       | El campo orderNumber debe ser obligatorio. | NIUBIZ-E-COMMERCE |

  @Automated @Happy_path @CONSULT_NIUBIZ_ECOMMERCE
  Scenario Outline: [UNHAPPY PATH] Consultar saldo de millas de tarjetas con enviar orderNumber mas de 50 caracteres
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When el usuario consulta con enviar orderNumber mas de 50 caracteres, con tipo de documento <documentType> y numero de documento <documentNumber> consulta su tarjeta <cardNumber>
    Then validamos el código de respuesta http es <codigo>
    And validamos el mensaje de error <mensaje> de la consulta

    #4222240010041552
    Examples: TC Visa Platinum
      | cardNumber       | codigo | documentType | documentNumber | mensaje                                                            | cliente           |
      | 422224******1552 | 403    | 1            | 50501822       | El campo orderNumber debe tener un tamaño máximo de 50 caracteres. | NIUBIZ-E-COMMERCE |

  @Automated @Happy_path #@CONSULT_NIUBIZ_ECOMMERCE
  Scenario Outline: [UNHAPPY PATH] Consultar saldo de millas de tarjetas en ambiente caido
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When el usuario con tipo de documento <documentType> y numero de documento <documentNumber> consulta su tarjeta <cardNumber>
    Then validamos el código de respuesta http es <codigo>
    And validamos el mensaje de error <mensaje> de la consulta

    #4222240010041552
    Examples: TC Visa Platinum
      | cardNumber       | codigo | documentType | documentNumber | mensaje                                                      | cliente           |
      | 422224******1552 | 500    | 1            | 50501822       | Lo sentimos, algo salió mal, por favor inténtalo nuevamente. | NIUBIZ-E-COMMERCE |
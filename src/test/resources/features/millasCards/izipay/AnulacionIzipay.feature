@AllAnulacionMillas
Feature: Anulacion canje de millas con tarjeta - IZIPAY

  @Automated @Happy_path @functional_testing @ANULATIONS_IZIPAY1
  Scenario Outline: [HAPPY PATH] Anulacion canje de millas por tarjeta
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el canje de millas es satisfactorio con el mensaje <mensaje>
    When el usuario anula la operacion de su tarjeta <tarjeta> con <documentType>, <documentNumber>, <codComercio>, <nameComercio> y <terminal>
    Then validamos el código de respuesta http es <codigo>
    And la anulacion canje de millas de su tarjeta es satisfactoria <mensaje>

#    #4913370720093330
#    Examples: TC Visa Oro - DNI
#      | users       | tarjeta          | codigo | mensaje | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
#      | Calle Nuñez | 491337******3330 | 200    | OK      | 1            | 50502463       | 1235        | Comercio de prueba | 120      | IZIPAY  |
#    #4110905020038781
#    Examples: TC Visa Signature
#      | users            | tarjeta          | codigo | mensaje | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
#      | Cancho Huaripata | 411090******8781 | 200    | OK      | 1            | 50502464       | 1235        | Comercio de prueba | 120      | IZIPAY  |
#    #5491610370036163
#    Examples: TC Mastercard Platinum
#      | users        | tarjeta          | codigo | mensaje | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
#      | Zonda Belito | 549161******6163 | 200    | OK      | 1            | 50502307       | 1235        | Comercio de prueba | 120      | IZIPAY  |
#    #5444021730057295
#    Examples: TC Mastercard Clasica - DNI
#      | users           | tarjeta          | codigo | mensaje | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
#      | Esteban Polanco | 544402******7295 | 200    | OK      | 1            | 50502319       | 1235        | Comercio de prueba | 120      | IZIPAY  |
#   #377754800113265
#    Examples: TC American Express® Black - DNI
#      | users          | tarjeta         | codigo | mensaje | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
#      | Cabello Lidice | 377754*****3265 | 200    | OK      | 1            | 50501730       | 1235        | Comercio de prueba | 120      | IZIPAY  |
#    #4110740057000101
#    Examples: TD Débito Joven - DNI
#      | users              | tarjeta          | codigo | mensaje | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
#      | Estudio Tributario | 411074******0101 | 200    | OK      | 1            | 50501639       | 1235        | Comercio de prueba | 120      | IZIPAY  |
    #4110740000077511
    Examples: TD Débito Cuenta corriente - DNI
      | users        | tarjeta          | codigo | mensaje | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
      | Juan Paredes | 411074******7511 | 200    | OK      | 1            | 08819568       | 1235        | Comercio de prueba | 120      | IZIPAY  |

    #--------------------------------------------DOCUMENTOS DIFERENTES A DNI---------------------------------------//
    #377754498001731
    Examples: TC American Express® Blue - PASAPORTE
      | users         | tarjeta         | codigo | mensaje | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
      | Javier Caraza | 377754*****1731 | 200    | OK      | 5            | AD100005       | 1235        | Comercio de prueba | 120      | IZIPAY  |
    #377753998003106
    Examples: TC American Express® Gold - PASAPORTE
      | users        | tarjeta         | codigo | mensaje | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
      | Ramiro Calle | 377753*****3106 | 200    | OK      | 5            | AD100004       | 1235        | Comercio de prueba | 120      | IZIPAY  |
    #4222240057015394
    Examples: TC Visa Platinum - Carné de extranjería
      | users         | tarjeta          | codigo | mensaje | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
      | Baltasar Peña | 422224******5394 | 200    | OK      | 3            | CE277062       | 1235        | Comercio de prueba | 120      | IZIPAY  |


  @Automated @Happy_path @functional_testing @ANULATIONS_IZIPAY
  Scenario Outline: [UNHAPPY PATH] Anulacion canje de millas con envío de código de autorización mas de 6 caracteres
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es 200
    And se valida el canje de millas es satisfactorio con el mensaje OK
    When se anula la operacion de su tarjeta <tarjeta> con <documentType>, <documentNumber>, <codComercio>, <nameComercio> y <terminal>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>
#4110740000077511
    Examples: Envío de código autorización mas de 6 caracteres
      | users        | tarjeta          | codigo | mensaje                                                         | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
      | Juan Paredes | 411074******7511 | 403    | El campo authorizationCode debe tener un tamaño de 6 caracteres | 1            | 50501822       | 1235        | Comercio de prueba | 120      | IZIPAY  |

  @Automated @Happy_path @functional_testing @ANULATIONS_IZIPAY
  Scenario Outline: [UNHAPPY PATH] Anulacion canje de millas con envío de código de autorización de tipo string
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es 200
    And se valida el canje de millas es satisfactorio con el mensaje OK
    When el usuario tiene que anular la operacion de su tarjeta <tarjeta> con <documentType>, <documentNumber>, <codComercio>, <nameComercio> y <terminal>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>
#4110740000077511
    Examples: Envío de código autorización de tipo string
      | users        | tarjeta          | codigo | mensaje                                | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
      | Juan Paredes | 411074******7511 | 403    | El campo authorizationCode es numérico | 1            | 50501822       | 1235        | Comercio de prueba | 120      | IZIPAY  |

  @Automated @Happy_path @functional_testing @ANULATIONS_IZIPAY
  Scenario Outline: [UNHAPPY PATH] Anulacion canje de millas sin envio de la tarjeta encriptada
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es 200
    And se valida el canje de millas es satisfactorio con el mensaje OK
    When el usuario anula la operacion de su tarjeta <tarjetaEmpty> con <documentType>, <documentNumber>, <codComercio>, <nameComercio> y <terminal>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: Sin envio de la tarjeta encriptada
      | users        | tarjeta          | tarjetaEmpty | codigo | mensaje                        | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
      | Juan Paredes | 411074******7511 |              | 403    | El campo cardId es obligatorio | 1            | 50501822       | 1235        | Comercio de prueba | 120      | IZIPAY  |

  @Automated @Happy_path @functional_testing @ANULATIONS_IZIPAY
  Scenario Outline: [UNHAPPY PATH] Anulacion canje de millas con envio de la tarjeta en plano
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es 200
    And se valida el canje de millas es satisfactorio con el mensaje OK
    When el usuario anula la operacion de su tarjeta <tarjetaEmpty> con <documentType>, <documentNumber>, <codComercio>, <nameComercio> y <terminal>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: Envio de la tarjeta en plano
      | users        | tarjeta          | tarjetaEmpty     | codigo | mensaje                                 | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
      | Juan Paredes | 411074******7511 | 4110740000077511 | 403    | ERROR EN TARJETA NO INFORMADO O FORMATO | 1            | 50501822       | 1235        | Comercio de prueba | 120      | IZIPAY  |

  @Automated @Happy_path @functional_testing @ANULATIONS_IZIPAY
  Scenario Outline: [UNHAPPY PATH] Anulacion canje de millas con envio de la tarjeta encriptada con mas de 20 caracteres
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es 200
    And se valida el canje de millas es satisfactorio con el mensaje OK
    When el usuario anula la operacion de su tarjeta <tarjetaEmpty> con <documentType>, <documentNumber>, <codComercio>, <nameComercio> y <terminal>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: Con envio de la tarjeta encriptada con mas de 20 caracteres
      | users        | tarjeta          | tarjetaEmpty      | codigo | mensaje                                                         | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
      | Juan Paredes | 411074******7511 | 411074******75112 | 403    | El campo cardNumber debe tener un tamaño de 15 o 16 caracteres. | 1            | 50501822       | 1235        | Comercio de prueba | 120      | IZIPAY  |

  @Automated @Happy_path @functional_testing @ANULATIONS_IZIPAY
  Scenario Outline: [UNHAPPY PATH] Anulacion canje de millas sin enviar valores
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es 200
    And se valida el canje de millas es satisfactorio con el mensaje OK
    When el usuario anula la operacion de su tarjeta <tarjeta> con <documentType>, <documentNumber>, <codComercio>, <nameComercio> y <terminal>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>
#4913370720093330
    Examples: Enviar - cógido de comercio con mas de 20 caracteres
      | users        | tarjeta          | codigo | mensaje                                                              | documentType | documentNumber | codComercio           | nameComercio       | terminal | cliente |
      | Juan Paredes | 411074******7511 | 403    | El campo commerce.code debe tener un tamaño máximo de 20 caracteres. | 1            | 08819568       | 123456789012345678901 | Comercio de prueba | 120      | IZIPAY  |

    Examples: Enviar - cógido de comercio con mas de 20 caracteres
      | users        | tarjeta          | codigo | mensaje                                                               | documentType | documentNumber | codComercio | nameComercio                                                                                                                                                                         | terminal | cliente |
      | Juan Paredes | 411074******7511 | 403    | El campo commerce.name debe tener un tamaño máximo de 128 caracteres. | 1            | 08819568       | 1235        | Comercio de pruebaComercio de pruebaComercio de pruebaComercio de pruebaComercio de pruebaComercio de pruebaComercio de pruebaComercio de pruebaComercio de pruebaComercio de prueba | 120      | IZIPAY  |

    Examples: Enviar - campo terminal mas de 200 caracteres
      | users        | tarjeta          | codigo | mensaje                                                          | documentType | documentNumber | codComercio | nameComercio       | terminal                                                                                                                                                                                                  | cliente |
      | Juan Paredes | 411074******7511 | 403    | El campo terminal debe tener un tamaño máximo de 200 caracteres. | 1            | 08819568       | 1235        | Comercio de prueba | 123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901 | IZIPAY  |

  @Automated @Happy_path @functional_testing @ANULATIONS_IZIPAY
  Scenario Outline: [UNHAPPY PATH] Anulacion canje de millas sin enviar valores para orderNumber
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es 200
    And se valida el canje de millas es satisfactorio con el mensaje OK
    When el usuario anula la operacion sin enviar el número orden para su <tarjeta> con <documentType>, <documentNumber>, <codComercio>, <nameComercio> y <terminal>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: Sin enviar - campo orderNumber
      | users        | tarjeta          | codigo | mensaje                                    | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
      | Juan Paredes | 411074******7511 | 403    | El campo orderNumber debe ser obligatorio. | 1            | 08819568       | 1235        | Comercio de prueba | 120      | IZIPAY  |

  @Automated @Happy_path @functional_testing @ANULATIONS_IZIPAY
  Scenario Outline: [UNHAPPY PATH] Anulacion canje de millas con enviar orderNumber mas de 50 caracteres
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es 200
    And se valida el canje de millas es satisfactorio con el mensaje OK
    When el usuario anula la operacion con enviar número de orden para su tarjeta <tarjeta> con <documentType>, <documentNumber>, <codComercio>, <nameComercio> y <terminal>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: Enviar - campo orderNumber mas de 50 caracteres
      | users        | tarjeta          | codigo | mensaje                                                            | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
      | Juan Paredes | 411074******7511 | 403    | El campo orderNumber debe tener un tamaño máximo de 50 caracteres. | 1            | 08819568       | 1235        | Comercio de prueba | 120      | IZIPAY  |

  @Automated @Happy_path @functional_testing @ANULATIONS_IZIPAY
  Scenario Outline: [UNHAPPY PATH] Anulacion canje de millas con envío de diferentes valores incorrectos en customer
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es 200
    And se valida el canje de millas es satisfactorio con el mensaje OK
    When el usuario anula la operacion de su tarjeta <tarjeta> con <documentType>, <documentNumber>, <codComercio>, <nameComercio> y <terminal>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: Enviando customer.documentType de tipo string
      | users        | tarjeta          | codigo | mensaje                                     | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
      | Juan Paredes | 411074******7511 | 403    | El campo customer.documentType es numérico. | A            | 08819568       | 1235        | Comercio de prueba | 120      | IZIPAY  |

    Examples: Enviando customer.documentType mas de 2 caracteres
      | users        | tarjeta          | codigo | mensaje                                                                                             | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
      | Juan Paredes | 411074******7511 | 403    | El campo customer.documentType solo admite valores 1 = DNI, 3 = Carnet extranjeria y 5 = Pasaporte. | 11           | 08819568       | 1235        | Comercio de prueba | 120      | IZIPAY  |

    Examples: Enviando customer.documentType diferente a 1, 3 y 5
      | users        | tarjeta          | codigo | mensaje                                                                                             | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
      | Juan Paredes | 411074******7511 | 403    | El campo customer.documentType solo admite valores 1 = DNI, 3 = Carnet extranjeria y 5 = Pasaporte. | 2            | 08819568       | 1235        | Comercio de prueba | 120      | IZIPAY  |

    Examples: Sin enviar customer.documentType
      | users        | tarjeta          | codigo | mensaje                                        | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
      | Juan Paredes | 411074******7511 | 403    | El campo customer.documentType es obligatorio. |              | 08819568       | 1235        | Comercio de prueba | 120      | IZIPAY  |

    Examples: Enviando customer.documentNumber de tipo string
      | users        | tarjeta          | codigo | mensaje                                       | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
      | Juan Paredes | 411074******7511 | 403    | El campo customer.documentNumber es numérico. | 1            | ABCDFEGI       | 1235        | Comercio de prueba | 120      | IZIPAY  |

    Examples: Enviando customer.documentNumber mas de 8 caracteres de tipo numérico
      | users        | tarjeta          | codigo | mensaje                                                                | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
      | Juan Paredes | 411074******7511 | 403    | El campo customer.documentNumber debe tener un tamaño de 8 caracteres. | 1            | 088195681      | 1235        | Comercio de prueba | 120      | IZIPAY  |

    Examples: Enviando customer.documentNumber mas de 8 caracteres de tipo string
      | users        | tarjeta          | codigo | mensaje                                       | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
      | Juan Paredes | 411074******7511 | 403    | El campo customer.documentNumber es numérico. | 1            | ABCDEFGHD      | 1235        | Comercio de prueba | 120      | IZIPAY  |

    Examples: Sin enviar customer.documentNumber
      | users        | tarjeta          | codigo | mensaje                                          | documentType | documentNumber | codComercio | nameComercio       | terminal | cliente |
      | Juan Paredes | 411074******7511 | 403    | El campo customer.documentNumber es obligatorio. | 1            |                | 1235        | Comercio de prueba | 120      | IZIPAY  |

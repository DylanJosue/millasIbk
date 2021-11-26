@AllCanjeMillas
Feature: Valida canje de millas con tarjeta - NIUBIZ

  @Automated @Happy_path @EXCHANGE_NIUBIZ
  Scenario Outline: [HAPPY PATH] Valida canje de millas con diferentes tarjetas que participan en el programa
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el canje de millas es satisfactorio con el mensaje <mensaje>

 #4222240010041552
    Examples: TC Visa Oro - DNI
      | users          | tarjeta          | codigo | mensaje | cliente |
      | Benjamin Aroni | 422224******1552 | 200    | OK      | NIUBIZ  |
#
#4913370720093330
    Examples: TC Visa Oro - DNI
      | users       | tarjeta          | codigo | mensaje | cliente |
      | Calle Nuñez | 491337******3330 | 200    | OK      | NIUBIZ  |
#4110905020038781
    Examples: TC Visa Signature
      | users            | tarjeta          | codigo | mensaje | cliente |
      | Cancho Huaripata | 411090******8781 | 200    | OK      | NIUBIZ  |
    #5491610370036163
    Examples: TC Mastercard Platinum
      | users        | tarjeta          | codigo | mensaje | cliente |
      | Zonda Belito | 549161******6163 | 200    | OK      | NIUBIZ  |
    #5444021730057295
    Examples: TC Mastercard Clasica - DNI
      | users           | tarjeta          | codigo | mensaje | cliente |
      | Esteban Polanco | 544402******7295 | 200    | OK      | NIUBIZ  |
    #377754800113265
    Examples: TC American Express® Black - DNI
      | users          | tarjeta         | codigo | mensaje | cliente |
      | Cabello Lidice | 377754*****3265 | 200    | OK      | NIUBIZ  |
    #4110740057000101
    Examples: TD Débito Joven - DNI
      | users              | tarjeta          | codigo | mensaje | cliente |
      | Estudio Tributario | 411074******0101 | 200    | OK      | NIUBIZ  |
    #4110740000077511
    Examples: TD Débito Cuenta corriente - DNI
      | users        | tarjeta          | codigo | mensaje | cliente |
      | Juan Paredes | 411074******7511 | 200    | OK      | NIUBIZ  |

    #---------------------------CANJE--------------------------------#

    #377754498001731
    Examples: TC American Express® Blue - PASAPORTE
      | users         | tarjeta         | codigo | mensaje | cliente |
      | Javier Caraza | 377754*****1731 | 200    | OK      | NIUBIZ  |

    #377753998003106
    Examples: TC American Express® Gold - PASAPORTE
      | users        | tarjeta         | codigo | mensaje | cliente |
      | Ramiro Calle | 377753*****3106 | 200    | OK      | NIUBIZ  |

    #4222240057015394
    Examples: TC Visa Platinum - Carné de extranjería
      | users         | tarjeta          | codigo | mensaje | cliente |
      | Baltasar Peña | 422224******5394 | 200    | OK      | NIUBIZ  |

  @Automated @Happy_path @functional_testing @EXCHANGE_NIUBIZ
  Scenario Outline: [UNHAPPY PATH] Valida canje de millas por segunda vez con el mismo orderNumber
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas con enviar orderNumber existente para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>
#4913370720093330
    Examples: TC American Express® Blue - PASAPORTE
      | users       | tarjeta          | codigo | mensaje                                        | cliente |
      | Calle Nuñez | 491337******3330 | 403    | EXISTE UNA OPERACION CON EL CAMPO ORDER_NUMBER | NIUBIZ  |


  @Automated @Happy_path @functional_testing @EXCHANGE_NIUBIZ
  Scenario Outline: [UNHAPPY PATH] Valida canje de millas con tarjetas que no participan en el programa
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>
#4110939980029241
    Examples: TC Visa Oro - DNI
      | users         | tarjeta          | codigo | mensaje                                                                    | cliente |
      | Mirtha Flores | 411093******9241 | 403    | LA TARJETA NO PARTICIPA EN EL PROGRAMA DE BENEFICIOS Y/O NO ACUMULA MILLAS | NIUBIZ  |

  @Automated @Happy_path @functional_testing @EXCHANGE_NIUBIZ
  Scenario Outline: [UNHAPPY PATH] Valida canje de millas con tarjeta sin saldo suficiente
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>
#4222240010041347
    Examples: TC Visa Platinum - DNI
      | users        | tarjeta          | codigo | mensaje                        | cliente |
      | Solorio Jose | 422224******1347 | 403    | NO CUENTA CON SALDO SUFICIENTE | NIUBIZ  |

  @Automated @Happy_path @functional_testing @EXCHANGE_NIUBIZ
  Scenario Outline: [UNHAPPY PATH] Valida canje de millas con cuenta dada de baja
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>
#4732455980023132
    Examples: TC Visa Cashback Oro - DNI
      | users           | tarjeta          | codigo | mensaje             | cliente |
      | Conavirus Virus | 473245******3132 | 403    | CUENTA DADA DE BAJA | NIUBIZ  |
    #4222240010042006
    Examples: TC Visa Platinium - DNI
      | users            | tarjeta          | codigo | mensaje             | cliente |
      | Beltran Martinez | 422224******2006 | 403    | CUENTA DADA DE BAJA | NIUBIZ  |

  @Automated @Happy_path @functional_testing @EXCHANGE_NIUBIZ
  Scenario Outline: [UNHAPPY PATH] Valida canje de millas con tarjeta cuenta bloqueada
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>
#5443590450043678
    Examples: C Visa Cashback Oro - DNI
      | users        | tarjeta          | codigo | mensaje          | cliente |
      | Ramos Cuevas | 544359******3678 | 403    | CUENTA BLOQUEADA | NIUBIZ  |
    #377754500179681
    Examples: C Visa Cashback Oro - DNI
      | users       | tarjeta         | codigo | mensaje          | cliente |
      | Sermax Mery | 377754*****9681 | 403    | CUENTA BLOQUEADA | NIUBIZ  |


  @Automated @Happy_path @functional_testing @EXCHANGE_NIUBIZ
  Scenario Outline: [HAPPY PATH] Valida canje de millas enviando tarjeta en plano
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>
#4913370720093330
    Examples: TC Visa Oro - DNI
      | users           | tarjeta          | codigo | mensaje                            | cliente |
      | Calle Nuñez Sin | 4913370720093330 | 403    | REVISAR FORMATO TARJETA ENCRIPTADA | NIUBIZ  |

  @Automated @Happy_path @functional_testing @EXCHANGE_NIUBIZ
  Scenario Outline: [HAPPY PATH] Validar canje de millas sin enviar orderNumber
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas sin enviar orderNumber para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>
#4913370720093330
    Examples: TC Visa Oro - DNI
      | users           | tarjeta          | codigo | mensaje                                    | cliente |
      | Calle Nuñez Sin | 491337******3330 | 403    | El campo orderNumber debe ser obligatorio. | NIUBIZ  |

  @Automated @Happy_path @functional_testing @EXCHANGE_NIUBIZ
  Scenario Outline: [UNHAPPY PATH] Valida canjear con envio de orderNumber mas de 50 caracteres
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas con envio de orderNumber mas de 50 caracteres para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: Envio de orderNumber mas de 50 caracteres
      | users       | tarjeta          | codigo | mensaje                                                            | cliente |
      | Calle Nuñez | 549161******6163 | 403    | El campo orderNumber debe tener un tamaño máximo de 50 caracteres. | NIUBIZ  |

  @Automated @Happy_path @functional_testing @EXCHANGE_NIUBIZ
  Scenario Outline: [UNHAPPY PATH] Valida campo del request enviando valores vacíos
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: Sin enviar valor en campo netMiles
      | users                | tarjeta          | codigo | mensaje                                | cliente |
      | Calle Nuñez netMiles | 491337******3330 | 403    | El campo netMiles es un número entero. | NIUBIZ  |

#    Examples: Sin enviar valor en campo commerce.code
#      | users            | tarjeta          | codigo | mensaje                                |cliente |
#      | Calle Nuñez Code | 491337******3330 | 403    | El campo commerce.code es obligatorio. |NIUBIZ  |
#
#    Examples: Sin enviar valor en campo commerce.name
#      | users            | tarjeta          | codigo | mensaje                                |cliente |
#      | Calle Nuñez Name | 491337******3330 | 403    | El campo commerce.name es obligatorio. |NIUBIZ  |

    Examples: Sin enviar valor typo en campo customer
      | users                | tarjeta          | codigo | mensaje                                        | cliente |
      | Calle Nuñez Customer | 491337******3330 | 403    | El campo customer.documentType es obligatorio. | NIUBIZ  |
    Examples: Sin enviar valor document en campo customer
      | users                 | tarjeta          | codigo | mensaje                                          | cliente |
      | Calle Nuñez customer2 | 491337******3330 | 403    | El campo customer.documentNumber es obligatorio. | NIUBIZ  |

#    Examples: Sin enviar valor en campo terminal
#      | users                | tarjeta          | codigo | mensaje                                                      | cliente |
#      | Calle Nuñez Terminal | 491337******3330 | 403    | Lo sentimos, algo salió mal, por favor inténtalo nuevamente. | NIUBIZ  |

  @Automated @Happy_path @functional_testing @EXCHANGE_NIUBIZ
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas negativas
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: Valida canje con millas negativas
      | users          | tarjeta          | codigo | mensaje                                | cliente |
      | Zonda Belito 1 | 549161******6163 | 403    | El campo netMiles es un número entero. | NIUBIZ  |

  @Automated @Happy_path @functional_testing @EXCHANGE_NIUBIZ
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas enviando commerce.code mas de 20 caracteres
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: commerce.code mas de 20 caracteres
      | users                | tarjeta          | codigo | mensaje                                                              | cliente |
      | Zonda Belito 20carac | 549161******6163 | 403    | El campo commerce.code debe tener un tamaño máximo de 20 caracteres. | NIUBIZ  |

  @Automated @Happy_path @functional_testing @EXCHANGE_NIUBIZ
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas enviando commerce.name mas de 128 caracteres
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: commerce.name mas de 128 caracteres
      | users                 | tarjeta          | codigo | mensaje                                                               | cliente |
      | Zonda Belito 128carac | 549161******6163 | 403    | El campo commerce.name debe tener un tamaño máximo de 128 caracteres. | NIUBIZ  |

  @Automated @Happy_path @functional_testing @EXCHANGE_NIUBIZ
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas enviando customer.documentType mas de 2 caracteres
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: customer.documentType mas de 2 caracteres
      | users              | tarjeta          | codigo | mensaje                                                                                             | cliente |
      | Zonda Belito 2type | 549161******6163 | 403    | El campo customer.documentType solo admite valores 1 = DNI, 3 = Carnet extranjeria y 5 = Pasaporte. | NIUBIZ  |

  @Automated @Happy_path @functional_testing @EXCHANGE_NIUBIZ
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas enviando customer.documentType de tipo string
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: customer.documentType de tipo string
      | users                   | tarjeta          | codigo | mensaje                                     | cliente |
      | Zonda Belito TypeString | 549161******6163 | 403    | El campo customer.documentType es numérico. | NIUBIZ  |

  @Automated @Happy_path @functional_testing @EXCHANGE_NIUBIZ
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas enviando customer.documentType diferente a 1, 3 y 5
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: customer.documentType diferente a 1, 3 y 5
      | users             | tarjeta          | codigo | mensaje                                                                                             | cliente |
      | Zonda Belito Diff | 549161******6163 | 403    | El campo customer.documentType solo admite valores 1 = DNI, 3 = Carnet extranjeria y 5 = Pasaporte. | NIUBIZ  |

  @Automated @Happy_path @functional_testing @EXCHANGE_NIUBIZ
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas enviando customer.documentNumber de tipo string
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples:  customer.documentNumber de tipo string
      | users                     | tarjeta          | codigo | mensaje                                       | cliente |
      | Zonda Belito NumberString | 549161******6163 | 403    | El campo customer.documentNumber es numérico. | NIUBIZ  |

  @Automated @Happy_path @functional_testing @EXCHANGE_NIUBIZ
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas enviando customer.documentNumber mas de 8 caracteres de tipo numérico
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples:  customer.documentNumber mas de 8 caracteres de tipo numérico
      | users                  | tarjeta          | codigo | mensaje                                                                | cliente |
      | Zonda Belito NumberMas | 549161******6163 | 403    | El campo customer.documentNumber debe tener un tamaño de 8 caracteres. | NIUBIZ  |

  @Automated @Happy_path @functional_testing @EXCHANGE_NIUBIZ
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas enviando customer.documentNumber mas de 8 caracteres de tipo string
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples:  customer.documentNumber mas de 8 caracteres de tipo string
      | users                  | tarjeta          | codigo | mensaje                                       | cliente |
      | Zonda Belito StringMas | 549161******6163 | 403    | El campo customer.documentNumber es numérico. | NIUBIZ  |

  @Automated @Happy_path @functional_testing @EXCHANGE_NIUBIZ
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas sin enviar customer.documentNumber
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples:  sin enviar customer.documentNumber
      | users                  | tarjeta          | codigo | mensaje                                          | cliente |
      | Zonda Belito SinDocNum | 549161******6163 | 403    | El campo customer.documentNumber es obligatorio. | NIUBIZ  |

  @Automated @Happy_path @functional_testing @EXCHANGE_NIUBIZ
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas sin enviar customer.documentType y customer.documentNumber no correspondiente
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: customer.documentType y customer.documentNumber no correspondiente
      | users                  | tarjeta          | codigo | mensaje                        | cliente |
      | Zonda Belito NotCorres | 549161******6163 | 403    | ERROR EN DATOS DE ENTRADA A TC | NIUBIZ  |

  @Automated @Happy_path @functional_testing @EXCHANGE_NIUBIZ
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas enviando terminal mas de 200 caracteres
    Given que el usuario accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: enviando terminal mas de 200 caracteres
      | users                    | tarjeta          | codigo | mensaje                                                          | cliente |
      | Zonda Belito 200Terminal | 549161******6163 | 403    | El campo terminal debe tener un tamaño máximo de 200 caracteres. | NIUBIZ  |






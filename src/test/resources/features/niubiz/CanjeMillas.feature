@AllCanjeMillas
Feature: Valida canje de millas niubiz

  @Automated @Happy_path @EXCHANGE_01
  Scenario Outline: [HAPPY PATH] Valida canje de millas con diferentes tarjetas que participan en el programa
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el canje de millas es satisfactorio con el mensaje <mensaje>
#4913370720093330
    Examples: TC Visa Oro - DNI
      | users       | tarjeta          | codigo | mensaje |
      | Calle Nuñez | 491337******3330 | 200    | OK      |
#4110905020038781
    Examples: TC Visa Signature
      | users            | tarjeta          | codigo | mensaje |
      | Cancho Huaripata | 411090******8781 | 200    | OK      |
#5491610370036163
    Examples: TC Mastercard Platinum
      | users        | tarjeta          | codigo | mensaje |
      | Zonda Belito | 549161******6163 | 200    | OK      |
    #5444021730057295
    Examples: TC Mastercard Clasica - DNI
      | users           | tarjeta          | codigo | mensaje |
      | Esteban Polanco | 544402******7295 | 200    | OK      |
    #377754500179673
#    Examples: TC American Express® Platinum - DNI
#      | users            | tarjeta          | codigo | mensaje |
#      | Nestor Diaz | 377754*****9673 | 200    | OK      |
    #377754800113265
    Examples: TC American Express® Black - DNI
      | users          | tarjeta         | codigo | mensaje |
      | Cabello Lidice | 377754*****3265 | 200    | OK      |
    #4110740057000101
    Examples: TD Débito Joven - DNI
      | users              | tarjeta          | codigo | mensaje |
      | Estudio Tributario | 411074******0101 | 200    | OK      |
    #4110740000077511
    Examples: TD Débito Cuenta corriente - DNI
      | users        | tarjeta          | codigo | mensaje |
      | Juan Paredes | 411074******7511 | 200    | OK      |

  @Automated @Happy_path @functional_testing @EXCHANGE_02
  Scenario Outline: [UNHAPPY PATH] Valida canje de millas por segunda vez con el mismo orderNumber
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>
#4913370720093330
    Examples: TC American Express® Blue - PASAPORTE
      | users       | tarjeta          | codigo | mensaje                                        |
      | Calle Nuñez | 491337******3330 | 403    | EXISTE UNA OPERACION CON EL CAMPO ORDER_NUMBER |

  @Automated @Happy_path @functional_testing @EXCHANGE_03
  Scenario Outline: [UNHAPPY PATH] Valida canje de millas con tarjetas que no cuenta con saldo suficiente
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>
#377754498001731
    Examples: TC American Express® Blue - PASAPORTE
      | users         | tarjeta         | codigo | mensaje                        |
      | Javier Caraza | 377754*****1731 | 403    | NO CUENTA CON SALDO SUFICIENTE |

  @Automated @Happy_path @functional_testing @EXCHANGE_04
  Scenario Outline: [UNHAPPY PATH] Valida canje de millas con tarjetas que no participan en el programa
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>
#4110939980029241
    Examples: TC Visa Oro - DNI
      | users         | tarjeta          | codigo | mensaje                                                                    |
      | Mirtha Flores | 411093******9241 | 403    | LA TARJETA NO PARTICIPA EN EL PROGRAMA DE BENEFICIOS Y/O NO ACUMULA MILLAS |

  @Automated @Happy_path @functional_testing @EXCHANGE_05
  Scenario Outline: [UNHAPPY PATH] Valida canje de millas con tarjeta sin saldo suficiente
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>
#4222240010041347
    Examples: TC Visa Platinum - DNI
      | users        | tarjeta          | codigo | mensaje                        |
      | Solorio Jose | 422224******1347 | 403    | NO CUENTA CON SALDO SUFICIENTE |

  @Automated @Happy_path @functional_testing @EXCHANGE_06
  Scenario Outline: [UNHAPPY PATH] Valida canje de millas con cuenta dada de baja
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>
#4732455980023132
    Examples: TC Visa Cashback Oro - DNI
      | users           | tarjeta          | codigo | mensaje             |
      | Conavirus Virus | 473245******3132 | 403    | CUENTA DADA DE BAJA |
    #4222240010042006
    Examples: TC Visa Platinium - DNI
      | users            | tarjeta          | codigo | mensaje             |
      | Beltran Martinez | 422224******2006 | 403    | CUENTA DADA DE BAJA |

  @Automated @Happy_path @functional_testing @EXCHANGE_07
  Scenario Outline: [UNHAPPY PATH] Valida canje de millas con tarjeta cuenta bloqueada
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>
#5443590450043678
    Examples: C Visa Cashback Oro - DNI
      | users        | tarjeta          | codigo | mensaje          |
      | Ramos Cuevas | 544359******3678 | 403    | CUENTA BLOQUEADA |
    #377754500179681
    Examples: C Visa Cashback Oro - DNI
      | users       | tarjeta         | codigo | mensaje          |
      | Sermax Mery | 377754*****9681 | 403    | CUENTA BLOQUEADA |

  @Automated @Happy_path @functional_testing @EXCHANGE_08
  Scenario Outline: [UNHAPPY PATH] Valida parametro numero tarjeta enviando valor vacío
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: TC Visa Oro - DNI
      | users        | tarjeta | codigo | mensaje            |
      | Zonda Belito |         | 404    | Resource not found |

  @Automated @Happy_path @functional_testing @EXCHANGE_09
  Scenario Outline: [HAPPY PATH] Valida canje de millas enviando tarjeta en plano
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>
#4913370720093330
    Examples: TC Visa Oro - DNI
      | users           | tarjeta          | codigo | mensaje                                        |
      | Calle Nuñez Sin | 4913370720093330 | 403    | REVISAR FORMATO TARJETA ENCRIPTADA |

  @Automated @Happy_path @functional_testing @EXCHANGE_10
  Scenario Outline: [HAPPY PATH] Validar canje de millas sin enviar orderNumber
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>
#4913370720093330
    Examples: TC Visa Oro - DNI
      | users           | tarjeta          | codigo | mensaje                                        |
      | Calle Nuñez Sin | 491337******3330 | 403    | El campo orderNumber debe ser obligatorio. |

  @Automated @Happy_path @functional_testing @EXCHANGE_11
  Scenario Outline: [UNHAPPY PATH] Valida canjear con envio de orderNumber mas de 50 caracteres
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: Envio de orderNumber mas de 50 caracteres
      | users                    | tarjeta          | codigo | mensaje                                                            |
      | Calle Nuñez | 549161******6163 | 403    | El campo orderNumber debe tener un tamaño máximo de 50 caracteres. |

  @Automated @Happy_path @functional_testing @EXCHANGE_12
  Scenario Outline: [UNHAPPY PATH] Valida campo del request enviando valores vacíos
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>
#4913370720093330
#    Examples: Sin enviar valor en campo totalMiles
#      | users                   | tarjeta          | codigo | mensaje                            |
#      | Calle Nuñez TotalMilles | 491337******3330 | 403    | El campo totalMiles es obligatorio |
#
#    Examples: Sin enviar valor en campo totalAmount
#      | users                   | tarjeta          | codigo | mensaje                             |
#      | Calle Nuñez totalAmount | 491337******3330 | 403    | El campo totalAmount es obligatorio |
#
#    Examples: Sin enviar valor en campo currencyId
#      | users                  | tarjeta          | codigo | mensaje                            |
#      | Calle Nuñez currencyId | 491337******3330 | 403    | El campo currencyId es obligatorio |

    Examples: Sin enviar valor en campo netMiles
      | users                | tarjeta          | codigo | mensaje                          |
      | Calle Nuñez netMiles | 491337******3330 | 403    | El campo netMiles es un número entero. |

#    Examples: Sin enviar valor en campo netAmount
#      | users                 | tarjeta          | codigo | mensaje                           |
#      | Calle Nuñez netAmount | 491337******3330 | 403    | El campo netAmount es obligatorio |

    Examples: Sin enviar valor en campo commerce.code
      | users            | tarjeta          | codigo | mensaje                               |
      | Calle Nuñez Code | 491337******3330 | 403    |El campo commerce.code es obligatorio. |

    Examples: Sin enviar valor en campo commerce.name
      | users            | tarjeta          | codigo | mensaje                               |
      | Calle Nuñez Name | 491337******3330 | 403    | El campo commerce.name es obligatorio.|

    Examples: Sin enviar valor typo en campo customer
      | users                | tarjeta          | codigo | mensaje                           |
      | Calle Nuñez Customer | 491337******3330 | 403    | El campo customer.documentType es obligatorio. |
    Examples: Sin enviar valor document en campo customer
      | users                 | tarjeta          | codigo | mensaje                           |
      | Calle Nuñez customer2 | 491337******3330 | 403    | El campo customer.documentNumber es obligatorio. |

#    Examples: Sin enviar valor en campo terminal
#      | users                | tarjeta          | codigo | mensaje                          |
#      | Calle Nuñez Terminal | 491337******3330 | 403    | Lo sentimos, algo salió mal, por favor inténtalo nuevamente. |

  @Automated @Happy_path @functional_testing @EXCHANGE_13
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas negativas
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: Valida canje con millas negativas
      | users          | tarjeta          | codigo | mensaje                                     |
      | Zonda Belito 1 | 549161******6163 | 403    | El campo netMiles es un número entero. |

  @Automated @Happy_path @functional_testing @EXCHANGE_14
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas enviando commerce.code mas de 20 caracteres
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: commerce.code mas de 20 caracteres
      | users          | tarjeta          | codigo | mensaje                                     |
      | Zonda Belito 1 | 549161******6163 | 403    | El campo commerce.code debe tener un tamaño máximo de 20 caracteres. |

  @Automated @Happy_path @functional_testing @EXCHANGE_15
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas enviando commerce.name mas de 128 caracteres
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: commerce.name mas de 128 caracteres
      | users          | tarjeta          | codigo | mensaje                                     |
      | Zonda Belito 1 | 549161******6163 | 403    | El campo commerce.name debe tener un tamaño máximo de 128 caracteres. |

  @Automated @Happy_path @functional_testing @EXCHANGE_16
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas enviando customer.documentType mas de 2 caracteres
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: customer.documentType mas de 2 caracteres
      | users          | tarjeta          | codigo | mensaje                                     |
      | Zonda Belito 1 | 549161******6163 | 403    | El campo customer.documentType solo admite valores 1 = DNI, 3 = Carnet extranjeria y 5 = Pasaporte. |

  @Automated @Happy_path @functional_testing @EXCHANGE_17
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas enviando customer.documentType de tipo string
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: customer.documentType de tipo string
      | users          | tarjeta          | codigo | mensaje                                     |
      | Zonda Belito 1 | 549161******6163 | 403    | El campo customer.documentType es numérico. |

  @Automated @Happy_path @functional_testing @EXCHANGE_18
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas enviando customer.documentType diferente a 1, 3 y 5
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: customer.documentType diferente a 1, 3 y 5
      | users          | tarjeta          | codigo | mensaje                                     |
      | Zonda Belito 1 | 549161******6163 | 403    | El campo customer.documentType solo admite valores 1 = DNI, 3 = Carnet extranjeria y 5 = Pasaporte. |

  @Automated @Happy_path @functional_testing @EXCHANGE_19
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas enviando customer.documentNumber de tipo string
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples:  customer.documentNumber de tipo string
      | users          | tarjeta          | codigo | mensaje                                     |
      | Zonda Belito 1 | 549161******6163 | 403    | El campo customer.documentNumber es numérico. |

  @Automated @Happy_path @functional_testing @EXCHANGE_20
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas enviando customer.documentNumber mas de 8 caracteres de tipo numérico
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples:  customer.documentNumber mas de 8 caracteres de tipo numérico
      | users          | tarjeta          | codigo | mensaje                                     |
      | Zonda Belito 1 | 549161******6163 | 403    | El campo customer.documentNumber debe tener un tamaño de 8 caracteres. |

  @Automated @Happy_path @functional_testing @EXCHANGE_21
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas enviando customer.documentNumber mas de 8 caracteres de tipo string
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples:  customer.documentNumber mas de 8 caracteres de tipo string
      | users          | tarjeta          | codigo | mensaje                                     |
      | Zonda Belito 1 | 549161******6163 | 403    | El campo customer.documentNumber es numérico. |

  @Automated @Happy_path @functional_testing @EXCHANGE_22
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas sin enviar customer.documentNumber
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples:  sin enviar customer.documentNumber
      | users          | tarjeta          | codigo | mensaje                                     |
      | Zonda Belito 1 | 549161******6163 | 403    | El campo customer.documentNumber es obligatorio.|

  @Automated @Happy_path @functional_testing @EXCHANGE_23
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas sin enviar customer.documentType y customer.documentNumber no correspondiente
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: customer.documentType y customer.documentNumber no correspondiente
      | users          | tarjeta          | codigo | mensaje                                     |
      | Zonda Belito 1 | 549161******6163 | 403    | ERROR EN DATOS DE ENTRADA A TC|

  @Automated @Happy_path @functional_testing @EXCHANGE_24
  Scenario Outline: [UNHAPPY PATH] Valida canjear con millas enviando terminal mas de 200 caracteres
    Given que el usuario accede a la aplicacion
    When realiza el proceso de canje de millas para el usuario <users> con su tarjeta <tarjeta>
    Then validamos el código de respuesta http es <codigo>
    And se valida el mensaje de error del canje <mensaje>

    Examples: enviando terminal mas de 200 caracteres
      | users          | tarjeta          | codigo | mensaje                                     |
      | Zonda Belito 1 | 549161******6163 | 403    | El campo terminal debe tener un tamaño máximo de 200 caracteres.|






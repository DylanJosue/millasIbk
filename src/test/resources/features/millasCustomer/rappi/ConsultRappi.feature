@allConsultMiles
Feature: Consulta saldo de millas con documento para - RAPPI

  @Automated @Happy_path @functional_testing @CONSULT_RAPPI
  Scenario Outline: [HAPPY PATH] Valida consulta de millas con cliente habilitado
    Given que el cliente accede a la aplicacion
    When ingresamos el codigo unico <customerId> para generar token con el cliente <cliente>
    Then validamos la generacion de token satisfactorio para el usuario con tipo de documento <documentType> y numero de documento <documentNumber>
    When se realiza la consulta de millas para el cliente <cliente>
    Then validamos el código de respuesta http es <codigo>
    And la consulta de millas de su tarjeta es satisfactoria <mensaje>
    And validamos que el response contenga sus datos y su codigo único <customerId>

    Examples: Valida consulta de millas con cliente habilitado - DNI
      | customerId | codigo | documentType | documentNumber | mensaje | cliente |
      | 0060102625 | 200    | 1            | 50501822       | OK      | RAPPI   |

    Examples: Valida consulta de millas con cliente habilitado - CE
      | customerId | codigo | documentType | documentNumber | mensaje | cliente |
      | 0060058604 | 200    | 3            | CE201701       | OK      | RAPPI   |

    Examples: Valida consulta de millas con cliente habilitado - PASAPORTE
      | customerId | codigo | documentType | documentNumber | mensaje | cliente |
      | 0060106724 | 200    | 5            | AD100004       | OK      | RAPPI   |


  @Automated @Happy_path @functional_testing @CONSULT_RAPPI
  Scenario Outline: [HAPPY PATH] Valida consulta con saldo 0 de millas
    Given que el cliente accede a la aplicacion
    When ingresamos el codigo unico <customerId> para generar token con el cliente <cliente>
    Then validamos la generacion de token satisfactorio para el usuario con tipo de documento <documentType> y numero de documento <documentNumber>
    When se realiza la consulta de millas para el cliente <cliente>
    Then validamos el código de respuesta http es <codigo>
    And la consulta de millas de su tarjeta es satisfactoria <mensaje>
    And validamos que el response contenga sus datos y su codigo único <customerId>

    Examples: Cliente con saldo 0 de millas - DNI
      | customerId | codigo | documentType | documentNumber | mensaje | cliente |
      | 0060102336 | 200    | 1            | 50501528       | OK      | RAPPI   |

  @Automated @Happy_path @functional_testing @CONSULT_RAPPI
  Scenario Outline: [HAPPY PATH] Valida consulta con saldo negativo de millas
    Given que el cliente accede a la aplicacion
    When ingresamos el codigo unico <customerId> para generar token con el cliente <cliente>
    Then validamos la generacion de token satisfactorio para el usuario con tipo de documento <documentType> y numero de documento <documentNumber>
    When se realiza la consulta de millas para el cliente <cliente>
    Then validamos el código de respuesta http es <codigo>
    And la consulta de millas de su tarjeta es satisfactoria <mensaje>
    And validamos que el response contenga sus datos y su codigo único <customerId>

    Examples: Cliente con saldo negativo de millas - DNI
      | customerId | codigo | documentType | documentNumber | mensaje | cliente |
      | 0060102547 | 200    | 1            | 50501744       | OK      | RAPPI   |

  @Automated @Happy_path @functional_testing @CONSULT_RAPPI
  Scenario Outline: [UNHAPPY PATH] Valida consulta millas con cliente cuenta bloqueada
    Given que el cliente accede a la aplicacion
    When ingresamos el codigo unico <customerId> para generar token con el cliente <cliente>
    Then validamos la generacion de token satisfactorio para el usuario con tipo de documento <documentType> y numero de documento <documentNumber>
    When se realiza la consulta de millas para el cliente <cliente>
    Then validamos el código de respuesta http es <codigo>
    And validamos el mensaje de error <mensaje> de la consulta
    Examples: Cliente con saldo negativo de millas - DNI
      | customerId | codigo | documentType | documentNumber | mensaje                                                         | cliente |
      | 0060538690 | 403    | 1            | 26669401       | NO PARTICIPA EN EL PROGRAMA DE BENEFICIOS Y/O NO ACUMULA MILLAS | RAPPI   |

  @Automated @Happy_path @functional_testing @CONSULT_RAPPI
  Scenario Outline: [UNHAPPY PATH] Valida consulta millas con cliente cuenta cancelada
    Given que el cliente accede a la aplicacion
    When ingresamos el codigo unico <customerId> para generar token con el cliente <cliente>
    Then validamos la generacion de token satisfactorio para el usuario con tipo de documento <documentType> y numero de documento <documentNumber>
    When se realiza la consulta de millas para el cliente <cliente>
    Then validamos el código de respuesta http es <codigo>
    And validamos el mensaje de error <mensaje> de la consulta
    Examples: Cliente cuenta cancelada - DNI
      | customerId | codigo | documentType | documentNumber | mensaje                                                         | cliente |
      | 0060104252 | 403    | 1            | 50503452       | NO PARTICIPA EN EL PROGRAMA DE BENEFICIOS Y/O NO ACUMULA MILLAS | RAPPI   |

  @Automated @Happy_path @functional_testing @CONSULT_RAPPI
  Scenario Outline: [UNHAPPY PATH] Valida consulta millas con cliente cuenta dada de baja
    Given que el cliente accede a la aplicacion
    When ingresamos el codigo unico <customerId> para generar token con el cliente <cliente>
    Then validamos el código de respuesta http es <codigo>
    And validamos el mensaje de error <mensaje> de la consulta

    Examples: Valida cliente con cuenta dada de baja - DNI
      | customerId | codigo | mensaje                                                                 | cliente |
      | 0060334563 | 403    | Los datos no están registrados. ¿No tienes una cuenta? Crea una cuenta. | RAPPI   |

  @Automated @Happy_path @functional_testing @CONSULT_RAPPI
  Scenario Outline: [UNHAPPY PATH] Valida consulta millas con cliente no registrado en Benefit
    Given que el cliente accede a la aplicacion
    When ingresamos el codigo unico <customerId> para generar token con el cliente <cliente>
    Then validamos el código de respuesta http es <codigo>
    And validamos el mensaje de error <mensaje> de la consulta

    Examples: Cliente no esta registrado en Benefit - TC INTERBANK PREMIA
      | customerId | codigo | mensaje                                                                 | cliente |
      | 0060135832 | 403    | Los datos no están registrados. ¿No tienes una cuenta? Crea una cuenta. | RAPPI   |

  @Automated @Happy_path @functional_testing @CONSULT_RAPPI
  Scenario Outline: [UNHAPPY PATH] Valida consulta millas campo numero de orden enviando valor null
    Given que el cliente accede a la aplicacion
    When ingresamos el codigo unico <customerId> para generar token con el cliente <cliente>
    Then validamos la generacion de token satisfactorio para el usuario con tipo de documento <documentType> y numero de documento <documentNumber>
    When se realiza la consulta de millas sin enviar ordernumber para el cliente <cliente>
    Then validamos el código de respuesta http es <codigo>
    And validamos el mensaje de error <mensaje> de la consulta

    Examples: Valida consulta millas campo numero de orden con valor null - CE
      | customerId | codigo | documentType | documentNumber | mensaje                                    | cliente |
      | 0060538904 | 403    | 3            | CE277062       | El campo orderNumber debe ser obligatorio. | RAPPI   |

  @Automated @Happy_path @functional_testing @CONSULT_RAPPI
  Scenario Outline: [UNHAPPY PATH] Valida consulta millas campo numero de orden con mayor valor longitud caracteres
    Given que el cliente accede a la aplicacion
    When ingresamos el codigo unico <customerId> para generar token con el cliente <cliente>
    Then validamos la generacion de token satisfactorio para el usuario con tipo de documento <documentType> y numero de documento <documentNumber>
    When se realiza la consulta de millas con enviar ordernumber para el cliente <cliente>
    Then validamos el código de respuesta http es <codigo>
    And validamos el mensaje de error <mensaje> de la consulta

    Examples: Valida consulta millas campo numero de orden con mayor valor longitud caracteres - CE
      | customerId | codigo | documentType | documentNumber | mensaje                                                            | cliente |
      | 0060538904 | 403    | 3            | CE277062       | El campo orderNumber debe tener un tamaño máximo de 50 caracteres. | RAPPI   |


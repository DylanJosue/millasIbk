@api-visa-extorno
Feature: Extorno de Canje de Millas

  Scenario Outline: [HAPPY PATH] Extorno de canje de millas por tarjeta

    Given el usuario accede a la aplicacion
    When el usuario ingresa su tarjeta <numero_tarjeta>, cantidad de millas <cantidad_millas>, tipo de documento <tipo_doc> y número <num_doc>
    Then el canje de millas es satisfactorio
    When el usuario extorna la operacion de su tarjeta <numero_tarjeta> con <codigo_comercio>, <nombre_comercio>, <external_trx_id>
    Then el extorno de canje de millas de su tarjeta <numero_tarjeta> es satisfactoria

    Examples: Visa Infiniti
      | numero_tarjeta   | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id |
      | 4772890057004816 | 1               | 1        | 89003394 | 77777777        | Comercio Prueba | 234443          |

    Examples: Tarjeta American Express® Tha Platinum Card
      | numero_tarjeta  | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id |
      | 377752998065610 | 1               | 1        | 89003394 | 77777777        | Comercio Prueba | 234443          |

    Examples: Tarjeta Interbank Visa Signature
      | numero_tarjeta   | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id |
      | 4110905057004755 | 1               | 1        | 89003394 | 77777777        | Comercio Prueba | 234443          |

    Examples: Tarjeta Interbank Visa Platinum
      | numero_tarjeta   | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id |
      | 4222240057003424 | 1               | 1        | 89003394 | 77777777        | Comercio Prueba | 234443          |

    Examples: Tarjeta Interbank Visa Clasica INTERNACIONAL
      | numero_tarjeta   | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id |
      | 4547751247006620 | 1               | 1        | 89003394 | 77777777        | Comercio Prueba | 234443          |

    Examples: Tarjeta Interbank Visa Oro
      | numero_tarjeta   | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id |
      | 4913379980064329 | 1               | 1        | 89003394 | 77777777        | Comercio Prueba | 234443          |

    Examples: Tarjeta Interbank MasterCard Platinum
      | numero_tarjeta   | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id |
      | 5491619980076485 | 1               | 1        | 89003394 | 77777777        | Comercio Prueba | 234443          |

    Examples: Tarjeta Interbank MasterCard Clasica
      | numero_tarjeta   | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id |
      | 5444029980076980 | 1               | 1        | 89003394 | 77777777        | Comercio Prueba | 234443          |

    Examples: Tarjeta Interbank MasterCard Oro
      | numero_tarjeta   | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id |
      | 5443599980070838 | 1               | 1        | 89003394 | 77777777        | Comercio Prueba | 234443          |

    Examples: Tarjeta Amex Blue
      | numero_tarjeta  | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id |
      | 377754498051934 | 1               | 1        | 89003394 | 77777777        | Comercio Prueba | 234443          |

    Examples: Tarjeta Amex Black
      | numero_tarjeta  | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id |
      | 377754998046830 | 1               | 1        | 89003394 | 77777777        | Comercio Prueba | 234443          |

    Examples: Tarjeta Amex Platinum
      | numero_tarjeta  | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id |
      | 377754798069925 | 1               | 1        | 89003394 | 77777777        | Comercio Prueba | 234443          |

    Examples: Tarjeta American Express®  - AMEX REVOL
      | numero_tarjeta  | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id |
      | 377753006156110 | 1               | 1        | 89003394 | 77777777        | Comercio Prueba | 234443          |

    Examples: Tarjeta American Express® Gold - AMEX REV.G
      | numero_tarjeta  | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id |
      | 377753998050818 | 1               | 1        | 89003394 | 77777777        | Comercio Prueba | 234443          |

    Examples: Tarjeta Interbank Visa Debito Joven
      | numero_tarjeta   | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id |
      | 4110740000017814 | 1               | 1        | 52471859 | 77777777        | Comercio Prueba | 234443          |


  Scenario Outline: Extorno de canje de millas de inválido

    Given el usuario accede a la aplicacion
    When el usuario ingresa su tarjeta <numero_tarjeta_otro>, cantidad de millas <cantidad_millas>, tipo de documento <tipo_doc> y número <num_doc>
    Then el canje de millas es satisfactorio
    When el usuario extorna la operacion de su tarjeta <numero_tarjeta> con <codigo_comercio>, <nombre_comercio>, <external_trx_id>
    Then el extorno de canje de millas es inválido
    And el mensaje de error es <mensaje_error>

    Examples: Extorno de canje de millas de otro cliente
      | numero_tarjeta_otro | numero_tarjeta   | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id | mensaje_error                   |
      | 4913379980064329    | 4772890057004816 | 1               | 1        | 89003394 | 77777777        | Comercio Prueba | 234443          | CODIGO DE AUTORIZACION INVALIDO |

    Examples: Tarjeta bloqueada
      | numero_tarjeta_otro | numero_tarjeta   | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id | mensaje_error     |
      | 4913379980064329    | 4547751247001555 | 1               | 1        | 89003394 | 77777777        | Comercio Prueba | 234443          | TARJETA NO ACTIVA |

    Examples: Tarjeta Premia
      | numero_tarjeta_otro | numero_tarjeta   | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id | mensaje_error                   |
      | 4913379980064329    | 4110939980029241 | 1               | 1        | 89003394 | 77777777        | Comercio Prueba | 234443          | CODIGO DE AUTORIZACION INVALIDO |

    Examples: Tarjeta Interbank Visa Cashback Signature
      | numero_tarjeta_otro | numero_tarjeta   | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id | mensaje_error                   |
      | 4913379980064329    | 4110919057000820 | 1               | 1        | 89003394 | 77777777        | Comercio Prueba | 234443          | CODIGO DE AUTORIZACION INVALIDO |

    Examples: Tarjeta Interbank Visa Cashback Platinum
      | numero_tarjeta_otro | numero_tarjeta   | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id | mensaje_error                   |
      | 4913379980064329    | 4732444557000889 | 1               | 1        | 89003394 | 77777777        | Comercio Prueba | 234443          | CODIGO DE AUTORIZACION INVALIDO |

    Examples: Tarjeta Interbank Visa Cashback Gold
      | numero_tarjeta_otro | numero_tarjeta   | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id | mensaje_error                   |
      | 4913379980064329    | 4732450457000838 | 1               | 1        | 89003394 | 77777777        | Comercio Prueba | 234443          | CODIGO DE AUTORIZACION INVALIDO |

    Examples: Tarjeta Débito Oro
      | numero_tarjeta_otro | numero_tarjeta   | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id | mensaje_error                   |
      | 4913379980064329    | 4547770000018580 | 1               | 1        | 52460060 | 77777777        | Comercio Prueba | 234443          | CODIGO DE AUTORIZACION INVALIDO |


  Scenario Outline: Extorno de canje de millas campos vacíos

    Given el usuario accede a la aplicacion
    When el usuario ingresa su tarjeta <numero_tarjeta>, cantidad de millas <cantidad_millas>, tipo de documento <tipo_doc> y número <num_doc>
    Then el canje de millas es satisfactorio
    When el usuario extorna la operacion de su tarjeta <numero_tarjeta> con <codigo_comercio>, <nombre_comercio>, <external_trx_id>
    Then el extorno de canje de millas es inválido
    And el mensaje de error es <mensaje_error>


    Examples: External Trx ID vacío
      | numero_tarjeta   | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id | mensaje_error                                        |
      | 4222240010041347 | 1               | 1        | 89003394 | 77777777        | Comercio Prueba |                 | El campo externalTransactionId debe ser obligatorio. |

    Examples: Código Comercio vacío
      | numero_tarjeta   | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id | mensaje_error                          |
      | 4222240010041347 | 1               | 1        | 89003394 |                 | Comercio Prueba | 234443          | El campo commerce.code es obligatorio. |

    Examples: Nombre Comercio vacío
      | numero_tarjeta   | cantidad_millas | tipo_doc | num_doc  | codigo_comercio | nombre_comercio | external_trx_id | mensaje_error                          |
      | 4222240010041347 | 1               | 1        | 89003394 | 43333           |                 | 234443          | El campo commerce.name es obligatorio. |


  Scenario: Extorno de canje de millas sin tarjeta

    Given el usuario accede a la aplicacion
    When el usuario ingresa su tarjeta 4222240010041347, cantidad de millas 1, tipo de documento 1 y número 89003394
    Then el canje de millas es satisfactorio
    When el usuario extorna la operacion de su tarjeta  con 43333, Comercio Prueba, 234443
    Then el extorno de canje de millas es inválido
    And el mensaje de error es El campo cardId es obligatorio.

  Scenario: Codigo de operacion negativo

    Given el usuario accede a la aplicacion
    When el codigo de operacion es negativo
    When el usuario extorna la operacion de su tarjeta 4222240010041347 con 43333, Comercio Prueba, 234443
    Then el extorno de canje de millas es inválido
    And el mensaje de error es El campo authorizationCode debe tener un tamaño de 6 caracteres.


  Scenario: Codigo de operacion inexistente

    Given el usuario accede a la aplicacion
    When el codigo de operacion es inexistente
    When el usuario extorna la operacion de su tarjeta 4222240010041347 con 43333, Comercio Prueba, 234443
    Then el extorno de canje de millas es inválido
    And el mensaje de error es El campo authorizationCode debe tener un tamaño de 6 caracteres.



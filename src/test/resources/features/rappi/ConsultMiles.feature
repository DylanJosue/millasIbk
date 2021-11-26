@allConsultMiles
Feature: Consulta saldo de millas

  @Automated @Happy_path @functional_testing @TEST_CONSULT1
  Scenario Outline: Valida consulta de millas con cliente habilitado
    Given que el cliente accede a la aplicacion
    When el ingresa codigo unico <customerId>
    Then se valida generar token rappi con satisfactorio
    And se ingresa numero de orden <orderNumber> del cliente
    Then el cliente obtiene su millas <obtainMiles> y verifica su saldo millas

    Examples: Valida consulta de millas con cliente habilitado - DNI
      | customerId | orderNumber | obtainMiles |
      | 0060102625 | 1020304050  | SI          |

    Examples: Valida consulta de millas con cliente habilitado - CE
      | customerId | orderNumber | obtainMiles |
      | 0060058604 | 1020304050  | SI          |

    Examples: Valida consulta de millas con cliente habilitado - PASAPORTE
      | customerId | orderNumber | obtainMiles |
      | 0060106724 | 1020304050  | SI          |

  @Automated @Happy_path @functional_testing #@TEST_CONSULT
  Scenario Outline: Valida consulta con saldo 0 de millas
    Given que el cliente accede a la aplicacion
    When el ingresa codigo unico <customerId>
    Then se valida generar token rappi con satisfactorio
    And se ingresa numero de orden <orderNumber> del cliente
    Then valida cliente con saldo cero de millas

    Examples: Cliente con saldo 0 de millas - DNI
      | customerId | orderNumber |
      | 0060102336 | 1020304050  |

  @Automated @Happy_path @functional_testing #@TEST_CONSULT
  Scenario Outline: Valida consulta con saldo negativo de millas
    Given que el cliente accede a la aplicacion
    When el ingresa codigo unico <customerId>
    Then se valida generar token rappi con satisfactorio
    And se ingresa numero de orden <orderNumber> del cliente
    Then valida cliente con saldo negativo de millas

    Examples: Cliente con saldo negativo de millas - DNI
      | customerId | orderNumber |
      | 0060102547 | 1020304050  |

  @Automated @Unhappy_path @functional_testing #@TEST_CONSULT
  Scenario Outline: Valida consulta millas con cliente cuenta bloqueada
    Given que el cliente accede a la aplicacion
    When el ingresa codigo unico <customerId>
    Then se valida generar token rappi con satisfactorio
    And se ingresa numero de orden <orderNumber> del cliente
    Then valida cliente con cuenta bloqueada

    Examples: Valida cliente con cuenta bloqueada
      | customerId | orderNumber |
      | 0060538690 | 1020304050  |

  @Automated @Unhappy_path @functional_testing #@TEST_CONSULT
  Scenario Outline: Valida consulta millas con cliente cuenta cancelada
    Given que el cliente accede a la aplicacion
    When el ingresa codigo unico <customerId>
    Then se valida generar token rappi con satisfactorio
    And se ingresa numero de orden <orderNumber> del cliente
    Then valida cliente con cuenta cancelada

    Examples: Valida cliente con cuenta cancelada
      | customerId | orderNumber |
      | 0060104252 | 1020304050  |

  @Automated @Unhappy_path @functional_testing #@TEST_CONSULT
  Scenario Outline: Valida consulta millas con cliente cuenta dada de baja
    Given que el cliente accede a la aplicacion
    When el ingresa codigo unico <customerId>
    Then valida cliente con cuenta dada de baja

    Examples: Valida cliente con cuenta dada de baja
      | customerId |
      | 0060334563 |

  @Automated @Unhappy_path @functional_testing #@TEST_CONSULT
  Scenario Outline: Valida consulta millas con cliente no registrado en Benefit
    Given que el cliente accede a la aplicacion
    When el ingresa codigo unico <customerId>
    Then valida cliente no esta registrado en benefit

    Examples: Cliente no esta registrado en Benefit - TC INTERBANK PREMIA
      | customerId |
      | 0060135832 |

  #Valida campo orderNumber
  @Automated @Alternative_path @functional_testing #@TEST_CONSULT
  Scenario Outline: Valida consulta millas campo numero de orden
    Given que el cliente accede a la aplicacion
    When el ingresa codigo unico <customerId>
    Then se valida generar token rappi con satisfactorio
    And se ingresa numero de orden <orderNumber> del cliente
    Then valida consulta millas campo numero de orden

    Examples: Valida consulta millas campo numero de orden con menor valor longitud caracteres - CE
      | customerId | orderNumber |
      | 0060538904 | 5           |

    Examples: Valida consulta millas campo numero de orden con valor alfanumérico - CE
      | customerId | orderNumber          |
      | 0060538904 | YW55IGNhcm5hbCBwbGVh |

  @Automated @Alternative_path @functional_testing #@TEST_CONSULT
  Scenario Outline: Valida consulta millas campo numero de orden enviando valor null
    Given que el cliente accede a la aplicacion
    When el ingresa codigo unico <customerId>
    Then se valida generar token rappi con satisfactorio
    And se ingresa numero de orden <orderNumber> del cliente
    Then valida consulta millas campo numero de orden enviando valor null

    Examples: Valida consulta millas campo numero de orden con valor null - CE
      | customerId | orderNumber |
      | 0060538904 |             |

  @Automated @Alternative_path @functional_testing #@TEST_CONSULT
  Scenario Outline: Valida consulta millas campo numero de orden con mayor valor longitud caracteres
    Given que el cliente accede a la aplicacion
    When el ingresa codigo unico <customerId>
    Then se valida generar token rappi con satisfactorio
    And se ingresa numero de orden <orderNumber> del cliente
    Then valida campo numero de orden con mayor valor longitud caracteres

    Examples: Valida consulta millas campo numero de orden con mayor valor longitud caracteres - CE
      | customerId | orderNumber                                                                      |
      | 0060538904 | 43534435344353443534435344353443534435344353443534435344353443534435344353443534 |


@ConsultTransactionBim
Feature: Consultar transacción

  @Happy_path
  Scenario Outline: Valida filtrar por numero de documento del cliente
    Given que el cliente accede a la aplicacion
    When se ingresa numero de documento <documentNumber> del cliente
    Then se valida total de transaccion

    Examples: DNI
      | documentNumber |
      | 50501568       |

    Examples: CE
      | documentNumber |
      | CE100004       |

    Examples: PASAPORTE
      | documentNumber |
      | AD100001       |

  @Happy_path
  Scenario Outline: Valida filtrar por codigo unico del cliente
    Given que el cliente accede a la aplicacion
    When se ingresa codigo unico <codUnico> del cliente
    Then se valida total de transaccion

    Examples: CU
      | codUnico   |
      | 0060102376 |

  @Happy_path
  Scenario Outline: Valida filtrar por nombre del cliente
    Given que el cliente accede a la aplicacion
    When se ingresa nombre <name> del cliente
    Then se valida total de transaccion

    Examples: Ingresa nombre del cliente
      | name            |
      | PERALTA RODOLFO |

  @Happy_path
  Scenario Outline: Valida filtrar por apellido del cliente
    Given que el cliente accede a la aplicacion
    When se ingresa apellido <lastName> del cliente
    Then se valida total de transaccion

    Examples: Ingresa apellido del cliente
      | lastName |
      | LEONCIO  |

  @Happy_path
  Scenario Outline: Valida filtrar por codigo del comercio para mundo vales y productos
    Given que el cliente accede a la aplicacion
    When se ingresa codigo del comercio <codCommerce>
    And ingresa numero de documento <documentNumber> del cliente
    Then se valida total de transaccion

    Examples: Filtrar por codigo comercio para mundo vales y productos
      | codCommerce | documentNumber |
      | 1           | 50501568       |

    Examples: Filtrar por codigo comercio para mundo viajes
      | codCommerce | documentNumber |
      | 2           | 50501539       |

  @Happy_path
  Scenario Outline: Valida filtrar por estado de transaccion
    Given que el cliente accede a la aplicacion
    When se ingresa estado de transaccion <orderStatus>
    Then se valida total de transaccion

    Examples: Filtrar estado de transaccion exitosa
      | orderStatus |
      | 00          |

    Examples: Filtrar estado de transaccion error tarjeta
      | orderStatus |
      | 01          |

    Examples: Filtrar estado de transaccion error millas
      | orderStatus |
      | 02          |

  @Happy_path
  Scenario Outline: Valida filtrar por rango de fechas
    Given que el cliente accede a la aplicacion
    When se ingresa fecha inicio <startDate> hasta <endDate>
    Then se valida total de transaccion

    Examples: Filtrar por rango de fecha de un año de transaccion
      | startDate  | endDate    |
      | 2020-01-01 | 2021-04-06 |

    Examples: Filtrar transaccion de tres meses
      | startDate  | endDate    |
      | 2020-01-01 | 2020-03-31 |

    Examples: Filtrar transaccion de sais meses
      | startDate  | endDate    |
      | 2020-01-01 | 2020-06-30 |

  @Happy_path
  Scenario Outline: Valida ordenar transaccion del cliente de forma ascendente y descendente
    Given que el cliente accede a la aplicacion
    When se ingresa numero de documento <documentNumber> e ordenar transaccion <ordenarTrx>
    Then se valida total de transaccion

    Examples: Ordenar transaccion de forma ascendente
      | documentNumber | ordenarTrx |
      | 50501539       | ASC        |

    Examples: Ordenar transaccion de forma descendente
      | documentNumber | ordenarTrx |
      | 50501539       | DESC       |

  @Unhappy_path
  Scenario Outline: Valida filtrar con cliente sin transaccion
    Given que el cliente accede a la aplicacion
    When se ingresa numero de documento <documentNumber> del cliente sin transaccion
    Then se valida total de transaccion

    Examples: Ingresa numero de documento
      | documentNumber |
      | 50501563       |

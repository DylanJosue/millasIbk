@allLogin
Feature: Customer Login

  @Automated @Happy_path @functional_testing
  Scenario Outline: Valida login cliente con satisfactorio
    Given que el cliente accede a la aplicacion
    When ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then se valida login accede con satisfactorio

    Examples: Ingresa con documento DNI
      | documentType | documentNumber | password  |
      | 1            | 50501729       | Auto2021@ |

    Examples: Ingresa con documento CE
      | documentType | documentNumber | password  |
      | 3            | CE201701       | Abc12345$ |

    Examples: Ingresa con documento PASAPORTE
      | documentType | documentNumber | password  |
      | 5            | AD100004       | Abc12345$ |

  @Automated @Unhappy_path @functional_testing
  Scenario Outline: Valida login cliente ingresando sin afiliar a SMS
    Given que el cliente accede a la aplicacion
    When ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then se valida login sin afiliar SMS

    Examples: CUSTOMER WITHOUT AFFILIATE TO SMS
      | documentType | documentNumber | password  |
      | 1            | 50502463       | Abc12345$ |

  @Automated @Unhappy_path @functional_testing
  Scenario Outline: Valida login ingresando número de documento sin registrar en Interbank Benefit
    Given que el cliente accede a la aplicacion
    When ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then se valida cliente sin registrar en Interbank Benefit

    Examples: CUSTOMER WITHOUT REGISTER IN INTERBANK BENEFIT
      | documentType | documentNumber | password  |
      | 1            | 10112233       | Auto2021@ |

  @Automated @Unhappy_path @functional_testing
  Scenario Outline: Valida cliente ingresando su clave incorrecta demasiadas veces y con estado (0=Bloqueado)
    Given que el cliente accede a la aplicacion
    When ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then se valida cliente ingresando su <claveInvalido> incorrecta demasiadas veces

    Examples: CUSTOMER ENTERING INCORRECT PASSWORD
      | documentType | documentNumber | password           | claveInvalido |
      | 1            | 50501742       | Auto2021@YW55I     | SI            |
      | 1            | 50501742       | Auto2021@GNhcm5    | SI            |
      | 1            | 50501742       | Auto2021@hbCBwbGVh |               |

  @Automated @Unhappy_path @functional_testing
  Scenario Outline: Valida cliente logueando con estado (1=Activo)
    Given que el cliente accede a la aplicacion
    When ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then se valida cliente logueando con estado activo

    Examples: CLIENT LOGGING WITH ACTIVE STATUS
      | documentType | documentNumber | password  |
      | 1            | 50501729       | Auto2021@ |

  @Automated @Unhappy_path @functional_testing
  Scenario Outline: Valida cliente logueando con estado (2=Suspendido)
    Given que el cliente accede a la aplicacion
    When ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then se valida cliente logueando con estado suspendido

    Examples: CLIENT LOGGING WITH SUSPENDED STATUS
      | documentType | documentNumber | password  |
      | 1            | 50501609       | Abc12345$ |

  #Valida campo documentType
  @Automated @Alternative_path @functional_testing
  Scenario Outline: Valida login ingresando tipo de documento inválido
    Given que el cliente accede a la aplicacion
    When ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then se valida ingresando tipo de documento invalido

    Examples: VALIDATE DOCUMENT TYPE INVALID - CE + DNI
      | documentType | documentNumber | password  |
      | 3            | 50501743       | Auto2021@ |

    Examples: VALIDATE DOCUMENT TYPE INVALID - PASS + DNI
      | documentType | documentNumber | password  |
      | 5            | 50501743       | Auto2021@ |

  @Automated @Alternative_path @functional_testing
  Scenario Outline: Valida login ingresando tipo de documento con valor alfanumérico
    Given que el cliente accede a la aplicacion
    When ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then se valida ingresando tipo de documento con valor alfanumerico

    Examples: VALIDATE DOCUMENT TYPE WITH VALUE ALPHANUMERIC
      | documentType | documentNumber | password  |
      | @hbCBw       | 50501743       | Auto2021@ |

  @Automated @Alternative_path @functional_testing
  Scenario Outline: Valida login ingresando tipo de documento con valor null
    Given que el cliente accede a la aplicacion
    When ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then se valida ingresando tipo de documento con valor null

    Examples: VALIDATE DOCUMENT TYPE WITH VALUE NULL
      | documentType | documentNumber | password  |
      |              | 50501743       | Auto2021@ |

  #Valida campo documentNumber
  @Automated @Alternative_path @functional_testing
  Scenario Outline: Valida login ingresando numero de documento inválido
    Given que el cliente accede a la aplicacion
    When ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then se valida ingresando numero de documento invalido

    Examples: VALIDATE DOCUMENT NUMBER INVALID - DNI + CE
      | documentType | documentNumber | password  |
      | 1            | CE201701       | Auto2021@ |

    Examples: VALIDATE DOCUMENT NUMBER INVALID - DNI + PASS
      | documentType | documentNumber | password  |
      | 1            | AD100004       | Auto2021@ |

  @Automated @Alternative_path @functional_testing
  Scenario Outline: Valida login ingresando numero de documento con menor y mayor valor longitud caracteres
    Given que el cliente accede a la aplicacion
    When ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then se valida ingresando numero de documento con menor y mayor valor longitud caracteres

    Examples: valida numero de documento con menor valor longitud caracteres
      | documentType | documentNumber | password  |
      | 1            | 5050           | Auto2021@ |

    Examples: valida numero de documento con mayor valor longitud caracteres
      | documentType | documentNumber   | password  |
      | 1            | 5050174350501743 | Auto2021@ |

  @Automated @Alternative_path @functional_testing
  Scenario Outline: Valida login ingresando numero de documento con valor null
    Given que el cliente accede a la aplicacion
    When ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then se valida ingresando numero de documento con valor null

    Examples: valida numero de documento con menor valor longitud caracteres
      | documentType | documentNumber | password  |
      | 1            |                | Auto2021@ |

  #Valida campo password
  @Automated @Alternative_path @functional_testing
  Scenario Outline: Valida login ingresando contraseña incorrecto
    Given que el cliente accede a la aplicacion
    When ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then se valida ingresando password incorrecto

    Examples: VALIDATE PASSWORD INCORRECT
      | documentType | documentNumber | password      |
      | 1            | 50501743       | Auto2021@1743 |

  @Automated @Alternative_path @functional_testing
  Scenario Outline: Valida login ingresando contraseña con valor null
    Given que el cliente accede a la aplicacion
    When ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then se valida ingresando password con valor null

    Examples: VALIDATE PASSWORD WITH VALUE NULL
      | documentType | documentNumber | password |
      | 1            | 50501743       |          |


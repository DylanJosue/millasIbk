@allLogin
Feature: Customer Login

  @Automated @Happy_path @functional_testing #@TEST_LOGIN
  Scenario Outline: [HAPPY PATH] Valida login cliente con satisfactorio
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then validamos el código de respuesta http es 200
    And se valida login exitoso con valores: codigo unico <customerId>, celular <cellPhone>, operador <operator> y el mensaje exitoso <message>

    Examples: Ingresa con documento DNI
      | cliente | documentType | documentNumber | password  | customerId | cellPhone | operator | message |
      | RAPPI   | 1            | 27679503       | Abc12345$ | 0060555674 | 929···100 | C        | OK      |

    Examples: Ingresa con documento CE
      | cliente | documentType | documentNumber | password  | customerId | cellPhone | operator | message |
      | RAPPI   | 3            | CE201701       | Abc12345$ | 0060058604 | 951···898 | M        | OK      |

    Examples: Ingresa con documento PASAPORTE
      | cliente | documentType | documentNumber | password  | customerId | cellPhone | operator | message |
      | RAPPI   | 5            | AD100004       | Abc12345$ | 0060106724 | 962···491 | M        | OK      |

  @Automated @Unhappy_path @functional_testing #@TEST_LOGIN
  Scenario Outline: [UNHAPPY PATH] Valida login cliente ingresando sin afiliar a SMS
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then validamos el código de respuesta http es 403
    And se valida mensaje de error <message> del login con codigo de identificacion <code>

    Examples: Cliente no afiliado a Banca SMS
      | cliente | documentType | documentNumber | password  | message                                           | code     |
      | RAPPI   | 1            | 50502463       | Abc12345$ | Aún no tienes un celular registrado en Interbank. | 02.01.21 |

  @Automated @Unhappy_path @functional_testing #@TEST_LOGIN
  Scenario Outline: [UNHAPPY PATH] Valida login ingresando número de documento sin registrar en Interbank Benefit
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then validamos el código de respuesta http es 403
    And se valida mensaje de error <message> del login con codigo de identificacion <code>

    Examples: Cliente no registrado en Benefit
      | cliente | documentType | documentNumber | password  | message                                                                       | code     |
      | RAPPI   | 1            | 10112233       | Abc12345$ | Aún no estás registrado en Interbank Benefit. Para ingresar, crea una cuenta. | 02.01.01 |

  @Automated @Unhappy_path @functional_testing #@TEST_LOGIN
  Scenario Outline: [UNHAPPY PATH] Valida cliente ingresando su clave incorrecta demasiadas veces y con estado (0=Bloqueado)
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then validamos el código de respuesta http es <statusCode>
    And se valida mensaje de error <message> del login con codigo de identificacion <code>

    Examples: Cliente ingresa datos incorrectos
      | cliente | documentType | documentNumber | password           | message                                                                                                                   | code     | statusCode |
      | RAPPI   | 1            | 50501742       | Auto2021@YW55I     | Lo sentimos los datos ingresados son inválidos, inténtalo nuevamente.                                                     | 02.01.03 | 401        |
      | RAPPI   | 1            | 50501742       | Auto2021@GNhcm5    | Lo sentimos los datos ingresados son inválidos, inténtalo nuevamente.                                                     | 02.01.03 | 401        |
      | RAPPI   | 1            | 50501742       | Auto2021@hbCBwbGVh | Ingresaste una contraseña incorrecta demasiadas veces. Por tu seguridad, hemos bloqueado tu acceso hasta las 00:00 horas. | 02.01.04 | 403        |

  @Automated @Unhappy_path @functional_testing #@TEST_LOGIN
  Scenario Outline: [HAPPY PATH] Valida cliente logueando con estado (1=Activo)
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then validamos el código de respuesta http es 200
    And se valida login exitoso con valores: codigo unico <customerId>, celular <cellPhone>, operador <operator> y el mensaje exitoso <message>

    Examples: Cliente loguea con estado activo
      | cliente | documentType | documentNumber | password  | customerId | cellPhone | operator | message |
      | RAPPI   | 1            | 27679503       | Abc12345$ | 0060555674 | 929···100 | C        | OK      |

  @Automated @Unhappy_path @functional_testing #@TEST_LOGIN
  Scenario Outline: [UNHAPPY PATH] Valida cliente logueando con estado (2=Suspendido)
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then validamos el código de respuesta http es 403
    And se valida mensaje de error <message> del login con codigo de identificacion <code>

    Examples: Cliente loguea con estado suspendido
      | cliente | documentType | documentNumber | password  | message                                                     | code     |
      | RAPPI   | 1            | 50501609       | Abc12345$ | Debes tener una tarjeta activa del programa para continuar. | 02.01.08 |

  #Valida campo documentType
  @Automated @Alternative_path @functional_testing #@TEST_LOGIN
  Scenario Outline: [ALTERNATIVE PATH] Valida login ingresando tipo de documento inválido
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then validamos el código de respuesta http es 403
    And se valida mensaje de error <message> del login con codigo de identificacion <code>

    Examples: Valida tipo documento invalido - CE + DNI
      | cliente | documentType | documentNumber | password  | message                                                                       | code     |
      | RAPPI   | 3            | 50501743       | Auto2021@ | Aún no estás registrado en Interbank Benefit. Para ingresar, crea una cuenta. | 02.01.01 |

    Examples: Valida tipo documento invalido - PASS + DNI
      | cliente | documentType | documentNumber | password  | message                                                                       | code     |
      | RAPPI   | 5            | 50501743       | Auto2021@ | Aún no estás registrado en Interbank Benefit. Para ingresar, crea una cuenta. | 02.01.01 |

  @Automated @Alternative_path @functional_testing #@TEST_LOGIN
  Scenario Outline: [ALTERNATIVE PATH] Valida login ingresando tipo de documento con valor alfanumérico
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then validamos el código de respuesta http es 500
    And se valida mensaje de error <message> del login con codigo de identificacion <code>

    Examples: Valida tipo de documento con valor alfanumérico
      | cliente | documentType | documentNumber | password  | message                                                      | code |
      | RAPPI   | @hbCBw       | 50501743       | Auto2021@ | Lo sentimos, algo salió mal, por favor inténtalo nuevamente. | 500  |

  @Automated @Alternative_path @functional_testing #@TEST_LOGIN
  Scenario Outline: [ALTERNATIVE PATH] Valida login ingresando tipo de documento con valor null
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then validamos el código de respuesta http es 404
    And se valida mensaje de error <message> del login

    Examples: Valida tipo de documento con valor Null
      | cliente | documentType | documentNumber | password  | message            |
      | RAPPI   |              | 50501743       | Auto2021@ | Resource not found |

  #Valida campo documentNumber
  @Automated @Alternative_path @functional_testing #@TEST_LOGIN
  Scenario Outline: [ALTERNATIVE PATH] Valida login ingresando numero de documento inválido
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then validamos el código de respuesta http es 403
    And se valida mensaje de error <message> del login con codigo de identificacion <code>

    Examples: Valida numero de documento invalido - DNI + CE
      | cliente | documentType | documentNumber | password  | message                                                                       | code     |
      | RAPPI   | 1            | CE201701       | Auto2021@ | Aún no estás registrado en Interbank Benefit. Para ingresar, crea una cuenta. | 02.01.01 |

    Examples: Valida numero de documento invalido - DNI + PASS
      | cliente | documentType | documentNumber | password  | message                                                                       | code     |
      | RAPPI   | 1            | AD100004       | Auto2021@ | Aún no estás registrado en Interbank Benefit. Para ingresar, crea una cuenta. | 02.01.01 |

  @Automated @Alternative_path @functional_testing #@TEST_LOGIN
  Scenario Outline: [ALTERNATIVE PATH] Valida login ingresando numero de documento con menor y mayor valor longitud caracteres
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then validamos el código de respuesta http es 403
    And se valida mensaje de error <message> del login con codigo de identificacion <code>

    Examples: valida numero de documento con menor valor longitud caracteres
      | cliente | documentType | documentNumber | password  | message                                                                       | code     |
      | RAPPI   | 1            | 5050           | Auto2021@ | Aún no estás registrado en Interbank Benefit. Para ingresar, crea una cuenta. | 02.01.01 |

    Examples: valida numero de documento con mayor valor longitud caracteres
      | cliente | documentType | documentNumber   | password  | message                                                                       | code     |
      | RAPPI   | 1            | 5050174350501743 | Auto2021@ | Aún no estás registrado en Interbank Benefit. Para ingresar, crea una cuenta. | 02.01.01 |

  @Automated @Alternative_path @functional_testing #@TEST_LOGIN
  Scenario Outline: [ALTERNATIVE PATH] Valida login ingresando numero de documento con valor null
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then validamos el código de respuesta http es 404
    And se valida mensaje de error <message> del login

    Examples: valida numero de documento con menor valor longitud caracteres
      | cliente | documentType | documentNumber | password  | message            |
      | RAPPI   | 1            |                | Auto2021@ | Resource not found |

  #Valida campo password
  @Automated @Alternative_path @functional_testing #@TEST_LOGIN
  Scenario Outline: [ALTERNATIVE PATH] Valida login ingresando contraseña incorrecto
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then validamos el código de respuesta http es 401
    And se valida mensaje de error <message> del login con codigo de identificacion <code>

    Examples: Valida ingresando contraseña incorrecta
      | cliente | documentType | documentNumber | password      | message                                                               | code     |
      | RAPPI   | 1            | 50501743       | Auto2021@1743 | Lo sentimos los datos ingresados son inválidos, inténtalo nuevamente. | 02.01.03 |

  @Automated @Alternative_path @functional_testing #@TEST_LOGIN
  Scenario Outline: [ALTERNATIVE PATH] Valida login ingresando contraseña con valor null
    Given que el cliente accede a la aplicacion
    When ingresamos al servicio de generar token para cliente <cliente>
    And ingresa tipo de documento <documentType> numero de documento <documentNumber> y contrasena <password>
    Then validamos el código de respuesta http es 401
    And se valida mensaje de error <message> del login con codigo de identificacion <code>

    Examples: Valida ingresando contraseña valor Null
      | cliente | documentType | documentNumber | password | message                                                               | code     |
      | RAPPI   | 1            | 50501743       |          | Lo sentimos los datos ingresados son inválidos, inténtalo nuevamente. | 02.01.03 |


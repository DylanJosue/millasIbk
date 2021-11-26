@allGenerarToken
Feature: Generar token

  @Automated @Happy_path @functional_testing
  Scenario Outline: Valida generar token
    Given que el cliente accede a la aplicacion
    When se ingresa codigo unico <customerId>
    Then se valida generar token con satisfactorio

    Examples: Ingresa codigo unico del cliente - DNI
      | customerId |
      | 0060102322 |

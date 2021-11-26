@allGenerarToken
Feature: Generar token

  @Automated @Happy_path
  Scenario Outline: Valida generar token
    Given que el cliente accede a la aplicacion
    When el ingresa tipo de documento <documentType> y numero de documento <documentNumber> contrasena <password>
    Then se valida generar token con satisfactorio

    Examples: Ingresa con documento DNI
      | documentType | documentNumber | password  |
      | 1            | 50501742       | Auto2021@ |


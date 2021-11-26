package extorno;

import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.rest.SerenityRest;
import net.thucydides.core.annotations.Steps;

public class ExtornoCanjeStepDefinitions {

    @Steps
    ExtornoCanje extorno;

    @When("^el usuario extorna la operacion de su tarjeta (.*) con (.*), (.*), (.*)$")
    public void extornar_canje(String numeroTarjeta, String codigoComercio, String nombreComercio, String externalTrxId) {

        String operationId = Serenity.sessionVariableCalled("operationId");
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        extorno.extornoCanje(accessToken, numeroTarjeta, operationId, codigoComercio, nombreComercio, externalTrxId);

        try {
            Serenity.setSessionVariable("millasAnulacion").to(SerenityRest.lastResponse().path("miles").toString());
        } catch (Exception e) {
            System.out.println("Error en ejecución de anulación de canje");
        }


    }

    @Then("^el extorno de canje de millas de su tarjeta (.*) es satisfactoria$")
    public void validar_extorno(String numeroTarjeta) {
        String millasAnulacion = Serenity.sessionVariableCalled("millasAnulacion");
        //consultaSteps.consultar_millas(numeroTarjeta);
        String consultaMillas = SerenityRest.lastResponse().path("miles").toString();
        extorno.validarExtorno(millasAnulacion, consultaMillas);
    }

    @Then("^el extorno de canje de millas es inválido$")
    public void extorno_invalido() {
        extorno.extornoInvalido();
    }

}

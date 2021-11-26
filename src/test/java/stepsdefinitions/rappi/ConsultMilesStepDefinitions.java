package stepsdefinitions.rappi;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import net.serenitybdd.rest.SerenityRest;
import org.junit.Assert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import tasks.rappi.ConsultMiles;
import tasks.rappi.GenerarToken;
import exceptions.ApiError;
import utils.ApiCommons;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.rest.questions.ResponseConsequence.seeThatResponse;
import static org.hamcrest.core.IsNot.not;
import static org.hamcrest.text.IsEmptyString.isEmptyString;

public class ConsultMilesStepDefinitions {

    private static final Logger LOGGER = LoggerFactory.getLogger(ConsultMilesStepDefinitions.class);

    @When("^el ingresa codigo unico (.*)$")
    public void insertCustomerId(String customerId) {
        theActorInTheSpotlight().attemptsTo(GenerarToken.generateToken(customerId));
    }

    @Then("se valida generar token rappi con satisfactorio")
    public void validaGenerarTokenRappiSatisfactorio() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
        String accessToken = SerenityRest.lastResponse().path("access_token").toString();
        String documentType = SerenityRest.lastResponse().path("documentType").toString();
        String documentNumber = SerenityRest.lastResponse().path("documentNumber").toString();
        String customerId = SerenityRest.lastResponse().path("customerId").toString();
        String status = SerenityRest.lastResponse().path("status").toString();
        Assert.assertThat(accessToken, not(isEmptyString()));
        Assert.assertThat(documentType, not(isEmptyString()));
        Assert.assertThat(documentNumber, not(isEmptyString()));
        Assert.assertThat(customerId, not(isEmptyString()));
        Assert.assertThat(status, not(isEmptyString()));
    }

    @And("^se ingresa numero de orden (.*) del cliente$")
    public void ingresaOrderNumber(String orderNumber) {
        theActorInTheSpotlight().attemptsTo(
                ConsultMiles.consultMiles(orderNumber)
        );
    }

    @Then("^el cliente obtiene su millas (.*) y verifica su saldo millas$")
    public void validaVerificaSaldoMillas(String obtainMiles) {

        if (obtainMiles.equals("SI")) {
            theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
            String firstDescription = SerenityRest.lastResponse().path("response.mile.firstDescription").toString();
            String description = SerenityRest.lastResponse().path("response.mile.description").toString();
            String miles = SerenityRest.lastResponse().path("response.mile.miles").toString();
            String documentType = SerenityRest.lastResponse().path("response.customer.documentType").toString();
            String documentNumber = SerenityRest.lastResponse().path("response.customer.documentNumber").toString();
            String customerId = SerenityRest.lastResponse().path("response.customer.customerId").toString();
            String operationDate = SerenityRest.lastResponse().path("response.operationDate").toString();

            Assert.assertThat(firstDescription, not(isEmptyString()));
            Assert.assertThat(description, not(isEmptyString()));
            Assert.assertThat(miles, not(isEmptyString()));
            Assert.assertThat(documentType, not(isEmptyString()));
            Assert.assertThat(documentNumber, not(isEmptyString()));
            Assert.assertThat(customerId, not(isEmptyString()));
            Assert.assertThat(operationDate, not(isEmptyString()));
        } else {
            LOGGER.info("NOT FOUND MILES");
        }
    }

    @Then("valida cliente con saldo cero de millas")
    public void validaClienteConSaldoCeroMillas() {
        theActorInTheSpotlight().should(seeThat(
                actor -> SerenityRest.lastResponse().getStatusCode() == ApiCommons.STATUS_CODE_OK,
                actor -> SerenityRest.lastResponse().getBody().asString().contains("0"))
        );
    }

    @Then("valida cliente con saldo negativo de millas")
    public void validaClienteConSaldoNegativoMillas() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
        String miles = SerenityRest.lastResponse().path("response.mile.miles").toString();
        Assert.assertThat(miles, not(isEmptyString()));
    }

    @Then("valida cliente con cuenta bloqueada")
    public void validaClienteCuentaBloqueada() {
        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
                .message("NO PARTICIPA EN EL PROGRAMA DE BENEFICIOS Y/O NO ACUMULA MILLAS")
                .codes("04.01.08")));
    }

    @Then("valida cliente con cuenta cancelada")
    public void validaClienteCuentaCancelada() {
        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
                .message("NO PARTICIPA EN EL PROGRAMA DE BENEFICIOS Y/O NO ACUMULA MILLAS")
                .codes("04.01.08")));
    }

    @Then("valida cliente con cuenta dada de baja")
    public void validaCuentaDadaBaja() {
        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
                .message("Los datos no están registrados. ¿No tienes una cuenta? Crea una cuenta.")
                .codes("01.01.10")));
    }

    @Then("valida cliente no esta registrado en benefit")
    public void validaClienteNoRegistradoBenefit() {
        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
                .message("Los datos no están registrados. ¿No tienes una cuenta? Crea una cuenta.")
                .codes("01.01.10")));
    }

    @Then("valida consulta millas campo numero de orden")
    public void validaCampoNumeroOrden() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
        String firstDescription = SerenityRest.lastResponse().path("response.mile.firstDescription").toString();
        String description = SerenityRest.lastResponse().path("response.mile.description").toString();
        String miles = SerenityRest.lastResponse().path("response.mile.miles").toString();
        String documentType = SerenityRest.lastResponse().path("response.customer.documentType").toString();
        String documentNumber = SerenityRest.lastResponse().path("response.customer.documentNumber").toString();
        String customerId = SerenityRest.lastResponse().path("response.customer.customerId").toString();
        String operationDate = SerenityRest.lastResponse().path("response.operationDate").toString();

        Assert.assertThat(firstDescription, not(isEmptyString()));
        Assert.assertThat(description, not(isEmptyString()));
        Assert.assertThat(miles, not(isEmptyString()));
        Assert.assertThat(documentType, not(isEmptyString()));
        Assert.assertThat(documentNumber, not(isEmptyString()));
        Assert.assertThat(customerId, not(isEmptyString()));
        Assert.assertThat(operationDate, not(isEmptyString()));
    }

    @Then("valida consulta millas campo numero de orden enviando valor null")
    public void validaOrderNumberEnviandoValorNull() {
        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
                .message("El campo orderNumber debe ser obligatorio.")
                .codes("04.01.11")));
    }

    @Then("valida campo numero de orden con mayor valor longitud caracteres")
    public void validaOrderNumberMayorValorLongitudCaracteres() {
        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
                .message("El campo orderNumber debe tener un tamaño máximo de 50 caracteres.")
                .codes("04.01.11")));
    }

}

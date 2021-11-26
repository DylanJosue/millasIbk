package stepsdefinitions.rappi;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import net.serenitybdd.rest.SerenityRest;
import org.junit.Assert;
import tasks.rappi.AnnulmentInvalid;
import tasks.rappi.AnnulmentMiles;
import tasks.rappi.ExchangeMiles;
import tasks.rappi.GenerarToken;
import utils.ApiCommons;
import exceptions.ApiError;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.rest.questions.ResponseConsequence.seeThatResponse;
import static org.hamcrest.core.IsNot.not;
import static org.hamcrest.text.IsEmptyString.isEmptyString;

/**
 * @author Nilo Carrion
 */
public class AnnulmentMilesStepDefinitions {

    @When("^se ingresa su codigo unico (.*) del cliente$")
    public void ingresaCustomerId(String customerId) {
        theActorInTheSpotlight().attemptsTo(GenerarToken.generateToken(customerId));
    }

    @And("^el ingresa (.*), (.*), (.*), (.*), (.*) items (.*), (.*), (.*), (.*), (.*) numero de orden de la trx (.*)$")
    public void insertQuantityMiles(String totalMiles, String totalAmount, String currencyIdOne, String quantityMiles, String netAmount, String identifier, String description, String quantity, String amount, String currencyIdTwo, String orderNumber) {
        theActorInTheSpotlight().attemptsTo(ExchangeMiles.exchangeMiles(totalMiles, totalAmount, currencyIdOne, quantityMiles, netAmount, identifier, description, quantity, amount, currencyIdTwo, orderNumber));
    }

    @And("^el cliente anula la operacion del canje de millas con numero de orden es (.*)$")
    public void anularCanjeMillas(String orderNumber) {
        theActorInTheSpotlight().attemptsTo(AnnulmentMiles.annulmentMiles(orderNumber));
    }

    @Then("se valida anulacion canje es satisfactorio")
    public void validaAnulacionSatisfactorio() {

        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
        String miles = SerenityRest.lastResponse().path("response.mile.miles").toString();
        String authorizationCode = SerenityRest.lastResponse().path("response.authorizationCode").toString();
        String operationDate = SerenityRest.lastResponse().path("response.operationDate").toString();
        String documentType = SerenityRest.lastResponse().path("response.customer.documentType").toString();
        String documentNumber = SerenityRest.lastResponse().path("response.customer.documentNumber").toString();
        String customerId = SerenityRest.lastResponse().path("response.customer.customerId").toString();
        Assert.assertThat(miles, not(isEmptyString()));
        Assert.assertThat(authorizationCode, not(isEmptyString()));
        Assert.assertThat(operationDate, not(isEmptyString()));
        Assert.assertThat(documentType, not(isEmptyString()));
        Assert.assertThat(documentNumber, not(isEmptyString()));
        Assert.assertThat(customerId, not(isEmptyString()));
    }

    @And("^el cliente anula la operacion del canje con (.*), (.*) y fecha de operacion (.*)$")
    public void validaAuthorizationCodeInvalid(String authorizationCode, String orderNumber, String operationDate) {
        theActorInTheSpotlight().attemptsTo(AnnulmentInvalid.annulmentInvalid(authorizationCode, orderNumber, operationDate));
    }

    @Then("se valida anulacion canje con authorizationCode invalido")
    public void validaAnulacionCanjeAuthorizationCodeInvalido() {
        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
                .message("AUTHORIZATION_CODE DE CANJE INVÁLIDO")
                .codes("04.01.11")));
    }

    @Then("se valida campo authorizationCode enviando con valor null")
    public void validaCampoAuthorizationCodeEnviandoValorNull() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_NOT_FOUND)));
        String message = SerenityRest.lastResponse().path("message").toString();
        Assert.assertEquals(message, "Resource not found");
    }

    @Then("se valida anulacion campo order number no existe operacion para anulacion")
    public void validaOrderNumberNoExisteOperacionParaAnulacion() {
        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
                .message("NO EXISTE OPERACION PARA ANULACION")
                .codes("04.01.23")));
    }

    @Then("se valida anulacion campo order number enviando con valor alfanumerico")
    public void validaOrderNumberEnviandoValorAlfanumerico() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_INTERNAL_SERVER_ERROR)));
        String message = SerenityRest.lastResponse().path("message").toString();
        Assert.assertEquals(message, "Lo sentimos, algo salió mal, por favor inténtalo nuevamente.");
    }

    @Then("se valida anulacion campo order number enviando con valor null")
    public void validaOrderNumberEnviandoValorNull() {
        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
                .message("El campo orderNumber debe ser obligatorio.")
                .codes("04.01.22")));
    }

    @Then("se valida anulacion campo numero de orden trx enviando valor con mayor longitud caracteres")
    public void validaOrderNumberTrxEnviandoMayorLongitudCaracteres() {
        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
                .message("El campo orderNumber debe tener un tamaño máximo de 50 caracteres.")
                .codes("04.01.22")));
    }

    @Then("se valida campo fecha de operacion del canje")
    public void validaCampoFechaOperacionCanje() {
        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
                .message("FECHA DE CANJE INVÁLIDO")
                .codes("04.01.20")));
    }

}

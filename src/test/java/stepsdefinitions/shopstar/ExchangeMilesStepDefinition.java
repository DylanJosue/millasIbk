package stepsdefinitions.shopstar;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.rest.SerenityRest;
import org.hamcrest.Matchers;
import org.hamcrest.core.IsNot;
import org.junit.Assert;
import questions.niubiz.CanjeMillasQuestions;
import tasks.shopstar.ExchangeMiles;
import tasks.shopstar.GenerarToken;
import exceptions.ApiError;
import utils.ApiCommons;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.rest.questions.ResponseConsequence.seeThatResponse;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.core.IsEqual.equalTo;
import static org.hamcrest.core.IsNot.not;
import static org.hamcrest.text.IsEmptyString.isEmptyOrNullString;
import static org.hamcrest.text.IsEmptyString.isEmptyString;

/**
 * @author Cesar Ilachoque
 */
public class ExchangeMilesStepDefinition {

    @When("^el usuario ingresa su código unico (.*) para obtener el token$")
    public void insertCustomerId(String customerId) {
        theActorInTheSpotlight().attemptsTo(
                GenerarToken.generateToken(customerId)
        );
    }

    @When("^realiza el canje de millas ingresando (.*), (.*), (.*), (.*), (.*) items (.*), (.*), (.*), (.*)y (.*)$")
    public void insertDataExchangeMiles(String totalMiles, String totalAmount, String currencyIdOne, String quantityMiles, String netAmount, String identifier, String description, String quantity, String amount, String currencyIdTwo) {
        theActorInTheSpotlight().attemptsTo(
                ExchangeMiles.exchangeMiles(totalMiles, totalAmount, currencyIdOne, quantityMiles, netAmount, identifier, description, quantity, amount, currencyIdTwo));
    }
    @And("^validamos el canje de millas es satisfactorio con el mensaje (.*)$")
    public void validateMessage(String message) {

        theActorInTheSpotlight().should(
                seeThat("El mensaje es ", CanjeMillasQuestions.messageResponse(), containsString(message)),
                seeThat("Millas", CanjeMillasQuestions.responseMillas(), IsNot.not(isEmptyOrNullString())),
                seeThat("Neto de millas", CanjeMillasQuestions.responseNetMillas(), IsNot.not(isEmptyOrNullString())),
                seeThat("Mensaje de autorización", CanjeMillasQuestions.responseAutorizations(), Matchers.not(Matchers.isEmptyString()))
               );

        Serenity.setSessionVariable("authorizationCode").to(theActorInTheSpotlight().asksFor(CanjeMillasQuestions.responseAutorizations()));
        Serenity.setSessionVariable("operationDate").to(theActorInTheSpotlight().asksFor(CanjeMillasQuestions.responseOperations()));
    }
    @And("^validamos el response con datos del cliente: tipo documento (.*), número documento (.*) y el código único (.*)$")
    public void validateMessage(String documentType,String documentNumber,String customerId) {
        theActorInTheSpotlight().should(
                seeThat("Mensaje de typo de documento", CanjeMillasQuestions.responseType(), equalTo(documentType)),
                seeThat("Mensaje de número de documento", CanjeMillasQuestions.responseNumber(), equalTo(documentNumber)),
                seeThat("Mensaje de date de operación", CanjeMillasQuestions.responseCustomer(), equalTo(customerId))
        );
    }

//    @Then("valida canje cliente con saldo negativo de millas")
//    public void validaClienteSaldoNegativoMillas() {
//        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
//                .message("La operación ha sido rechazada.")
//                .codes("04.02.02.16")));
//    }
//
//    @Then("valida canje cliente con cuenta bloqueada")
//    public void validaCanjeCuentaBloqueada() {
//        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
//                .message("NO PARTICIPA EN EL PROGRAMA DE BENEFICIOS Y/O NO ACUMULA MILLAS")
//                .codes("04.01.08")));
//    }
//
//    @Then("valida canje cliente con cuenta cancelada")
//    public void validaCanjeCuentaCancelada() {
//        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
//                .message("NO PARTICIPA EN EL PROGRAMA DE BENEFICIOS Y/O NO ACUMULA MILLAS")
//                .codes("04.01.08")));
//    }
//
//    @Then("valida campo netMiles ingresando cero millas")
//    public void validaCampoNetMilesCeroMillas() {
//        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
//        String netMilesExchanged = SerenityRest.lastResponse().path("response.mile.netMiles").toString();
//        String miles = SerenityRest.lastResponse().path("response.mile.miles").toString();
//        String authorizationCode = SerenityRest.lastResponse().path("response.authorizationCode").toString();
//        String operationDate = SerenityRest.lastResponse().path("response.operationDate").toString();
//        String documentType = SerenityRest.lastResponse().path("response.customer.documentType").toString();
//        String documentNumber = SerenityRest.lastResponse().path("response.customer.documentNumber").toString();
//        String customerId = SerenityRest.lastResponse().path("response.customer.customerId").toString();
//        Assert.assertThat(netMilesExchanged, not(isEmptyString()));
//        Assert.assertThat(miles, not(isEmptyString()));
//        Assert.assertThat(authorizationCode, not(isEmptyString()));
//        Assert.assertThat(operationDate, not(isEmptyString()));
//        Assert.assertThat(documentType, not(isEmptyString()));
//        Assert.assertThat(documentNumber, not(isEmptyString()));
//        Assert.assertThat(customerId, not(isEmptyString()));
//    }
//
//    @Then("valida campo netMiles ingresando milla negativo")
//    public void validaCampoNetMilesMillaNegativo() {
//        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
//                .message("No se pueden redimir puntos en negativo.")
//                .codes("04.02.02.06")));
//    }
//
//    @Then("valida campo netMiles ingresando valor caracteres y alfanumerico")
//    public void validaCampoNetMilesValorCaracteresAlfanumerico() {
//        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_INTERNAL_SERVER_ERROR)));
//        String message = SerenityRest.lastResponse().path("message").toString();
//        Assert.assertEquals(message, "Lo sentimos, algo salió mal, por favor inténtalo nuevamente.");
//    }
//
//    @Then("valida campo netMiles enviando con valor null")
//    public void validaCampoNetMilesEnviandoValorNull() {
//        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
//                .message("Debes ingresar un valor de millas a canjear.")
//                .codes("04.01.11")));
//    }
//
//    @Then("se valida campo identificador unico del producto")
//    public void validaCampoIdentificadorUnicoProducto() {
//        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
//        String netMilesExchanged = SerenityRest.lastResponse().path("response.mile.netMiles").toString();
//        String miles = SerenityRest.lastResponse().path("response.mile.miles").toString();
//        String authorizationCode = SerenityRest.lastResponse().path("response.authorizationCode").toString();
//        String operationDate = SerenityRest.lastResponse().path("response.operationDate").toString();
//        String documentType = SerenityRest.lastResponse().path("response.customer.documentType").toString();
//        String documentNumber = SerenityRest.lastResponse().path("response.customer.documentNumber").toString();
//        String customerId = SerenityRest.lastResponse().path("response.customer.customerId").toString();
//        Assert.assertThat(netMilesExchanged, not(isEmptyString()));
//        Assert.assertThat(miles, not(isEmptyString()));
//        Assert.assertThat(authorizationCode, not(isEmptyString()));
//        Assert.assertThat(operationDate, not(isEmptyString()));
//        Assert.assertThat(documentType, not(isEmptyString()));
//        Assert.assertThat(documentNumber, not(isEmptyString()));
//        Assert.assertThat(customerId, not(isEmptyString()));
//    }
//
//    @Then("se valida campo identificador enviando valor con mayor longitud caracteres")
//    public void validaCampoIdentificadorConMayorLongitudCaracteres() {
//        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_FORBIDDEN)));
//        String message = SerenityRest.lastResponse().path("message").toString();
//        Assert.assertEquals(message, "Lo sentimos, algo salió mal, por favor inténtalo nuevamente.");
//    }
//
//    @Then("se valida campo descripcion del producto canjeado")
//    public void validaCampoDescripcionProducto() {
//        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
//        String netMilesExchanged = SerenityRest.lastResponse().path("response.mile.netMiles").toString();
//        String miles = SerenityRest.lastResponse().path("response.mile.miles").toString();
//        String authorizationCode = SerenityRest.lastResponse().path("response.authorizationCode").toString();
//        String operationDate = SerenityRest.lastResponse().path("response.operationDate").toString();
//        String documentType = SerenityRest.lastResponse().path("response.customer.documentType").toString();
//        String documentNumber = SerenityRest.lastResponse().path("response.customer.documentNumber").toString();
//        String customerId = SerenityRest.lastResponse().path("response.customer.customerId").toString();
//        Assert.assertThat(netMilesExchanged, not(isEmptyString()));
//        Assert.assertThat(miles, not(isEmptyString()));
//        Assert.assertThat(authorizationCode, not(isEmptyString()));
//        Assert.assertThat(operationDate, not(isEmptyString()));
//        Assert.assertThat(documentType, not(isEmptyString()));
//        Assert.assertThat(documentNumber, not(isEmptyString()));
//        Assert.assertThat(customerId, not(isEmptyString()));
//    }
//
//    @Then("se valida campo descripcion enviando valor con mayor longitud caracteres")
//    public void validaCampoDescripcionConMayorLongitudCaracteres() {
//        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_FORBIDDEN)));
//        String message = SerenityRest.lastResponse().path("message").toString();
//        Assert.assertEquals(message, "Lo sentimos, algo salió mal, por favor inténtalo nuevamente.");
//    }
//
//    @Then("se valida campo cantidad canjeada del producto")
//    public void validaCampoCantidadCanjeadaProducto() {
//        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
//        String netMilesExchanged = SerenityRest.lastResponse().path("response.mile.netMiles").toString();
//        String miles = SerenityRest.lastResponse().path("response.mile.miles").toString();
//        String authorizationCode = SerenityRest.lastResponse().path("response.authorizationCode").toString();
//        String operationDate = SerenityRest.lastResponse().path("response.operationDate").toString();
//        String documentType = SerenityRest.lastResponse().path("response.customer.documentType").toString();
//        String documentNumber = SerenityRest.lastResponse().path("response.customer.documentNumber").toString();
//        String customerId = SerenityRest.lastResponse().path("response.customer.customerId").toString();
//        Assert.assertThat(netMilesExchanged, not(isEmptyString()));
//        Assert.assertThat(miles, not(isEmptyString()));
//        Assert.assertThat(authorizationCode, not(isEmptyString()));
//        Assert.assertThat(operationDate, not(isEmptyString()));
//        Assert.assertThat(documentType, not(isEmptyString()));
//        Assert.assertThat(documentNumber, not(isEmptyString()));
//        Assert.assertThat(customerId, not(isEmptyString()));
//    }
//
//    @Then("valida campo cantidad enviando valor con mayor longitud caracteres")
//    public void validaCampoCantidadConMayorLongitudCaracteres() {
//        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_INTERNAL_SERVER_ERROR)));
//        String message = SerenityRest.lastResponse().path("message").toString();
//        Assert.assertEquals(message, "Lo sentimos, algo salió mal, por favor inténtalo nuevamente.");
//    }
//
//    @Then("se valida campo costo del producto")
//    public void validaCampoCostoDelProducto() {
//        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
//        String netMilesExchanged = SerenityRest.lastResponse().path("response.mile.netMiles").toString();
//        String miles = SerenityRest.lastResponse().path("response.mile.miles").toString();
//        String authorizationCode = SerenityRest.lastResponse().path("response.authorizationCode").toString();
//        String operationDate = SerenityRest.lastResponse().path("response.operationDate").toString();
//        String documentType = SerenityRest.lastResponse().path("response.customer.documentType").toString();
//        String documentNumber = SerenityRest.lastResponse().path("response.customer.documentNumber").toString();
//        String customerId = SerenityRest.lastResponse().path("response.customer.customerId").toString();
//        Assert.assertThat(netMilesExchanged, not(isEmptyString()));
//        Assert.assertThat(miles, not(isEmptyString()));
//        Assert.assertThat(authorizationCode, not(isEmptyString()));
//        Assert.assertThat(operationDate, not(isEmptyString()));
//        Assert.assertThat(documentType, not(isEmptyString()));
//        Assert.assertThat(documentNumber, not(isEmptyString()));
//        Assert.assertThat(customerId, not(isEmptyString()));
//    }
//
//    @Then("valida campo costo enviando mayor valor longitud caracteres y alfanumerico")
//    public void validaCampoCostoMayorLongitudCaracteresAlfanumerico() {
//        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_INTERNAL_SERVER_ERROR)));
//        String message = SerenityRest.lastResponse().path("message").toString();
//        Assert.assertEquals(message, "Lo sentimos, algo salió mal, por favor inténtalo nuevamente.");
//    }
//
//    @Then("se valida campo numero de orden")
//    public void validaCampoNumeroOrden() {
//        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
//        String netMilesExchanged = SerenityRest.lastResponse().path("response.mile.netMiles").toString();
//        String miles = SerenityRest.lastResponse().path("response.mile.miles").toString();
//        String authorizationCode = SerenityRest.lastResponse().path("response.authorizationCode").toString();
//        String operationDate = SerenityRest.lastResponse().path("response.operationDate").toString();
//        String documentType = SerenityRest.lastResponse().path("response.customer.documentType").toString();
//        String documentNumber = SerenityRest.lastResponse().path("response.customer.documentNumber").toString();
//        String customerId = SerenityRest.lastResponse().path("response.customer.customerId").toString();
//        Assert.assertThat(netMilesExchanged, not(isEmptyString()));
//        Assert.assertThat(miles, not(isEmptyString()));
//        Assert.assertThat(authorizationCode, not(isEmptyString()));
//        Assert.assertThat(operationDate, not(isEmptyString()));
//        Assert.assertThat(documentType, not(isEmptyString()));
//        Assert.assertThat(documentNumber, not(isEmptyString()));
//        Assert.assertThat(customerId, not(isEmptyString()));
//    }
//
//    @Then("se valida campo numero de orden enviando valor null debe ser obligatorio")
//    public void validaCampoOrderNumberSerObligatorio() {
//        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
//                .message("El campo orderNumber debe ser obligatorio.")
//                .codes("04.01.11")));
//    }
//
//    @Then("valida campo numero de orden debe tener un tamano maximo")
//    public void validaOrderNumberDebeTenerUnTamanoMaximo() {
//        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
//                .message("El campo orderNumber debe tener un tamaño máximo de 50 caracteres.")
//                .codes("04.01.11")));
//    }
//
//    @Then("^valida campo numero de orden enviando valor (.*)$")
//    public void validaOrderNumberEnviandoValueDuplicado(String condicion) {
//        if (condicion.equals("NO")) {
//            theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
//            String netMilesExchanged = SerenityRest.lastResponse().path("response.mile.netMiles").toString();
//            String miles = SerenityRest.lastResponse().path("response.mile.miles").toString();
//            String authorizationCode = SerenityRest.lastResponse().path("response.authorizationCode").toString();
//            String operationDate = SerenityRest.lastResponse().path("response.operationDate").toString();
//            String documentType = SerenityRest.lastResponse().path("response.customer.documentType").toString();
//            String documentNumber = SerenityRest.lastResponse().path("response.customer.documentNumber").toString();
//            String customerId = SerenityRest.lastResponse().path("response.customer.customerId").toString();
//            Assert.assertThat(netMilesExchanged, not(isEmptyString()));
//            Assert.assertThat(miles, not(isEmptyString()));
//            Assert.assertThat(authorizationCode, not(isEmptyString()));
//            Assert.assertThat(operationDate, not(isEmptyString()));
//            Assert.assertThat(documentType, not(isEmptyString()));
//            Assert.assertThat(documentNumber, not(isEmptyString()));
//            Assert.assertThat(customerId, not(isEmptyString()));
//
//        } else {
//            theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
//                    .message("EXISTE UNA OPERACION CON EL CAMPO ORDER_NUMBER")
//                    .codes("04.03.22")));
//        }
//    }

}

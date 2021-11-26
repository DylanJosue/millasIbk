package stepsdefinitions.shopstar;

import exceptions.ApiError;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import net.serenitybdd.rest.SerenityRest;
import org.junit.Assert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import questions.ResponseCode;
import questions.shopstar.ConsultaMillasQuestions;
import tasks.shopstar.ConsultMiles;
import tasks.rappi.GenerarToken;
import utils.ApiCommons;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.rest.questions.ResponseConsequence.seeThatResponse;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.core.IsEqual.equalTo;
import static org.hamcrest.core.IsNot.not;
import static org.hamcrest.text.IsEmptyString.isEmptyOrNullString;
import static org.hamcrest.text.IsEmptyString.isEmptyString;

public class ConsultMilesStepDefinitions {

    private static final Logger LOGGER = LoggerFactory.getLogger(ConsultMilesStepDefinitions.class);

    @When("^se ingresa código unico (.*) para generar el token$")
    public void insertCustomerId(String customerId) {
        theActorInTheSpotlight().attemptsTo(GenerarToken.generateToken(customerId));
    }

    @Then("se valida la generacíon de token shoptar con satisfactorio con valores: tipo documento (.*), número de documento (.*), código único (.*) y el status (.*)")
    public void validaGenerarTokenShopstarSatisfactorio(String documentType,String documentNumber,String customerId, String status) {
        theActorInTheSpotlight().should(seeThatResponse(
                response -> response.statusCode(ApiCommons.STATUS_CODE_OK))
        );
        theActorInTheSpotlight().should(
                seeThat("el código de token access", ConsultaMillasQuestions.responseAccesToken(),not(isEmptyString())),
                seeThat("el document Type", ConsultaMillasQuestions.responseDocumentType(),equalTo(documentType)),
                seeThat("el document number", ConsultaMillasQuestions.responseDocumentNumber(),equalTo(documentNumber)),
                seeThat("el customer id", ConsultaMillasQuestions.responseCustomerId(),equalTo(customerId)),
                seeThat("el status código ", ConsultaMillasQuestions.responseStatus(),equalTo(status))
        );
    }

    @And("^ingresa numero de orden (.*) del cliente$")
    public void ingresaOrderNumber(String orderNumber) {
        theActorInTheSpotlight().attemptsTo(
                ConsultMiles.consultMiles(orderNumber)
        );
    }

    @Then("^validamos que el response contenga los siguientes datos: tipo documento (.*), número de documento (.*), código único (.*) y el mensaje (.*)$")
    public void validaVerificaSaldoMillas(String documentType,String documentNumber,String customerId,String message) {

        theActorInTheSpotlight().should(
                seeThat("El mensaje es ", questions.niubiz.ConsultaMillasQuestions.messageResponse(), equalTo(message)),
                seeThat("Mensaje de las millas", questions.niubiz.ConsultaMillasQuestions.responseMillas(), not(isEmptyString())),
                seeThat("Mensaje de autorización", questions.niubiz.ConsultaMillasQuestions.responseDesciptions(), equalTo("USTED DISPONE DE")),
                seeThat("Mensaje de tipo de documento", questions.niubiz.ConsultaMillasQuestions.responseDescription2(), containsString("MILLAS BENEFIT")),
                seeThat("Mensaje de date de operación", questions.niubiz.ConsultaMillasQuestions.responseOperations(), not(isEmptyString())),
                seeThat("Mensaje de tipo documento", questions.niubiz.ConsultaMillasQuestions.responseType(), equalTo(documentType)),
                seeThat("Mensaje de número de documento", questions.niubiz.ConsultaMillasQuestions.responseNumber(), equalTo(documentNumber)),
                seeThat("Mensaje de número de documento", questions.niubiz.ConsultaMillasQuestions.responseCustomer(), equalTo(customerId))
        );
    }
    @Then("verificamos el código de respuesta (.*)")
    public void validateStatusCode(String status) {
        theActorInTheSpotlight().should(
                seeThat("Status code: ",new ResponseCode(), equalTo(Integer.parseInt(status)))
        );
    }
//    @Then("valida cliente con saldo cero de millas")
//    public void validaClienteConSaldoCeroMillas() {
//        theActorInTheSpotlight().should(seeThat(
//                actor -> SerenityRest.lastResponse().getStatusCode() == ApiCommons.STATUS_CODE_OK,
//                actor -> SerenityRest.lastResponse().getBody().asString().contains("0"))
//        );
//    }
//
//    @Then("valida cliente con saldo negativo de millas")
//    public void validaClienteConSaldoNegativoMillas() {
//        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
//        String miles = SerenityRest.lastResponse().path("response.mile.miles").toString();
//        Assert.assertThat(miles, not(isEmptyString()));
//    }
//
//    @Then("valida cliente con cuenta bloqueada")
//    public void validaClienteCuentaBloqueada() {
//        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
//                .message("NO PARTICIPA EN EL PROGRAMA DE BENEFICIOS Y/O NO ACUMULA MILLAS")
//                .codes("04.01.08")));
//    }
//
//    @Then("valida cliente con cuenta cancelada")
//    public void validaClienteCuentaCancelada() {
//        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
//                .message("NO PARTICIPA EN EL PROGRAMA DE BENEFICIOS Y/O NO ACUMULA MILLAS")
//                .codes("04.01.08")));
//    }
//
//    @Then("valida cliente con cuenta dada de baja")
//    public void validaCuentaDadaBaja() {
//        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
//                .message("Los datos no están registrados. ¿No tienes una cuenta? Crea una cuenta.")
//                .codes("01.01.10")));
//    }
//
//    @Then("valida cliente no esta registrado en benefit")
//    public void validaClienteNoRegistradoBenefit() {
//        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
//                .message("Los datos no están registrados. ¿No tienes una cuenta? Crea una cuenta.")
//                .codes("01.01.10")));
//    }
//
//    @Then("valida consulta millas campo numero de orden")
//    public void validaCampoNumeroOrden() {
//        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
//        String firstDescription = SerenityRest.lastResponse().path("response.mile.firstDescription").toString();
//        String description = SerenityRest.lastResponse().path("response.mile.description").toString();
//        String miles = SerenityRest.lastResponse().path("response.mile.miles").toString();
//        String documentType = SerenityRest.lastResponse().path("response.customer.documentType").toString();
//        String documentNumber = SerenityRest.lastResponse().path("response.customer.documentNumber").toString();
//        String customerId = SerenityRest.lastResponse().path("response.customer.customerId").toString();
//        String operationDate = SerenityRest.lastResponse().path("response.operationDate").toString();
//
//        Assert.assertThat(firstDescription, not(isEmptyString()));
//        Assert.assertThat(description, not(isEmptyString()));
//        Assert.assertThat(miles, not(isEmptyString()));
//        Assert.assertThat(documentType, not(isEmptyString()));
//        Assert.assertThat(documentNumber, not(isEmptyString()));
//        Assert.assertThat(customerId, not(isEmptyString()));
//        Assert.assertThat(operationDate, not(isEmptyString()));
//    }
//
//    @Then("valida consulta millas campo numero de orden enviando valor null")
//    public void validaOrderNumberEnviandoValorNull() {
//        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
//                .message("El campo orderNumber debe ser obligatorio.")
//                .codes("04.01.11")));
//    }
//
//    @Then("valida campo numero de orden con mayor valor longitud caracteres")
//    public void validaOrderNumberMayorValorLongitudCaracteres() {
//        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
//                .message("El campo orderNumber debe tener un tamaño máximo de 50 caracteres.")
//                .codes("04.01.11")));
//    }

}

package stepsdefinitions.rappi;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.rest.SerenityRest;
import org.hamcrest.core.IsNot;
import org.junit.Assert;
import exceptions.ApiError;
import questions.millasOtp.ValidateOtpQuestions;
import utils.ApiCommons;
import tasks.rappi.ValidateOTP;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.rest.questions.ResponseConsequence.seeThatResponse;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.core.IsEqual.equalTo;
import static org.hamcrest.text.IsEmptyString.isEmptyOrNullString;

/**
 * @author Nilo Carrion
 */
public class ValidateOTPStepDefinitions {

    @And("^ingresa tipo de documento (.*) numero de documento (.*) y codigo activacion (.*)$")
    public void ingresaDatosCliente(String documentType, String documentNumber, String activationCode) {
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String cliente = Serenity.sessionVariableCalled("cliente");
        theActorInTheSpotlight().attemptsTo(
                ValidateOTP.validateCodeOTP(accessToken, cliente, documentType, documentNumber, activationCode)
        );
    }

    @And("se valida codigo otp satisfactorio para cliente (.*) con mensaje (.*)")
    public void validaCodigoOtpConSatisfactorio(String customerId, String message) {

        theActorInTheSpotlight().should(
                seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK))
        );
        String DocumentType = Serenity.sessionVariableCalled("type");
        String DocumentNumber = Serenity.sessionVariableCalled("number");
        theActorInTheSpotlight().should(
                seeThat("Tipo de documento", ValidateOtpQuestions.responseDocumentType(), equalTo(DocumentType)),
                seeThat("Número de documento", ValidateOtpQuestions.responseDocumentNumber(), equalTo(DocumentNumber)),
                seeThat("Código de documento", ValidateOtpQuestions.responseCodigoUnico(), equalTo(customerId)),
                seeThat("Key de cliente", ValidateOtpQuestions.responseCustomerKey(), IsNot.not(isEmptyOrNullString())),
                seeThat("Mensaje ", ValidateOtpQuestions.responseMessage(), containsString(message))
        );
    }

    @Then("se valida codigo otp ingresando con distintos tipos de documentos")
    public void validaCodigoOtpIngresandoDistintosTiposDocumentos() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_FORBIDDEN)));
        String message = SerenityRest.lastResponse().path("message").toString();
        Assert.assertEquals(message, "El access_token no pertenece al cliente");
    }

    @Then("se valida codigo otp con mayor valor longitud caracteres")
    public void validaCodigoOtpConMayorValorLongitudCaracteres() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_INTERNAL_SERVER_ERROR)));
        String message = SerenityRest.lastResponse().path("message").toString();
        Assert.assertEquals(message, "Lo sentimos, algo salió mal, por favor inténtalo nuevamente.");
    }

    @Then("se valida codigo otp campos del parametro")
    public void validaCamposDelParametro() {
        theActorInTheSpotlight().should(seeThat(ApiError.inSyncCall(ApiCommons.STATUS_CODE_FORBIDDEN)
                .message("Aún no estás registrado en Interbank Benefit. Para ingresar, crea una cuenta.")
                .codes("02.01.01")));
    }

    @Then("se valida codigo otp enviando con valor null")
    public void validaCodigoOtpEnviandoValorNull() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_NOT_FOUND)));
        String message = SerenityRest.lastResponse().path("message").toString();
        Assert.assertEquals(message, "Resource not found");
    }

}

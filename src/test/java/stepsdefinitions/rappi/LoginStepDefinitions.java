package stepsdefinitions.rappi;

import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import questions.millasOtp.LoginOtpQuestions;
import tasks.rappi.Login;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.core.IsEqual.equalTo;

public class LoginStepDefinitions {

    @And("^ingresa tipo de documento (.*) numero de documento (.*) y contrasena (.*)$")
    public void loginSatisfactorio(String documentType, String documentNumber, String password) {

        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String cliente = Serenity.sessionVariableCalled("cliente");

        theActorInTheSpotlight().attemptsTo(
                Login.customerLogin(accessToken, cliente, documentType, documentNumber, password)
        );

        Serenity.setSessionVariable("type").to(documentType);
        Serenity.setSessionVariable("number").to(documentNumber);

    }

    @And("^se valida login exitoso con valores: codigo unico (.*), celular (.*), operador (.*) y el mensaje exitoso (.*)$")
    public void validaLoginSatisfactorio(String customerId, String cellPhone, String operator, String message) {

        String DocumentType = Serenity.sessionVariableCalled("type");
        String DocumentNumber = Serenity.sessionVariableCalled("number");

        theActorInTheSpotlight().should(
                seeThat("tipo documento", LoginOtpQuestions.responseDocumentType(), equalTo(DocumentType)),
                seeThat("Numero de documento", LoginOtpQuestions.responseDocumentNumber(), equalTo(DocumentNumber)),
                seeThat("Código único", LoginOtpQuestions.responseCustomerId(), equalTo(customerId)),
                seeThat("Operador", LoginOtpQuestions.responseOperator(), equalTo(operator)),
                seeThat("Numero de celular", LoginOtpQuestions.responseNumberPhone(), containsString(cellPhone)),
                seeThat("Estado activo", LoginOtpQuestions.responseEstatusActive(), equalTo("1")),

                seeThat("Mensaje", LoginOtpQuestions.responseMessage(), containsString(message))
        );
    }

    @And("^se valida mensaje de error (.*) del login con codigo de identificacion (.*)$")
    public void validaLoginMensajesError(String mensaje, String codigo) {
        theActorInTheSpotlight().should(
                seeThat("Mensaje de Error", LoginOtpQuestions.responseMessage(), containsString(mensaje)),
                seeThat("Código de Indentificación", LoginOtpQuestions.responseCode(), equalTo(codigo))
        );
    }

    @And("^se valida mensaje de error (.*) del login$")
    public void validaMensajeErrorLogin(String mensaje) {
        theActorInTheSpotlight().should(
                seeThat("Mensaje de Error", LoginOtpQuestions.responseMessage(), containsString(mensaje))
        );
    }

}

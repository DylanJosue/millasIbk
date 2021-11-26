package stepsdefinitions.rappi;

import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import questions.millasOtp.GenerateOtpQuestions;
import tasks.rappi.GenerateOTP;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.core.IsNot.not;
import static org.hamcrest.text.IsEmptyString.isEmptyString;
import static org.hamcrest.core.IsEqual.equalTo;

/**
 * @author Nilo Carrion
 */
public class GenerateOTPStepDefinitions {

    @And("^genera codigo otp ingresando tipo de documento (.*) y (.*)$")
    public void validaGenerateOTP(String documentType, String documentNumber) {
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String cliente = Serenity.sessionVariableCalled("cliente");
        theActorInTheSpotlight().attemptsTo(
                GenerateOTP.generateCodeOTP(accessToken, cliente, documentType, documentNumber)
        );
        Serenity.setSessionVariable("type").to(documentType);
        Serenity.setSessionVariable("number").to(documentNumber);
    }

    @And("^se valida generar otp con satisfactorio: operador (.*), celular (.*), nombre de operador (.*), codigo unico (.*) y el mensaje exitoso (.*)$")
    public void validaGenerarOtpConSatisfactorio(String operator, String cellPhone, String operatorName, String customerId, String mensaje) {
        theActorInTheSpotlight().should(
                seeThat("Código cliente llave", GenerateOtpQuestions.responseCustomerKey(), not(isEmptyString())),
                seeThat("Operador", GenerateOtpQuestions.responseOperator(), equalTo(operator)),
                seeThat("Numero de celular", GenerateOtpQuestions.responseNumberPhone(), containsString(cellPhone)),
                seeThat("Nombre de Operador", GenerateOtpQuestions.responseNameOperator(), equalTo(operatorName)),
                seeThat("Mensaje", GenerateOtpQuestions.responseMessage(), equalTo(mensaje)),
                seeThat("Estado activo", GenerateOtpQuestions.responseEstatusActive(), equalTo("1")),
                seeThat("Codigo unico", GenerateOtpQuestions.responseCustomerId(), equalTo(customerId))
        );
    }

    @And("^se valida mensaje de error (.*) del generar otp con codigo de identificacion (.*)$")
    public void validaMensajeErrorGenerarOtp(String mensaje, String codigo) {
        theActorInTheSpotlight().should(
                seeThat("Mensaje de Error", GenerateOtpQuestions.responseMessage(), containsString(mensaje)),
                seeThat("Código de Indentificación", GenerateOtpQuestions.responseCode(), equalTo(codigo))
        );
    }

    @And("^se valida mensaje de error (.*) del generar otp$")
    public void validaMensajeErrorGenerarOtp(String mensaje) {
        theActorInTheSpotlight().should(
                seeThat("Mensaje de Error", GenerateOtpQuestions.responseMessage(), containsString(mensaje))
        );
    }

}

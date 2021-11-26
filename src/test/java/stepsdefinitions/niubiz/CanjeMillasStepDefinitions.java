package stepsdefinitions.niubiz;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import net.serenitybdd.core.Serenity;
import org.hamcrest.Matchers;
import org.hamcrest.core.IsNot;
import questions.ResponseCode;
import questions.niubiz.CanjeMillasQuestions;
import tasks.niubiz.CanjeMillas;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.Matchers.not;
import static org.hamcrest.core.IsEqual.equalTo;
import static org.hamcrest.text.IsEmptyString.isEmptyOrNullString;
import static org.hamcrest.text.IsEmptyString.isEmptyString;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author Cesar Ilachoque
 */
public class CanjeMillasStepDefinitions {

    @When("^realiza el proceso de canje de millas para el usuario (.*) con su tarjeta (.*)$")
    public void changeMilles(String usuario, String tarjeta) {
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String cliente = Serenity.sessionVariableCalled("cliente");
        Date date = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("ddMMyyyyhhmmss");
        String messageIdDate = dateFormat.format(date);

        theActorInTheSpotlight().attemptsTo(
                CanjeMillas.withUsers(accessToken, cliente, usuario, tarjeta, messageIdDate)
        );
    }

    @When("^realiza el proceso de canje de millas con enviar orderNumber existente para el usuario (.*) con su tarjeta (.*)$")
    public void changeMillesConOrderNumber(String usuario, String tarjeta) {
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String cliente = Serenity.sessionVariableCalled("cliente");
        theActorInTheSpotlight().attemptsTo(
                CanjeMillas.withUsers(accessToken, cliente, usuario, tarjeta, "10000050213")
        );
    }

    @When("^realiza el proceso de canje de millas sin enviar orderNumber para el usuario (.*) con su tarjeta (.*)$")
    public void changeMillesSinOrderNumber(String usuario, String tarjeta) {
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String cliente = Serenity.sessionVariableCalled("cliente");
        theActorInTheSpotlight().attemptsTo(
                CanjeMillas.withUsers(accessToken, cliente, usuario, tarjeta, "")
        );
    }

    @When("^realiza el proceso de canje de millas con envio de orderNumber mas de 50 caracteres para el usuario (.*) con su tarjeta (.*)$")
    public void changeMillesConOrderNumber50Caracteres(String usuario, String tarjeta) {
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String cliente = Serenity.sessionVariableCalled("cliente");
        theActorInTheSpotlight().attemptsTo(
                CanjeMillas.withUsers(accessToken, cliente, usuario, tarjeta, "123456789012345678901234567890123456789012345678901")
        );
    }

    @Then("^validamos el código de respuesta http es (.*)$")
    public void statusCode(String code) {
        theActorInTheSpotlight().should(
                seeThat("El código de respuesta", new ResponseCode(), equalTo(Integer.parseInt(code)))
        );
    }

    @And("^se valida el canje de millas es satisfactorio con el mensaje (.*)$")
    public void validateMessage(String message) {
        String type = Serenity.sessionVariableCalled("type");
        String number = Serenity.sessionVariableCalled("number");

        theActorInTheSpotlight().should(
                seeThat("El mensaje es ", CanjeMillasQuestions.messageResponse(), containsString(message)),
                seeThat("Millas", CanjeMillasQuestions.responseMillas(), IsNot.not(isEmptyOrNullString())),
                seeThat("Neto de millas", CanjeMillasQuestions.responseNetMillas(), IsNot.not(isEmptyOrNullString())),
                seeThat("Mensaje de autorización", CanjeMillasQuestions.responseAutorizations(), not(Matchers.isEmptyString())),
                seeThat("Mensaje de número de documento", CanjeMillasQuestions.responseType(), equalTo(type)),
                seeThat("Mensaje de número de documento", CanjeMillasQuestions.responseNumber(), equalTo(number)),
                seeThat("Mensaje de date de operación", CanjeMillasQuestions.responseOperations(), IsNot.not(isEmptyString()))
        );
        Serenity.setSessionVariable("authorizationCode").to(theActorInTheSpotlight().asksFor(CanjeMillasQuestions.responseAutorizations()));
    }

    @And("^se valida el mensaje de error del canje (.*)$")
    public void validateMessageError(String message) {
        theActorInTheSpotlight().should(
                seeThat("El mensaje es ", CanjeMillasQuestions.messageResponse(), containsString(message))
        );
    }

}

package stepsdefinitions.niubiz;

import io.cucumber.java.Before;
import io.cucumber.java.en.And;
import io.cucumber.java.en.When;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actors.OnStage;
import net.serenitybdd.screenplay.actors.OnlineCast;
import questions.niubiz.ConsultaMillasQuestions;
import tasks.niubiz.ConsultaMillas;

import java.text.SimpleDateFormat;
import java.util.Date;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.core.IsEqual.equalTo;
import static org.hamcrest.core.IsNot.not;
import static org.hamcrest.text.IsEmptyString.isEmptyString;

/**
 * @author Cesar Ilachoque
 */
public class ConsultaMillasStepDefinitions {

    @Before
    public void setTheStage() {
        OnStage.setTheStage(new OnlineCast());
    }

    @When("^el usuario con tipo de documento (.*) y numero de documento (.*) consulta su tarjeta (.*)$")
    public void consultarMillas(String tipodoc, String number, String cardNumber) {
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String cliente = Serenity.sessionVariableCalled("cliente");
        Date date = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("ddMMyyyyhhmmss");
        String messageIdDate = dateFormat.format(date);

        theActorInTheSpotlight().attemptsTo(
                ConsultaMillas.consult(accessToken, cliente, tipodoc, number, cardNumber, messageIdDate)
        );
        Serenity.setSessionVariable("type").to(tipodoc);
        Serenity.setSessionVariable("number").to(number);
    }

    @When("^el usuario consulta sin enviar valor en orderNumber, cliente con tipo de documento (.*) y numero de documento (.*) consulta su tarjeta (.*)$")
    public void consultarMillasSinOrderNumber(String tipodoc, String number, String cardNumber) {
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String cliente = Serenity.sessionVariableCalled("cliente");

        theActorInTheSpotlight().attemptsTo(
                ConsultaMillas.consult(accessToken, cliente, tipodoc, number, cardNumber, "")
        );
        Serenity.setSessionVariable("type").to(tipodoc);
        Serenity.setSessionVariable("number").to(number);
    }

    @When("^el usuario consulta con enviar orderNumber mas de 50 caracteres, con tipo de documento (.*) y numero de documento (.*) consulta su tarjeta (.*)$")
    public void consultarMillas50OrderNumber(String tipodoc, String number, String cardNumber) {
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String cliente = Serenity.sessionVariableCalled("cliente");

        theActorInTheSpotlight().attemptsTo(
                ConsultaMillas.consult(accessToken, cliente, tipodoc, number, cardNumber, "123456789012345678901234567890123456789012345678901")
        );
        Serenity.setSessionVariable("type").to(tipodoc);
        Serenity.setSessionVariable("number").to(number);
    }

    @And("la consulta de millas de su tarjeta es satisfactoria (.*)")
    public void anulacionCanjeMillasSatisfactorio(String mensaje) {
        theActorInTheSpotlight().should(
                seeThat("El mensaje es ", ConsultaMillasQuestions.messageResponse(), equalTo(mensaje)),
                seeThat("Mensaje de las millas", ConsultaMillasQuestions.responseMillas(), not(isEmptyString())),
                seeThat("Mensaje de autorización", ConsultaMillasQuestions.responseDesciptions(), equalTo("USTED DISPONE DE")),
                seeThat("Mensaje de tipo de documento", ConsultaMillasQuestions.responseDescription2(), containsString("MILLAS BENEFIT")),
                seeThat("Mensaje de date de operación", ConsultaMillasQuestions.responseOperations(), not(isEmptyString()))
        );
    }

    @And("validamos que el response contenga sus datos y su codigo único (.*)")
    public void validateContentResponse(String codUnico) {
        String type = Serenity.sessionVariableCalled("type");
        String number = Serenity.sessionVariableCalled("number");
        theActorInTheSpotlight().should(
                seeThat("Mensaje de tipo documento", ConsultaMillasQuestions.responseType(), equalTo(type)),
                seeThat("Mensaje de número de documento", ConsultaMillasQuestions.responseNumber(), equalTo(number)),
                seeThat("Mensaje de número de documento", ConsultaMillasQuestions.responseCustomer(), equalTo(codUnico))
        );
    }

    @And("^validamos el mensaje de error (.*) de la consulta$")
    public void validaMensajeError(String mensaje) {
        theActorInTheSpotlight().should(
                seeThat("El mensaje de error", ConsultaMillasQuestions.messageResponse(), containsString(mensaje))
        );
    }

}

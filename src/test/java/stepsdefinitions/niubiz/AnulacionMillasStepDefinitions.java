package stepsdefinitions.niubiz;

import io.cucumber.java.en.And;
import io.cucumber.java.en.When;
import net.serenitybdd.core.Serenity;
import questions.niubiz.AnulationsMillasQuestions;
import tasks.niubiz.AnnulmentInvalid;
import tasks.niubiz.AnulacionMillas;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.core.IsEqual.equalTo;
import static org.hamcrest.core.IsNot.not;
import static org.hamcrest.text.IsEmptyString.isEmptyString;

/**
 * @author Nilo Carrion
 */
public class AnulacionMillasStepDefinitions {

    @When("^el usuario anula la operacion de su tarjeta (.*) con (.*), (.*), (.*), (.*) y (.*)$")
    public void anularCanjeMillas(String cardNumber, String documentType, String documentNumber, String codComercio, String nameComercio, String terminal) {
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String cliente = Serenity.sessionVariableCalled("cliente");
        String authorizationCode = Serenity.sessionVariableCalled("authorizationCode");
        String orderNumber = Serenity.sessionVariableCalled("orderNumber");
        theActorInTheSpotlight().attemptsTo(
                AnulacionMillas.annulmentMiles(accessToken, cliente, cardNumber, authorizationCode, documentType, documentNumber, orderNumber, codComercio, nameComercio, terminal)
        );

    }

    @When("^se anula la operacion de su tarjeta (.*) con (.*), (.*), (.*), (.*) y (.*)$")
    public void anularCanjeMillasauthorizationCode(String cardNumber, String documentType, String documentNumber, String codComercio, String nameComercio, String terminal) {
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String cliente = Serenity.sessionVariableCalled("cliente");
        String authorizationCode = Serenity.sessionVariableCalled("authorizationCode");
        String orderNumber = Serenity.sessionVariableCalled("orderNumber");
        theActorInTheSpotlight().attemptsTo(
                AnulacionMillas.annulmentMiles(accessToken, cliente, cardNumber, authorizationCode + "1", documentType, documentNumber, orderNumber, codComercio, nameComercio, terminal)
        );
    }

    @When("^el usuario tiene que anular la operacion de su tarjeta (.*) con (.*), (.*), (.*), (.*) y (.*)$")
    public void anularCanjeMillasauthorizationCodeString(String cardNumber, String documentType, String documentNumber, String codComercio, String nameComercio, String terminal) {
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String cliente = Serenity.sessionVariableCalled("cliente");
        String authorizationCode = Serenity.sessionVariableCalled("authorizationCode");
        String orderNumber = Serenity.sessionVariableCalled("orderNumber");
        theActorInTheSpotlight().attemptsTo(
                AnulacionMillas.annulmentMiles(accessToken, cliente, cardNumber, "ABCDEF", documentType, documentNumber, orderNumber, codComercio, nameComercio, terminal)
        );
    }

    @And("la anulacion canje de millas de su tarjeta es satisfactoria (.*)")
    public void anulacionCanjeMillasSatisfactorio(String mensaje) {
        String type = Serenity.sessionVariableCalled("type");
        String number = Serenity.sessionVariableCalled("number");
        theActorInTheSpotlight().should(
                seeThat("El código de respuesta", AnulationsMillasQuestions.messageResponse(), equalTo(mensaje)),
                seeThat("Mensaje de las millas", AnulationsMillasQuestions.responseMillas(), not(isEmptyString())),
                seeThat("Mensaje de autorización", AnulationsMillasQuestions.responseAutorizations(), not(isEmptyString())),
                seeThat("Mensaje de tipo de documento", AnulationsMillasQuestions.responseType(), equalTo(type)),
                seeThat("Mensaje de número de documento", AnulationsMillasQuestions.responseNumber(), equalTo(number)),
                seeThat("Mensaje de date de operación", AnulationsMillasQuestions.responseOperations(), not(isEmptyString()))
        );

    }

    @When("^el usuario anula la operacion del canje millas (.*), (.*) con (.*), (.*), (.*), (.*)$")
    public void validaAnulacionCanjeCuentaDadaBaja(String operationId, String cardNumber, String commerceCode, String commerceName, String annulmentTerminal, String annulmentExternalTrxId) {
        theActorInTheSpotlight().attemptsTo(AnnulmentInvalid.invalid(operationId, cardNumber, commerceCode, commerceName, annulmentTerminal, annulmentExternalTrxId));
    }

    @When("^el usuario anula la operacion sin enviar el número orden para su (.*) con (.*), (.*), (.*), (.*) y (.*)$")
    public void anularCanjeMillasSinOrderNumber(String cardNumber, String documentType, String documentNumber, String codComercio, String nameComercio, String terminal) {
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String cliente = Serenity.sessionVariableCalled("cliente");
        String authorizationCode = Serenity.sessionVariableCalled("authorizationCode");
        String orderNumber = "";
        theActorInTheSpotlight().attemptsTo(
                AnulacionMillas.annulmentMiles(accessToken, cliente, cardNumber, authorizationCode, documentType, documentNumber, orderNumber, codComercio, nameComercio, terminal)
        );
    }

    @When("^el usuario anula la operacion con enviar número de orden para su tarjeta (.*) con (.*), (.*), (.*), (.*) y (.*)$")
    public void anularConenviarOrdenNumber(String cardNumber, String documentType, String documentNumber, String codComercio, String nameComercio, String terminal) {
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String cliente = Serenity.sessionVariableCalled("cliente");
        String authorizationCode = Serenity.sessionVariableCalled("authorizationCode");
        String orderNumber = "123456789012345678901234567890123456789012345678901";
        theActorInTheSpotlight().attemptsTo(
                AnulacionMillas.annulmentMiles(accessToken, cliente, cardNumber, authorizationCode, documentType, documentNumber, orderNumber, codComercio, nameComercio, terminal)
        );
    }

}

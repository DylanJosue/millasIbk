package stepsdefinitions.documento;

import io.cucumber.java.en.And;
import io.cucumber.java.en.When;
import net.serenitybdd.core.Serenity;
import questions.AuthToken;
import questions.niubiz.AnulationsMillasQuestions;
import tasks.GetOauthTokenV1;
import tasks.documents.AnnulmentMiles;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.core.IsEqual.equalTo;

/**
 * @author Nilo Carrion
 */
public class AnnulmentMilesStepDefinitions {

    @And("^el usuario realiza la operacion de anulación del canje de millas del cliente (.*)$")
    public void anularCanjeMillas(String cliente) {
        String authorizationCode = Serenity.sessionVariableCalled("authorizationCode");
        String orderNumber = Serenity.sessionVariableCalled("orderNumber");
        String operationDate = Serenity.sessionVariableCalled("operationDate");
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        theActorInTheSpotlight().attemptsTo(
                AnnulmentMiles.annulmentMiles(accessToken, cliente, authorizationCode, orderNumber, operationDate)
        );
    }

    @And("^validamos la anulacion satisfactorio del canje$")
    public void validateMessage() {
        String authorizationCode = Serenity.sessionVariableCalled("authorizationCode");
        String documentType = Serenity.sessionVariableCalled("type");
        String documentNumber = Serenity.sessionVariableCalled("number");
        String customerId = Serenity.sessionVariableCalled("customerId");

        theActorInTheSpotlight().should(
                seeThat("Mensaje de ordernumber", AnulationsMillasQuestions.responseAutorizations(), equalTo(authorizationCode)),
                seeThat("El mensaje es ", AnulationsMillasQuestions.messageResponse(), containsString("OK")),
                seeThat("Mensaje de typo de documento", AnulationsMillasQuestions.responseType(), equalTo(documentType)),
                seeThat("Mensaje de número de documento", AnulationsMillasQuestions.responseNumber(), equalTo(documentNumber)),
                seeThat("Mensaje de date de operación", AnulationsMillasQuestions.responseCustomer(), equalTo(customerId))
        );
    }

    @When("^ingresamos el codigo unico (.*) para generar token client credencial para el cliente (.*)$")
    public void insertCustomerId(String customerId, String cliente) {
        theActorInTheSpotlight().attemptsTo(
                GetOauthTokenV1.withCliente(customerId, cliente)
        );
        Serenity.setSessionVariable("cliente").to(cliente);
        Serenity.setSessionVariable("accessToken").to(theActorInTheSpotlight().asksFor(AuthToken.accessToken()));
        Serenity.setSessionVariable("customerId").to(customerId);
    }

}

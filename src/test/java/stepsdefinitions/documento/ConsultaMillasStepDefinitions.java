package stepsdefinitions.documento;

import io.cucumber.java.en.When;
import net.serenitybdd.core.Serenity;
import questions.AuthToken;
import tasks.GetOauthToken;
import tasks.GetTokenAuthorizations;
import tasks.documents.ConsultMiles;
import utils.ApiCommons;

import java.text.SimpleDateFormat;
import java.util.Date;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.rest.questions.ResponseConsequence.seeThatResponse;
import static org.hamcrest.core.IsEqual.equalTo;
import static org.hamcrest.core.IsNot.not;
import static org.hamcrest.text.IsEmptyString.isEmptyOrNullString;

/**
 * @author Cesar Ilachoque
 */
public class ConsultaMillasStepDefinitions {

    @When("^ingresamos al servicio de generar token para cliente (.*)$")
    public void generate_token(String cliente) {
        theActorInTheSpotlight().attemptsTo(
                GetOauthToken.withCliente(cliente)
        );
        Serenity.setSessionVariable("accessToken").to(theActorInTheSpotlight().asksFor(AuthToken.accessToken()));
        Serenity.setSessionVariable("cliente").to(cliente);
    }

    @When("^ingresamos el codigo unico (.*) para generar token con el cliente (.*)$")
    public void insertCustomerId(String customerId, String cliente) {
        theActorInTheSpotlight().attemptsTo(
                GetTokenAuthorizations.generateToken(customerId, cliente)
        );
        Serenity.setSessionVariable("cliente").to(cliente);
        Serenity.setSessionVariable("accessToken").to(theActorInTheSpotlight().asksFor(AuthToken.accessToken()));
        Serenity.setSessionVariable("customerId").to(customerId);
    }

    @When("^validamos la generacion de token satisfactorio para el usuario con tipo de documento (.*) y numero de documento (.*)$")
    public void validate(String documentType, String documentNumber) {
        String customerId = Serenity.sessionVariableCalled("customerId");
        theActorInTheSpotlight().should(
                seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)
                )
        );
        theActorInTheSpotlight().should(
                seeThat("Refresh token", AuthToken.refreshToken(), not(isEmptyOrNullString())),
                seeThat("Tipo de documento", AuthToken.tipoDocumento(), equalTo(documentType)),
                seeThat("Número de documento", AuthToken.numeroDocumento(), equalTo(documentNumber)),
                seeThat("Código único", AuthToken.codigoUnico(), equalTo(customerId)),
                seeThat("Tipo de token", AuthToken.typoToken(), equalTo("bearer")),
                seeThat("Gran tipo", AuthToken.granTipo(), equalTo("authorization_code"))
        );
        Serenity.setSessionVariable("type").to(documentType);
        Serenity.setSessionVariable("number").to(documentNumber);
    }

    @When("^se realiza la consulta de millas para el cliente (.*)$")
    public void consultMillas(String cliente) {
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        Date date = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("ddMMyyyyhhmmss");
        String messageIdDate = dateFormat.format(date);

        theActorInTheSpotlight().attemptsTo(
                ConsultMiles.consultMiles(accessToken, cliente, messageIdDate)
        );
    }

    @When("^se realiza la consulta de millas sin enviar ordernumber para el cliente (.*)$")
    public void consultMillasSinOrderNumber(String cliente) {
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        theActorInTheSpotlight().attemptsTo(
                ConsultMiles.consultMiles(accessToken, cliente, "")
        );
    }

    @When("^se realiza la consulta de millas con enviar ordernumber para el cliente (.*)$")
    public void consultMillasConOrderNumber(String cliente) {
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        theActorInTheSpotlight().attemptsTo(
                ConsultMiles.consultMiles(accessToken, cliente, "43534435344353443534435344353443534435344353443534435344353443534435344353443534")
        );
    }
    
}

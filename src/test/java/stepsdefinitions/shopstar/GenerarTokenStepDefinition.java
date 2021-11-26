package stepsdefinitions.shopstar;

import io.cucumber.java.Before;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.actors.OnStage;
import net.serenitybdd.screenplay.actors.OnlineCast;
import net.thucydides.core.util.EnvironmentVariables;
import org.junit.Assert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import tasks.shopstar.GenerarToken;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.rest.questions.ResponseConsequence.seeThatResponse;
import static org.hamcrest.core.IsNot.not;
import static org.hamcrest.text.IsEmptyString.isEmptyString;
import static utils.ApiCommons.STATUS_CODE_OK;

/**
 * @author Nilo Carrion
 */
public class GenerarTokenStepDefinition {

    @Before
    public void setTheStage() {
        OnStage.setTheStage(new OnlineCast());
    }

    @When("^el ingresa tipo de documento (.*) y numero de documento (.*) contrasena (.*)$")
    public void ingresaDatosUsuario(String documentType, String documentNumber, String password) {
//        theActorInTheSpotlight().attemptsTo(GenerarToken.generateToken(documentType, documentNumber, password));
    }

/*
    @Then("se valida generar token con satisfactorio")
    public void validaGenerarTokenSatisfactorio() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(STATUS_CODE_OK)));
        String accessToken = SerenityRest.lastResponse().path("access_token").toString();
        String customerId = SerenityRest.lastResponse().path("customerId").toString();
        Assert.assertThat(accessToken, not(isEmptyString()));
        Assert.assertThat(customerId, not(isEmptyString()));
    }
*/

}

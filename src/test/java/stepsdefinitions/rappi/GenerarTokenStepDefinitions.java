package stepsdefinitions.rappi;

import io.cucumber.java.Before;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import net.serenitybdd.core.environment.EnvironmentSpecificConfiguration;
import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.actors.OnStage;
import net.serenitybdd.screenplay.actors.OnlineCast;
import net.serenitybdd.screenplay.rest.abilities.CallAnApi;
import net.thucydides.core.util.EnvironmentVariables;
import org.junit.Assert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import tasks.rappi.GenerarToken;
import utils.ApiCommons;

import static net.serenitybdd.screenplay.actors.OnStage.theActorCalled;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.rest.questions.ResponseConsequence.seeThatResponse;
import static org.hamcrest.core.IsNot.not;
import static org.hamcrest.text.IsEmptyString.isEmptyString;

/**
 * @author Nilo Carrion
 */
public class GenerarTokenStepDefinitions {

    private static final Logger LOGGER = LoggerFactory.getLogger(GenerarTokenStepDefinitions.class);

    EnvironmentVariables environmentVariables;

    @Before
    public void setTheStage() {
        OnStage.setTheStage(new OnlineCast());
    }

    @Given("^que el (.*) accede a la aplicacion$")
    public void usuarioAccedeAplicacion(String name) {
        theActorCalled(name).whoCan(CallAnApi.at(EnvironmentSpecificConfiguration.from(environmentVariables).getProperty("url")));
        LOGGER.info("ACCESS APP");
        LOGGER.info("DOMINIO "+EnvironmentSpecificConfiguration.from(environmentVariables).getProperty("url"));
    }

    @When("^se ingresa codigo unico (.*)$")
    public void insertCustomerId(String customerId) {
        theActorInTheSpotlight().attemptsTo(GenerarToken.generateToken(customerId));
    }

    @Then("se valida generar token con satisfactorio")
    public void validaGenerarTokenSatisfactorio() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
        String accessToken = SerenityRest.lastResponse().path("access_token").toString();
        String customerId = SerenityRest.lastResponse().path("customerId").toString();
        String status = SerenityRest.lastResponse().path("status").toString();
        Assert.assertThat(accessToken, not(isEmptyString()));
        Assert.assertThat(customerId, not(isEmptyString()));
        Assert.assertThat(status, not(isEmptyString()));
    }

}

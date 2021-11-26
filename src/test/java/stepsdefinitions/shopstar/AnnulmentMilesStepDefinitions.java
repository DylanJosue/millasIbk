package stepsdefinitions.shopstar;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import tasks.documents.AnnulmentMiles;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

/**
 * @author Nilo Carrion
 */
public class AnnulmentMilesStepDefinitions {

    @And("^el usuario anula la operacion del canje de millas$")
    public void anularCanjeMillas() {
        String authorizationCode = Serenity.sessionVariableCalled("authorizationCode");
        String orderNumber = Serenity.sessionVariableCalled("orderNumber");
        String operationDate = Serenity.sessionVariableCalled("operationDate");
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String cliente = Serenity.sessionVariableCalled("cliente");
        theActorInTheSpotlight().attemptsTo(
                AnnulmentMiles.annulmentMiles(accessToken,cliente,authorizationCode,orderNumber,operationDate)
        );
    }
    @And("^el usuario anula la operacion enviando autorización code invalidos (.*)$")
    public void anularCanjeMillasCode(String authorizationCode) {
        String orderNumber = Serenity.sessionVariableCalled("orderNumber");
        String operationDate = Serenity.sessionVariableCalled("operationDate");
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String cliente = Serenity.sessionVariableCalled("cliente");
        theActorInTheSpotlight().attemptsTo(
                AnnulmentMiles.annulmentMiles(accessToken,cliente,authorizationCode,orderNumber,operationDate)
        );
    }

    @And("^el usuario anula la operacion enviando order number invalidos (.*)$")
    public void anularCanjeMillasOrderNumber(String orderNumber) {
        String authorizationCode = Serenity.sessionVariableCalled("authorizationCode");
        String operationDate = Serenity.sessionVariableCalled("operationDate");
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String cliente = Serenity.sessionVariableCalled("cliente");
        theActorInTheSpotlight().attemptsTo(AnnulmentMiles.annulmentMiles(accessToken,cliente,authorizationCode,orderNumber,operationDate));
    }
}

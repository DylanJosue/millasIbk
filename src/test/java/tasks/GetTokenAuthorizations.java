package tasks;

import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.Tasks;
import net.serenitybdd.screenplay.rest.interactions.Post;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import stepsdefinitions.rappi.GenerarTokenStepDefinitions;
import utils.SecurityCommons;
import utils.WebServiceEndPoints;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

/**
 * @author Cesar Ilachoque
 */
public class GetTokenAuthorizations implements Task {
    private static final Logger LOGGER = LoggerFactory.getLogger(GenerarTokenStepDefinitions.class);
    private final String customerId;
    private final String cliente;

    public GetTokenAuthorizations(String customerId, String cliente) {

        this.customerId = customerId;
        this.cliente = cliente;
    }

    public static Performable generateToken(String customerId, String cliente) {
        return Tasks.instrumented(GetTokenAuthorizations.class, customerId, cliente);
    }

    @Override
    public <T extends Actor> void performAs(T actor) {
        String client_secret = "";
        if (cliente.equals("RAPPI")) {
            client_secret = "BenefitRappi*4_9";
        } else if (cliente.equals("SHOPSTAR")) {
            client_secret = "BenefitShopstar*1_521";
        } else {
            client_secret = "BNFTNiubizEcommerce*1";
        }
        LOGGER.info("END POINT: " + WebServiceEndPoints.GENERATE_TOKEN_AUTHORIZATION.getUrl());
        String finalClient_secret = client_secret;
        actor.attemptsTo(
                Post.to(WebServiceEndPoints.GENERATE_TOKEN_AUTHORIZATION.getUrl())
                        .with(request -> request
                                .relaxedHTTPSValidation()
                                .formParam("client_id", cliente)
                                .formParam("client_secret", finalClient_secret)
                                .formParam("grant_type", "authorization_code")
                                .formParam("scope", "write")
                                .formParam("code", "aaaaa11111aaaaa11111aaaaa11111aa")
                                .formParam("customerId", customerId)
                                .header("Accept-Encoding", "UTF-8")
                                .header(SecurityCommons.API_IB_CLIENT_ID, SecurityCommons.API_IB_CLIENT_ID_UAT_VALUE)
                                .contentType("application/x-www-form-urlencoded")
                        ));
        LOGGER.info("cliente: " + cliente);
        System.out.println(SerenityRest.lastResponse().body().prettyPrint());
        System.out.println("Token");
    }

}

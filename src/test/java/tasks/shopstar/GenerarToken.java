package tasks.shopstar;

import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.Tasks;
import net.serenitybdd.screenplay.rest.interactions.Post;
import utils.SecurityCommons;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

/**
 * @author Cesar Ilachoque
 */
public class GenerarToken implements Task {

    public static final String URL_GENERAR_TOKEN_RAPPI = "/api/tokenbim/v2/oauth";

    private final String customerId;

    public GenerarToken(String customerId) {

        this.customerId = customerId;
    }

    public static Performable generateToken(String customerId) {
        return Tasks.instrumented(GenerarToken.class, customerId);
    }
    @Override
    public <T extends Actor> void performAs(T actor) {
        actor.attemptsTo(Post.to(URL_GENERAR_TOKEN_RAPPI)
                .with(request -> request
                        .contentType("application/x-www-form-urlencoded")
                        .formParam("client_id", "SHOPSTAR")
                        .formParam("client_secret", "BenefitShopstar*1_521")
                        .formParam("grant_type", "authorization_code")
                        .formParam("scope", "write")
                        .formParam("code", "aaaaa11111aaaaa11111aaaaa11111aa")
                        .formParam("customerId", customerId)
                        .header("Accept-Encoding", "UTF-8")
                        .header(SecurityCommons.API_IB_CLIENT_ID, SecurityCommons.API_IB_CLIENT_ID_UAT_VALUE)
                ));

        if (SerenityRest.lastResponse().statusCode() == 200) {
            theActorInTheSpotlight().remember("ACCESS_TOKEN", "Bearer " + SerenityRest.lastResponse().path("access_token").toString());
        }
    }



}

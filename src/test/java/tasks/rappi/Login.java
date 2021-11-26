package tasks.rappi;

import io.restassured.http.ContentType;
import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.Tasks;
import net.serenitybdd.screenplay.rest.interactions.Post;
import utils.ApiCommons;
import utils.WebServiceEndPoints;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

/**
 * @author Nilo Carrion
 */
public class Login implements Task {

    private static final String TEMPLATE_CUSTOMER_LOGIN = "/templates/login-input.json";

    private final String accessToken;
    private final String cliente;
    private final String documentType;
    private final String documentNumber;
    private final String password;

    public Login(String accessToken, String cliente, String documentType, String documentNumber, String password) {
        this.accessToken = accessToken;
        this.cliente = cliente;
        this.documentType = documentType;
        this.documentNumber = documentNumber;
        this.password = password;
    }

    @Override
    public <T extends Actor> void performAs(T actor) {

        actor.attemptsTo(Post.to(WebServiceEndPoints.URL_CUSTOMER_LOGIN.getUrl())
                .with(request -> request
                        .relaxedHTTPSValidation()
                        .contentType(ContentType.JSON)
                        .header("Authorization", "Bearer " + accessToken)
                        .header("X-INT-Consumer-Id", cliente)
                        .pathParam("documentType", documentType)
                        .pathParam("documentNumber", documentNumber)
                        .body(ApiCommons.getTemplate(TEMPLATE_CUSTOMER_LOGIN)
                                .replace("{password}", password)
                        )
                ));

        if (SerenityRest.lastResponse().statusCode() == 200) {
            theActorInTheSpotlight().remember("ACCESS_TOKEN_OTP", "Bearer " + SerenityRest.lastResponse().path("response.token.access_token").toString());
        }
    }

    public static Performable customerLogin(String accessToken, String cliente, String documentType, String documentNumber, String password) {
        return Tasks.instrumented(Login.class, accessToken, cliente, documentType, documentNumber, password);
    }

}

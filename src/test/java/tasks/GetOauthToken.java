package tasks;

import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.Tasks;
import net.serenitybdd.screenplay.rest.interactions.Post;
import net.thucydides.core.annotations.Step;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import utils.Utils;
import utils.WebServiceEndPoints;

import java.io.IOException;
import java.util.Properties;

/**
 * @author César Alcántara
 */

public class GetOauthToken implements Task {

    private static final Logger LOGGER = LoggerFactory.getLogger(GetOauthToken.class);

    Utils utils = new Utils();

    Properties prop = utils.properties();
    private final String ibClientIdUat = prop.getProperty("serenity.client.id.uat");

    private final String cliente;

    public GetOauthToken(String cliente) throws IOException {
        this.cliente = cliente;
    }

    public static Performable withCliente(String cliente) {
        return Tasks.instrumented(GetOauthToken.class, cliente);
    }

    @Step("{0} obtiene oauth token")
    @Override
    public <T extends Actor> void performAs(T actor) {
        String client_secret = "";

        switch (cliente) {
            case "NIUBIZ":
                client_secret = prop.getProperty("serenity.client.niubiz");
                break;
            case "IZIPAY":
                client_secret = prop.getProperty("serenity.client.izipay");
                break;
            case "NIUBIZ-E-COMMERCE":
                client_secret = prop.getProperty("serenity.client.niubizecommerce");
                break;
            case "RAPPI":
                client_secret = prop.getProperty("serenity.client.rappi");
                break;
            case "SHOPSTAR":
                client_secret = prop.getProperty("serenity.client.shopstar");
                break;
            default:
                LOGGER.info(cliente + "Comercio no encontrado !!!");
        }

        String finalClient_secret = client_secret;

        LOGGER.info("ENDPOINT: " + WebServiceEndPoints.GENERATE_TOKEN.getUrl());
        actor.attemptsTo(
                Post.to(WebServiceEndPoints.GENERATE_TOKEN.getUrl()).with(
                        requestSpecification -> requestSpecification
                                .formParam("client_id", cliente)
                                .formParam("client_secret", finalClient_secret)
                                .formParam("grant_type", "client_credentials")
                                .formParam("scope", "read")
                                .header("Content-Type", "application/x-www-form-urlencoded")
                                .header("X-IB-Client-Id", ibClientIdUat)
                )
        );
        LOGGER.info("Token: " + SerenityRest.lastResponse().body().prettyPrint());
    }

}

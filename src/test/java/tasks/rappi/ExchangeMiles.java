package tasks.rappi;

import io.restassured.http.ContentType;
import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.Tasks;
import net.serenitybdd.screenplay.rest.interactions.Put;
import utils.ApiCommons;
import utils.SecurityCommons;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

/**
 * @author Nilo Carrion
 */
public class ExchangeMiles implements Task {

    private static final String URL_EXCHANGE_MILES = "/benefit/millas/v2/exchange";
    private static final String TEMPLATE_EXCHANGE_MILES = "/templates/exchangeMiles-input.json";

    private final String totalMiles;
    private final String totalAmount;
    private final String currencyIdOne;
    private final String quantityMiles;
    private final String netAmount;
    private final String identifier;
    private final String description;
    private final String quantity;
    private final String amount;
    private final String currencyIdTwo;
    private final String orderNumber;

    public ExchangeMiles(String totalMiles, String totalAmount, String currencyIdOne, String quantityMiles, String netAmount, String identifier, String description, String quantity, String amount, String currencyIdTwo, String orderNumber) {
        this.totalMiles = totalMiles;
        this.totalAmount = totalAmount;
        this.currencyIdOne = currencyIdOne;
        this.quantityMiles = quantityMiles;
        this.netAmount = netAmount;
        this.identifier = identifier;
        this.description = description;
        this.quantity = quantity;
        this.amount = amount;
        this.currencyIdTwo = currencyIdTwo;
        this.orderNumber = orderNumber;
    }

    @Override
    public <T extends Actor> void performAs(T actor) {
        actor.attemptsTo(Put.to(URL_EXCHANGE_MILES)
                .with(request -> request
                        .contentType(ContentType.JSON)
                        .header("Authorization", actor.recall("ACCESS_TOKEN"))
                        .header(SecurityCommons.API_IB_CLIENT_ID, SecurityCommons.API_IB_CLIENT_ID_UAT_VALUE)
                        .header("X-INT-Timestamp", "2020-05-17T16:40:48")
                        .header("X-INT-Message-Id", "20200407170000")
                        .header("X-INT-Consumer-Id", "RAPPI")
                        .header("X-INT-Device-Id", SecurityCommons.IP_DEVICE_ID_TRX)
                        .body(ApiCommons.getTemplate(TEMPLATE_EXCHANGE_MILES)
                                .replace("{totalMiles}", totalMiles)
                                .replace("{totalAmount}", totalAmount)
                                .replace("{currencyIdOne}", currencyIdOne)
                                .replace("{quantityMiles}", quantityMiles)
                                .replace("{netAmount}", netAmount)
                                .replace("{identifier}", identifier)
                                .replace("{description}", description)
                                .replace("{quantity}", quantity)
                                .replace("{amount}", amount)
                                .replace("{currencyIdTwo}", currencyIdTwo)
                                .replace("{orderNumber}", orderNumber)
                        )));
        System.out.println(SerenityRest.lastResponse().body().prettyPrint());
        System.out.println("test");
        if (SerenityRest.lastResponse().statusCode() == 200) {
            theActorInTheSpotlight().remember("AUTHORIZATION_CODE", SerenityRest.lastResponse().path("response.authorizationCode").toString());
            theActorInTheSpotlight().remember("OPERATION_DATE", SerenityRest.lastResponse().path("response.operationDate").toString());
        }
    }

    public static Performable exchangeMiles(String totalMiles, String totalAmount, String currencyIdOne, String quantityMiles, String netAmount, String identifier, String description, String quantity, String amount, String currencyIdTwo, String orderNumber) {
        System.out.println("quantityMiles: " + quantityMiles);
        return Tasks.instrumented(ExchangeMiles.class, totalMiles, totalAmount, currencyIdOne, quantityMiles, netAmount, identifier, description, quantity, amount, currencyIdTwo, orderNumber);
    }

}

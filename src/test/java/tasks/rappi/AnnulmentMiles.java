package tasks.rappi;

import io.restassured.http.ContentType;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.Tasks;
import net.serenitybdd.screenplay.rest.interactions.Put;
import utils.ApiCommons;
import utils.SecurityCommons;

/**
 * @author Nilo Carrion
 */
public class AnnulmentMiles implements Task {

    private static final String URL_ANULACION_MILLAS = "/benefit/millas/v2/{authorizationCode}/annulment";
    private static final String TEMPLATE_ANULACION_MILLAS = "/templates/annulmentMiles-input.json";

    private final String orderNumber;

    public AnnulmentMiles(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    @Override
    public <T extends Actor> void performAs(T actor) {
        actor.attemptsTo(Put.to(URL_ANULACION_MILLAS)
                .with(request -> request
                        .contentType(ContentType.JSON)
                        .pathParam("authorizationCode", actor.recall("AUTHORIZATION_CODE"))
                        .header("Authorization", actor.recall("ACCESS_TOKEN"))
                        .header(SecurityCommons.API_IB_CLIENT_ID, SecurityCommons.API_IB_CLIENT_ID_UAT_VALUE)
                        .header("X-INT-Timestamp", "2020-12-22T16:41:50")
                        .header("X-INT-Message-Id", "20200407170500")
                        .header("X-INT-Consumer-Id", "RAPPI")
                        .header("X-INT-Device-Id", SecurityCommons.IP_DEVICE_ID_TRX)
                        .body(ApiCommons.getTemplate(TEMPLATE_ANULACION_MILLAS)
                                .replace("{orderNumber}", orderNumber)
                                .replace("{operationDate}", actor.recall("OPERATION_DATE"))
                        )));

    }

    public static Performable annulmentMiles(String orderNumber) {
        System.out.println("Order number: " + orderNumber);
        return Tasks.instrumented(AnnulmentMiles.class, orderNumber);
    }

}

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
public class AnnulmentInvalid implements Task {

    private static final String URL_ANULACION_MILLAS_INVALID = "/benefit/millas/v2/{authorizationCode}/annulment";
    private static final String TEMPLATE_ANULACION_MILLAS_INVALID = "/templates/annulmentMiles-input.json";

    private final String authorizationCode;
    private final String orderNumber;
    private final String operationDate;

    public AnnulmentInvalid(String authorizationCode, String orderNumber, String operationDate) {
        this.authorizationCode = authorizationCode;
        this.orderNumber = orderNumber;
        this.operationDate = operationDate;
    }

    @Override
    public <T extends Actor> void performAs(T actor) {
        actor.attemptsTo(Put.to(URL_ANULACION_MILLAS_INVALID)
                .with(request -> request
                        .contentType(ContentType.JSON)
                        .pathParam("authorizationCode", authorizationCode)
                        .header("Authorization", actor.recall("ACCESS_TOKEN"))
                        .header(SecurityCommons.API_IB_CLIENT_ID, SecurityCommons.API_IB_CLIENT_ID_UAT_VALUE)
                        .header("X-INT-Timestamp", "2020-12-22T16:41:50")
                        .header("X-INT-Message-Id", "20200407170500")
                        .header("X-INT-Consumer-Id", "RAPPI")
                        .header("X-INT-Device-Id", SecurityCommons.IP_DEVICE_ID_TRX)
                        .body(ApiCommons.getTemplate(TEMPLATE_ANULACION_MILLAS_INVALID)
                                .replace("{orderNumber}", orderNumber)
                                .replace("{operationDate}", operationDate)
                        )));

    }

    public static Performable annulmentInvalid(String authorizationCode, String orderNumber, String operationDate) {
        System.out.println("Authorization code: " + authorizationCode);
        return Tasks.instrumented(AnnulmentInvalid.class, authorizationCode, orderNumber, operationDate);
    }

}

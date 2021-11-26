package tasks.shopstar;

import io.restassured.http.ContentType;
import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.Tasks;
import net.serenitybdd.screenplay.rest.interactions.Put;
import utils.ApiCommons;
import utils.SecurityCommons;
import utils.WebServiceEndPoints;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author Cesar Ilachoque
 */
public class AnnulmentMiles implements Task {

    private static final String TEMPLATE_ANULACION_MILLAS = "/templates/annulmentMiles-input.json";
    private final String authorizationCode;
    private final String orderNumber;
    private final String operationDate;

    public AnnulmentMiles(String authorizationCode,String orderNumber,String operationDate) {
        this.authorizationCode = authorizationCode;
        this.orderNumber = orderNumber;
        this.operationDate = operationDate;
    }
    public static Performable annulmentMiles(String authorizationCode,String orderNumber,String operationDate) {
        return Tasks.instrumented(AnnulmentMiles.class,authorizationCode, orderNumber,operationDate);
    }

    @Override
    public <T extends Actor> void performAs(T actor) {
        Date date = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddhhmmss");
        String messageIdDate = dateFormat.format(date);
        actor.attemptsTo(Put.to(WebServiceEndPoints.API_ANNULMENTMILES_SHOPSTAR.getUrl())
                .with(request -> request
                        .contentType(ContentType.JSON)
                        .pathParam("authorizationCode", authorizationCode)
                        .header("Authorization", actor.recall("ACCESS_TOKEN"))
                        .header(SecurityCommons.API_IB_CLIENT_ID, SecurityCommons.API_IB_CLIENT_ID_UAT_VALUE)
                        .header("X-INT-Timestamp", "2020-12-22T16:41:50")
                        .header("X-INT-Message-Id", "ANNULMENT_QA_"+messageIdDate)
                        .header("X-INT-Consumer-Id", "SHOPSTAR")
                        .header("X-INT-Device-Id", SecurityCommons.IP_DEVICE_ID_TRX)
                        .body(ApiCommons.getTemplate(TEMPLATE_ANULACION_MILLAS)
                                .replace("{orderNumber}", orderNumber)
                                .replace("{operationDate}", operationDate)
                        )));
        System.out.println(SerenityRest.lastResponse().body().prettyPrint());
        System.out.println("test");
    }



}

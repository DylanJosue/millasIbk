package tasks.shopstar;

import io.restassured.http.ContentType;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.Tasks;
import net.serenitybdd.screenplay.rest.interactions.Get;
import utils.SecurityCommons;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author Nilo Carrion
 */
public class ConsultMiles implements Task {

    private static final String URL_CONSULT_MILES = "/benefit/millas/v2/";

    private final String orderNumber;

    public ConsultMiles(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    @Override
    public <T extends Actor> void performAs(T actor) {
        Date date = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddhhmmss");
        String messageIdDate = dateFormat.format(date);
        actor.attemptsTo(Get.resource(URL_CONSULT_MILES)
                .with(request -> request
                        .contentType(ContentType.JSON)
                        .header("Authorization", actor.recall("ACCESS_TOKEN"))
                        .header(SecurityCommons.API_IB_CLIENT_ID, SecurityCommons.API_IB_CLIENT_ID_UAT_VALUE)
                        .formParam("orderNumber", orderNumber)
                        .header("X-INT-Timestamp", "2020-04-07T17:13:00")
                        .header("X-INT-Message-Id", "ConsultShopstart_"+messageIdDate)
                        .header("X-INT-Consumer-Id", "SHOPSTAR")
                        .header("X-INT-Device-Id", SecurityCommons.IP_DEVICE_ID_TRX)
                ));

    }

    public static Performable consultMiles(String orderNumber) {
        System.out.println("Order number: " + orderNumber);
        return Tasks.instrumented(ConsultMiles.class, orderNumber);
    }

}

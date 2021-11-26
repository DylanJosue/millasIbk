package tasks.documents;

import io.restassured.http.ContentType;
import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.Tasks;
import net.serenitybdd.screenplay.rest.interactions.Get;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import stepsdefinitions.rappi.GenerarTokenStepDefinitions;
import utils.SecurityCommons;
import utils.WebServiceEndPoints;

/**
 * @author Cesar Ilachoque
 */
public class ConsultMiles implements Task {
    private static final Logger LOGGER = LoggerFactory.getLogger(GenerarTokenStepDefinitions.class);
    private String accessToken;
    private final String cliente;
    private final String orderNumber;

    public ConsultMiles(String accessToken, String cliente, String orderNumber) {
        this.accessToken = accessToken;
        this.cliente = cliente;
        this.orderNumber = orderNumber;
    }

    public static Performable consultMiles(String accessToken, String cliente, String orderNumber) {
        return Tasks.instrumented(ConsultMiles.class, accessToken, cliente, orderNumber);
    }

    @Override
    public <T extends Actor> void performAs(T actor) {
        LOGGER.info("ENDPOINT : " + WebServiceEndPoints.API_CONSULT_MILLAS_DOCUMENT.getUrl());
        LOGGER.info("Cliente : " + cliente);
        actor.attemptsTo(
                Get.resource(WebServiceEndPoints.API_CONSULT_MILLAS_DOCUMENT.getUrl())
                        .with(requestSpecification -> requestSpecification
                                .relaxedHTTPSValidation()
                                .header("Authorization", "Bearer " + accessToken)
                                .header(SecurityCommons.API_IB_CLIENT_ID, SecurityCommons.API_IB_CLIENT_ID_UAT_VALUE)
                                .formParam("orderNumber", orderNumber)
                                .header("X-INT-Timestamp", "2020-04-07T17:13:00")
                                .header("X-INT-Message-Id", "ConsultQA_" + cliente + "_" + orderNumber)
                                .header("X-INT-Consumer-Id", cliente)
                                .header("X-INT-Device-Id", SecurityCommons.IP_DEVICE_ID_TRX)
                                .contentType(ContentType.JSON)
                        ));
        System.out.println(SerenityRest.lastResponse().body().prettyPrint());
        System.out.println("test");
    }


}

package tasks.niubiz;

import io.restassured.http.ContentType;
import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.Tasks;
import net.serenitybdd.screenplay.rest.interactions.Get;
import utils.WebServiceEndPoints;

import java.text.SimpleDateFormat;
import java.util.Date;
import static utils.SecurityCommons.*;
import static utils.SecurityCommons.generarAccessTokenNiubiz;

/**
 * @author Cesar Ilachoque
 */
public class ConsultaMillas implements Task {
    private String accessToken;
    private final String cliente;
    private final String documentType;
    private final String documentNumber;
    private final String cardNumber;
    private final String orderNumber;

    public ConsultaMillas(String accessToken,String cliente,String documentType,String documentNumber,String cardNumber,String orderNumber) {
        this.accessToken = accessToken;
        this.cliente = cliente;
        this.documentType = documentType;
        this.documentNumber = documentNumber;
        this.cardNumber = cardNumber;
        this.orderNumber = orderNumber;
    }

    public static Performable consult(String accessToken,String cliente,String documentType,String documentNumber,String cardNumber,String orderNumber) {
        return Tasks.instrumented(ConsultaMillas.class,accessToken,cliente,documentType,documentNumber, cardNumber,orderNumber);
    }
    @Override
    public <T extends Actor> void performAs(T actor) {

        String client =  "";
        if (cliente.equals("NIUBIZ")){
            client = "NBZ";
        }
        else if(cliente.equals("IZIPAY")) {
                client = "IZIPAY";
            }
            else {
                client = "NIUBIZ-E-COMMERCE";
            }

        String finalclient = client;

        Date date  = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("ddMMyyyyhhmmss");
        String messageIdDateqa = dateFormat.format(date);

        actor.attemptsTo(
                Get.resource(WebServiceEndPoints.API_CONSULTA.getUrl())
                        .with(requestSpecification -> requestSpecification
                                .relaxedHTTPSValidation()
                                .param("code", "777777")
                                .param("name", "NORMAC")
                                .param("terminal", "1232")
                                .param("orderNumber", orderNumber)
                                .param("documentType",documentType)
                                .param("documentNumber",documentNumber)
                                .pathParam("cardId", cardNumber)
                                .header("Authorization", "Bearer " + accessToken)
                                .header("X-IB-Client-Id", "d5d20dc03c31445298913f2f65790afa")
                                .header("X-INT-Device-Id", "13.10.13.1")
                                .header("X-INT-Timestamp", "2020-04-07T17:13:00")
                                .header("X-INT-Consumer-Id", finalclient)
                                .header("X-INT-Message-Id", "ConsultMillasQA_"+messageIdDateqa)
                                .contentType(ContentType.JSON)
                        ));
        System.out.println(SerenityRest.lastResponse().body().prettyPrint());
        System.out.println("test");
    }

}

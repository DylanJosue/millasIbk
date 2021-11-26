package tasks.niubiz;

import io.restassured.http.ContentType;
import models.AnulationsModels;
import models.Commerce;
import models.Customer;
import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.Tasks;
import net.serenitybdd.screenplay.rest.interactions.Put;
import utils.WebServiceEndPoints;

import java.text.SimpleDateFormat;
import java.util.Date;

import utils.SecurityCommons;

/**
 * @author Cesar Ilachoque
 */
public class AnulacionMillas implements Task {
    private String accessToken;
    private final String cliente;
    private final String authorizationCode;
    private final String cardNumber;
    private final String documentType;
    private final String documentNumber;
    private final String orderNumber;
    private final String codComercio;
    private final String nameComercio;
    private final String terminal;
    public AnulacionMillas(String accessToken,String cliente,String cardNumber, String authorizationCode, String documentType, String documentNumber, String orderNumber,String codComercio,String nameComercio, String terminal) {
        this.accessToken = accessToken;
        this.cliente = cliente;
        this.cardNumber = cardNumber;
        this.authorizationCode = authorizationCode;
        this.documentType = documentType;
        this.documentNumber = documentNumber;
        this.orderNumber = orderNumber;
        this.codComercio = codComercio;
        this.nameComercio = nameComercio;
        this.terminal = terminal;
    }

    public static Performable annulmentMiles(String accessToken,String cliente,String cardNumber, String authorizationCode, String documentType, String documentNumber, String orderNumber,String codComercio,String nameComercio, String terminal) {
        return Tasks.instrumented(AnulacionMillas.class,accessToken,cliente, cardNumber,authorizationCode,documentType,documentNumber, orderNumber,codComercio,nameComercio,terminal);
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

        Date date = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("ddMMyyyyhhmmss");
        String messageIdDate = dateFormat.format(date);
        Commerce commerce = Commerce.builder()
                .code(codComercio)
                .name(nameComercio)
                .build();

        Customer customer = Customer.builder()
                .documentType(documentType)
                .documentNumber(documentNumber)
                .build();
        AnulationsModels anulationsModels = AnulationsModels.builder()
                .cardId(cardNumber)
                .commerce(commerce)
                .customer(customer)
                .terminal(terminal)
                .orderNumber(orderNumber)
                .build();

        actor.attemptsTo(
                Put.to(WebServiceEndPoints.API_ANULATIONS.getUrl())
                        .with(requestSpecification -> requestSpecification
                                .relaxedHTTPSValidation()
                                .contentType(ContentType.JSON)
                                .pathParam("authorizationCode", authorizationCode)
                                .header("Authorization", "Bearer " + accessToken)
                                .header(SecurityCommons.API_IB_CLIENT_ID, SecurityCommons.API_IB_CLIENT_ID_UAT_VALUE)
                                .header("X-INT-Timestamp", "2020-04-07T16:43:30")
                                .header("X-INT-Message-Id", "AnulacionQA_" + messageIdDate)
                                .header("X-INT-Consumer-Id", finalclient)
                                .header("X-INT-Device-Id", SecurityCommons.IP_DEVICE_ID_TRX)
                                .body(anulationsModels)
                        )
        );

        System.out.println(SerenityRest.lastResponse().body().prettyPrint());
        System.out.println("test");

    }

}

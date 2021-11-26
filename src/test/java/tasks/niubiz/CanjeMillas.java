package tasks.niubiz;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import io.restassured.http.ContentType;
import models.Commerce;
import models.Customer;
import models.ExchangeModel;
import models.Items;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.rest.interactions.Put;
import utils.SecurityCommons;
import utils.Utils;
import utils.WebServiceEndPoints;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

import static net.serenitybdd.screenplay.Tasks.instrumented;

/**
 * @author Cesar Ilachoque
 */
public class CanjeMillas implements Task {

    Utils utils = new Utils();
    private String accessToken;
    private final String cliente;
    private final String users;
    private final String tarjeta;
    private final String orderNumber;

    public CanjeMillas(String accessToken,String cliente,String users, String tarjeta, String orderNumber) {
        this.accessToken = accessToken;
        this.cliente = cliente;
        this.users = users;
        this.tarjeta = tarjeta;
        this.orderNumber = orderNumber;

    }

    public static Performable withUsers(String accessToken,String cliente,String users, String tarjeta, String orderNumber) {
        return instrumented(CanjeMillas.class,accessToken,cliente, users, tarjeta, orderNumber);
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
        JsonObject userData = null;
        try {
            userData = utils.getJsonFile("/users/" + users.toLowerCase().replace(" ", "_") + ".json");
        } catch (IOException e) {
            e.printStackTrace();
        }
        JsonObject parameters0 = userData.get("commerce").getAsJsonObject();
        JsonObject parameters1 = userData.get("customer").getAsJsonObject();
        JsonArray items1 = userData.get("items").getAsJsonArray();
        JsonObject parameters2 = items1.get(0).getAsJsonObject();
        Items items = Items.builder()
                .identifier(parameters2.get("identifier").getAsString())
                .description(parameters2.get("description").getAsString())
                .quantity(parameters2.get("quantity").getAsInt())
                .amount(parameters2.get("amount").getAsDouble())
                .currencyId(parameters2.get("currencyId").getAsString())
                .build();
        Commerce commerce = Commerce.builder()
                .code(parameters0.get("code").getAsString())
                .name(parameters0.get("name").getAsString())
                .build();
        Customer customer = Customer.builder()
                .documentType(parameters1.get("documentType").getAsString())
                .documentNumber(parameters1.get("documentNumber").getAsString())
                .build();
        Serenity.setSessionVariable("type").to(parameters1.get("documentType").getAsString());
        Serenity.setSessionVariable("number").to(parameters1.get("documentNumber").getAsString());
        //TODO: el valor para orderNumber se obtiene de acuerdo a la fecha de la ejecución - messageIdDate, no del archivo json del cliente
        Date date = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("ddMMyyyyhhmmss");
        String messageIdDate = dateFormat.format(date);

        ExchangeModel exchange = ExchangeModel.builder()
                .totalMiles(userData.get("totalMiles").getAsInt())
                .totalAmount(userData.get("totalAmount").getAsInt())
                .currencyId(userData.get("currencyId").getAsString())
                .netMiles(userData.get("netMiles").getAsInt())
                .netAmount(userData.get("netAmount").getAsDouble())
                .items(Arrays.asList(items))
                .commerce(commerce)
                .customer(customer)
                .terminal(userData.get("terminal").getAsString())
                .orderNumber(orderNumber)
                .build();
        Serenity.setSessionVariable("orderNumber").to(orderNumber);
        System.out.println(WebServiceEndPoints.API_EXCHANGE.getUrl());
        actor.attemptsTo(
                Put.to(WebServiceEndPoints.API_EXCHANGE.getUrl())
                        .with(requestSpecification -> requestSpecification
                                .relaxedHTTPSValidation()
                                .contentType(ContentType.JSON)
                                .pathParam("cardId", tarjeta)
                                .header("Authorization", "Bearer " + accessToken)
                                .header(SecurityCommons.API_IB_CLIENT_ID, SecurityCommons.API_IB_CLIENT_ID_UAT_VALUE)
                                .header("X-INT-Timestamp", "2020-04-07T16:40:48")
                                .header("X-INT-Message-Id", "CanjeMillasQA_" + messageIdDate)
                                .header("X-INT-Consumer-Id", finalclient)
                                .header("X-INT-Device-Id", SecurityCommons.IP_DEVICE_ID_TRX)
                                .body("exchange")
                        )
        );

        System.out.println(SerenityRest.lastResponse().body().prettyPrint());
        System.out.println("test");

    }
}
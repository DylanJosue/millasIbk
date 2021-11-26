package extorno;

import com.google.gson.JsonObject;
import io.restassured.response.Response;
import net.serenitybdd.rest.SerenityRest;
import org.junit.Assert;
import utils.WebServiceEndPoints;

public class ExtornoCanje {

    private Response r;
    private String ibClientIdUat = "d5d20dc03c31445298913f2f65790afa";
    private String ibClientIdDev = "891ba0eed8f04dd6bd8b69aa255e0db3";

    public void extornoCanje(String accessToken, String numeroTarjeta, String operationId, String codigoComercio, String nombreComercio, String externalTrxId) {

        System.out.println("\nAPI >>>>>>>>> " + WebServiceEndPoints.API_VISA.getUrl() + operationId + "/refund");

        JsonObject payload = new JsonObject();
        payload.addProperty("cardId", numeroTarjeta);

        JsonObject commerce = new JsonObject();
        commerce.addProperty("code", codigoComercio);
        commerce.addProperty("name", nombreComercio);

        payload.add("commerce", commerce);
        payload.addProperty("terminal", "77777777");
        payload.addProperty("externalTrxId", externalTrxId);

        System.out.println("\nPayload: " + payload);

        r = SerenityRest.given().log().all()
                .contentType("application/json")
                .header("Authorization", "Bearer " + accessToken)
                .header("X-IB-Client-Id", ibClientIdUat)
                .header("X-INT-Device-Id", "13.10.13.1")
                .header("X-INT-Timestamp", "2020-04-07T16:41:50")
                .header("X-INT-Consumer-Id", "NBZ")
                .header("X-INT-Message-Id", "2020040717050015555")
                .body(payload.toString())
                .when()
                .put(WebServiceEndPoints.API_VISA.getUrl() + operationId + "/refund");

        String response = r.getBody().asString();
        System.out.println("\nCurrent response >>>>>>>>> " + response);

    }

    public void validarExtorno(String millas, String consultaMillas) {

        r.then().statusCode(200);
        Assert.assertEquals(millas, consultaMillas);
        Assert.assertNotNull(r.jsonPath().get("operationId"));

    }

    public void extornoInvalido() {

        r.then().statusCode(403);
        Assert.assertEquals(r.jsonPath().get("httpMessage"), "Business error");

    }

}

package utils;

import io.restassured.RestAssured;
import io.restassured.response.Response;

import static io.restassured.RestAssured.given;

/**
 * @author Nilo Carrion
 */
public class SecurityCommons {

    public static final String API_AUTHORIZATION_HEADER = "Authorization";
    private static final String URL_API_UAT = "https://apis.uat.interbank.pe";
    //IB CLIENT ID UAT
    private static final String URL_TOKEN_SHOPSTAR_OAUTH = "/api/tokenbim/v1/oauth";
    private static final String URL_TOKEN_NIUBIZ_OAUTH = "/api/tokenbim/v1/oauth";
    public static final String URL_TOKEN_RAPPI_OAUTH = "/api/tokenbim/v1/oauth";
    //IB CLIENT ID UAT
    public static final String API_IB_CLIENT_ID = "X-IB-Client-Id";
    public static final String API_IB_CLIENT_ID_UAT_VALUE = "95014a21e1cb416da2d521cad8cf7ca8";
    //APPLICATION NIUBIZ
    private static final String APPLICATION_ID_NBZ = "NIUBIZ";
    private static final String APPLICATION_SECRET_NBZ = "Abc12345*";
    //APPLICATION RAPPI
    public static final String APPLICATION_ID_RAPPI = "RAPPI";
    public static final String APPLICATION_SECRET_RAPPI = "BenefitRappi*4_9";
    //APPLICATION RAPPI
    private static final String APPLICATION_ID_SHOPSTAR = "BENEFIT_SHOPSTAR";
    private static final String APPLICATION_SECRET_SHOPSTAR = "BenefitShopstar*1_521";
    //IPv4 del dispositivo donde se originó la trx
    public static final String IP_DEVICE_ID_TRX = "13.10.13.1";
    

    public static String generarAccessTokenNiubiz() {
        RestAssured.baseURI = URL_API_UAT;
        try {
            Response res = given()
                    .auth().preemptive().basic(APPLICATION_ID_NBZ, APPLICATION_SECRET_NBZ)
                    .contentType("application/x-www-form-urlencoded")
                    .formParam("grant_type", "client_credentials")
                    .formParam("scope", "read")
                    .header(API_IB_CLIENT_ID, API_IB_CLIENT_ID_UAT_VALUE)
                    .post(URL_TOKEN_NIUBIZ_OAUTH);
            String access_token = "Bearer " + res.then().extract().path("access_token");
            System.out.println("GENERAR TOKEN: " + access_token);
            return access_token;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static String generarAccessTokenRappi() {
        RestAssured.baseURI = URL_API_UAT;
        try {
            Response res = given()
                    .auth().preemptive().basic(APPLICATION_ID_RAPPI, APPLICATION_SECRET_RAPPI)
                    .contentType("application/x-www-form-urlencoded")
                    .formParam("grant_type", "client_credentials")
                    .formParam("scope", "read")
                    .header(API_IB_CLIENT_ID, API_IB_CLIENT_ID_UAT_VALUE)
                    .post(URL_TOKEN_RAPPI_OAUTH);

            String access_token = "Bearer " + res.then().extract().path("access_token");

            System.out.println("RAPPI GENERAR TOKEN: " + access_token);
            return access_token;

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static String generarAccessTokenShopstar() {
        RestAssured.baseURI = URL_API_UAT;
        try {
            Response res = given()
                    .auth().preemptive().basic(APPLICATION_ID_SHOPSTAR, APPLICATION_SECRET_SHOPSTAR)
                    .contentType("application/x-www-form-urlencoded")
                    .formParam("grant_type", "client_credentials")
                    .formParam("scope", "read")
                    .header(API_IB_CLIENT_ID, API_IB_CLIENT_ID_UAT_VALUE)
                    .post(URL_TOKEN_SHOPSTAR_OAUTH);

            String access_token = "Bearer " + res.then().extract().path("access_token");

            System.out.println("GENERAR TOKEN: " + access_token);
            return access_token;

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}

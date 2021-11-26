package tasks.rappi;

import io.restassured.http.ContentType;
import models.ValidacionRappiModels;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.Tasks;
import net.serenitybdd.screenplay.rest.interactions.Put;
import utils.ApiCommons;
import utils.WebServiceEndPoints;

/**
 * @author Nilo Carrion
 */
public class ValidateOTP implements Task {
    private static final String TEMPLATE_VALIDATE_CODE_OTP = "/templates/validateOTP-input.json";
    private String accessToken;
    private final String cliente;
    private final String documentType;
    private final String documentNumber;
    private final String activationCode;

    public ValidateOTP(String accessToken,String cliente,String documentType, String documentNumber, String activationCode) {
        this.accessToken = accessToken;
        this.cliente = cliente;
        this.documentType = documentType;
        this.documentNumber = documentNumber;
        this.activationCode = activationCode;
    }

    public static Performable validateCodeOTP(String accessToken,String cliente,String documentType, String documentNumber, String activationCode) {
        return Tasks.instrumented(ValidateOTP.class,accessToken,cliente, documentType, documentNumber, activationCode);
    }
    @Override
    public <T extends Actor> void performAs(T actor) {
        if (cliente.equals("NIUBIZ-E-COMMERCE")){
            actor.attemptsTo(
                    Put.to(WebServiceEndPoints.URL_VALIDATE_OTP.getUrl())
                            .with(requestSpecification -> requestSpecification
                                    .relaxedHTTPSValidation()
                                    .contentType(ContentType.JSON)
                                    .header("Authorization", "Bearer " + accessToken)
                                    .header("X-INT-Consumer-Id", cliente)
                                    .pathParam("identifier", "payment")
                                    .pathParam("documentType", documentType)
                                    .pathParam("documentNumber", documentNumber)
                                    .body(ApiCommons.getTemplate(TEMPLATE_VALIDATE_CODE_OTP)
                                            .replace("{activationCode}", activationCode)
                                    ))
            );
        }
        else {
            ValidacionRappiModels request = ValidacionRappiModels.builder()
                    .redirect("https://www.rappi.com.pe")
                    .activationCode(activationCode)
                    .build();
            actor.attemptsTo(
                    Put.to(WebServiceEndPoints.URL_VALIDATE_OTP.getUrl())
                            .with(requestSpecification -> requestSpecification
                                    .relaxedHTTPSValidation()
                                    .contentType(ContentType.JSON)
                                    .header("Authorization", "Bearer " + accessToken)
                                    .header("X-INT-Consumer-Id", cliente)
                                    .pathParam("identifier", "payment")
                                    .pathParam("documentType", documentType)
                                    .pathParam("documentNumber", documentNumber)
                                    .body(request))
            );
        }

    }
}

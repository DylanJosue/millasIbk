package tasks.rappi;

import io.restassured.http.ContentType;
import models.Commerce;
import models.EcommerceModels;
import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.Tasks;
import net.serenitybdd.screenplay.rest.interactions.Post;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import utils.WebServiceEndPoints;

/**
 * @author Nilo Carrion
 */
public class GenerateOTP implements Task {

    private static final Logger LOGGER = LoggerFactory.getLogger(GenerateOTP.class);

    private final String accessToken;
    private final String cliente;
    private final String documentType;
    private final String documentNumber;

    public GenerateOTP(String accessToken, String cliente, String documentType, String documentNumber) {
        this.accessToken = accessToken;
        this.cliente = cliente;
        this.documentType = documentType;
        this.documentNumber = documentNumber;
    }

    public static Performable generateCodeOTP(String accessToken, String cliente, String documentType, String documentNumber) {
        return Tasks.instrumented(GenerateOTP.class, accessToken, cliente, documentType, documentNumber);
    }

    @Override
    public <T extends Actor> void performAs(T actor) {

        LOGGER.info("ENDPOINT: " + WebServiceEndPoints.URL_GENERATE_OTP.getUrl());
        if(cliente.equals("NIUBIZ-E-COMMERCE")){
            Commerce comercio = Commerce.builder()
                    .code("1235")
                    .name("Comercio test")
                    .build();
            EcommerceModels comemodel = EcommerceModels.builder()
                    .commerce(comercio).build();
            actor.attemptsTo(Post.to(WebServiceEndPoints.URL_GENERATE_OTP.getUrl())
                    .with(requestSpecification -> requestSpecification
                            .relaxedHTTPSValidation()
                            .contentType(ContentType.JSON)
                            .header("Authorization", "Bearer " + accessToken)
                            .header("X-INT-Consumer-Id", cliente)
                            .pathParam("identifier", "payment")
                            .pathParam("documentType", documentType)
                            .pathParam("documentNumber", documentNumber)
                            .body(comemodel)
                    ));
        }
        else
            {
                actor.attemptsTo(Post.to(WebServiceEndPoints.URL_GENERATE_OTP.getUrl())
                        .with(requestSpecification -> requestSpecification
                                .relaxedHTTPSValidation()
                                .contentType(ContentType.JSON)
                                .header("Authorization", "Bearer " + accessToken)
                                .header("X-INT-Consumer-Id", cliente)
                                .pathParam("identifier", "payment")
                                .pathParam("documentType", documentType)
                                .pathParam("documentNumber", documentNumber)
                                .body("{}")
                        ));
            }
        LOGGER.info("LOG " + SerenityRest.lastResponse().body().prettyPrint());
    }

}

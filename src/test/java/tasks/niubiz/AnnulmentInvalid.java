package tasks.niubiz;

import io.restassured.http.ContentType;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.Tasks;
import net.serenitybdd.screenplay.rest.interactions.Put;
import utils.ApiCommons;
import utils.SecurityCommons;

/**
 * @author Nilo Carrion
 */
public class AnnulmentInvalid implements Task {

    private static final String URL_ANNULMENT_INVALID_OPERATION_ID = "/benefit/millas/v1/{operationId}/annulment";
    private static final String TEMPLATE_ANULACION_MILLAS = "/templates/anulacionMillas-input.json";

    private final String operationId;
    private final String cardNumber;
    private final String commerceCode;
    private final String commerceName;
    private final String annulmentTerminal;
    private final String annulmentExternalTrxId;

    public AnnulmentInvalid(String operationId, String cardNumber, String commerceCode, String commerceName, String annulmentTerminal, String annulmentExternalTrxId) {
        this.operationId = operationId;
        this.cardNumber = cardNumber;
        this.commerceCode = commerceCode;
        this.commerceName = commerceName;
        this.annulmentTerminal = annulmentTerminal;
        this.annulmentExternalTrxId = annulmentExternalTrxId;
    }

    @Override
    public <T extends Actor> void performAs(T actor) {
        actor.attemptsTo(Put.to(URL_ANNULMENT_INVALID_OPERATION_ID)
                .with(request -> request
                        .contentType(ContentType.JSON)
                        .pathParam("operationId", operationId)
                        .header(SecurityCommons.API_AUTHORIZATION_HEADER, SecurityCommons.generarAccessTokenNiubiz())
                        .header(SecurityCommons.API_IB_CLIENT_ID, SecurityCommons.API_IB_CLIENT_ID_UAT_VALUE)
                        .header("X-INT-Timestamp", "2020-04-07T16:43:30")
                        .header("X-INT-Message-Id", "202004071656002332332")
                        .header("X-INT-Consumer-Id", "NBZ")
                        .header("X-INT-Device-Id", SecurityCommons.IP_DEVICE_ID_TRX)
                        .body(ApiCommons.getTemplate(TEMPLATE_ANULACION_MILLAS)
                                .replace("{cardNumber}", cardNumber)
                                .replace("{commerceCode}", commerceCode)
                                .replace("{commerceName}", commerceName)
                                .replace("{annulmentTerminal}", annulmentTerminal)
                                .replace("{annulmentExternalTrxId}", annulmentExternalTrxId)
                        )));

    }

    public static Performable invalid(String operationId, String cardNumber, String commerceCode, String commerceName, String annulmentTerminal, String annulmentExternalTrxId) {
        return Tasks.instrumented(AnnulmentInvalid.class, operationId, cardNumber, commerceCode, commerceName, annulmentTerminal, annulmentExternalTrxId);
    }

}

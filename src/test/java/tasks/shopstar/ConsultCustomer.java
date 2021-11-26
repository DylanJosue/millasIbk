package tasks.shopstar;

import io.restassured.http.ContentType;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.Tasks;
import net.serenitybdd.screenplay.rest.interactions.Post;
import utils.ApiCommons;
import utils.SecurityCommons;

/**
 * @author Nilo Carrion
 */
public class ConsultCustomer implements Task {

    private static final String URL_CONSULT_CUSTOMER = "/api/customer-tec/v1/full-info/{channelI}";
    private static final String TEMPLATE_CONSULT_CUSTOMER = "/templates/consultCustomer-input.json";

    private final String status;
    private final String flgConsent;
    private final String searchKey;
    private final String startDate;
    private final String endDate;
    private final String page;
    private final String size;
    private final String direction;

    public ConsultCustomer(String status, String flgConsent, String searchKey, String startDate, String endDate, String page, String size, String direction) {
        this.status = status;
        this.flgConsent = flgConsent;
        this.searchKey = searchKey;
        this.startDate = startDate;
        this.endDate = endDate;
        this.page = page;
        this.size = size;
        this.direction = direction;
    }

    @Override
    public <T extends Actor> void performAs(T actor) {
        actor.attemptsTo(Post.to(URL_CONSULT_CUSTOMER)
                .with(request -> request
                        .contentType(ContentType.JSON)
                        .pathParam("channelI", "BIM")
                        .header("Authorization", SecurityCommons.generarAccessTokenRappi())
                        .header(SecurityCommons.API_IB_CLIENT_ID, "8c6ad2e1524542549e7bc1e4476abfc7")
                        .body(ApiCommons.getTemplate(TEMPLATE_CONSULT_CUSTOMER)
                                .replace("{status}", status)
                                .replace("{flgConsent}", flgConsent)
                                .replace("{searchKey}", searchKey)
                                .replace("{startDate}", startDate)
                                .replace("{endDate}", endDate)
                                .replace("{page}", page)
                                .replace("{size}", size)
                                .replace("{direction}", direction)
                        )));

    }

    public static Performable consultCustomer(String status, String flgConsent, String searchKey, String startDate, String endDate, String page, String size, String direction) {
        return Tasks.instrumented(ConsultCustomer.class, status, flgConsent, searchKey, startDate, endDate, page, size, direction);
    }

}

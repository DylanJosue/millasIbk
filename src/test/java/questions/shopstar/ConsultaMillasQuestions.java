package questions.shopstar;

import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.Question;

public class ConsultaMillasQuestions {

    public static Question<String> responseAccesToken() {
        return Question.about("Mensaje de respuesta")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("access_token")
                );
    }

    public static Question<String> responseDocumentType() {
        return Question.about("Mensaje de las millas")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("documentType")
                );
    }

    public static Question<String> responseDocumentNumber() {
        return Question.about("Mensaje de autorización")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("documentNumber")
                );
    }

    public static Question<String> responseCustomerId() {
        return Question.about("Mensaje de tipo de documento")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("customerId")
                );
    }

    public static Question<String> responseStatus() {
        return Question.about("Mensaje de número de documento")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("status")
                );
    }
    
}

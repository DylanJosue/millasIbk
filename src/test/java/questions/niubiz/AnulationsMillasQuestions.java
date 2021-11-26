package questions.niubiz;

import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.Question;

public class AnulationsMillasQuestions {

    public static Question<String> messageResponse() {
        return Question.about("Mensaje de respuesta")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("message")
                );
    }

    public static Question<String> responseMillas() {
        return Question.about("Mensaje de las millas")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("response.mile.miles")
                );
    }

    public static Question<String> responseAutorizations() {
        return Question.about("Mensaje de autorización")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("response.authorizationCode")
                );
    }

    public static Question<String> responseType() {
        return Question.about("Mensaje de tipo de documento")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("response.customer.documentType")
                );
    }

    public static Question<String> responseNumber() {
        return Question.about("Mensaje de número de documento")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("response.customer.documentNumber")
                );
    }

    public static Question<String> responseCustomer() {
        return Question.about("Mensaje de número de cu")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("response.customer.customerId")
                );
    }

    public static Question<String> responseOperations() {
        return Question.about("Mensaje de date de operación")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("response.operationDate")
                );
    }

}

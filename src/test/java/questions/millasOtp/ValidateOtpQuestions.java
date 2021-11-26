package questions.millasOtp;

import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.Question;

public class ValidateOtpQuestions {

    public static Question<String> responseDocumentType() {
        return Question.about("Tipo de documento")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("response.customer.documentType")
                );
    }

    public static Question<String> responseDocumentNumber() {
        return Question.about("Número de documento")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("response.customer.documentNumber")
                );
    }

    public static Question<String> responseCodigoUnico() {
        return Question.about("Código único")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("response.customer.customerId")
                );
    }

    public static Question<String> responseCustomerKey() {
        return Question.about("Código cliente llave")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("response.customer.id")
                );
    }

    public static Question<String> responseMessage() {
        return Question.about("Mensaje")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("message")
                );
    }
    
}

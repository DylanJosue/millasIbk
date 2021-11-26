package questions.millasOtp;

import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.Question;

public class LoginOtpQuestions {

    public static Question<String> responseDocumentType() {
        return Question.about("Tipo de documento")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("response.customer.identityDocument.type")
                );
    }

    public static Question<String> responseDocumentNumber() {
        return Question.about("Numero de documento")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("response.customer.identityDocument.id")
                );
    }

    public static Question<String> responseCustomerId() {
        return Question.about("Código único")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("response.customer.customerId")
                );
    }

    public static Question<String> responseOperator() {
        return Question.about("Operador")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("response.customer.cellPhone.operator")
                );
    }

    public static Question<String> responseNumberPhone() {
        return Question.about("Numero de celular")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("response.customer.cellPhone.numberObfuscated")
                );
    }

    public static Question<String> responseMessage() {
        return Question.about("Mensaje")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("message")
                );
    }

    public static Question<String> responseCode() {
        return Question.about("Codigo de Identificación")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("code")
                );
    }

    public static Question<String> responseEstatusActive() {
        return Question.about("Estado activo")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("response.customer.status")
                );
    }

}

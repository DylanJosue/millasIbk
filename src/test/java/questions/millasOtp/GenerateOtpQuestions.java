package questions.millasOtp;

import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.Question;

public class GenerateOtpQuestions {

    public static Question<String> responseCustomerKey() {
        return Question.about("Código cliente llave")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("response.customer.id")
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

    public static Question<String> responseNameOperator() {
        return Question.about("Nombre de Operador")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("response.customer.cellPhone.operatorName")
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

    public static Question<String> responseCustomerId() {
        return Question.about("Código unico")
                .answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("response.customer.customerId")
                );
    }

}

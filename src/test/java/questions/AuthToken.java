package questions;

import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.Question;

/**
 * @author César Ilachoque
 */

public class AuthToken {

    public static Question<String> accessToken() {
        return Question.about("Access Token").
                answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("access_token")
                );
    }

    public static Question<String> refreshToken() {
        return Question.about("refresh Token").
                answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("refresh_token")
                );
    }

    public static Question<String> tipoDocumento() {
        return Question.about("Tipo documento").
                answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("documentType")
                );
    }

    public static Question<String> numeroDocumento() {
        return Question.about("Número documento").
                answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("documentNumber")
                );
    }

    public static Question<String> codigoUnico() {
        return Question.about("Código único").
                answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("customerId")
                );
    }

    public static Question<String> typoToken() {
        return Question.about("tipoToken").
                answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("token_type")
                );
    }

    public static Question<String> granTipo() {
        return Question.about("tipoToken").
                answeredBy(
                        actor -> SerenityRest.lastResponse().jsonPath().getString("grant_type")
                );
    }
}

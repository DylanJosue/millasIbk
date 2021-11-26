package stepsdefinitions.documento;

import io.cucumber.java.en.And;
import io.cucumber.java.en.When;
import net.serenitybdd.core.Serenity;
import org.hamcrest.Matchers;
import org.hamcrest.core.IsNot;
import questions.niubiz.CanjeMillasQuestions;
import tasks.documents.ExchangeMilesDocumentos;
import tasks.shopstar.ExchangeMiles;
import tasks.shopstar.GenerarToken;

import java.text.SimpleDateFormat;
import java.util.Date;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.core.IsEqual.equalTo;
import static org.hamcrest.text.IsEmptyString.isEmptyOrNullString;

/**
 * @author Cesar Ilachoque
 */
public class ExchangeCanjeMilesStepDefinition {

//    @When("^el usuario ingresa su código unico (.*) para obtener el token$")
//    public void insertCustomerId(String customerId) {
//        theActorInTheSpotlight().attemptsTo(
//                GenerarToken.generateToken(customerId)
//        );
//    }

    @When("^se realiza el canje de millas para cliente ingresando (.*), (.*), (.*), (.*), (.*) items (.*), (.*), (.*), (.*)y (.*)$")
    public void insertDataExchangeMiles(String totalMiles, String totalAmount, String currencyIdOne, String quantityMiles, String netAmount, String identifier, String description, String quantity, String amount, String currencyIdTwo) {
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String cliente = Serenity.sessionVariableCalled("cliente");
        Date date  = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("ddMMyyyyhhmmss");
        String messageIdDate = dateFormat.format(date);
        theActorInTheSpotlight().attemptsTo(
                ExchangeMilesDocumentos.exchangeMiles(accessToken,cliente,messageIdDate,totalMiles, totalAmount, currencyIdOne, quantityMiles, netAmount, identifier, description, quantity, amount, currencyIdTwo)
        );


    }
    @When("^se realiza el canje de millas sin enviar ordernumber para cliente ingresando (.*), (.*), (.*), (.*), (.*) items (.*), (.*), (.*), (.*)y (.*)$")
    public void insertDataExchangeMilesSinON(String totalMiles, String totalAmount, String currencyIdOne, String quantityMiles, String netAmount, String identifier, String description, String quantity, String amount, String currencyIdTwo) {
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String cliente = Serenity.sessionVariableCalled("cliente");
        theActorInTheSpotlight().attemptsTo(
                ExchangeMilesDocumentos.exchangeMiles(accessToken,cliente,"",totalMiles, totalAmount, currencyIdOne, quantityMiles, netAmount, identifier, description, quantity, amount, currencyIdTwo)
        );


    }
    @When("^se realiza el canje de millas con enviar ordernumber mas de 50 caracteres para cliente ingresando (.*), (.*), (.*), (.*), (.*) items (.*), (.*), (.*), (.*)y (.*)$")
    public void insertDataExchangeMiles50(String totalMiles, String totalAmount, String currencyIdOne, String quantityMiles, String netAmount, String identifier, String description, String quantity, String amount, String currencyIdTwo) {
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String cliente = Serenity.sessionVariableCalled("cliente");
        theActorInTheSpotlight().attemptsTo(
                ExchangeMilesDocumentos.exchangeMiles(accessToken,cliente,"123456789012345678901234567890123456789012345678901",totalMiles, totalAmount, currencyIdOne, quantityMiles, netAmount, identifier, description, quantity, amount, currencyIdTwo)
        );
    }
    @When("^se realiza el canje de millas con enviando mismo ordernumber para cliente ingresando (.*), (.*), (.*), (.*), (.*) items (.*), (.*), (.*), (.*)y (.*)$")
    public void insertDataExchangeMilesDOBLE(String totalMiles, String totalAmount, String currencyIdOne, String quantityMiles, String netAmount, String identifier, String description, String quantity, String amount, String currencyIdTwo) {
        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String cliente = Serenity.sessionVariableCalled("cliente");
        theActorInTheSpotlight().attemptsTo(
                ExchangeMilesDocumentos.exchangeMiles(accessToken,cliente,"1234567890",totalMiles, totalAmount, currencyIdOne, quantityMiles, netAmount, identifier, description, quantity, amount, currencyIdTwo)
        );
    }
//    @And("^validamos el canje de millas es satisfactorio con el mensaje (.*)$")
//    public void validateMessage(String message) {
//
//        theActorInTheSpotlight().should(
//                seeThat("El mensaje es ", CanjeMillasQuestions.messageResponse(), containsString(message)),
//                seeThat("Millas", CanjeMillasQuestions.responseMillas(), IsNot.not(isEmptyOrNullString())),
//                seeThat("Neto de millas", CanjeMillasQuestions.responseNetMillas(), IsNot.not(isEmptyOrNullString())),
//                seeThat("Mensaje de autorización", CanjeMillasQuestions.responseAutorizations(), Matchers.not(Matchers.isEmptyString()))
//               );
//
//        Serenity.setSessionVariable("authorizationCode").to(theActorInTheSpotlight().asksFor(CanjeMillasQuestions.responseAutorizations()));
//        Serenity.setSessionVariable("operationDate").to(theActorInTheSpotlight().asksFor(CanjeMillasQuestions.responseOperations()));
//    }
//    @And("^validamos el response con datos del cliente: tipo documento (.*), número documento (.*) y el código único (.*)$")
//    public void validateMessage(String documentType,String documentNumber,String customerId) {
//        theActorInTheSpotlight().should(
//                seeThat("Mensaje de typo de documento", CanjeMillasQuestions.responseType(), equalTo(documentType)),
//                seeThat("Mensaje de número de documento", CanjeMillasQuestions.responseNumber(), equalTo(documentNumber)),
//                seeThat("Mensaje de date de operación", CanjeMillasQuestions.responseCustomer(), equalTo(customerId))
//        );
//    }

}

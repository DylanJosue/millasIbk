package stepsdefinitions.shopstar;

import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import net.serenitybdd.rest.SerenityRest;
import org.junit.Assert;
import tasks.shopstar.ConsultCustomer;
import utils.ApiCommons;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.rest.questions.ResponseConsequence.seeThatResponse;
import static org.hamcrest.core.IsNot.not;
import static org.hamcrest.text.IsEmptyString.isEmptyString;

/**
 * @author Nilo Carrion
 */
public class ConsultCustomerStepDefinition {

    @When("^el cliente consulta (.*), (.*), (.*), (.*), (.*), (.*), (.*) y (.*)$")
    public void consultaCliente(String status, String flgConsent, String searchKey, String startDate, String endDate, String page, String size, String direction) {
        theActorInTheSpotlight().attemptsTo(ConsultCustomer.consultCustomer(status, flgConsent, searchKey, startDate, endDate, page, size, direction));
    }

    @Then("valida la consulta es satisfactorio")
    public void validaConsultaSatisfactorio() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
        String customerId = SerenityRest.lastResponse().path("content.customerId").toString();
        String documentNumber = SerenityRest.lastResponse().path("content.identityDocument.id").toString();
        String documentType = SerenityRest.lastResponse().path("content.identityDocument.type").toString();
        String status = SerenityRest.lastResponse().path("content.status").toString();
        String dateCreation = SerenityRest.lastResponse().path("content.dateCreation").toString();
        Assert.assertThat(customerId, not(isEmptyString()));
        Assert.assertThat(documentNumber, not(isEmptyString()));
        Assert.assertThat(documentType, not(isEmptyString()));
        Assert.assertThat(status, not(isEmptyString()));
        Assert.assertThat(dateCreation, not(isEmptyString()));
    }

    @Then("valida consulta con codigo unico")
    public void validaConsultaConCodigoUnico() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
        String customerId = SerenityRest.lastResponse().path("content.customerId").toString();
        Assert.assertThat(customerId, not(isEmptyString()));
    }

    @Then("valida consulta con correo electronico")
    public void validaConsultaCorreoElectronico() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
        String email = SerenityRest.lastResponse().path("content.email").toString();
        Assert.assertThat(email, not(isEmptyString()));
    }

    @Then("valida la consulta con id bim")
    public void validaConsultaConIdBim() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
        String idBim = SerenityRest.lastResponse().path("content.id").toString();
        Assert.assertThat(idBim, not(isEmptyString()));
    }

    @Then("valida consulta por primer y segunda nombre del cliente")
    public void validaConsultaPorPrimerSegundaNombreCliente() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
        String firstName = SerenityRest.lastResponse().path("content.firstName").toString();
        String secondName = SerenityRest.lastResponse().path("content.secondName").toString();
        Assert.assertThat(firstName, not(isEmptyString()));
        Assert.assertThat(secondName, not(isEmptyString()));
    }

    @Then("valida consulta por primer y segunda apellido del cliente")
    public void validaConsultaPorPrimerSegundaApellidoCliente() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
        String lastName = SerenityRest.lastResponse().path("content.lastName").toString();
        String secondLastName = SerenityRest.lastResponse().path("content.secondLastName").toString();
        Assert.assertThat(lastName, not(isEmptyString()));
        Assert.assertThat(secondLastName, not(isEmptyString()));
    }

    @Then("valida consulta por nombre y apellido completo del cliente")
    public void validaConsultaNombreApellidoCompletoCliente() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
    }

    @Then("valida consulta valores coincidencias")
    public void validaConsultaValoresCoincidencias() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
    }

    @Then("valida consulta con numero documento DNI no existe")
    public void validaConsultaNumeroDocumentoDNINoExiste() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
    }

    @Then("valida consulta con numero documento valor vacio")
    public void validaConsultaNumeroDocumentoValorVacio() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
        String documentNumber = SerenityRest.lastResponse().path("content.identityDocument.id").toString();
        String documentType = SerenityRest.lastResponse().path("content.identityDocument.type").toString();
        Assert.assertThat(documentNumber, not(isEmptyString()));
        Assert.assertThat(documentType, not(isEmptyString()));
    }

    @Then("valida consulta con fecha de cambio de password")
    public void validaConsultaFechaCambioPassword() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
        String changePasswordDate = SerenityRest.lastResponse().path("content.changePasswordDate").toString();
        Assert.assertThat(changePasswordDate, not(isEmptyString()));
    }

    @Then("valida consulta con estados")
    public void validaConsultaConEstados() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
        String status = SerenityRest.lastResponse().path("content.status").toString();
        Assert.assertThat(status, not(isEmptyString()));
    }

    @Then("valida consulta con autorizacion de tratamiento de datos")
    public void validaConsultaAutorizacionTratamientoDatos() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
        String status = SerenityRest.lastResponse().path("content.flgConsent").toString();
        Assert.assertThat(status, not(isEmptyString()));
    }

    @Then("valida consulta por rango de fechas")
    public void validaConsultaRangoFechas() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
        String dateCreation = SerenityRest.lastResponse().path("content.dateCreation").toString();
        Assert.assertThat(dateCreation, not(isEmptyString()));
    }

    @Then("valida consulta de forma paginable")
    public void validaConsultaFormaPaginable() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
        String pageNumber = SerenityRest.lastResponse().path("pageable.pageNumber").toString();
        String numberOfElements = SerenityRest.lastResponse().path("numberOfElements").toString();
        Assert.assertThat(pageNumber, not(isEmptyString()));
        Assert.assertThat(numberOfElements, not(isEmptyString()));
    }

    @Then("valida consulta de forma ascendente y descendente")
    public void validaConsultaFormaAscendenteDescendente() {
        theActorInTheSpotlight().should(seeThatResponse(response -> response.statusCode(ApiCommons.STATUS_CODE_OK)));
        String dateCreation = SerenityRest.lastResponse().path("content.dateCreation").toString();
        Assert.assertThat(dateCreation, not(isEmptyString()));
    }

}

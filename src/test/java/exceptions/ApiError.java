package exceptions;

import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Question;
import org.apache.commons.lang3.StringUtils;
import utils.ApiCommons;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author Nilo Carrion
 */
public class ApiError implements Question<Boolean> {

    private final List<String> errorCodes;
    private final List<Integer> httpStatusCodes;
    private String errorMessage;

    private ApiError(Integer... httpStatusCodes) {
        this.httpStatusCodes = new ArrayList<>();
        this.errorCodes = new ArrayList<>();
        this.httpStatusCodes.addAll(Arrays.asList(httpStatusCodes));
    }

    public static ApiError inAsyncCall() {
        return new ApiError(ApiCommons.STATUS_CODE_OK);
    }

    public static ApiError inSyncCall(Integer statusCodeOk) {
        return new ApiError(statusCodeOk);
    }

    public static ApiError inAsyncOrSyncCall(Integer statusCodeOk) {
        return new ApiError(ApiCommons.STATUS_CODE_OK, statusCodeOk);
    }

    @Override
    public Boolean answeredBy(Actor actor) {
        Integer status = SerenityRest.lastResponse().getStatusCode();

        if (errorCodes.size() > 0 || StringUtils.isNotEmpty(errorMessage)) {
            String code = SerenityRest.lastResponse().jsonPath().get(isAsyncCall(status) ? "correlation.error.code" : "code");
            String message = SerenityRest.lastResponse().jsonPath().get(isAsyncCall(status) ? "correlation.error.message" : "message");

            if (errorCodes.size() > 0 && !errorCodes.contains(code))
                return false;

            if (isAsyncCall(status) && !SerenityRest.lastResponse().jsonPath().get("correlation.status").equals("FAILED"))
                return false;

            if (errorMessage != null && !errorMessage.equals(message))
                return false;
        }

        return httpStatusCodes.contains(status);
    }

    private boolean isAsyncCall(Integer status) {
        return status.equals(ApiCommons.STATUS_CODE_OK);
    }

    public ApiError message(String errorMessage) {
        this.errorMessage = errorMessage;
        return this;
    }

    public ApiError codes(String... codes) {
        this.errorCodes.addAll(Arrays.asList(codes));
        return this;
    }

}

package utils;

import org.apache.commons.io.IOUtils;
import org.springframework.core.io.ClassPathResource;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

/**
 * @author Nilo Carrion
 */
public class ApiCommons {

    public static final String API_CORRELATION_HEADER = "X-Correlation-Id";
    private static final String KEY_CORRELATION_ID = "correlationID";
    public static final int STATUS_CODE_UNAUTHORIZED = 401;
    public static final int STATUS_CODE_NOT_FOUND = 404;
    public static final int STATUS_CODE_OK = 200;
    public static final int STATUS_CODE_CREATED = 201;
    public static final int ACCEPTED = 202;
    public static final int STATUS_CODE_FORBIDDEN = 403;
    public static final int STATUS_CODE_SERVICE_UNAVAILABLE = 503;
    public static final int STATUS_CODE_BAD_REQUEST = 400;
    public static final int STATUS_CODE_PRECONDITION_FAILED = 412;
    public static final int STATUS_CODE_CONFLICT = 409;
    public static final int STATUS_CODE_UNPROCESSABLE_ENTITY = 422;
    public static final int STATUS_CODE_INTERNAL_SERVER_ERROR = 500;


    public static String getTemplate(String templatePath) {
        try {
            return IOUtils.toString(new ClassPathResource(templatePath).getInputStream(), StandardCharsets.UTF_8);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

}

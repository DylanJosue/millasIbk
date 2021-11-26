package utils;

public enum WebServiceEndPoints {

    GENERATE_TOKEN("/api/tokenbim/v1/oauth"),
    GENERATE_TOKEN_AUTHORIZATION("/api/tokenbim/v2/oauth"),
    API_VISA("https://apis.uat.interbank.pe/benefit/millas/v1/"),
    API_CONSULTA("/benefit-miles/v1/{cardId}"),
    API_CONSULT_MILLAS_DOCUMENT("/benefit-miles/v1/customers"),
    API_ANULATIONS("/benefit-miles/v1/{authorizationCode}/annulment"),
    API_EXCHANGE("/benefit-miles/v1/{cardId}/exchange"),
    API_EXCHANGE_SHOPSTAR("/benefit/millas/v2/exchange"),
    API_EXCHANGE_CARDS("/benefit-miles/v1/exchange"),
    API_ANNULMENTMILES_SHOPSTAR("/benefit/millas/v2/{authorizationCode}/annulment"),
    API_ANNULMENTMILES_DOCUMENT("/benefit-miles/v1/{authorizationCode}/refund"),
    URL_CUSTOMER_LOGIN("/api/sec-user/v2/login/{documentType}/{documentNumber}"),
    URL_GENERATE_OTP("/api/customer-tec/v2/{identifier}/{documentType}/{documentNumber}/codeOtp"),
    URL_VALIDATE_OTP("/api/customer-tec/v2/codeOtp/{identifier}/{documentType}/{documentNumber}");

    private final String url;

    WebServiceEndPoints(String url) {
        this.url = url;
    }

    public String getUrl() {
        return url;
    }

}

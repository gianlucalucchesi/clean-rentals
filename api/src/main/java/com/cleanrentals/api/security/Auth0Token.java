package com.cleanrentals.api.security;

import antlr.Token;
import com.google.gson.Gson;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;

public class Auth0Token {
    /**
     * Get Auth0 management api access tokens for production
     * https://auth0.com/docs/security/tokens/access-tokens/get-management-api-access-tokens-for-production
     * @return Auth0 management token
     * @throws UnirestException
     */
    public static String ClaimAccessToken() throws UnirestException {

        String clientId = System.getenv("AUTH0_CLIENT_ID");
        String clientSecret = System.getenv("AUTH0_CLIENT_SECRET");
        String audience = System.getenv("AUTH0_DOMAIN");

        HttpResponse<String> response = Unirest.post(audience + "oauth/token")
                .header("content-type", "application/x-www-form-urlencoded")
                .body("grant_type=client_credentials&client_id=" + clientId + "&client_secret=" + clientSecret +
                        "&audience=" + audience + "api/v2/")
                .asString();

        TokenDTO token = new Gson().fromJson(response.getBody(), TokenDTO.class);

        return token.access_token;
    }
}

/**
 * Token model for Json deserialization
 */
class TokenDTO {
    public String access_token;
}

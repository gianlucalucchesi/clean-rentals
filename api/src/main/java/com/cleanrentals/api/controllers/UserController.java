package com.cleanrentals.api.controllers;

import com.cleanrentals.api.security.Auth0Token;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@RestController
@RequestMapping(path = "api/v1/user", produces = MediaType.APPLICATION_JSON_VALUE)
@CrossOrigin(origins = "*")
public class UserController {

    /**
     * Get all Auth0 users
     * @return user list
     * @throws IOException
     * @throws UnirestException
     */
    @GetMapping
    public String getUserInfo() throws IOException, UnirestException {
        String accessToken = Auth0Token.ClaimAccessToken();
        String domain = System.getenv("AUTH0_DOMAIN");

        HttpResponse<String> response = Unirest.get(domain + "/api/v2/users")
                .header("authorization", "Bearer " + accessToken)
                .asString();

        // TODO: if needed -> create user (DTO) model and deserialize
        return response.getBody();
    }
}

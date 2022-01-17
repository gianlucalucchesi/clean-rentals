package com.cleanrentals.api.controllers;

import com.cleanrentals.api.security.Auth0Token;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;
import io.swagger.annotations.Api;
import org.springframework.http.MediaType;
import org.springframework.security.core.parameters.P;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@RestController
@RequestMapping(path = "api/v1/user", produces = MediaType.APPLICATION_JSON_VALUE)
@CrossOrigin(origins = "*")
@Api(tags="User") // Swagger doc
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

    /**
     * Get Auth0 user
     * @param user_id Auth0 user id
     * @return Auth0 user
     * @throws UnirestException
     */
    @GetMapping(value = "{user_id}")
    public String getUser(@PathVariable String user_id) throws UnirestException {
        String accessToken = Auth0Token.ClaimAccessToken();
        String domain = System.getenv("AUTH0_DOMAIN");

        // Had to hardcode "auth0|" from actual auth0 user_id because of pipe encoding error in Postman
        // TODO: remove hardcoded part if not an issue in front-end
        HttpResponse<String> response = Unirest.get(domain + "/api/v2/users/auth0|" + user_id)
                .header("authorization", "Bearer " + accessToken)
                .asString();

        return response.getBody();
    }

    /**
     * Get user permissions for specific Auth0 user
     * https://auth0.com/docs/authorization/rbac/rbac-users/view-user-permissions
     * @param user_id Auth0 user id
     * @return
     * @throws UnirestException
     */
    @GetMapping(value = "{user_id}/permissions")
    public String getUserPermissions(@PathVariable String user_id) throws UnirestException {
        String accessToken = Auth0Token.ClaimAccessToken();
        String domain = System.getenv("AUTH0_DOMAIN");

        // Had to hardcode "auth0|" from actual auth0 user_id because of pipe encoding error in Postman
        // TODO: remove hardcoded part if not an issue with front-end
        HttpResponse<String> response = Unirest.get(domain + "/api/v2/users/auth0|" + user_id + "/permissions")
                .header("authorization", "Bearer " + accessToken)
                .asString();

        return response.getBody();
    }

    /**
     * Get user roles for specific Auth0 user
     * https://auth0.com/docs/users/view-user-roles
     * @param user_id
     * @return
     */
    @GetMapping(value = "{user_id}/roles")
    public String getUserRoles(@PathVariable String user_id) throws UnirestException {
        String accessToken = Auth0Token.ClaimAccessToken();
        String domain = System.getenv("AUTH0_DOMAIN");

        // Had to hardcode "auth0|" from actual auth0 user_id because of pipe encoding error in Postman
        // TODO: remove hardcoded part if not an issue with front-end
        HttpResponse<String> response = Unirest.get(domain + "/api/v2/users/auth0|" + user_id + "/roles")
                .header("authorization", "Bearer " + accessToken)
                .asString();

        return response.getBody();
    }

    // TODO: Remove role from specific auth0 user https://auth0.com/docs/users/remove-roles-from-users
    // TODO: Assign role to specific auth0 user https://auth0.com/docs/users/assign-roles-to-users
    // TODO: Update auth0 user info https://auth0.com/docs/users/metadata/manage-metadata-api
    // TODO: Delete auth0 user by id https://auth0.com/docs/api/management/v2#!/Users/delete_users_by_id
}

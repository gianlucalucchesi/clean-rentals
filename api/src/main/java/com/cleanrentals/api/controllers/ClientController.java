package com.cleanrentals.api.controllers;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.Client;
import com.cleanrentals.api.services.ClientService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@CrossOrigin
@RequestMapping("/api/v1/client")
@Api(tags = "Client") // Swagger doc
public class ClientController {
    @Autowired
    private ClientService clientService;

    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public List<Client> get() {
        return this.clientService.findAll();
    }

    @GetMapping("private/{id}")
    @ResponseStatus(HttpStatus.OK)
    public Client get(@PathVariable UUID id) throws NotFoundException {
        return this.clientService.findById(id);
    }

    @GetMapping("private/auth0/{id}")
    @ResponseStatus(HttpStatus.OK)
    public Client getByAuth0Id(@PathVariable String id) throws NotFoundException {
        return this.clientService.findByAuth0Id(id);
    }

    @PostMapping("private")
    @ResponseStatus(HttpStatus.CREATED)
    public Client create(@RequestBody Client client) throws ConflictException, NotFoundException {
        return this.clientService.create(client);
    }

    @PutMapping("private")
    @ResponseStatus(HttpStatus.OK)
    public Client update(@RequestBody Client client) throws NotFoundException {
        return this.clientService.update(client);
    }
}

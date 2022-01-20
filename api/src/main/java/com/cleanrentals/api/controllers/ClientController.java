package com.cleanrentals.api.controllers;

import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.Client;
import com.cleanrentals.api.repositories.ClientRepository;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@RestController
@CrossOrigin
@RequestMapping("/api/v1/client")
@Api(tags="Client") // Swagger doc
public class ClientController {
    @Autowired
    private ClientRepository clientRepository;

    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<List<Client>> get() {
        List<Client> clients = clientRepository.findAll();
        return new ResponseEntity<List<Client>>(clients, HttpStatus.OK);
    }

    @GetMapping("private/{id}")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<Client> get(@PathVariable UUID id) throws NotFoundException {
        Optional<Client> optionalClient = clientRepository.findById(id);

        if (optionalClient.isEmpty()) {
            throw new NotFoundException(String.format("Client with id %s not found", id));
        }

        return new ResponseEntity<Client>(optionalClient.get(), HttpStatus.OK);
    }

    @GetMapping("private/auth0/{id}")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<Client> getByAuth0Id(@PathVariable String id) throws NotFoundException {
        Optional<Client> optionalClient = clientRepository.findByAuth0Id(id);

        if (optionalClient.isEmpty()) {
            throw new NotFoundException(String.format("Client with Auth0 id %s not found", id));
        }

        return new ResponseEntity<Client>(optionalClient.get(), HttpStatus.OK);
    }
}
package com.cleanrentals.api.services;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.Client;
import com.cleanrentals.api.repositories.ClientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class ClientService {
    @Autowired
    private ClientRepository clientRepository;

    public List<Client> findAll() {
        return this.clientRepository.findAll();
    }

    public Client findById(UUID id) throws NotFoundException {
        Optional<Client> optionalClient = clientRepository.findById(id);

        if (optionalClient.isEmpty()) {
            throw new NotFoundException(String.format("Client with id %s not found", id));
        }

        return optionalClient.get();
    }

    public Client findByAuth0Id(String auth0Id) throws NotFoundException {
        Optional<Client> optionalClient = this.clientRepository.findByAuth0Id(auth0Id);

        if (optionalClient.isEmpty())
            throw new NotFoundException(String.format("Client with Auth0 id %s not found", auth0Id));

        return optionalClient.get();
    }

    public Client create(Client client) throws ConflictException {
        Optional<Client> optionalClient = this.clientRepository.findByAuth0Id(client.getAuth0Id());

        if (optionalClient.isPresent())
            throw new ConflictException(String.format("Client %s already exists", client.getAuth0Id()));

        if (client.getId() == null)
            client.setId(UUID.randomUUID());

        return this.clientRepository.saveAndFlush(client);
    }

    public Client update(Client client) throws NotFoundException {
        Optional<Client> optionalClient = this.clientRepository.findById(client.getId());

        if (optionalClient.isEmpty())
            throw new NotFoundException(String.format("Client with Auth0 id %s not found", client.getId()));

        return this.clientRepository.saveAndFlush(client);
    }
}

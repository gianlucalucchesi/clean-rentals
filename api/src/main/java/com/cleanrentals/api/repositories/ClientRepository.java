package com.cleanrentals.api.repositories;

import com.cleanrentals.api.models.Client;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface ClientRepository extends JpaRepository<Client, UUID> {
    @Query("SELECT c FROM client AS c WHERE (LOWER(auth0_id) = LOWER(:auth0Id))")
    Optional<Client> findByAuth0Id(String auth0Id);
}

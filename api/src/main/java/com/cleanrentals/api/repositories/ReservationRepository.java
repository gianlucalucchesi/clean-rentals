package com.cleanrentals.api.repositories;

import com.cleanrentals.api.models.Client;
import com.cleanrentals.api.models.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, UUID> {
    Optional<List<Reservation>> findByClient(Client client);
}

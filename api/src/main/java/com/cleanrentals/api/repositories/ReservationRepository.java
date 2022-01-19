package com.cleanrentals.api.repositories;

import com.cleanrentals.api.models.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, UUID> {
    @Query("SELECT r FROM reservation AS r WHERE (client_id = :client_id)")
    Optional<List<Reservation>> findByClient(UUID client_id);
}

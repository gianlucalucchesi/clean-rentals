package com.cleanrentals.api.repositories;

import com.cleanrentals.api.models.Car;
import com.cleanrentals.api.models.Client;
import com.cleanrentals.api.models.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, UUID> {
    // FIXME: remove optional and work with empty list
    Optional<List<Reservation>> findByClient(Client client);

    @Query("SELECT r FROM reservation AS r WHERE ((:dateStart BETWEEN r.dateTimeStart AND r.dateTimeStop) " +
            "OR (:dateStop BETWEEN r.dateTimeStart AND r.dateTimeStop)) AND r.car = :car")
    List<Reservation> findReservationBetweenDates(Car car, Date dateStart, Date dateStop);
}
package com.cleanrentals.api.controllers;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.Reservation;
import com.cleanrentals.api.repositories.ReservationRepository;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@RestController
@CrossOrigin
@RequestMapping(path = "/api/v1/reservation", produces = MediaType.APPLICATION_JSON_VALUE)
@Api(tags="Reservation") // Swagger doc
public class ReservationController {
    @Autowired
    ReservationRepository reservationRepository;

    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<List<Reservation>> get() {
        List<Reservation> reservations = reservationRepository.findAll();
        return new ResponseEntity<List<Reservation>>(reservations, HttpStatus.OK);
    }

    @GetMapping("private/{id}")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<Reservation> get(@PathVariable UUID id) throws NotFoundException {
        Optional<Reservation> optionalReservation = reservationRepository.findById(id);

        if (optionalReservation.isEmpty()) {
            throw new NotFoundException(String.format("Reservation with id %s not found", id));
        }

        return new ResponseEntity<Reservation>(optionalReservation.get(), HttpStatus.OK);
    }

    @GetMapping("private/client/{id}/reservations")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<List<Reservation>> getByClient(@PathVariable UUID id) throws NotFoundException {
        Optional<List<Reservation>> optionalReservationList = reservationRepository.findByClient(id);

        if (optionalReservationList.get().isEmpty()) {
            throw new NotFoundException(String.format("No reservations found for client with id %s", id));
        }

        return new ResponseEntity<List<Reservation>>(optionalReservationList.get(), HttpStatus.OK);
    }

    @PostMapping()
    @ResponseStatus(HttpStatus.CREATED)
    public Reservation create(@RequestBody Reservation reservation) throws ConflictException {
        if(reservation.getId() != null) {
            Optional<Reservation> optionalReservation = this.reservationRepository.findById(reservation.getId());

            if (optionalReservation.isPresent())
                throw new ConflictException(String.format("Reservation %s already exists", reservation.getId()));
        }

//        reservation.setId(UUID.randomUUID()); // Not needed because comes with ID from body
        return reservationRepository.saveAndFlush(reservation);
    }
}

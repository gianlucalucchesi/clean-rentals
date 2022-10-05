package com.cleanrentals.api.controllers;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.Reservation;
import com.cleanrentals.api.models.ReservationFinalizationDTO;
import com.cleanrentals.api.services.ReservationService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@CrossOrigin
@RequestMapping(path = "/api/v1/reservation", produces = MediaType.APPLICATION_JSON_VALUE)
@Api(tags = "Reservation") // Swagger doc
@EnableTransactionManagement
public class ReservationController {
    @Autowired
    private ReservationService reservationService;

    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public List<Reservation> get() {
        return this.reservationService.findAll();
    }

    @GetMapping("private/{id}")
    @ResponseStatus(HttpStatus.OK)
    public Reservation get(@PathVariable UUID id) throws NotFoundException {
        return this.reservationService.findById(id);
    }

    @GetMapping("private/client/{id}/reservations")
    @ResponseStatus(HttpStatus.OK)
    public List<Reservation> getByClientId(@PathVariable UUID id) throws NotFoundException {
        return this.reservationService.findByClientId(id);
    }

    @PostMapping()
    @ResponseStatus(HttpStatus.CREATED)
    public Reservation create(@RequestBody Reservation reservation) throws ConflictException {
        return this.reservationService.create(reservation);
    }

    @PatchMapping("paid/{reservationId}")
    @ResponseStatus(HttpStatus.OK)
    public Reservation setReservationAsPaid(@PathVariable String reservationId) throws NotFoundException {
        return this.reservationService.setReservationAsPaid(reservationId);
    }

    @PatchMapping("finalize/{reservationId}")
    @ResponseStatus(HttpStatus.OK)
    public Reservation finalize(@PathVariable String reservationId,
                                @RequestBody ReservationFinalizationDTO reservationFinalization)
            throws NotFoundException, ConflictException {
        return this.reservationService.finalize(reservationId, reservationFinalization);
    }

    @PatchMapping("cancel/{reservationId}")
    @ResponseStatus(HttpStatus.OK)
    public void cancel(@PathVariable String reservationId) throws NotFoundException, ConflictException {
        this.reservationService.cancel(reservationId);
    }

}

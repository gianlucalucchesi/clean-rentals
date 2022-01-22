package com.cleanrentals.api.controllers;

import com.cleanrentals.api.models.CarOption;
import com.cleanrentals.api.models.ReservationOption;
import com.cleanrentals.api.repositories.ReservationOptionRepository;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/reservation-option")
@Api(tags="Reservation Option") // Swagger doc
public class ReservationOptionController {
    @Autowired
    private ReservationOptionRepository reservationOptionRepository;

    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<List<ReservationOption>> get() {
        List<ReservationOption> reservationOptions = reservationOptionRepository.findAll();
        return new ResponseEntity<List<ReservationOption>>(reservationOptions, HttpStatus.OK);
    }
}

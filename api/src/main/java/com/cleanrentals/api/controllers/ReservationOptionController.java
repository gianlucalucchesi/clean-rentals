package com.cleanrentals.api.controllers;

import com.cleanrentals.api.repositories.ReservationOptionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ReservationOptionController {
    @Autowired
    private ReservationOptionRepository reservationOptionRepository;
}

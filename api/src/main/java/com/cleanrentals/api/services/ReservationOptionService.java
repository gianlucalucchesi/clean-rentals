package com.cleanrentals.api.services;

import com.cleanrentals.api.repositories.ReservationOptionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReservationOptionService {
    @Autowired
    private ReservationOptionRepository reservationOptionRepository;
}

package com.cleanrentals.api.services;

import com.cleanrentals.api.models.ReservationOption;
import com.cleanrentals.api.repositories.ReservationOptionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReservationOptionService {
    @Autowired
    private ReservationOptionRepository reservationOptionRepository;

    public List<ReservationOption> findAll() {
        return reservationOptionRepository.findAll();
    }
}

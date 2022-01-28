package com.cleanrentals.api.services;

import com.cleanrentals.api.repositories.CarOptionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CarOptionService {
    @Autowired
    private CarOptionRepository carOptionRepository;
}

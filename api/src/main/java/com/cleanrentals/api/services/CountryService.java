package com.cleanrentals.api.services;

import com.cleanrentals.api.repositories.CountryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CountryService {
    @Autowired
    private CountryRepository countryRepository;
}

package com.cleanrentals.api.services;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.Country;
import com.cleanrentals.api.repositories.CountryRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class CountryService {
    @Autowired
    private CountryRepository countryRepository;

    public List<Country> findAll() {
        return this.countryRepository.findAll();
    }

    public Country findById(UUID id) throws NotFoundException {
        Optional<Country> optionalCountry = countryRepository.findById(id);

        if (optionalCountry.isEmpty())
            throw new NotFoundException(String.format("Country with id %s not found", id));

        return optionalCountry.get();
    }


    public Country create(Country country) throws ConflictException {
        Optional<Country> optionalExistingCountry = countryRepository.findByName(country.getName());

        if (optionalExistingCountry.isPresent())
            throw new ConflictException(String.format("Country %s already exists", country.getName()));

        if(country.getId() == null)
            country.setId(UUID.randomUUID());

        return countryRepository.saveAndFlush(country);
    }


    public Country update(Country country) throws NotFoundException {
        Optional<Country> optionalExistingCountry = countryRepository.findById(country.getId());

        if (optionalExistingCountry.isEmpty())
            throw new NotFoundException(String.format("Country %s does not exist", country.getName()));

        BeanUtils.copyProperties(country, optionalExistingCountry.get(), "id");
        return countryRepository.saveAndFlush(optionalExistingCountry.get());
    }

    public void delete(UUID id) throws NotFoundException {
        Optional<Country> optionalExistingCountry = countryRepository.findById(id);

        if (optionalExistingCountry.isEmpty())
            throw new NotFoundException(String.format("Country %s does not exist", id));

        countryRepository.deleteById(id);
    }

    public Country findByName(String name) throws NotFoundException {
        Optional<Country> optionalCountry = this.countryRepository.findByName(name);

        if(optionalCountry.isEmpty())
            throw new NotFoundException(String.format("Country %s does not exist", name));

        return optionalCountry.get();
    }
}

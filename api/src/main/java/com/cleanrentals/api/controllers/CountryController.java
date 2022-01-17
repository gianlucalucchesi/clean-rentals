package com.cleanrentals.api.controllers;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.Country;
import com.cleanrentals.api.repositories.CountryRepository;
import io.swagger.annotations.Api;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/country")
@Api(tags="Country") // Swagger doc
public class CountryController {
    @Autowired
    private CountryRepository countryRepository;

    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<List<Country>> get() {
        List<Country> countries = countryRepository.findAll();
        return new ResponseEntity<List<Country>>(countries, HttpStatus.OK);
    }

    @GetMapping("{id}")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<Country> get(@PathVariable UUID id) throws NotFoundException {
        Optional<Country> optionalCountry = countryRepository.findById(id);

        if (optionalCountry.isEmpty()) {
            throw new NotFoundException(String.format("Country with id %s not found", id));
        }

        return new ResponseEntity<Country>(optionalCountry.get(), HttpStatus.OK);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Country create(@RequestBody Country country) throws ConflictException {
        Optional<Country> optionalExistingCountry = countryRepository.findByName(country.getName());

        if (optionalExistingCountry.isPresent()) {
            throw new ConflictException(String.format("Country %s already exists", country.getName()));
        }

        country.setId(UUID.randomUUID());
        return countryRepository.saveAndFlush(country);
    }

    @PutMapping
    @ResponseStatus(HttpStatus.OK)
    public Country update(@RequestBody @NotNull Country country) throws NotFoundException {
        Optional<Country> optionalExistingCountry = countryRepository.findById(country.getId());

        if (optionalExistingCountry.isEmpty()) {
            throw new NotFoundException(String.format("Country %s does not exist", country.getName()));
        }

        BeanUtils.copyProperties(country, optionalExistingCountry.get(), "id");
        return countryRepository.saveAndFlush(optionalExistingCountry.get());
    }

    @DeleteMapping("{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@PathVariable UUID id) throws NotFoundException {
        Optional<Country> optionalExistingCountry = countryRepository.findById(id);

        if (optionalExistingCountry.isEmpty()) {
            throw new NotFoundException(String.format("Country %s does not exist", id));
        }

        countryRepository.deleteById(id);
    }
}

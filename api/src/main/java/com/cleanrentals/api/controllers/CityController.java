package com.cleanrentals.api.controllers;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.City;
import com.cleanrentals.api.repositories.CityRepository;
import io.swagger.annotations.Api;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/city")
@Api(tags="City") // Swagger doc
public class CityController {
    @Autowired
    private CityRepository cityRepository;

    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<List<City>> get() throws NotFoundException {
        List<City> cities = cityRepository.findAll();
        return new ResponseEntity<List<City>>(cities, HttpStatus.OK);
    }

    @GetMapping("{id}")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<City> get(@PathVariable UUID id) throws NotFoundException {
        Optional<City> optionalCity = cityRepository.findById(id);

        if (optionalCity.isEmpty()) {
            throw new NotFoundException("City not found");
        }

        return new ResponseEntity<City>(optionalCity.get(), HttpStatus.OK);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public City create(@RequestBody City city) throws ConflictException {
        Optional<City> optionalExistingCity = cityRepository.findByName(city.getName(), city.getCountry().getId());

        if (optionalExistingCity.isPresent()) {
            throw new ConflictException(String.format("City %s in %s already exists", city.getName(), city.getCountry().getName()));
        }

        city.setId(UUID.randomUUID());
        return cityRepository.saveAndFlush(city);
    }

    @PutMapping
    @ResponseStatus(HttpStatus.OK)
    public City update(@RequestBody City city) throws NotFoundException {
        Optional<City> optionalExistingCity = cityRepository.findById(city.getId());

        if (optionalExistingCity.isEmpty()) {
            throw new NotFoundException(String.format("City %s in %s does not exist", city.getName(), city.getCountry().getName()));
        }

        BeanUtils.copyProperties(city, optionalExistingCity.get(), "id");
        return cityRepository.saveAndFlush(city);
    }

    @DeleteMapping
    @ResponseStatus(HttpStatus.OK)
    public void delete(@PathVariable UUID id) throws NotFoundException {
        Optional<City> optionalExistingCity = cityRepository.findById(id);

        if (optionalExistingCity.isEmpty()) {
            throw new NotFoundException(String.format("City with id %s does not exist", id));
        }

        cityRepository.deleteById(id);
    }

}

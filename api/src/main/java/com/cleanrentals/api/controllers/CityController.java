package com.cleanrentals.api.controllers;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.City;
import com.cleanrentals.api.services.CityService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/city")
@Api(tags = "City") // Swagger doc
public class CityController {
    @Autowired
    private CityService cityService;

    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public List<City> get() throws NotFoundException {
        return this.cityService.findAll();
    }

    @GetMapping("{id}")
    @ResponseStatus(HttpStatus.OK)
    public City get(@PathVariable UUID id) throws NotFoundException {
        return this.cityService.findById(id);
    }

    @GetMapping("name/{name}")
    @ResponseStatus(HttpStatus.OK)
    public City getByName(@PathVariable String name) throws NotFoundException {
        return this.cityService.findByName(name);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public City create(@RequestBody City city) throws ConflictException {
        return this.cityService.create(city);
    }

    @PutMapping
    @ResponseStatus(HttpStatus.OK)
    public City update(@RequestBody City city) throws NotFoundException {
        return this.cityService.update(city);
    }

    @DeleteMapping
    @ResponseStatus(HttpStatus.OK)
    public void delete(@PathVariable UUID id) throws NotFoundException {
        this.cityService.delete(id);
    }

}

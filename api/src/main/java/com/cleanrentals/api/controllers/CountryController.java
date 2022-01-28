package com.cleanrentals.api.controllers;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.Country;
import com.cleanrentals.api.services.CountryService;
import io.swagger.annotations.Api;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/country")
@Api(tags="Country") // Swagger doc
public class CountryController {
    @Autowired
    private CountryService countryService;

    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public List<Country> get() {
        return this.countryService.findAll();
    }

    @GetMapping("{id}")
    @ResponseStatus(HttpStatus.OK)
    public Country get(@PathVariable UUID id) throws NotFoundException {
        return this.countryService.findById(id);
    }

    @GetMapping("name/{name}")
    @ResponseStatus(HttpStatus.OK)
    public Country get(@PathVariable String name) throws NotFoundException {
        return this.countryService.findByName(name);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Country create(@RequestBody Country country) throws ConflictException {
        return this.countryService.create(country);
    }

    @PutMapping
    @ResponseStatus(HttpStatus.OK)
    public Country update(@RequestBody @NotNull Country country) throws NotFoundException {
        return this.countryService.update(country);
    }

    @DeleteMapping("{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@PathVariable UUID id) throws NotFoundException {
        this.countryService.delete(id);
    }
}

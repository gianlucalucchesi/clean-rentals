package com.cleanrentals.api.controllers;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.Location;
import com.cleanrentals.api.services.LocationService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/location")
@Api(tags="Location") // Swagger doc
public class LocationController {
    @Autowired
    private LocationService locationService;

    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public List<Location> get() {
        return this.locationService.findAll();
    }

    @GetMapping("{id}")
    @ResponseStatus(HttpStatus.OK)
    public Location get(@PathVariable UUID id) throws NotFoundException {
        return this.locationService.findById(id);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Location create(@RequestBody Location location) throws ConflictException {
        return this.locationService.create(location);
    }

    @PutMapping
    @ResponseStatus(HttpStatus.OK)
    public Location update(@RequestBody Location location) throws NotFoundException {
        return this.locationService.update(location);
    }

    @DeleteMapping("{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@PathVariable UUID id) throws NotFoundException {
        this.locationService.delete(id);
    }
}

package com.cleanrentals.api.controllers;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.Location;
import com.cleanrentals.api.repositories.LocationRepository;
import io.swagger.annotations.Api;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/location")
@Api(tags="Location") // Swagger doc
public class LocationController {
    @Autowired
    private LocationRepository locationRepository;

    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<List<Location>> get() {
        List<Location> locations = locationRepository.findAll();
        return new ResponseEntity<List<Location>>(locations, HttpStatus.OK);
    }

    @GetMapping("{id}")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<Location> get(@PathVariable UUID id) throws NotFoundException {
        Optional<Location> optionalLocation = locationRepository.findById(id);

        if (optionalLocation.isEmpty())
            throw new NotFoundException(String.format("Location with id %s does not exist", id));

        return new ResponseEntity<Location>(optionalLocation.get(), HttpStatus.OK);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Location create(@RequestBody Location location) throws ConflictException {
        Optional<Location> optionalLocation =
                locationRepository.findByName(location.getName(), location.getCity().getId());

        if (optionalLocation.isPresent())
            throw new ConflictException(String.format("Location '%s' already exists", location.getName()));

        location.setId(UUID.randomUUID());
        return locationRepository.saveAndFlush(location);
    }

    @PutMapping
    @ResponseStatus(HttpStatus.OK)
    public Location update(@RequestBody Location location) throws NotFoundException {
        Optional<Location> optionalExistingLocation = locationRepository.findById(location.getId());

        if (optionalExistingLocation.isEmpty())
            throw new NotFoundException(String.format("Location %s does not exist", location.getName()));

        // Copies updated object into existing object and ignores 'id' property
        BeanUtils.copyProperties(location, optionalExistingLocation.get(), "id");
        return locationRepository.saveAndFlush(optionalExistingLocation.get());
    }

    @DeleteMapping("{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@PathVariable UUID id) throws NotFoundException {
        Optional<Location> optionalLocation = locationRepository.findById(id);

        if (optionalLocation.isEmpty())
            throw new NotFoundException(String.format("Location with id %s does not exist", id));

        locationRepository.deleteById(id);
    }
}

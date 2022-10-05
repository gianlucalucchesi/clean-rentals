package com.cleanrentals.api.services;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.Location;
import com.cleanrentals.api.repositories.LocationRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class LocationService {
    @Autowired
    private LocationRepository locationRepository;

    public List<Location> findAll() {
        return this.locationRepository.findAll();
    }

    public Location findById(UUID id) throws NotFoundException {
        Optional<Location> optionalLocation = locationRepository.findById(id);

        if (optionalLocation.isEmpty())
            throw new NotFoundException(String.format("Location with id %s does not exist", id));

        return optionalLocation.get();
    }

    public Location create(Location location) throws ConflictException {
        Optional<Location> optionalLocation = locationRepository.findByName(location.getName());

        if (optionalLocation.isPresent())
            throw new ConflictException(String.format("Location '%s' already exists", location.getName()));

        if (location.getId() == null)
            location.setId(UUID.randomUUID());

        return locationRepository.saveAndFlush(location);
    }

    public Location update(Location location) throws NotFoundException {
        Optional<Location> optionalExistingLocation = locationRepository.findById(location.getId());

        if (optionalExistingLocation.isEmpty())
            throw new NotFoundException(String.format("Location %s does not exist", location.getName()));

        // Copies updated object into existing object and ignores 'id' property
        BeanUtils.copyProperties(location, optionalExistingLocation.get(), "id");
        return locationRepository.saveAndFlush(location);
    }

    public void delete(UUID id) throws NotFoundException {
        Optional<Location> optionalLocation = locationRepository.findById(id);

        if (optionalLocation.isEmpty())
            throw new NotFoundException(String.format("Location with id %s does not exist", id));

        locationRepository.deleteById(id);
    }
}

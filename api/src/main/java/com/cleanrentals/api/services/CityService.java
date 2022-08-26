package com.cleanrentals.api.services;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.City;
import com.cleanrentals.api.repositories.CityRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class CityService {
    @Autowired
    private CityRepository cityRepository;

    public List<City> findAll() {
        return this.cityRepository.findAll();
    }

    public City findById(UUID id) throws NotFoundException {
        Optional<City> optionalCity = this.cityRepository.findById(id);

        if (optionalCity.isEmpty())
            throw new NotFoundException(String.format("City with id %s not found", id));

        return optionalCity.get();
    }

    public City findByName(String name) throws NotFoundException {
        Optional<City> optionalCity = this.cityRepository.findByName(name);

        if (optionalCity.isEmpty())
            throw new NotFoundException(String.format("City %s not found", name));

        return optionalCity.get();
    }

    public City create(City city) throws ConflictException {
        Optional<City> optionalExistingCity = this.cityRepository.findByName(city.getName());

        if (optionalExistingCity.isPresent())
            throw new ConflictException(String.format("City %s already exists", city.getName()));

        if (city.getId() == null) {
            city.setId(UUID.randomUUID());
        }

        return this.cityRepository.saveAndFlush(city);
    }

    public City update(City city) throws NotFoundException {
        Optional<City> optionalExistingCity = cityRepository.findById(city.getId());

        if (optionalExistingCity.isEmpty()) {
            throw new NotFoundException(String.format("City %s in %s does not exist", city.getName(), city.getCountry().getName()));
        }

        BeanUtils.copyProperties(city, optionalExistingCity.get(), "id");
        return cityRepository.saveAndFlush(city);
    }

    public void delete(UUID id) throws NotFoundException {
        Optional<City> optionalExistingCity = cityRepository.findById(id);

        if (optionalExistingCity.isEmpty()) {
            throw new NotFoundException(String.format("City with id %s does not exist", id));
        }

        cityRepository.deleteById(id);
    }
}

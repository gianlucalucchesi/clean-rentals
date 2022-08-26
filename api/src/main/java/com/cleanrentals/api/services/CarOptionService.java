package com.cleanrentals.api.services;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.CarOption;
import com.cleanrentals.api.repositories.CarOptionRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class CarOptionService {
    @Autowired
    private CarOptionRepository carOptionRepository;

    public List<CarOption> findAll() {
        return this.carOptionRepository.findAll();
    }

    public CarOption findById(UUID id) throws NotFoundException {
        Optional<CarOption> optionalCarOption = carOptionRepository.findById(id);

        if (optionalCarOption.isEmpty())
            throw new NotFoundException(String.format("Car option with id %s does not exist", id));

        return optionalCarOption.get();
    }

    public CarOption findByName(String name) throws NotFoundException, ConflictException {
        Optional<CarOption> optionalCarOption = carOptionRepository.findByName(name);

        if (optionalCarOption.isEmpty())
            throw new NotFoundException(String.format("Car option '%s' not found", name));

        return optionalCarOption.get();
    }

    public CarOption create(CarOption carOption) throws ConflictException {
        Optional<CarOption> optionalCarOption = carOptionRepository.findByName(carOption.getName());

        if (optionalCarOption.isPresent()) {
            throw new ConflictException(String.format("Car option '%s' already exists", carOption.getName()));
        }

        if (carOption.getId() == null) {
            carOption.setId(UUID.randomUUID());
        }

        return carOptionRepository.saveAndFlush(carOption);
    }

    public CarOption update(CarOption carOption) throws NotFoundException {
        Optional<CarOption> optionalExistingCarOption = carOptionRepository.findById(carOption.getId());

        if (optionalExistingCarOption.isEmpty()) {
            throw new NotFoundException(String.format("Car option with id %s does not exist", carOption.getId()));
        }

        BeanUtils.copyProperties(carOption, optionalExistingCarOption.get(), "id");
        return carOptionRepository.saveAndFlush(carOption);
    }
}

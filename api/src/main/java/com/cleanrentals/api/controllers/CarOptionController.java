package com.cleanrentals.api.controllers;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.CarOption;
import com.cleanrentals.api.repositories.CarOptionRepository;
import io.swagger.annotations.Api;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.swing.text.html.Option;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/car-option")
@Api(tags="Car Option") // Swagger doc
public class CarOptionController {
    @Autowired
    private CarOptionRepository carOptionRepository;

    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<List<CarOption>> get() {
        List<CarOption> carOptions = carOptionRepository.findAll();
        return new ResponseEntity<List<CarOption>>(carOptions, HttpStatus.OK);
    }

    @GetMapping("{id}")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<CarOption> get(@PathVariable UUID id) throws NotFoundException {
        Optional<CarOption> optionalCarOption = carOptionRepository.findById(id);

        if (optionalCarOption.isEmpty()) {
            throw new NotFoundException(String.format("Car option with id %s does not exist", id));
        }

        return new ResponseEntity<CarOption>(optionalCarOption.get(), HttpStatus.OK);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public CarOption create(@RequestBody CarOption carOption) throws ConflictException {
        Optional<CarOption> optionalCarOption = carOptionRepository.findByName(carOption.getName());

        if (optionalCarOption.isPresent()) {
            throw new ConflictException(String.format("Car option '%s' already exists", carOption.getName()));
        }

        carOption.setId(UUID.randomUUID());
        return carOptionRepository.saveAndFlush(carOption);
    }

    @PutMapping
    @ResponseStatus(HttpStatus.OK)
    public CarOption update(@RequestBody CarOption carOption) throws NotFoundException {
        Optional<CarOption> optionalExistingCarOption = carOptionRepository.findById(carOption.getId());

        if (optionalExistingCarOption.isEmpty()) {
            throw new NotFoundException(String.format("Car option with id %s does not exist", carOption.getId()));
        }

        BeanUtils.copyProperties(carOption, optionalExistingCarOption.get() , "id");
        return carOptionRepository.saveAndFlush(carOption);
    }
}

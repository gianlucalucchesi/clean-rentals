package com.cleanrentals.api.controllers;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.Car;
import com.cleanrentals.api.repositories.CarRepository;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequestMapping(path = "/api/v1/car", produces = MediaType.APPLICATION_JSON_VALUE)
@Api(tags="car") // Swagger doc
@CrossOrigin(origins = "*")
public class CarController {
    @Autowired
    private CarRepository carRepository;

    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<List<Car>> get() throws NotFoundException {
        List<Car> cars = carRepository.findAll();
        return new ResponseEntity<List<Car>>(cars, HttpStatus.OK);
    }

    @GetMapping(value = "{id}")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<Car> get(@PathVariable UUID id) throws NotFoundException {
        Optional<Car> optionalCar = carRepository.findById(id);

        if (optionalCar.isEmpty())
            throw new NotFoundException(String.format("Car with id %s not found", id));

        return new ResponseEntity<Car>(optionalCar.get(), HttpStatus.OK);
    }

    @GetMapping(value = "/private-scoped/{id}")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<Car> get2(@PathVariable UUID id) throws NotFoundException {
        Optional<Car> optionalCar = carRepository.findById(id);

        if (optionalCar.isEmpty())
            throw new NotFoundException(String.format("Car with id %s not found", id));

        return new ResponseEntity<Car>(optionalCar.get(), HttpStatus.OK);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Car create(@RequestBody Car car) throws ConflictException {
        Optional<Car> optionalCar = carRepository.findByModelAndBrand(car.getModel(), car.getBrand().getId());

        if (optionalCar.isPresent())
            throw new ConflictException(String.format("%s %s already exists", car.getBrand().getName(), car.getModel()));

        car.setId(UUID.randomUUID());
        return carRepository.saveAndFlush(car);
    }

    @DeleteMapping("{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@PathVariable UUID id) throws NotFoundException {
        Optional<Car> optionalCar = carRepository.findById(id);

        if (optionalCar.isEmpty())
            throw new NotFoundException(String.format("Car with id %s does not exist", id));

        carRepository.delete(optionalCar.get());
    }
}
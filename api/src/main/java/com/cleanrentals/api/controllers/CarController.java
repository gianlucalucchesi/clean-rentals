package com.cleanrentals.api.controllers;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.Brand;
import com.cleanrentals.api.models.Car;
import com.cleanrentals.api.repositories.CarRepository;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/car")
@Api(tags="car") // Swagger doc
public class CarController {
    @Autowired
    private CarRepository carRepository;

    @GetMapping("all")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<List<Car>> getAll() throws NotFoundException {
        List<Car> carList = carRepository.findAll();

        if (carList.size() == 0)
            throw new NotFoundException("No cars");

        return new ResponseEntity<List<Car>>(carList, HttpStatus.OK);
    }

    @GetMapping("{id}")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<Car> get(@PathVariable UUID id) throws NotFoundException {
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
}
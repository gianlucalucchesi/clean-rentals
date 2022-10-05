package com.cleanrentals.api.controllers;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.Car;
import com.cleanrentals.api.services.CarService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@CrossOrigin
@RequestMapping(path = "/api/v1/car", produces = MediaType.APPLICATION_JSON_VALUE)
@Api(tags = "Car") // Swagger doc
public class CarController {
    @Autowired
    private CarService carService;

    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public List<Car> get() throws NotFoundException {
        return this.carService.findAll();
    }

    @GetMapping("/pagination/{pageNumber}/{pageSize}")
    @ResponseStatus(HttpStatus.OK)
    public Page<Car> get(@PathVariable int pageNumber, @PathVariable int pageSize) throws NotFoundException {
        Page<Car> carPage = carService.findAll(PageRequest.of(pageNumber, pageSize));
        return carPage;
    }

    @GetMapping(value = "/private/{id}")
    @ResponseStatus(HttpStatus.OK)
    public Car get(@PathVariable UUID id) throws NotFoundException {
        return this.carService.findById(id);
    }

    @GetMapping(value = "/private-scoped/{id}")
    @ResponseStatus(HttpStatus.OK)
    public Car getScoped(@PathVariable UUID id) throws NotFoundException {
        return this.carService.findById(id);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Car create(@RequestBody Car car) throws ConflictException, NotFoundException {
        return this.carService.create(car);
    }

    @DeleteMapping("{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@PathVariable UUID id) throws NotFoundException {
        this.carService.delete(id);
    }

    @GetMapping("/model/{model}")
    @ResponseStatus(HttpStatus.OK)
    public List<Car> findByModel(@PathVariable String model) {
        return this.carService.findByModel(model);
    }

    @GetMapping("/brand/{brand}")
    @ResponseStatus(HttpStatus.OK)
    public List<Car> findByBrand(@PathVariable String brand) throws NotFoundException {
        return this.carService.findByBrand(brand);
    }

    @GetMapping("/brand/{brand}/model/{model}")
    @ResponseStatus(HttpStatus.OK)
    public List<Car> findByModelAndBrand(@PathVariable String brand, @PathVariable String model)
            throws NotFoundException {
        return this.carService.findByModelAndBrand(model, brand);
    }

}
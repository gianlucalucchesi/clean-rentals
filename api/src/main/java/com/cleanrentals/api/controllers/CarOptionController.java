package com.cleanrentals.api.controllers;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.CarOption;
import com.cleanrentals.api.services.CarOptionService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/car-option")
@Api(tags = "Car Option") // Swagger doc
public class CarOptionController {
    @Autowired
    private CarOptionService carOptionService;

    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public List<CarOption> get() {
        return this.carOptionService.findAll();
    }

    @GetMapping("{id}")
    @ResponseStatus(HttpStatus.OK)
    public CarOption get(@PathVariable UUID id) throws NotFoundException {
        return this.carOptionService.findById(id);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public CarOption create(@RequestBody CarOption carOption) throws ConflictException {
        return this.carOptionService.create(carOption);
    }

    @PutMapping
    @ResponseStatus(HttpStatus.OK)
    public CarOption update(@RequestBody CarOption carOption) throws NotFoundException {
        return this.carOptionService.update(carOption);
    }
}

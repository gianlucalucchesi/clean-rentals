package com.cleanrentals.api.controllers;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.Brand;
import com.cleanrentals.api.services.BrandService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@CrossOrigin
@RequestMapping("/api/v1/brand")
@Api(tags = "Brand") // Swagger doc
public class BrandController {
    @Autowired
    private BrandService brandService;

    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public List<Brand> get() throws NotFoundException {
        return this.brandService.findAll();
    }

    @GetMapping(value = "{id}")
    @ResponseStatus(HttpStatus.OK)
    public Brand get(@PathVariable UUID id) throws NotFoundException {
        return brandService.findById(id);
    }

    @GetMapping("name/{brandName}")
    @ResponseStatus(HttpStatus.OK)
    public Brand getByName(@PathVariable String brandName) throws NotFoundException {
        return this.brandService.findByName(brandName);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Brand create(@RequestBody final Brand brand) throws ConflictException, NotFoundException {
        return brandService.create(brand);
    }

    @PutMapping
    @ResponseStatus(HttpStatus.OK)
    public Brand update(@RequestBody final Brand brand) throws NotFoundException {
        return this.brandService.update(brand);
    }

    @DeleteMapping("{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@PathVariable UUID id) throws NotFoundException {
        this.brandService.delete(id);
    }

}

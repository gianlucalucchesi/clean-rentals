package com.cleanrentals.api.controllers;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.Brand;
import com.cleanrentals.api.repositories.BrandRepository;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.swing.text.html.Option;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/brand")
@Api(tags = "brand") // Swagger doc
public class BrandController {
    @Autowired
    private BrandRepository brandRepository;

    @GetMapping("all")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<List<Brand>> getAll() throws NotFoundException {
        List<Brand> brandList = this.brandRepository.findAll();

        if (brandList.size() == 0)
            throw new NotFoundException("Empty brand table");

        return new ResponseEntity<List<Brand>>(brandList, HttpStatus.OK);
    }

    //TODO: check if this routing is RESTful
    @GetMapping("name/{brandName}")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<Brand> getByName(@PathVariable String brandName) throws NotFoundException {
        Optional<Brand> optionalBrand = Optional.ofNullable(brandRepository.findByName(brandName));

        if (optionalBrand.isEmpty())
            throw new NotFoundException(brandName + " does not exist");

        return new ResponseEntity<Brand>(optionalBrand.get(), HttpStatus.OK);
    }

    @GetMapping("{id}")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<Brand> get(@PathVariable UUID id) throws NotFoundException {
        Optional<Brand> optionalBrand = this.brandRepository.findById(id);

        if (optionalBrand.isEmpty())
            throw new NotFoundException(String.format("Brand %s does not exist", id));

        return new ResponseEntity<Brand>(optionalBrand.get(), HttpStatus.OK);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Brand create(@RequestBody final Brand brand) throws ConflictException {
        Optional<Brand> optionalExistingBrand = Optional.ofNullable(brandRepository.findByName(brand.getName()));

        if (optionalExistingBrand.isPresent()) {
            throw new ConflictException(String.format("Brand %s already exists", brand.getName()));
        }

        brand.setId(UUID.randomUUID());
        return brandRepository.saveAndFlush(brand);
    }

}

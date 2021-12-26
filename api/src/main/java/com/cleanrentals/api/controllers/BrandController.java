package com.cleanrentals.api.controllers;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.Brand;
import com.cleanrentals.api.repositories.BrandRepository;
import io.swagger.annotations.Api;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/brand")
@Api(tags = "brand") // Swagger doc
public class BrandController {
    @Autowired
    private BrandRepository brandRepository;

    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<List<Brand>> get() throws NotFoundException {
        List<Brand> brands = this.brandRepository.findAll();
        return new ResponseEntity<List<Brand>>(brands, HttpStatus.OK);
    }

//    @GetMapping("name/{brandName}")
//    @ResponseStatus(HttpStatus.OK)
//    public ResponseEntity<Brand> getByName(@PathVariable String brandName) throws NotFoundException {
//        Optional<Brand> optionalBrand = brandRepository.findByName(brandName);
//
//        if (optionalBrand.isEmpty())
//            throw new NotFoundException(brandName + " does not exist");
//
//        return new ResponseEntity<Brand>(optionalBrand.get(), HttpStatus.OK);
//    }

    @GetMapping(value = "{id}")
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
        Optional<Brand> optionalExistingBrand = brandRepository.findByName(brand.getName());

        if (optionalExistingBrand.isPresent()) {
            throw new ConflictException(String.format("Brand %s already exists", brand.getName()));
        }

        brand.setId(UUID.randomUUID());
        return brandRepository.saveAndFlush(brand);
    }

    @PutMapping
    @ResponseStatus(HttpStatus.OK)
    public Brand update(@RequestBody final Brand brand) throws NotFoundException {
        Optional<Brand> optionalExistingBrand = brandRepository.findById(brand.getId());

        if (optionalExistingBrand.isEmpty()) {
            throw new NotFoundException(String.format("Brand %s does not exist", brand.getName()));
        }

        BeanUtils.copyProperties(brand, optionalExistingBrand.get(), "id");
        return brandRepository.saveAndFlush(brand);
    }

    @DeleteMapping("{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@PathVariable UUID id) throws NotFoundException {
        Optional<Brand> optionalExistingBrand = this.brandRepository.findById(id);

        if (optionalExistingBrand.isPresent()) {
            throw new NotFoundException(String.format("Brand %s does not exist", id));
        }

        brandRepository.deleteById(id);
    }

}

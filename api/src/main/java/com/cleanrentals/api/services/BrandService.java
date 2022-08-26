package com.cleanrentals.api.services;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.Brand;
import com.cleanrentals.api.repositories.BrandRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class BrandService {
    @Autowired
    private BrandRepository brandRepository;

    public List<Brand> findAll() {
        return this.brandRepository.findAll();
    }

    public Brand findById(UUID id) throws NotFoundException {
        Optional<Brand> optionalBrand = this.brandRepository.findById(id);

        if (optionalBrand.isEmpty())
            throw new NotFoundException(String.format("Brand with id %s not found", id));

        return optionalBrand.get();
    }

    public Brand findByName(String name) throws NotFoundException {
        Optional<Brand> optionalBrand = this.brandRepository.findByName(name);

        if (optionalBrand.isEmpty())
            throw new NotFoundException(String.format("Brand %s not found", name));

        return optionalBrand.get();
    }

    public Brand create(Brand brand) throws NotFoundException, ConflictException {
        Optional<Brand> optionalBrand = this.brandRepository.findByName(brand.getName());

        if (optionalBrand.isPresent())
            throw new ConflictException(String.format("Brand name %s already exists", brand.getName()));

        if (brand.getId() == null)
            brand.setId(UUID.randomUUID());

        return this.brandRepository.saveAndFlush(brand);
    }

    public Brand update(Brand brand) throws NotFoundException {
        Optional<Brand> optionalExistingBrand = this.brandRepository.findById(brand.getId());

        if (optionalExistingBrand.isEmpty()) {
            throw new NotFoundException(String.format("Brand %s does not exist", brand.getName()));
        }

        BeanUtils.copyProperties(brand, optionalExistingBrand.get(), "id");
        return brandRepository.saveAndFlush(brand);
    }

    public void delete(UUID id) throws NotFoundException {
        this.findById(id);
        brandRepository.deleteById(id);
    }

}

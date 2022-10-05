package com.cleanrentals.api.services;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.Brand;
import com.cleanrentals.api.models.Car;
import com.cleanrentals.api.repositories.CarRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class CarService {
    @Autowired
    private CarRepository carRepository;
    @Autowired
    private BrandService brandService;

    public List<Car> findAll() {
        return this.carRepository.findAll();
    }

    public Page<Car> findAll(PageRequest pageRequest) {
        return this.carRepository.findAll(pageRequest);
    }

    public Car findById(UUID id) throws NotFoundException {
        Optional<Car> optionalCar = carRepository.findById(id);

        if (optionalCar.isEmpty())
            throw new NotFoundException(String.format("Car with id %s not found", id));

        return optionalCar.get();
    }

    public List<Car> findByBrand(String brandName) throws NotFoundException {
        Brand brand = this.brandService.findByName(brandName);
        return this.carRepository.findByBrand(brand);
    }

    public List<Car> findByModel(String model) {
        return this.carRepository.findByModel(model);
    }

    public List<Car> findByModelAndBrand(String model, String brandName) throws NotFoundException {
        Brand brand = this.brandService.findByName(brandName);
        return this.carRepository.findByModelAndBrand(model, brand);
    }

    public Car create(Car car) throws ConflictException, NotFoundException {
        List<Car> carList = findByModelAndBrand(car.getModel(), car.getBrand().getName());

        if (carList.size() > 0)
            throw new ConflictException(
                    String.format("%s %s already exists", car.getBrand().getName(), car.getModel()));

        car.setId(UUID.randomUUID());
        return this.carRepository.saveAndFlush(car);
    }

    public void delete(UUID id) throws NotFoundException {
        Optional<Car> optionalCar = carRepository.findById(id);

        if (optionalCar.isEmpty())
            throw new NotFoundException(String.format("Car with id %s does not exist", id));

        this.carRepository.delete(optionalCar.get());
    }

}

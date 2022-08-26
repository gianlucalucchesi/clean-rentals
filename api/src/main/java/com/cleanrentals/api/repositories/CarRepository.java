package com.cleanrentals.api.repositories;

import com.cleanrentals.api.models.Brand;
import com.cleanrentals.api.models.Car;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface CarRepository extends JpaRepository<Car, UUID> {
    List<Car> findByModelAndBrand(String model, Brand brand);

    List<Car> findByModel(String model);

    List<Car> findByBrand(Brand brand);
}

package com.cleanrentals.api.repositories;

import com.cleanrentals.api.models.Car;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;
import java.util.UUID;

public interface CarRepository extends JpaRepository<Car, UUID> {
    @Query("SELECT c FROM car AS c WHERE (LOWER(model) = LOWER(:name)) AND brand_id = :brand_id")
    Optional<Car> findByModelAndBrand(String name, UUID brand_id);
}

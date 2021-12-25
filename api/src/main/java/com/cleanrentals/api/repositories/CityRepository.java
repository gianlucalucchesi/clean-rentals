package com.cleanrentals.api.repositories;

import com.cleanrentals.api.models.City;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface CityRepository extends JpaRepository<City, UUID> {
    @Query("SELECT c FROM city AS c WHERE (LOWER(name) = LOWER(:name)) AND country_id = :countryId")
    Optional<City> findByName(String name, UUID countryId);
}

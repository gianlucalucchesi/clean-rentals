package com.cleanrentals.api.repositories;

import com.cleanrentals.api.models.Country;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface CountryRepository extends JpaRepository<Country, UUID> {
    @Query("SELECT c FROM country AS c WHERE LOWER(name) = LOWER(:name)")
    Optional<Country> findByName(String name);
}

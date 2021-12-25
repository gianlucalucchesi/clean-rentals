package com.cleanrentals.api.repositories;

import com.cleanrentals.api.models.Location;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface LocationRepository extends JpaRepository<Location, UUID> {
    @Query("SELECT l FROM location AS l WHERE (LOWER(name) = LOWER(:name)) AND (city_id = :cityId)")
    Optional<Location> findByName(String name, UUID cityId);
}

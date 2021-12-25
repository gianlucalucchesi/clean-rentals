package com.cleanrentals.api.repositories;

import com.cleanrentals.api.models.CarOption;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface CarOptionRepository extends JpaRepository<CarOption, UUID> {
    @Query("SELECT co FROM brand AS co WHERE LOWER(name) = LOWER(:name)")
    Optional<CarOption> findByName(String name);
}

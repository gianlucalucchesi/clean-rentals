package com.cleanrentals.api.repositories;

import com.cleanrentals.api.models.Brand;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.UUID;

public interface BrandRepository extends JpaRepository<Brand, UUID> {
    @Query("SELECT b FROM brand AS b WHERE LOWER(name) = LOWER(:name)")
    Brand findByName(String name);
}

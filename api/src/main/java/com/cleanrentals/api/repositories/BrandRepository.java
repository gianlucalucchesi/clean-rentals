package com.cleanrentals.api.repositories;

import com.cleanrentals.api.models.Brand;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.swing.text.html.Option;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface BrandRepository extends JpaRepository<Brand, UUID> {
    @Query("SELECT b FROM brand AS b WHERE LOWER(name) = LOWER(:name)")
    Optional<Brand> findByName(String name);
}
